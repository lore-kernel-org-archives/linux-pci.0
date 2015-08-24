Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17836 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbbHXQNC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 24 Aug 2015 12:13:02 -0400
Date: Mon, 24 Aug 2015 16:13:00 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 3/3] PCI: Change MPS default to "match upstream bridge"
In-Reply-To: <CAErSpo7wEpPSy9BSt6t5UYXSqbXRf_Wu-1kzDCzmowO60UqKTQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1508241605130.3969@localhost.lm.intel.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150821150800.7525.14750.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CAErSpo7wEpPSy9BSt6t5UYXSqbXRf_Wu-1kzDCzmowO60UqKTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 21 Aug 2015, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2015 at 8:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Change the default MPS tuning policy to "default," which means we set every
>> device's MPS to match its upstream bridge.  Typically this means we'll
>> preserve the fabric configuration done by firmware, even for hot-added
>> devices.
>>
>> N.B. This effectively re-enables quirk_intel_mc_errata(), which turns off
>> read completion coalescing on Intel 5000 and 5100 memory controllers.
>
> I think this patch might be the wrong thing for quirk_intel_mc_errata().
>
> Currently, the default is PCIE_BUS_TUNE_OFF.  In that case, the quirk
> does nothing, Linux doesn't touch MPS at all, and the BIOS is
> responsible for avoiding the erratum, either by disabling read
> coalescing or by avoiding MPS=256.
>
> This patch (as-is) means that even if the BIOS set MPS=128, we would
> disable read coalescing here, which is unnecessary.  The new
> PCIE_BUS_DEFAULT basically means Linux will set MPS for hot-added
> devices the same way as for devices present at boot.  That means we
> should be able to rely on the BIOS workaround and shouldn't have to
> disable read coalescing.
>
> So I think maybe we should bail out of quirk_intel_mc_errata() for
> both TUNE_OFF and DEFAULT, e.g.,
>
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2862,7 +2862,8 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
>        int err;
>        u16 rcc;
>
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
> +           pcie_bus_config == PCIE_BUS_DEFAULT)
>                return;

Hi Bjorn,

I've successfully tested the previously failing hot-plug tests with your
pci/enumeration tree.

I don't understand the reported kbuild failure, though. It built
successfully for me and the error didn't make sense just from looking
at the patch either, so I hope it was a false alarm.

Thank you for working on this feature with us. I've no further concerns
with the most recent implementation, think it looks great and all the
better for the effort.

Tested-by: Keith Busch <keith.busch@intel.com>

>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
