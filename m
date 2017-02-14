Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 John Garry <john.garry@huawei.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
 bhelgaas@google.com, rafael@kernel.org, mark.rutland@arm.com,
 brian.starkey@arm.com, olof@lixom.net, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
 <6d5523be-1841-18b9-9b83-6f7e591ed66b@huawei.com>
 <1a1f1e70-b6e7-f3c6-2b86-348b3d28edfe@suse.de>
 <58A1BFE5.7050800@hisilicon.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <ee15da3a-b1d6-2fcb-ddf5-ebe9249fd9ee@suse.de>
Date: Tue, 14 Feb 2017 14:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <58A1BFE5.7050800@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 zhichang.yuan02@gmail.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-serial@vger.kernel.org,
 linux-pci@vger.kernel.org, zourongrong@gmail.com, kantyzc@163.com
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 13/02/2017 15:17, zhichang.yuan wrote:
> Hi, Alex,
>
>
> On 2017/2/1 3:37, Alexander Graf wrote:
>>
>>
>> On 31/01/2017 14:32, John Garry wrote:
>>> On 30/01/2017 17:12, Alexander Graf wrote:
>>>> On 01/24/2017 08:05 AM, zhichang.yuan wrote:
>>>>> Low-pin-count interface is integrated into some SoCs. The accesses to
>>>>> those
>>>>> peripherals under LPC make use of I/O ports rather than the memory
>>>>> mapped I/O.
>>>>>
>>>>> To drive these devices, this patch introduces a method named
>>>>> indirect-IO.
>>>>> In this method the in/out() accessor in include/asm-generic/io.h will be
>>>>> redefined. When upper layer drivers call in/out() with those known
>>>>> legacy port
>>>>> addresses to access the peripherals, the I/O operations will be routed
>>>>> to the
>>>>> right hooks which are registered specific to the host device, such as
>>>>> LPC.
>>>>> Then the hardware relevant manupulations are finished by the
>>>>> corresponding
>>>>> host.
>>>>>
>>>>> According to the comments on V5, this patch adds a common indirect-IO
>>>>> driver
>>>>> which support this I/O indirection to the generic directory.
>>>>>
>>>>> In the later pathches, some host-relevant drivers are implemented to
>>>>> support
>>>>> the specific I/O hooks and register them.
>>>>> Based on these, the upper layer drivers which depend on in/out() can
>>>>> work well
>>>>> without any extra work or any changes.
>>>>>
>>>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>
>>>> I like the extio idea. That allows us to handle all PIO requests on
>>>> platforms that don't have native PIO support via different routes
>>>> depending on the region they're in. Unfortunately we now we have 2
>>>> frameworks for handling sparse PIO regions: One in extio, one in PCI.
>>>>
>>>> Why don't we just merge the two? Most of the code that has #ifdef
>>>> PCI_IOBASE throughout the code base sounds like an ideal candidate to
>>>> get migrated to extio instead. Then we only have a single framework to
>>>> worry about ...
>>>
>>> To be clear, are you suggesting we merge the functionality from
>>> pci_register_io_range(), pci_pio_to_address(), pci_address_to_pio() into
>>> extio, so extio manages all PIO?
>>
>> Yes, I guess so.
>>
>>> And having a single type of node to
>>> register PIO ranges, by amalgamating struct extio_node and io_range (as
>>> Bjorn mentioned)?
>>
>> I'm not quite sure I follow you here. Basically I think you want a generic "non-x86 PIO" framework that PCI just plugs into.
>>
>> I don't think that necessarily means you want to statically allocate regions of that PIO space to separate (pseudo-)devices. Instead, everyone shares that space and should be able to fail gracefully if some space is already occupied.
>>
>>> It would make sense. We would be somewhat decoupling PIO from PCI.
>>
>> Yes :).
>>
>>> I think that other architectures, like PPC, and other code would need to
>>> be fixed up to handle this.
>>
>> I think only PPC, Microblaze and ARM are using this. Grep for PCI_IOBASE. It's not that many.
>>
>>> We need to consider all the other challenges/obstacles to this.
>>
>> Well, getting our abstraction levels right to me sounds like it's worth the obstacles.
>>
>>>
>>>>
>>>>> ---
>>>>>   include/asm-generic/io.h |  50 ++++++++++++++++
>>>>>   include/linux/extio.h    |  85 +++++++++++++++++++++++++++
>>>>>   include/linux/io.h       |   1 +
>>>>>   lib/Kconfig              |   8 +++
>>>>>   lib/Makefile             |   2 +
>>>>>   lib/extio.c              | 147
>>>>> +++++++++++++++++++++++++++++++++++++++++++++++ xc>>   create mode
>>>>> 100644 include/linux/extio.h
>>>>>   create mode 100644 lib/extio.c
>>>>>
>>>
>>> <snip>
>>>
>>>>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>>>>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>> + * published by the Free Software Foundation.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + * You should have received a copy of the GNU General Public License
>>>>> + * along with this program.  If not, see
>>>>> <http://www.gnu.org/licenses/>.
>>>>> + */
>>>>> +
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/spinlock.h>
>>>>> +
>>>>> +static LIST_HEAD(extio_dev_list);
>>>>> +static DEFINE_RWLOCK(extio_list_lock);
>>>>
>>>> Why not just make the list an RCU list? Then you don't need read locks.
>>>> We also wouldn't create potential lock contention between devices that
>>>> could easily have parallel PIO operations (say a PCI device and an LPC
>>>> device).
>>>>
>>>
>>> OK
>>>
>>>>> +
>>>>> +void register_extio(struct extio_node *node)
>>>>> +{
>>>>> +    write_lock(&extio_list_lock);
>>>>> +    list_add_tail(&node->list, &extio_dev_list);
>>>>> +    write_unlock(&extio_list_lock);
>>>>> +}
>>>>> +
>>>>> +static struct extio_node *find_extio_token(unsigned long addr)
>>>>> +{
>>>>> +    struct extio_node *extio_entry;
>>>>> +
>>>>> +    read_lock(&extio_list_lock);
>>>>> +    list_for_each_entry(extio_entry, &extio_dev_list, list) {
>>>>> +        if ((addr < extio_entry->io_start + extio_entry->range_size) &&
>>>>> +            (addr >= extio_entry->io_start))
>>>>> +            break;
>>>>> +    }
>>>>> +    read_unlock(&extio_list_lock);
>>>>> +    return (&extio_entry->list == &extio_dev_list) ? NULL :
>>>>> extio_entry;
>>>>> +}
>>>>> +
>>>>> +struct extio_node *extio_find_node(struct fwnode_handle *node)
>>>>> +{
>>>>> +    struct extio_node *entry;
>>>>> +
>>>>> +    read_lock(&extio_list_lock);
>>>>> +    list_for_each_entry(entry, &extio_dev_list, list) {
>>>>> +        if (entry->fwnode == node)
>>>>> +            break;
>>>>> +    }
>>>>> +    read_unlock(&extio_list_lock);
>>>>> +
>>>>> +    return (&entry->list == &extio_dev_list) ? NULL : entry;
>>>>> +}
>>>>> +
>>>>> +unsigned long extio_translate(struct fwnode_handle *node,
>>>>> +        unsigned long bus_addr)
>>>>> +{
>>>>> +    struct extio_node *entry;
>>>>> +    unsigned long port_id = -1;
>>>>> +
>>>>> +    read_lock(&extio_list_lock);
>>>>> +    list_for_each_entry(entry, &extio_dev_list, list) {
>>>>> +        if (entry->fwnode == node &&
>>>>> +            bus_addr >= entry->bus_start &&
>>>>> +            bus_addr - entry->bus_start < entry->range_size)
>>>>> +            port_id = entry->io_start + bus_addr -
>>>>> +                    entry->bus_start;
>>>>> +    }
>>>>> +    read_unlock(&extio_list_lock);
>>>>> +
>>>>> +    return port_id;
>>>>> +}
>>>>> +
>>>>> +#ifdef PCI_IOBASE
>>>>> +
>>>>> +#define BUILD_EXTIO(bw, type)                        \
>>>>> +type extio_in##bw(unsigned long addr)                    \
>>>>> +{                                    \
>>>>> +    struct extio_node *extio_entry = find_extio_token(addr);    \
>>>>> +                                    \
>>>>> +    if (!extio_entry)                        \
>>>>> +        return read##bw(PCI_IOBASE + addr);            \
>>>>> +    return extio_entry->ops->pfin ?                    \
>>>>> +            extio_entry->ops->pfin(extio_entry->devpara,    \
>>>>> +            addr, sizeof(type)) : -1;            \
>>>>> +}                                    \
>>>>> +                                    \
>>>>> +void extio_out##bw(type value, unsigned long addr)            \
>>>>> +{                                    \
>>>>> +    struct extio_node *extio_entry = find_extio_token(addr);    \
>>>>> +                                    \
>>>>> +    if (!extio_entry)                        \
>>>>> +        write##bw(value, PCI_IOBASE + addr);            \
>>>>
>>>> All of the fallback code would also disappear as a nice side effect of
>>>> making pci pio handling a user of extio :).
>>>
>>> Is your idea that PCI IO space will also register accessors, which would
>>> be the same read{b,w,l}/write{b,w,l}?
>
> I am not so sure what is your ideas on this. Do you mean the snippet like these:
>
> #define BUILD_IO(bw, type)					\
> type extio_in##bw(unsigned long addr) 				\
> { 								\
> 	struct io_range *entry = find_io_range(addr); 		\
> 								\
> 	if (entry) 						\
> 		return entry->ops->pfin(entry->devpara, 	\
> 			addr, sizeof(type)); 			\
> 	return read##bw(PCI_IOBASE + addr);			\
> }
>
> we add the last 'return read##bw(PCI_IOBASE + addr);' to keep the original logic of inX() in asm-generic/io.h;
> In above snippet, all the hosts applied extio should register their own ops->pfin().

Right, PCI would just register its own ops->pfin() which then calls an 
MMIO read function relative to *its own* PCI PIO window. There's no 
reason we couldn't have 2 PCI root complexes in a system. Then you would 
end up with 2 PIO spaces - one for each PCI bus.


Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
