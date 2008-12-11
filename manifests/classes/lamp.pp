class wordpress {
  include build,
          git,
          apache,
          mysql,
          php,
          sudo
}