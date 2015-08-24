Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36865 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbHXQdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 12:33:54 -0400
Received: by widdq5 with SMTP id dq5so77269579wid.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 09:33:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1508241605130.3969@localhost.lm.intel.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150821150800.7525.14750.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAErSpo7wEpPSy9BSt6t5UYXSqbXRf_Wu-1kzDCzmowO60UqKTQ@mail.gmail.com> <alpine.LNX.2.00.1508241605130.3969@localhost.lm.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Aug 2015 09:33:33 -0700
Message-ID: <CAErSpo55h5CfhNWOMSpvZ4hrAo_NkGezP9ow6Vey=_M4Y1fvAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Change MPS default to "match upstream bridge"
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 24, 2015 at 9:13 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 21 Aug 2015, Bjorn Helgaas wrote:
>>
>> On Fri, Aug 21, 2015 at 8:08 AM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>>>
>>> Change the default MPS tuning policy to "default," which means we set
>>> every
>>> device's MPS to match its upstream bridge.  Typically this means we'll
>>> preserve the fabric configuration done by firmware, even for hot-added
>>> devices.
>>>
>>> N.B. This effectively re-enables quirk_intel_mc_errata(), which turns off
>>> read completion coalescing on Intel 5000 and 5100 memory controllers.
>>
>>
>> I think this patch might be the wrong thing for quirk_intel_mc_errata().
>>
>> Currently, the default is PCIE_BUS_TUNE_OFF.  In that case, the quirk
>> does nothing, Linux doesn't touch MPS at all, and the BIOS is
>> responsible for avoiding the erratum, either by disabling read
>> coalescing or by avoiding MPS=256.
>>
>> This patch (as-is) means that even if the BIOS set MPS=128, we would
>> disable read coalescing here, which is unnecessary.  The new
>> PCIE_BUS_DEFAULT basically means Linux will set MPS for hot-added
>> devices the same way as for devices present at boot.  That means we
>> should be able to rely on the BIOS workaround and shouldn't have to
>> disable read coalescing.
>>
>> So I think maybe we should bail out of quirk_intel_mc_errata() for
>> both TUNE_OFF and DEFAULT, e.g.,
>>
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2862,7 +2862,8 @@ static void quirk_intel_mc_errata(struct pci_dev
>> *dev)
>>        int err;
>>        u16 rcc;
>>
>> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
>> +           pcie_bus_config == PCIE_BUS_DEFAULT)
>>                return;
>
>
> Hi Bjorn,
>
> I've successfully tested the previously failing hot-plug tests with your
> pci/enumeration tree.
>
> I don't understand the reported kbuild failure, though. It built
> successfully for me and the error didn't make sense just from looking
> at the patch either, so I hope it was a false alarm.

I couldn't figure that out either, but I reworked them slightly to
squash the last two patches together, and I just got the build success
email.

> Thank you for working on this feature with us. I've no further concerns
> with the most recent implementation, think it looks great and all the
> better for the effort.
>
> Tested-by: Keith Busch <keith.busch@intel.com>

Thanks for testing it!  I'll put it into -next today.

Bjorn
