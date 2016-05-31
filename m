Return-Path: <yu.c.chen@intel.com>
Return-Path: <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost> <20160530221123.GA13535@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yinghai Lu <yinghai@kernel.org>
From: Chen Yu <yu.c.chen@intel.com>
Message-ID: <574D0523.3020009@intel.com>
Date: Tue, 31 May 2016 11:29:39 +0800
MIME-Version: 1.0
In-Reply-To: <20160530221123.GA13535@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

On 2016年05月31日 06:11, Lukas Wunner wrote:
> On Mon, May 30, 2016 at 04:33:05PM -0500, Bjorn Helgaas wrote:
>> On Mon, May 30, 2016 at 06:33:24PM +0800, Chen Yu wrote:
>>> Currently there are many people reported that they can not
>>> do a poweroff nor a suspend to memory on their Mac Pro 11.
>>> After some investigations it was found that, once the PCI bridge
>>> 0000:00:1c.0 reassigns its mm windows([mem 0x7fa00000-0x7fbfffff]
>>> and [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
>>> io resource 0x1804 becomes unaccessible immediately, where the
>>> ACPI Sleep register is located, as a result neither poweroff(S5)
>>> nor suspend to memory(S3) works.
>>>
>>> I don't know why setting the base/limit of PCI bridge mem resource
>>> would affect another io resource region, so this quirk just simply
>>> bypass the assignment of these mm resources on 0000:00:1c.0, by
>>> resetting the resource flag to 0 before updating the base/limit registers.
>>> This patch also introduces a new pci fixup phase before the actual bridge
>>> resource assignment.
>> Split the new fixup phase into a separate patch.
>>
>> I'm doubtful about this because we don't understand the root cause.
> Agreed.
>
>
>>> +}
>>> +DECLARE_PCI_FIXUP_ASSIGN(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_mac_disable_mmio_bar);
>> Is this device *only* used on the Mac Pro 11?  http://pci-ids.ucs.cz
>> says "8 Series/C220 Series Chipset Family PCI Express Root Port #1",
>> which sounds pretty generic.
> It's a root port of a standard Haswell chipset.
>
> This concerns the Mac*Book*Pro11 (not MacPro11), and apparently only
> the two models introduced 2015, MacBookPro11,4 and MacBookPro11,5
> (can be queried with DMI). I've never heard of issues like this on the
> 2013/2014 models (MacBookPro11,1 to 11,3).
>
> Looking at the lspci output of the MacBookPro11,4 I notice that the
> root port in question, 00:1c.0, has secondary bus 02 below it, but
> there are no devices listed on that bus:
> https://bugzilla.kernel.org/attachment.cgi?id=218181
>
> On the MacBookPro11,5, there's bus 03 below that port, but likewise
> without any devices:
> https://launchpadlibrarian.net/222477783/Lspci.txt
>
> It looks like this root port is unused, so perhaps the best option
> is to disable it as if it were an appendix. I.e., don't scan it at all,
> put it into D3 and leave it alone.

I used to bypass the probe for this pci bridge:
https://bugzilla.kernel.org/attachment.cgi?id=216661
, but it looks like although poweroff works however
the wifi and facetime are broken:
https://bugzilla.kernel.org/show_bug.cgi?id=103211#c109

Thanks,
Yu
