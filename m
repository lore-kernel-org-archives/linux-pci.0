Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36999 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbaC1O5X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 10:57:23 -0400
Date: Fri, 28 Mar 2014 14:57:18 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] Versatile PCI DT support
Message-ID: <20140328145718.GZ17163@e106497-lin.cambridge.arm.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
 <20140328114618.GY17163@e106497-lin.cambridge.arm.com>
 <CAL_JsqL-LxCWe2Lopf3ZGHXmJB4fwEmKj1y7-bgBpYd5owNKKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL-LxCWe2Lopf3ZGHXmJB4fwEmKj1y7-bgBpYd5owNKKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 28, 2014 at 01:27:05PM +0000, Rob Herring wrote:
> On Fri, Mar 28, 2014 at 6:46 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Thu, Mar 27, 2014 at 10:46:35PM +0000, Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> This series adds a platform driver for Versatile PB's PCI host using
> >> Liviu's recent patch series[1] for DT parsing and setup.
> >>
> >> The first patch is a hack to get Liviu's current patches to work on ARM.
> >> It at least shows we are not that far off from being able to use the
> >> series on ARM.
> >>
> >> I've tested PCI under QEMU, but need someone with actual h/w to test.
> >> A branch with this series and which includes full conversion of
> >> Versatile to DT is available here[2].
> >
> > Hi Rob,
> >
> > Thanks for doing this. Hopefully others will take inspiration and start to
> > convert their host bridge controllers as well.
> >
> > I will post an updated series soon. (Un)fortunately it will look slightly
> > different than the last one I've posted as I am trying to get more code
> > that I've currently placed in arch/arm64/kernel/pci.c into drivers/pci,
> > so you will need to revisit your series.
> >
> > Regarding your comment about bridge->bus->self being needed: root busses
> > are supposed to have bus->self == NULL, and the bridge->bus *is* the root
> > bus. Where would you need to use bridge->bus->self?
> 
> If I want to use pci_write_config_* accesses, then I need a struct
> pci_dev pointer for the host. I can get this since I know the slot of
> the host, but only after pci_bus_add_devices which is perhaps too
> late. Historically, the Versatile PCI driver has blocked config
> accesses to the host's config space. I'm just wondering if this is
> really correct behavior and whether the core code should do the setup.

PCI core? It knows nothing of the Versatile registers. Versatile core code? Maybe.

> This is setup that is done which doesn't seem like it is very specific
> to Versatile.
> 
> local_pci_cfg_base = versatile_cfg_base[1] + (myslot << 11);
> 
> val = readl(local_pci_cfg_base + CSR_OFFSET);
> val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
> writel(val, local_pci_cfg_base + CSR_OFFSET);

Why don't you do this in a versatile_fixup_bridge() call, like pci-tegra.c
does?

> 
> /*
> * Configure the PCI inbound memory windows to be 1:1 mapped to SDRAM
> */
> writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_0);
> writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_1);
> writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_2);

My guess is that this has to be done at probe time. It just happens that for
Versatile PCI they live in the host config space, but they are not really
PCI config space writes.

Best regards,
Liviu

> 
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

