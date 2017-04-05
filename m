Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V8 1/6] LIBIO: Introduce a generic PIO mapping method
To: kbuild test robot <lkp@intel.com>, fengguang.wu@intel.com
References: <201704011328.1YdgEHnc%fengguang.wu@intel.com>
From: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Message-ID: <9fb5224f-eec3-5b03-e5f9-169280ef4c49@gmail.com>
Date: Wed, 5 Apr 2017 20:18:55 +0800
MIME-Version: 1.0
In-Reply-To: <201704011328.1YdgEHnc%fengguang.wu@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com,
 rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-acpi@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 john.garry@huawei.com, olof@lixom.net, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, kbuild-all@01.org,
 zourongrong@gmail.com, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for your report!

I am sorry for that!

This issue was caused by missing the '#include <linux/logic_pio.h>' in
logic_pio.c for some architectures where the 'asm-generic/io.h' wasn't been
included.

Will be fixed in the next V9.

Apologized for this!

-Zhichang


On 04/01/2017 01:58 PM, kbuild test robot wrote:
> Hi zhichang.yuan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.11-rc4 next-20170331]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LIBIO-Introduce-a-generic-PIO-mapping-method/20170401-104801
> config: alpha-allyesconfig (attached as .config)
> compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=alpha 
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> lib/logic_pio.c:32:50: error: 'PIO_MAX_SECT' undeclared here (not in a function)
>     static struct logic_pio_root logic_pio_root_list[PIO_MAX_SECT] = {
>                                                      ^~~~~~~~~~~~
>>> lib/logic_pio.c:39:3: error: 'PIO_CPU_MMIO' undeclared here (not in a function)
>      [PIO_CPU_MMIO ... PIO_INDIRECT - 1] = {
>       ^~~~~~~~~~~~
>>> lib/logic_pio.c:39:20: error: 'PIO_INDIRECT' undeclared here (not in a function)
>      [PIO_CPU_MMIO ... PIO_INDIRECT - 1] = {
>                        ^~~~~~~~~~~~
>>> lib/logic_pio.c:39:3: error: array index in initializer not of integer type
>      [PIO_CPU_MMIO ... PIO_INDIRECT - 1] = {
>       ^~~~~~~~~~~~
>    lib/logic_pio.c:39:3: note: (near initialization for 'logic_pio_root_list')
>>> lib/logic_pio.c:40:3: error: field name not in record or union initializer
>       .sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
>       ^
>    lib/logic_pio.c:40:3: note: (near initialization for 'logic_pio_root_list')
>    lib/logic_pio.c:41:3: error: field name not in record or union initializer
>       .sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
>       ^
>    lib/logic_pio.c:41:3: note: (near initialization for 'logic_pio_root_list')
>>> lib/logic_pio.c:41:14: error: implicit declaration of function 'PIO_SECT_MIN' [-Werror=implicit-function-declaration]
>       .sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
>                  ^~~~~~~~~~~~
>    lib/logic_pio.c:42:3: error: field name not in record or union initializer
>       .sec_max = PIO_SECT_MAX(PIO_INDIRECT - 1),
>       ^
>    lib/logic_pio.c:42:3: note: (near initialization for 'logic_pio_root_list')
>>> lib/logic_pio.c:42:14: error: implicit declaration of function 'PIO_SECT_MAX' [-Werror=implicit-function-declaration]
>       .sec_max = PIO_SECT_MAX(PIO_INDIRECT - 1),
>                  ^~~~~~~~~~~~
>    lib/logic_pio.c:46:3: error: array index in initializer not of integer type
>      [PIO_INDIRECT] = {
>       ^~~~~~~~~~~~
>    lib/logic_pio.c:46:3: note: (near initialization for 'logic_pio_root_list')
>    lib/logic_pio.c:47:3: error: field name not in record or union initializer
>       .sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_INDIRECT].sec_head),
>       ^
>    lib/logic_pio.c:47:3: note: (near initialization for 'logic_pio_root_list')
>    lib/logic_pio.c:48:3: error: field name not in record or union initializer
>       .sec_min = PIO_SECT_MIN(PIO_INDIRECT),
>       ^
>    lib/logic_pio.c:48:3: note: (near initialization for 'logic_pio_root_list')
>    lib/logic_pio.c:49:3: error: field name not in record or union initializer
>       .sec_max = PIO_SECT_MAX(PIO_INDIRECT),
>       ^
>    lib/logic_pio.c:49:3: note: (near initialization for 'logic_pio_root_list')
>    In file included from include/linux/list.h:8:0,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:21,
>                     from lib/logic_pio.c:18:
>    lib/logic_pio.c: In function 'logic_pio_find_range_byaddr':
>>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type 'struct logic_pio_hwaddr'
>      for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
>                                                      
>    include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
>      const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                      ^~~~
>>> include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
>      for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
>                 ^~~~~~~~~~~~~~
>>> lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
>      list_for_each_entry_rcu(range, &io_range_list, list) {
>      ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                                                    ^
>>> include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
>      container_of(lockless_dereference(ptr), type, member)
>      ^~~~~~~~~~~~
>>> include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
>      for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
>                 ^~~~~~~~~~~~~~
>>> lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
>      list_for_each_entry_rcu(range, &io_range_list, list) {
>      ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/kernel.h:852:48: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>      const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                                                    ^
>>> include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
>      container_of(lockless_dereference(ptr), type, member)
>      ^~~~~~~~~~~~
>    include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
>       pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
>             ^~~~~~~~~~~~~~
>>> lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
>      list_for_each_entry_rcu(range, &io_range_list, list) {
>      ^~~~~~~~~~~~~~~~~~~~~~~
>    lib/logic_pio.c: In function 'logic_pio_alloc_range':
>>> lib/logic_pio.c:109:19: error: dereferencing pointer to incomplete type 'struct logic_pio_root'
>      idle_start = root->sec_min;
>                       ^~
>    In file included from include/linux/list.h:8:0,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:21,
>                     from lib/logic_pio.c:18:
>>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type 'struct logic_pio_sect'
>      for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
>                                                      
>    include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
>      const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                      ^~~~
>>> include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
>      for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
>                 ^~~~~~~~~~~~~~
>    lib/logic_pio.c:111:2: note: in expansion of macro 'list_for_each_entry_rcu'
>      list_for_each_entry_rcu(entry, &root->sec_head, list) {
>      ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/kernel.h:852:48: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>      const typeof( ((type *)0)->member ) *__mptr = (ptr); \
>                                                    ^
> 
> vim +/PIO_MAX_SECT +32 lib/logic_pio.c
> 
>     12	 * GNU General Public License for more details.
>     13	 *
>     14	 * You should have received a copy of the GNU General Public License
>     15	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>     16	 */
>     17	
>   > 18	#include <linux/of.h>
>     19	#include <linux/io.h>
>     20	#include <linux/mm.h>
>     21	#include <linux/rculist.h>
>     22	#include <linux/sizes.h>
>     23	#include <linux/slab.h>
>     24	
>     25	/* The unique hardware address list. */
>     26	static LIST_HEAD(io_range_list);
>     27	static DEFINE_MUTEX(io_range_mutex);
>     28	
>     29	/*
>     30	 * These are the lists for PIO. The highest PIO_SECT_BITS of PIO is the index.
>     31	 */
>   > 32	static struct logic_pio_root logic_pio_root_list[PIO_MAX_SECT] = {
>     33	#ifdef CONFIG_INDIRECT_PIO
>     34		/*
>     35		 * At this moment, assign all the other logic PIO space to MMIO.
>     36		 * If more elements added, please adjust the ending index and .sec_max;
>     37		 * Please keep MMIO element started from index ZERO.
>     38		 */
>   > 39		[PIO_CPU_MMIO ... PIO_INDIRECT - 1] = {
>   > 40			.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
>   > 41			.sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
>   > 42			.sec_max = PIO_SECT_MAX(PIO_INDIRECT - 1),
>     43		},
>     44	
>     45		/* The last element */
>     46		[PIO_INDIRECT] = {
>     47			.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_INDIRECT].sec_head),
>     48			.sec_min = PIO_SECT_MIN(PIO_INDIRECT),
>     49			.sec_max = PIO_SECT_MAX(PIO_INDIRECT),
>     50		},
>     51	#else
>     52		[PIO_CPU_MMIO] = {
>     53			.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
>     54			.sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
>     55			.sec_max = PIO_SECT_MAX(PIO_CPU_MMIO),
>     56		},
>     57	
>     58	#endif
>     59	};
>     60	
>     61	/*
>     62	 * Search a io_range registered which match the fwnode and addr.
>     63	 *
>     64	 * @fwnode: the host fwnode which must be valid;
>     65	 * @start: the start hardware address of this search;
>     66	 * @end: the end hardware address of this search. can be equal to @start;
>     67	 *
>     68	 * return NULL when there is no matched node; IS_ERR() means ERROR;
>     69	 * valid virtual address represent a matched node was found.
>     70	 */
>     71	static struct logic_pio_hwaddr *
>     72	logic_pio_find_range_byaddr(struct fwnode_handle *fwnode,
>     73				resource_size_t start, resource_size_t end)
>     74	{
>     75		struct logic_pio_hwaddr *range;
>     76	
>   > 77		list_for_each_entry_rcu(range, &io_range_list, list) {
>     78			if (!range->pio_peer) {
>     79				pr_warn("Invalid cpu addr node(%pa) in list!\n",
>     80					&range->hw_start);
>     81				continue;
>     82			}
>     83			if (range->fwnode != fwnode)
>     84				continue;
>     85			/* without any overlap with current range */
>     86			if (start >= range->hw_start + range->size ||
>     87				end < range->hw_start)
>     88				continue;
>     89			/* overlap is not supported now. */
>     90			if (start < range->hw_start ||
>     91				end >= range->hw_start + range->size)
>     92				return ERR_PTR(-EBUSY);
>     93			/* had been registered. */
>     94			return range;
>     95		}
>     96	
>     97		return NULL;
>     98	}
>     99	
>    100	
>    101	static int logic_pio_alloc_range(struct logic_pio_root *root,
>    102			resource_size_t size, unsigned long align,
>    103			struct list_head **prev, resource_size_t *pio_alloc)
>    104	{
>    105		struct logic_pio_sect *entry;
>    106		resource_size_t tmp_start;
>    107		resource_size_t idle_start, idle_end;
>    108	
>  > 109		idle_start = root->sec_min;
>    110		*prev = &root->sec_head;
>    111		list_for_each_entry_rcu(entry, &root->sec_head, list) {
>    112			if (!entry->hwpeer ||
>    113				idle_start > entry->io_start) {
>    114				WARN(1, "skip an invalid io range during traversal!\n");
>    115				goto nextentry;
>    116			}
>    117			/* set the end edge. */
>    118			if (idle_start == entry->io_start) {
>    119				struct logic_pio_sect *next;
>    120	
>    121				idle_start = entry->io_start + entry->hwpeer->size;
>  > 122				next = list_next_or_null_rcu(&root->sec_head,
>  > 123					&entry->list, struct logic_pio_sect, list);
>    124				if (next) {
>    125					entry = next;
>    126				} else {
>    127					*prev = &entry->list;
>    128					break;
>    129				}
>    130			}
>    131			idle_end = entry->io_start - 1;
>    132	
>    133			/* contiguous range... */
>    134			if (idle_start > idle_end)
>    135				goto nextentry;
>    136	
>    137			tmp_start = idle_start;
>    138			idle_start = ALIGN(idle_start, align);
>    139			if (idle_start >= tmp_start &&
>    140				idle_start + size <= idle_end) {
>    141				*prev = &entry->list;
>    142				*pio_alloc = idle_start;
>    143				return 0;
>    144			}
>    145	
>    146	nextentry:
>    147			idle_start = entry->io_start + entry->hwpeer->size;
>    148			*prev = &entry->list;
>    149		}
>    150		/* check the last free gap... */
>    151		idle_end = root->sec_max;
>    152	
>    153		tmp_start = idle_start;
>    154		idle_start = ALIGN(idle_start, align);
>    155		if (idle_start >= tmp_start &&
>    156			idle_start + size <= idle_end) {
>    157			*pio_alloc = idle_start;
>    158			return 0;
>    159		}
>    160	
>    161		return -EBUSY;
>    162	}
>    163	
>    164	/*
>    165	 * register a io range node in the io range list.
>    166	 *
>    167	 * @newrange: pointer to the io range to be registered.
>    168	 *
>    169	 * return 'newrange' when success, ERR_VALUE() is for failures.
>    170	 * specially, return a valid pointer which is not equal to 'newrange' when
>    171	 * the io range had been registered before.
>    172	 */
>    173	struct logic_pio_hwaddr
>    174	*logic_pio_register_range(struct logic_pio_hwaddr *newrange,
>    175			unsigned long align)
>    176	{
>    177		struct logic_pio_hwaddr *range;
>    178		struct logic_pio_sect *newsect;
>    179		resource_size_t pio_alloc;
>    180		struct list_head *prev, *hwprev;
>    181		unsigned long sect_id;
>    182		int err;
>    183	
>    184		if (!newrange || !newrange->fwnode || !newrange->size)
>    185			return ERR_PTR(-EINVAL);
>    186	
>    187		sect_id = newrange->flags;
>    188		if (sect_id >= PIO_MAX_SECT)
>    189			return ERR_PTR(-EINVAL);
>    190	
>    191		mutex_lock(&io_range_mutex);
>    192		range = logic_pio_find_range_byaddr(newrange->fwnode,
>    193				newrange->hw_start,
>    194				newrange->hw_start + newrange->size - 1);
>    195		if (range) {
>    196			if (!IS_ERR(range))
>    197				pr_info("the request IO range had been registered!\n");
>    198			else
>    199				pr_err("registering IO[%pa - sz%pa) got failed!\n",
>    200					&newrange->hw_start, &newrange->size);
>    201			mutex_unlock(&io_range_mutex);
>    202			return range;
>    203		}
>    204	
>    205		err = logic_pio_alloc_range(&logic_pio_root_list[sect_id],
>    206				newrange->size, align, &prev, &pio_alloc);
>    207		if (err) {
>    208			pr_err("can't find free %pa logical IO range!\n",
>    209				&newrange->size);
>    210			goto exitproc;
>    211		}
>    212	
>    213		if (prev == &logic_pio_root_list[sect_id].sec_head) {
>    214			hwprev = &io_range_list;
>    215		} else {
>  > 216			newsect = to_pio_sect(prev);
>  > 217			hwprev = &newsect->hwpeer->list;
>    218		}
>    219	
>    220		newsect = kzalloc(sizeof(*newsect), GFP_KERNEL);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
