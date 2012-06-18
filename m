Return-Path: <bhelgaas@google.com>
MIME-Version: 1.0
In-Reply-To: <4FDE827E.30201@huawei.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
 <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
 <4FDB2192.5070709@huawei.com> <CAE9FiQVWhSZBcZM1DXJaN7rsj64YO=OjzOm6XkUqio5fZ5di+w@mail.gmail.com>
 <4FDC5084.6090504@huawei.com> <CAE9FiQVp9gyzRppPDu=bbRbOqY=mu1478YUSAJs=t3Cyvpmh+Q@mail.gmail.com>
 <CAErSpo5q=UJyT=bughbgfGpG19MfnYn6h=X=YFzfUdgLy9KcPg@mail.gmail.com>
 <CAE9FiQUDWForfUOkcLt6ZruTmutfhmR7H+Ct8z9zO_rWB1p8Dw@mail.gmail.com>
 <CABhMZUXWRsY7K+__5RtaksVnVHspnw5sShHSjmLjdCMsm-Fvmw@mail.gmail.com> <4FDE827E.30201@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 12:24:16 -0600
Message-ID: <CAErSpo4BwM8S6CjFEFrQLLs4ZgyRfZ9MX3o3AqOr-pywCKHEOQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bjorn.helgaas@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>, Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 17, 2012 at 7:21 PM, Jiang Liu <jiang.liu@huawei.com> wrote:
> On 2012-6-17 9:55, Bjorn Helgaas wrote:
>> On Sat, Jun 16, 2012 at 4:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Sat, Jun 16, 2012 at 2:48 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
>>>>>
>>>>> We'd better to make all path share as most code as possible.
>>>>> 1. hostbridge scanning during boot -- early, it will check chipset an=
d e820
>>>>> 2. MCFG checking during boot -- early, it will check e820
>>>>> 3. MCFG checking during boot -- late, it will check acpi pnp
>>>>> 4. _CBA checking for hotplug-able pci root bus but it is installed du=
ring boot.
>>>>> 5. _CBA checking for hotplug-able pci root bus during run time.
>>>>>
>>>>> please keep mapping for all entries in MCFG table. aka 1, 2, 3.
>>>>> I have some local patches that will read ext pci conf space before sc=
an pci bus.
>>>>> please check attached one for nehalem-ioh.
>>>>
>>>> I don't think it's a requirement that Gerry keep your Nehalem patch
>>>> working. =A0Your intel_bus.c is not in the tree and you haven't provid=
ed
>>>> an explanation for why it should be.
>>>>
>>>> The only requirement I'm aware of for PCI config access before we
>>>> discover the host bridges via ACPI is for segment group 0, bus 0, as
>>>> mentioned in ACPI spec 5.0, sec 5.2.3.1, PDF page 143, and I think
>>>> that applies only to the first 0x100 bytes of config space. =A0I don't
>>>> think there's a requirement for access to the extended configuration
>>>> space (bytes 0x100-0xFFF). =A0I do not see a requirement that this
>>>> pre-host bridge access happen via MMCONFIG; as far as I can tell, we
>>>> can use the legacy 0xCF8/0xCFC mechanism.
>>>
>>> that one shot for intel host bridge resource discovery before root bus
>>> scanning,
>>> will need to access registers above 0x100.
>>
>> I don't understand what you're saying. =A0Are you disagreeing with
>> something I said above?
>>
>> As far as I know, we can rely on ACPI _CRS completely for host bridge
>> resources. =A0Are there exceptions? =A0What does "one shot for intel hos=
t
>> bridge resource discovery" mean? =A0Are there machines that are broken
>> because we don't have intel_bus.c?
>
> I have consulted Bob Moore about this topic before and Bob said that
> they hasn't encountered a system on which the ACPICA has dependency
> on extended PCI configuration space yet.
>
>>> Current MCFG handling have some sanitary checking during probing.
>>>
>>> Now Jiang is trying to free result and cache it for two MCFG path 2/3.
>>> and later use cached and map again for entries from cached entries.
>>> but when use those cached entries sanitary of those entries are lost.
>>>
>>> so choice would be
>>> 1. cache all checked MMCFG result and use that later
>>> 2. or just leave current MCFG handling alone, just add _CBA support.
>>> like Jiang -v4 version.
>>
>> Choice 2 sounds like a possibility. =A0I probably encouraged mucking
>> around in the current MCFG handling, but if we're not going to
>> actually clean anything up, there's not much point in touching it.
> I prefer the second choice too. Backward compatibility is really
> important on x86, so don't want to break anything here. I could
> help to split the patch set into two parts: one for root bridge
> hotplug and the other for cleanup. This time we could focus on
> the first patch to prepare for host bridge hotplug, and have
> more time to discuss about the cleanup work.
>
> On the other hand, BIOS should report MMCONFIG information by _CBA
> if a host bridge supports physical hotplug. So the cleanup only
> benefits two cases:
> 1) BIOS reports MMCONFIG information for hot-pluggable host bridges
> =A0 in MCFG table. This is really a BIOS bug. Currently we have no
> =A0 really x86 platforms in the field which support PCI host bridge
> =A0 hotplug yet. So it may be acceptable for OS to report such bugs
> =A0 and let BIOS people to fix them.
> 2) Account MMCONFIG information to specific host bridges. It does
> =A0 give better representation about the MMCONFIG resource usages,
> =A0 but it's on risk of breaking backward compatibilities.
>
> So should we adopt the second solution here?

Yes, let's try that.  I'm sorry I encouraged you to go on a wild goose chas=
e.
