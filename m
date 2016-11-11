Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
To: "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F5D75@lhreml507-mbx>
 <10334260.ztLXZ2Oynd@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F900A@lhreml507-mbx>
 <20161111144539.GL10219@e106497-lin.cambridge.arm.com>
From: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Message-ID: <1eae3951-f1d9-c1c5-f70c-33150bc514ea@gmail.com>
Date: Sat, 12 Nov 2016 00:54:05 +0800
MIME-Version: 1.0
In-Reply-To: <20161111144539.GL10219@e106497-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "bhelgaas@googl e.com" <bhelgaas@google.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "minyard@acm.org" <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Liviu,


On 11/11/2016 10:45 PM, liviu.dudau@arm.com wrote:
> On Fri, Nov 11, 2016 at 01:39:35PM +0000, Gabriele Paoloni wrote:
>> Hi Arnd
>>
>>> -----Original Message-----
>>> From: Arnd Bergmann [mailto:arnd@arndb.de]
>>> Sent: 10 November 2016 16:07
>>> To: Gabriele Paoloni
>>> Cc: linux-arm-kernel@lists.infradead.org; Yuanzhichang;
>>> mark.rutland@arm.com; devicetree@vger.kernel.org;
>>> lorenzo.pieralisi@arm.com; minyard@acm.org; linux-pci@vger.kernel.org;
>>> benh@kernel.crashing.org; John Garry; will.deacon@arm.com; linux-
>>> kernel@vger.kernel.org; xuwei (O); Linuxarm; zourongrong@gmail.com;
>>> robh+dt@kernel.org; kantyzc@163.com; linux-serial@vger.kernel.org;
>>> catalin.marinas@arm.com; olof@lixom.net; liviu.dudau@arm.com;
>>> bhelgaas@googl e.com; zhichang.yuan02@gmail.com
>>> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
>>> Hip06
>>>
>>> On Thursday, November 10, 2016 3:36:49 PM CET Gabriele Paoloni wrote:
>>>>
>>>> Where should we get the range from? For LPC we know that it is going
>>>> Work on anything that is not used by PCI I/O space, and this is
>>>> why we use [0, PCIBIOS_MIN_IO]
>>>
>>> It should be allocated the same way we allocate PCI config space
>>> segments. This is currently done with the io_range list in
>>> drivers/pci/pci.c, which isn't perfect but could be extended
>>> if necessary. Based on what others commented here, I'd rather
>>> make the differences between ISA/LPC and PCI I/O ranges smaller
>>> than larger.
> 
> Gabriele,
> 
>>
>> I am not sure this would make sense...
>>
>> IMHO all the mechanism around io_range_list is needed to provide the
>> "mapping" between I/O tokens and physical CPU addresses.
>>
>> Currently the available tokens range from 0 to IO_SPACE_LIMIT.
>>
>> As you know the I/O memory accessors operate on whatever
>> __of_address_to_resource sets into the resource (start, end).
>>
>> With this special device in place we cannot know if a resource is
>> assigned with an I/O token or a physical address, unless we forbid
>> the I/O tokens to be in a specific range.
>>
>> So this is why we are changing the offsets of all the functions
>> handling io_range_list (to make sure that a range is forbidden to
>> the tokens and is available to the physical addresses).
>>
>> We have chosen this forbidden range to be [0, PCIBIOS_MIN_IO)
>> because this is the maximum physical I/O range that a non PCI device
>> can operate on and because we believe this does not impose much
>> restriction on the available I/O token range; that now is 
>> [PCIBIOS_MIN_IO, IO_SPACE_LIMIT].
>> So we believe that the chosen forbidden range can accommodate
>> any special ISA bus device with no much constraint on the rest
>> of I/O tokens...
> 
> Your idea is a good one, however you are abusing PCIBIOS_MIN_IO and you
> actually need another variable for "reserving" an area in the I/O space
> that can be used for physical addresses rather than I/O tokens.
> 
I think selecting PCIBIOS_MIN_IO as the separator of mapped and non-mapped I/O
range probably is not so reasonable.
PCIBIOS_MIN_IN is specific to PCI devices, it seems as the recommended minimal
start I/O address when assigning the pci device I/O region. It is probably not
defined in some platforms/architectures when no PCI is needed there. That is why
my patch caused some compile error on some archs;

