Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49595 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbCIMfe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 08:35:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Paul Bolle <pebolle@tiscali.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pci: iproc: Add Broadcom iProc PCIe support
Date: Mon, 09 Mar 2015 13:35:24 +0100
Message-ID: <2314573.X8TfIpVCUq@wuerfel>
In-Reply-To: <54F9EB42.3010804@broadcom.com>
References: <1425603699-13416-1-git-send-email-rjui@broadcom.com> <CAE_wzQ_Rq5u83UXOYRLShxuCzcgxA0BSPFZT4RmvDj8nfTSGcg@mail.gmail.com> <54F9EB42.3010804@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 06 March 2015 10:00:34 Ray Jui wrote:
> > 
> 
> Although I have not tested it, but to my best knowledge there shouldn't
> be any technical issue by making the PCIe iProc driver a loadable module
> and installing the module later after the kernel finishes booting.
> 
> But I wonder why I haven't seen any PCIe host driver being allowed to be
> compiled as module? Maybe there's no obvious benefit of doing that.
> People typically opt to load slave devices as module but tend to keep
> the bus or host devices compiled in.
> 
> And to allow a PCI host driver to be compiled as module, some PCI
> functions need to have their symbols exported:
> 
> ERROR: "pci_common_swizzle" [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "pci_fixup_irqs" [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "pci_assign_unassigned_bus_resources"
> [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "pci_remove_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "pci_stop_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "pci_create_root_bus" [drivers/pci/host/pcie-iproc.ko] undefined!
> 
> Maybe Bjorn can help to shed some light here? Should I go ahead and
> export_symbol these PCI functions and make the iProc PCI driver "tristate"?

My best guess is that no loadable driver ever tried to use these and
we should indeed just export them.

The call to pci_assign_unassigned_bus_resources could be avoided by using
pci_rescan_bus(), which would simplify the driver a little, but for
some reason, nothing else uses that, so I'm not sure about it.

The pci_remove_root_bus/pci_stop_root_bus calls are rarely used anywhere
else. Are they functional to the point where you could unload a pci
host driver that is a loadable module? If so, that would be
wonderful.

	Arnd
