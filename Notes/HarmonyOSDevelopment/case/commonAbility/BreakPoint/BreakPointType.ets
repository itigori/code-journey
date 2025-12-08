interface BreakPointTypeOption<T> {
  xs ?: T
  sm ?: T
  md ?: T
  lg ?: T
}

// 封装断点工具类 - UI调用
export class BreakPointType<T> {
  option: BreakPointTypeOption<T>

  constructor(option: BreakPointTypeOption<T>) {
    this.option = option
  }

  getValue(currentBreakPoint: string) {
    if (currentBreakPoint === 'xs') {
      return this.option.xs
    } else if (currentBreakPoint === 'md') {
      return this.option.md
    } else if (currentBreakPoint === 'sm') {
      return this.option.sm
    } else if (currentBreakPoint === 'lg') {
      return this.option.lg
    } else {
      return undefined
    }
  }
}