Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:34602 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755372AbcJQEjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 00:39:07 -0400
Subject: Re: [PATCH] MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups
To: Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160623221655.3154.89258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Isaacson <adi@hexapodia.org>,
        Yinghai Lu <yinghai@kernel.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <6ec8688e-57ed-33b3-3fe0-55d7d69a2c47@gentoo.org>
Date: Mon, 17 Oct 2016 00:36:34 -0400
MIME-Version: 1.0
In-Reply-To: <20160623221655.3154.89258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/23/2016 18:16, Bjorn Helgaas wrote:
> We claim PCI BAR and bridge window resources in pci_bus_assign_resources(),
> but when PCI_PROBE_ONLY is set, we treat those resources as immutable and
> don't call pci_bus_assign_resources(), so the resources aren't put in the
> resource tree.
> 
> When the resources aren't in the tree, they don't show up in /proc/iomem,
> we can't detect conflicts, and we need special cases elsewhere for
> PCI_PROBE_ONLY or resources without a parent pointer.
> 
> Claim all PCI BAR and window resources in the PCI_PROBE_ONLY case.
> 
> If a PCI_PROBE_ONLY platform assigns conflicting resources, Linux can't fix
> the conflicts.  Previously we didn't notice the conflicts, but now we will,
> which may expose new failures.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/mips/pci/pci.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 5717384..b4c02f2 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -112,7 +112,14 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  		need_domain_info = 1;
>  	}
>  
> -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +	/*
> +	 * We insert PCI resources into the iomem_resource and
> +	 * ioport_resource trees in either pci_bus_claim_resources()
> +	 * or pci_bus_assign_resources().
> +	 */
> +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_bus_claim_resources(bus);
> +	} else {
>  		pci_bus_size_bridges(bus);
>  		pci_bus_assign_resources(bus);
>  	}

So I finally tested this on two SGI platforms, IP30 and IP27.  For IP30, it
works fine once I drop the "pci_set_flags(PCI_PROBE_ONLY);" call.  IP30 uses
standard virtual addressing via ioremap and the like for all of its PCI stuff,
so it was trivial to fix it.

IP27, on the other hand, is not happy with this change.  I don't know about
mainline IP27, as that's generally bitrotted and didn't boot the last time I
tried it, but under the refactored code I'm using that actually boots, this
platform still needs to bypass *all* attempts to claim or assign the PCI addresses.

I suspect the difference with IP27 is unlike normal systems, IP27 uses special
physical addresses in the 0x92xxxxxxxxxxxxxx block to address I/O devices, so
there's no proper ioremap or use of virtual addressing for I/O.  Ralf, does
this sound correct?

If I use the patches I got plus this change and set PCI_PROBE_ONLY, this is
what happens:

[   47.299511] PCI host bridge to bus 0001:00
[   47.348155] pci_bus 0001:00: root bus resource [mem
0x920000000f200000-0x920000000f9fffff]
[   47.447663] pci_bus 0001:00: root bus resource [io
0x920000000fa00000-0x920000000fbfffff]
[   47.547183] pci_bus 0001:00: root bus resource [bus 01-ff]
[   47.616581] pci 0001:00:00.0: can't claim BAR 0 [io  0xf200000-0xf2000ff]:
no compatible bridge window
[   47.726766] pci 0001:00:00.0: can't claim BAR 1 [mem 0x0f200000-0x0f200fff]:
no compatible bridge window
[   47.840937] pci 0001:00:00.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff
pref]: no compatible bridge window
[   47.960317] pci 0001:00:01.0: can't claim BAR 0 [io  0xf400000-0xf4000ff]:
no compatible bridge window
[   48.072399] pci 0001:00:01.0: can't claim BAR 1 [mem 0x0f400000-0x0f400fff]:
no compatible bridge window
[   48.186560] pci 0001:00:01.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff
pref]: no compatible bridge window
[   48.305957] pci 0001:00:02.0: can't claim BAR 0 [mem 0x0f600000-0x0f6fffff]:
no compatible bridge window
[   48.420098] pci 0001:00:06.0: can't claim BAR 0 [mem 0x0fa00000-0x0fafffff]:
no compatible bridge window
[   48.534294] pci 0001:00:07.0: can't claim BAR 0 [mem 0x00000000-0x00001fff]:
no compatible bridge window
[   48.648541] qla1280: QLA1040 found on PCI bus 0, dev 0
[   48.710232] PCI: Enabling device 0001:00:00.0 (0006 -> 0007)
[   48.779231] qla1280 0001:00:00.0: can't ioremap BAR 1: [mem size 0x00001000]
[   48.863145] qla1280: Unable to map I/O memory
[   48.916520] qla1280: QLA1040 found on PCI bus 0, dev 1
[   48.977298] PCI: Enabling device 0001:00:01.0 (0006 -> 0007)
[   49.046128] qla1280 0001:00:01.0: can't ioremap BAR 1: [mem size 0x00001000]
[   49.130201] qla1280: Unable to map I/O memory
[   49.183068] IOC3 0001:00:02.0: can't ioremap BAR 0: [mem size 0x00100000]
[   49.264292] ioc3: Unable to remap PCI BAR for 0001:00:02.0.
[   49.331533] IOC3 0001:00:06.0: can't ioremap BAR 0: [mem size 0x00100000]
[   49.412984] ioc3: Unable to remap PCI BAR for 0001:00:06.0.