But more important thing is that the PCIBIOS_MIN_IO has different value on
different platforms/architectures. On Arm64, it is 4K currently, but in other
archs, it is not true. And the maximum LPC I/O address should be 64K
theoretically, although for compatible ISA, 2K is enough.
So, It means using PCIBIOS_MIN_IO on arm64 can match our I/O reservation
require. But we can not make this indirectIO work well on other architectures.

I am thinking Arnd's suggestion. But I worry about I haven't completely
understood his idea. What about create a new bus host for LPC/ISA whose I/O
range can be 64KB? This LPC/ISA I/O range works similar to PCI host bridge's I/O
window, all the downstream devices under LPC/ISA should request I/O from that
root resource. But it seems Arnd want this root resource registered dynamically,
I am not sure how to do...

Anyway, if we have this root I/O resource, we don't need any new macro or
variable for the LPC/ISA I/O reservation.

Hope my thought is right.

Best,
Zhichang


> The one good example for using PCIBIOS_MIN_IO is when your platform/architecture
> does not support legacy ISA operations *at all*. In that case someone
> sets the PCIBIOS_MIN_IO to a non-zero value to reserve that I/O range
> so that it doesn't get used. With Zhichang's patch you now start forcing
> those platforms to have a valid address below PCIBIOS_MIN_IO.
> 
> For the general case you also have to bear in mind that PCIBIOS_MIN_IO could
> be zero. In that case, what is your "forbidden" range? [0, 0) ? So it makes
> sense to add a new #define that should only be defined by those architectures/
> platforms that want to reserve on top of PCIBIOS_MIN_IO another region
> where I/O tokens can't be generated for.
> 
> Best regards,
> Liviu
> 
>>
>>>
>>>>> Your current version has
>>>>>
>>>>>         if (arm64_extio_ops->pfout)                             \
>>>>>                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
>>>>>                        addr, value, sizeof(type));             \
>>>>>
>>>>> Instead, just subtract the start of the range from the logical
>>>>> port number to transform it back into a bus-local port number:
>>>>
>>>> These accessors do not operate on IO tokens:
>>>>
>>>> If (arm64_extio_ops->start > addr || arm64_extio_ops->end < addr)
>>>> addr is not going to be an I/O token; in fact patch 2/3 imposes that
>>>> the I/O tokens will start at PCIBIOS_MIN_IO. So from 0 to
>>> PCIBIOS_MIN_IO
>>>> we have free physical addresses that the accessors can operate on.
>>>
>>> Ah, I missed that part. I'd rather not use PCIBIOS_MIN_IO to refer to
>>> the logical I/O tokens, the purpose of that macro is really meant
>>> for allocating PCI I/O port numbers within the address space of
>>> one bus.
>>
>> As I mentioned above, special devices operate on CPU addresses directly,
>> not I/O tokens. For them there is no way to distinguish....
>>
>>>
>>> Note that it's equally likely that whichever next platform needs
>>> non-mapped I/O access like this actually needs them for PCI I/O space,
>>> and that will use it on addresses registered to a PCI host bridge.
>>
>> Ok so here you are talking about a platform that has got an I/O range
>> under the PCI host controller, right?
>> And this I/O range cannot be directly memory mapped but needs special
>> redirections for the I/O tokens, right?
>>
>> In this scenario registering the I/O ranges with the forbidden range
>> implemented by the current patch would still allow to redirect I/O
>> tokens as long as arm64_extio_ops->start >= PCIBIOS_MIN_IO
>>
>> So effectively the special PCI host controller
>> 1) knows the physical range that needs special redirection
>> 2) register such range
>> 3) uses pci_pio_to_address() to retrieve the IO tokens for the
>>    special accessors
>> 4) sets arm64_extio_ops->start/end to the IO tokens retrieved in 3)
>>
>> So to be honest I think this patch can fit well both with
>> special PCI controllers that need I/O tokens redirection and with
>> special non-PCI controllers that need non-PCI I/O physical
>> address redirection...
>>
>> Thanks (and sorry for the long reply but I didn't know how
>> to make the explanation shorter :) )
>>
>> Gab
>>
>>>
>>> If we separate the two steps:
>>>
>>> a) assign a range of logical I/O port numbers to a bus
>>> b) register a set of helpers for redirecting logical I/O
>>>    port to a helper function
>>>
>>> then I think the code will get cleaner and more flexible.
>>> It should actually then be able to replace the powerpc
>>> specific implementation.
>>>
>>> 	Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
