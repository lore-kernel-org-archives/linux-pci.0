Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 1 Apr 2017 14:31:58 +0800
From: kbuild test robot <lkp@intel.com>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, frowand.list@gmail.com, bhelgaas@google.com,
        rafael@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        brian.starkey@arm.com, olof@lixom.net, lorenzo.pieralisi@arm.com,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        minyard@acm.org, zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V8 1/6] LIBIO: Introduce a generic PIO mapping method
Message-ID: <201704011443.8hlP62es%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <1490887619-61732-2-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc4 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LIBIO-Introduce-a-generic-PIO-mapping-method/20170401-104801
config: m68k-m5475evb_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All error/warnings (new ones prefixed by >>):

   lib/logic_pio.c:32:50: error: 'PIO_MAX_SECT' undeclared here (not in a function)
    static struct logic_pio_root logic_pio_root_list[PIO_MAX_SECT] = {
                                                     ^
   lib/logic_pio.c:52:3: error: 'PIO_CPU_MMIO' undeclared here (not in a function)
     [PIO_CPU_MMIO] = {
      ^
   lib/logic_pio.c:52:2: error: array index in initializer not of integer type
     [PIO_CPU_MMIO] = {
     ^
   lib/logic_pio.c:52:2: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:53:3: error: field name not in record or union initializer
      .sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
      ^
   lib/logic_pio.c:53:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:54:3: error: field name not in record or union initializer
      .sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
      ^
   lib/logic_pio.c:54:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:54:3: error: implicit declaration of function 'PIO_SECT_MIN' [-Werror=implicit-function-declaration]
   lib/logic_pio.c:55:3: error: field name not in record or union initializer
      .sec_max = PIO_SECT_MAX(PIO_CPU_MMIO),
      ^
   lib/logic_pio.c:55:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:55:3: error: implicit declaration of function 'PIO_SECT_MAX' [-Werror=implicit-function-declaration]
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   lib/logic_pio.c: In function 'logic_pio_find_range_byaddr':
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/kernel.h:852:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:853:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/compiler.h:62:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/of.h:18,
                    from lib/logic_pio.c:18:
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/compiler-gcc.h:161:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:853:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/pid.h:4:0,
                    from include/linux/sched.h:13,
                    from arch/m68k/include/asm/pgtable_mm.h:10,
                    from arch/m68k/include/asm/pgtable.h:4,
                    from include/linux/mm.h:68,
                    from lib/logic_pio.c:20:
   include/linux/rculist.h:352:7: error: dereferencing pointer to incomplete type
      &pos->member != (head); \
          ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/kernel.h:852:48: warning: initialization makes pointer from integer without a cast
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/kernel.h:853:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/compiler.h:62:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/of.h:18,
                    from lib/logic_pio.c:18:
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/compiler-gcc.h:161:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:853:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
>> lib/logic_pio.c:78:13: error: dereferencing pointer to incomplete type
      if (!range->pio_peer) {
                ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   lib/logic_pio.c:80:11: error: dereferencing pointer to incomplete type
        &range->hw_start);
              ^
   include/linux/printk.h:303:37: note: in definition of macro 'pr_warning'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                        ^
>> lib/logic_pio.c:79:4: note: in expansion of macro 'pr_warn'
       pr_warn("Invalid cpu addr node(%pa) in list!\n",
       ^
   lib/logic_pio.c:83:12: error: dereferencing pointer to incomplete type
      if (range->fwnode != fwnode)
               ^
   lib/logic_pio.c:86:21: error: dereferencing pointer to incomplete type
      if (start >= range->hw_start + range->size ||
                        ^
   lib/logic_pio.c:86:39: error: dereferencing pointer to incomplete type
      if (start >= range->hw_start + range->size ||
                                          ^
   lib/logic_pio.c:87:15: error: dereferencing pointer to incomplete type
       end < range->hw_start)
                  ^
   lib/logic_pio.c:90:20: error: dereferencing pointer to incomplete type
      if (start < range->hw_start ||
                       ^
   lib/logic_pio.c:91:16: error: dereferencing pointer to incomplete type
       end >= range->hw_start + range->size)
                   ^
   lib/logic_pio.c:91:34: error: dereferencing pointer to incomplete type
       end >= range->hw_start + range->size)
                                     ^
   lib/logic_pio.c: In function 'logic_pio_alloc_range':
   lib/logic_pio.c:109:19: error: dereferencing pointer to incomplete type
     idle_start = root->sec_min;
                      ^
   lib/logic_pio.c:110:15: error: dereferencing pointer to incomplete type
     *prev = &root->sec_head;
                  ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:111:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
     ^
   lib/logic_pio.c:111:38: error: dereferencing pointer to incomplete type
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
                                         ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:111:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
     ^
   lib/logic_pio.c:111:38: error: dereferencing pointer to incomplete type
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
                                         ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^

vim +351 include/linux/rculist.h

3943f42c Andrey Utkin         2014-11-14  271   * @member:     the name of the list_head within the struct.
72c6a987 Jiri Pirko           2009-04-14  272   *
72c6a987 Jiri Pirko           2009-04-14  273   * This primitive may safely run concurrently with the _rcu list-mutation
72c6a987 Jiri Pirko           2009-04-14  274   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
72c6a987 Jiri Pirko           2009-04-14  275   */
72c6a987 Jiri Pirko           2009-04-14  276  #define list_entry_rcu(ptr, type, member) \
8db70b13 Patrick Marlier      2015-09-11 @277  	container_of(lockless_dereference(ptr), type, member)
72c6a987 Jiri Pirko           2009-04-14  278  
72c6a987 Jiri Pirko           2009-04-14  279  /**
f88022a4 Michel Machado       2012-04-10  280   * Where are list_empty_rcu() and list_first_entry_rcu()?
f88022a4 Michel Machado       2012-04-10  281   *
f88022a4 Michel Machado       2012-04-10  282   * Implementing those functions following their counterparts list_empty() and
f88022a4 Michel Machado       2012-04-10  283   * list_first_entry() is not advisable because they lead to subtle race
f88022a4 Michel Machado       2012-04-10  284   * conditions as the following snippet shows:
f88022a4 Michel Machado       2012-04-10  285   *
f88022a4 Michel Machado       2012-04-10  286   * if (!list_empty_rcu(mylist)) {
f88022a4 Michel Machado       2012-04-10  287   *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
f88022a4 Michel Machado       2012-04-10  288   *	do_something(bar);
f88022a4 Michel Machado       2012-04-10  289   * }
f88022a4 Michel Machado       2012-04-10  290   *
f88022a4 Michel Machado       2012-04-10  291   * The list may not be empty when list_empty_rcu checks it, but it may be when
f88022a4 Michel Machado       2012-04-10  292   * list_first_entry_rcu rereads the ->next pointer.
f88022a4 Michel Machado       2012-04-10  293   *
f88022a4 Michel Machado       2012-04-10  294   * Rereading the ->next pointer is not a problem for list_empty() and
f88022a4 Michel Machado       2012-04-10  295   * list_first_entry() because they would be protected by a lock that blocks
f88022a4 Michel Machado       2012-04-10  296   * writers.
f88022a4 Michel Machado       2012-04-10  297   *
f88022a4 Michel Machado       2012-04-10  298   * See list_first_or_null_rcu for an alternative.
f88022a4 Michel Machado       2012-04-10  299   */
f88022a4 Michel Machado       2012-04-10  300  
f88022a4 Michel Machado       2012-04-10  301  /**
f88022a4 Michel Machado       2012-04-10  302   * list_first_or_null_rcu - get the first element from a list
72c6a987 Jiri Pirko           2009-04-14  303   * @ptr:        the list head to take the element from.
72c6a987 Jiri Pirko           2009-04-14  304   * @type:       the type of the struct this is embedded in.
3943f42c Andrey Utkin         2014-11-14  305   * @member:     the name of the list_head within the struct.
72c6a987 Jiri Pirko           2009-04-14  306   *
f88022a4 Michel Machado       2012-04-10  307   * Note that if the list is empty, it returns NULL.
72c6a987 Jiri Pirko           2009-04-14  308   *
72c6a987 Jiri Pirko           2009-04-14  309   * This primitive may safely run concurrently with the _rcu list-mutation
72c6a987 Jiri Pirko           2009-04-14  310   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
72c6a987 Jiri Pirko           2009-04-14  311   */
f88022a4 Michel Machado       2012-04-10  312  #define list_first_or_null_rcu(ptr, type, member) \
0adab9b9 Joe Perches          2013-12-05  313  ({ \
0adab9b9 Joe Perches          2013-12-05  314  	struct list_head *__ptr = (ptr); \
7d0ae808 Paul E. McKenney     2015-03-03  315  	struct list_head *__next = READ_ONCE(__ptr->next); \
0adab9b9 Joe Perches          2013-12-05  316  	likely(__ptr != __next) ? list_entry_rcu(__next, type, member) : NULL; \
f88022a4 Michel Machado       2012-04-10  317  })
72c6a987 Jiri Pirko           2009-04-14  318  
82524746 Franck Bui-Huu       2008-05-12  319  /**
ff3c44e6 Tom Herbert          2016-03-07  320   * list_next_or_null_rcu - get the first element from a list
ff3c44e6 Tom Herbert          2016-03-07  321   * @head:	the head for the list.
ff3c44e6 Tom Herbert          2016-03-07  322   * @ptr:        the list head to take the next element from.
ff3c44e6 Tom Herbert          2016-03-07  323   * @type:       the type of the struct this is embedded in.
ff3c44e6 Tom Herbert          2016-03-07  324   * @member:     the name of the list_head within the struct.
ff3c44e6 Tom Herbert          2016-03-07  325   *
ff3c44e6 Tom Herbert          2016-03-07  326   * Note that if the ptr is at the end of the list, NULL is returned.
ff3c44e6 Tom Herbert          2016-03-07  327   *
ff3c44e6 Tom Herbert          2016-03-07  328   * This primitive may safely run concurrently with the _rcu list-mutation
ff3c44e6 Tom Herbert          2016-03-07  329   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
ff3c44e6 Tom Herbert          2016-03-07  330   */
ff3c44e6 Tom Herbert          2016-03-07  331  #define list_next_or_null_rcu(head, ptr, type, member) \
ff3c44e6 Tom Herbert          2016-03-07  332  ({ \
ff3c44e6 Tom Herbert          2016-03-07  333  	struct list_head *__head = (head); \
ff3c44e6 Tom Herbert          2016-03-07  334  	struct list_head *__ptr = (ptr); \
ff3c44e6 Tom Herbert          2016-03-07  335  	struct list_head *__next = READ_ONCE(__ptr->next); \
ff3c44e6 Tom Herbert          2016-03-07  336  	likely(__next != __head) ? list_entry_rcu(__next, type, \
ff3c44e6 Tom Herbert          2016-03-07  337  						  member) : NULL; \
ff3c44e6 Tom Herbert          2016-03-07  338  })
ff3c44e6 Tom Herbert          2016-03-07  339  
ff3c44e6 Tom Herbert          2016-03-07  340  /**
82524746 Franck Bui-Huu       2008-05-12  341   * list_for_each_entry_rcu	-	iterate over rcu list of given type
82524746 Franck Bui-Huu       2008-05-12  342   * @pos:	the type * to use as a loop cursor.
82524746 Franck Bui-Huu       2008-05-12  343   * @head:	the head for your list.
3943f42c Andrey Utkin         2014-11-14  344   * @member:	the name of the list_head within the struct.
82524746 Franck Bui-Huu       2008-05-12  345   *
82524746 Franck Bui-Huu       2008-05-12  346   * This list-traversal primitive may safely run concurrently with
82524746 Franck Bui-Huu       2008-05-12  347   * the _rcu list-mutation primitives such as list_add_rcu()
82524746 Franck Bui-Huu       2008-05-12  348   * as long as the traversal is guarded by rcu_read_lock().
82524746 Franck Bui-Huu       2008-05-12  349   */
82524746 Franck Bui-Huu       2008-05-12  350  #define list_for_each_entry_rcu(pos, head, member) \
72c6a987 Jiri Pirko           2009-04-14 @351  	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
e66eed65 Linus Torvalds       2011-05-19  352  		&pos->member != (head); \
72c6a987 Jiri Pirko           2009-04-14 @353  		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
82524746 Franck Bui-Huu       2008-05-12  354  
82524746 Franck Bui-Huu       2008-05-12  355  /**
69b90729 Alexey Kardashevskiy 2015-12-05  356   * list_entry_lockless - get the struct for this entry

:::::: The code at line 351 was first introduced by commit
:::::: 72c6a9870f901045f2464c3dc6ee8914bfdc07aa rculist.h: introduce list_entry_rcu() and list_first_entry_rcu()

:::::: TO: Jiri Pirko <jpirko@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7/8Xu/tQvaVZAAA=

--xHFwDpU9dbj6ez1V--