If I disable PCI_PROBE_ONLY, then this:

[   47.588033] PCI host bridge to bus 0001:00
[   47.636649] pci_bus 0001:00: root bus resource [mem
0x920000000f200000-0x920000000f9fffff]
[   47.736144] pci_bus 0001:00: root bus resource [io
0x920000000fa00000-0x920000000fbfffff]
[   47.835621] pci_bus 0001:00: root bus resource [bus 01-ff]
[   47.905023] pci 0001:00:02.0: BAR 0: no space for [mem size 0x00100000]
[   47.982775] pci 0001:00:02.0: BAR 0: failed to assign [mem size 0x00100000]
[   48.066586] pci 0001:00:06.0: BAR 0: no space for [mem size 0x00100000]
[   48.146173] pci 0001:00:06.0: BAR 0: failed to assign [mem size 0x00100000]
[   48.229972] pci 0001:00:00.0: BAR 6: no space for [mem size 0x00010000 pref]
[   48.314783] pci 0001:00:00.0: BAR 6: failed to assign [mem size 0x00010000 pref]
[   48.403825] pci 0001:00:01.0: BAR 6: no space for [mem size 0x00010000 pref]
[   48.488655] pci 0001:00:01.0: BAR 6: failed to assign [mem size 0x00010000 pref]
[   48.577695] pci 0001:00:00.0: BAR 1: no space for [mem size 0x00001000]
[   48.657260] pci 0001:00:00.0: BAR 1: failed to assign [mem size 0x00001000]
[   48.741068] pci 0001:00:01.0: BAR 1: no space for [mem size 0x00001000]
[   48.820644] pci 0001:00:01.0: BAR 1: failed to assign [mem size 0x00001000]
[   48.904452] pci 0001:00:00.0: BAR 0: no space for [io  size 0x0100]
[   48.979840] pci 0001:00:00.0: BAR 0: failed to assign [io  size 0x0100]
[   49.059459] pci 0001:00:01.0: BAR 0: no space for [io  size 0x0100]
[   49.134855] pci 0001:00:01.0: BAR 0: failed to assign [io  size 0x0100]
[   49.214588] qla1280: QLA1040 found on PCI bus 0, dev 0
[   49.277249] qla1280 0001:00:00.0: can't ioremap BAR 1: [??? 0x00000000 flags
0x0]
[   49.366330] qla1280: Unable to map I/O memory
[   49.419832] qla1280: QLA1040 found on PCI bus 0, dev 1
[   49.481211] qla1280 0001:00:01.0: can't ioremap BAR 1: [??? 0x00000000 flags
0x0]
[   49.570560] qla1280: Unable to map I/O memory
[   49.623439] IOC3 0001:00:02.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   49.709857] ioc3: Unable to remap PCI BAR for 0001:00:02.0.
[   49.777113] IOC3 0001:00:06.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
[   49.863796] ioc3: Unable to remap PCI BAR for 0001:00:06.0.


The only fix I could come up with was more IP27 #ifdef hackery to retain the
original code for IP27, but use the new conditional logic for all other
platforms.  Would a patch for this be acceptable (with verbose comment), or is
there a better way to deal with IP27 that doesn't involve re-writing its I/O
addressing support entirely?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
