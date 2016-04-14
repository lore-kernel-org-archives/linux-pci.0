Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'Jisheng Zhang'" <jszhang@marvell.com>,
	<pratyush.anand@gmail.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Jingoo Han'" <jingoohan1@gmail.com>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com> <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs> <20160407103734.55e72da7@xhacker> <EE11001F9E5DDD47B7634E2F8A612F2E1ED43F95@lhreml503-mbs> <20160407163443.291fbd49@xhacker> <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs> <20160407140551.GA2648@localhost> <EE11001F9E5DDD47B7634E2F8A612F2E1ED45C38@lhreml503-mbs> <20160408160145.GA10565@localhost> <EE11001F9E5DDD47B7634E2F8A612F2E1ED4B88D@lhreml503-mbs> <00a901d19548$90bffc20$b23ff460$@com> <EE11001F9E5DDD47B7634E2F8A612F2E1ED4F10E@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED4F10E@lhreml503-mbs>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to dw_pcie_setup_rc()
Date: Thu, 14 Apr 2016 20:52:58 +0900
Message-ID: <000001d19644$356355a0$a02a00e0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 13, 2016 4:58 PM, Gabriele Paoloni wrote:
> 
> Hi Jingoo
>
> On 13 April 2016 06:52, Jingoo Han wrote:
> > On Tuesday, April 12, 2016 6:44 PM, Gabriele Paoloni wrote:
> > >
> > > Hi Bjorn
> > >
> > > [...]
> > >
> > > > > >
> > > > > > What's the hisi plan for resuming after suspend-to-RAM?  How
> > does
> > > > the
> > > > > > RC get reprogrammed after it loses all its state?
> > > > >
> > > > > PM is not part of the driver yet. This is planned for near
> > > > > future release so haven't made such considerations yet
> > > > > >
> > > > > > What would break if hisi did call dw_pcie_setup_rc()?  I know
> > you
> > > > said
> > > > > > it would overwrite what the bootloader already did, which is
> > true.
> > > > >
> > > > > I am try to figure this out now with our HW team.
> > > > >
> > > > > >
> > > > > > But hisi does call dw_pcie_host_init(), so it reads pp->mem
> > (which
> > > > > > determines pp->mem_base) and pp->lanes from the DT.  Other
> > drivers
> > > > > > then call dw_pcie_setup_rc() which programs the RC based on
> > > > > > pp->mem_base and pp->lanes.  So hisi assumes UEFI programmed
> > the RC
> > > > to
> > > > > > match the DT, while the other drivers read the DT and program
> > the
> > > > RC
> > > > > > to match.  The latter seems more robust because it enforces the
> > > > > > consistency rather than relying on it.
> > > > >
> > > > > Yes I agree with you, however we have preferred to move RC config
> > to
> > > > > BIOS to have a single driver to support multiple versions of the
> > > > > same SoC.
> > > >
> > > > I think there are two reasonable approaches:
> > > >
> > > >   1) A single generic driver that doesn't have any knowledge about
> > the
> > > >   chipset registers; it uses run-time firmware interfaces to manage
> > > >   the bridge.  The ACPI pci_root.c driver is the best example so
> > far
> > > >   and works very well.  It supports basically all x86 and ia64
> > > >   chipsets and requires no kernel work for new ones.
> > > >
> > > >   2) Native drivers specific to each chipset.  These may get
> > > >   configuration information from DT, but they do their own
> > > >   register-level programming of the device without run-time help
> > from
> > > >   firmware.
> > > >
> > > > I think hisi is a native driver because it uses hip05/hip06
> > registers
> > > > to check link state and perform config operations.  And apparently
> > you
> > > > rely on the ATU, BAR, class, and link width programming currently
> > done
> > > > in dw_pcie_host_init().  But you want to rely on pre-boot firmware
> > to
> > > > set up the link.  That doesn't make sense to me -- if the driver
> > wants
> > > > to twiddle the registers, it should know how to do it all.  I don't
> > > > see how you can reasonably manage this half-way approach.
> > > >
> > > > > The patch I proposed above does the same job as the original
> > patch
> > > > > proposed by Jisheng and also allows hisi driver to call the moved
> > > > > code.
> > > > >
> > > > > Do you see anything wrong with it?
> > > >
> > > > Only that it makes the structure more complicated and we haven't
> > > > identified a corresponding benefit yet.
> > >
> > > Finally I have checked that assigning .host_init function pointer
> > > in our driver to call dw_pcie_setup_rc() will not affect the values
> > > already set by BIOS.
> > >
> > > Also I agree with you that a hybrid approach is not ideal.
> >
> > I also agree with Bjorn's opinion.
> > As far as I know, two approaches are reasonable.
> >
> > In the case of using UEFI, how about using 'pci-host-generic.c'?
> > You may consult with Linaro guys for this issue.
> 
> Many thanks for your suggestion, I'll take it into account for next
> releases
> 
> > Good luck.
> >
> > Best regards,
> > Jingoo Han
> >
> > >
> > > So I will update the driver to call dw_pcie_setup_rc() from
> > > .host_init and ask the BIOS team to update the firmware for next
> > > releases (the driver will be backward compatible anyway).
> > >
> > > Also during my investigation I have noticed that in
> > dw_pcie_setup_rc()
> > > http://lxr.free-electrons.com/source/drivers/pci/host/pcie-
> > designware.c#L762
> > >
> > > we use pp->mem_base rather than pp->mem_bus_addr to setup
> > > memory base and memory limit in the Type1 header...I think this
> > > is wrong right?
> > > Also I do not see why this code is needed at all since we overwrite
> > > this register when we call pci_bus_assign_resources(bus) that
> > > will end up in calling pci_setup_bridge() and then
> > > pci_setup_bridge_mmio()...?
> 
> Do you have any comment on this issue above?

Sorry, I am not sure.
However, there are some redundant codes like this.
At that time, I was not able to decide to remove these codes.

Maybe, Pratyush Anand or other guys would give opinions about this.

Best regards,
Jingoo Han

> 
> > >
> > > Many Thanks
> > >
> > > Gab
> > >
> > > >
> > > > Bjorn
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-
> > pci" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
