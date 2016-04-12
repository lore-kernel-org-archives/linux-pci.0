Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:2066 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbcDLJnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 05:43:52 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jisheng Zhang <jszhang@marvell.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Date: Tue, 12 Apr 2016 09:43:32 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED4B88D@lhreml503-mbs>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
 <20160407103734.55e72da7@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED43F95@lhreml503-mbs>
 <20160407163443.291fbd49@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
 <20160407140551.GA2648@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED45C38@lhreml503-mbs>
 <20160408160145.GA10565@localhost>
In-Reply-To: <20160408160145.GA10565@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

[...]

> > >
> > > What's the hisi plan for resuming after suspend-to-RAM?  How does
> the
> > > RC get reprogrammed after it loses all its state?
> >
> > PM is not part of the driver yet. This is planned for near
> > future release so haven't made such considerations yet
> > >
> > > What would break if hisi did call dw_pcie_setup_rc()?  I know you
> said
> > > it would overwrite what the bootloader already did, which is true.
> >
> > I am try to figure this out now with our HW team.
> >
> > >
> > > But hisi does call dw_pcie_host_init(), so it reads pp->mem (which
> > > determines pp->mem_base) and pp->lanes from the DT.  Other drivers
> > > then call dw_pcie_setup_rc() which programs the RC based on
> > > pp->mem_base and pp->lanes.  So hisi assumes UEFI programmed the RC
> to
> > > match the DT, while the other drivers read the DT and program the
> RC
> > > to match.  The latter seems more robust because it enforces the
> > > consistency rather than relying on it.
> >
> > Yes I agree with you, however we have preferred to move RC config to
> > BIOS to have a single driver to support multiple versions of the
> > same SoC.
> 
> I think there are two reasonable approaches:
> 
>   1) A single generic driver that doesn't have any knowledge about the
>   chipset registers; it uses run-time firmware interfaces to manage
>   the bridge.  The ACPI pci_root.c driver is the best example so far
>   and works very well.  It supports basically all x86 and ia64
>   chipsets and requires no kernel work for new ones.
> 
>   2) Native drivers specific to each chipset.  These may get
>   configuration information from DT, but they do their own
>   register-level programming of the device without run-time help from
>   firmware.
> 
> I think hisi is a native driver because it uses hip05/hip06 registers
> to check link state and perform config operations.  And apparently you
> rely on the ATU, BAR, class, and link width programming currently done
> in dw_pcie_host_init().  But you want to rely on pre-boot firmware to
> set up the link.  That doesn't make sense to me -- if the driver wants
> to twiddle the registers, it should know how to do it all.  I don't
> see how you can reasonably manage this half-way approach.
> 
> > The patch I proposed above does the same job as the original patch
> > proposed by Jisheng and also allows hisi driver to call the moved
> > code.
> >
> > Do you see anything wrong with it?
> 
> Only that it makes the structure more complicated and we haven't
> identified a corresponding benefit yet.

Finally I have checked that assigning .host_init function pointer
in our driver to call dw_pcie_setup_rc() will not affect the values
already set by BIOS.

Also I agree with you that a hybrid approach is not ideal.

So I will update the driver to call dw_pcie_setup_rc() from
.host_init and ask the BIOS team to update the firmware for next
releases (the driver will be backward compatible anyway). 

Also during my investigation I have noticed that in dw_pcie_setup_rc()
http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L762

we use pp->mem_base rather than pp->mem_bus_addr to setup
memory base and memory limit in the Type1 header...I think this
is wrong right?
Also I do not see why this code is needed at all since we overwrite
this register when we call pci_bus_assign_resources(bus) that
will end up in calling pci_setup_bridge() and then
pci_setup_bridge_mmio()...?  

Many Thanks

Gab

> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
