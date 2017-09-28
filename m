Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbdI1Rsv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Sep 2017 13:48:51 -0400
Date: Thu, 28 Sep 2017 12:48:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 1/2] pci: designware: add driver for DWC controller in
 ECAM shift mode
Message-ID: <20170928174847.GW15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
 <20170828180437.2646-2-ard.biesheuvel@linaro.org>
 <20170926173200.GL15970@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 08:51:43AM -0700, Ard Biesheuvel wrote:
> On 26 September 2017 at 10:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Aug 28, 2017 at 07:04:36PM +0100, Ard Biesheuvel wrote:
> >> Some implementations of the Synopsys Designware PCIe controller implement
> >> a so-called ECAM shift mode, which allows a static memory window to be
> >> configured that covers the configuration space of the entire bus range.

> >> Note that, unlike most drivers for this IP, this driver does not expose
> >> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
> >> given that this is not a true bridge, and does not require any windows
> >> to be configured in order for the downstream device to operate correctly.
> >> Omitting it also prevents the PCI resource allocation routines from
> >> handing out BAR space to it unnecessarily.
> >
> > This is a tangent, but does this mean the other drivers do not need to
> > expose a fake 00:00.0 device either?
> 
> To be honest, I am not so sure anymore. I am seeing some issues in
> ASPM code making the assumption that any device which is not a root
> port has a parent. If this is mandated by the spec, I guess there
> isn't a whole lot we can do except expose a fake root port on b/d/f
> 0/0/0. This used to work fine, though, and I have to confirm whether
> the issues I am seeing currently are due to different hardware or
> changes in the software.

I agree that our ASPM code had some assumptions that any non-root port
device should have a parent.  I think the spec also makes that
assumption, but I haven't found an explicit mandate.  And there *are*
systems lacking root ports:

http://lkml.kernel.org/r/1439808478-23253-1-git-send-email-wangyijing@huawei.com

We fixed one such assumption in that thread, but I wouldn't be
surprised if more remain.  If there are, I think we should fix the
code to remove the assumption.

> > This really doesn't have any DesignWare specifics in it, and it seems
> > more related to drivers/pci/host/pci-host-generic.c than to anything
> > in drivers/pci/dwc.  Maybe it should be
> > drivers/pci/host/pci-host-generic-quirks.c or something?  That's
> > unwieldy, I admit.
> 
> I don't care where we put it, and I am fine with owning it if you prefer.

I think Will's idea of teaching pci-host-generic to deal with this is
perfect.

> >> +config PCIE_DW_HOST_ECAM
> >> +     bool "Synopsys DesignWare PCIe controller in ECAM mode"
> >> +     depends on OF && PCI
> >> +     select PCI_HOST_COMMON
> >> +     select IRQ_DOMAIN
> >> +     help
> >> +       Add support for Synopsys DesignWare PCIe controllers configured
> >> +       by the firmware into ECAM shift mode. In some cases, these are
> >> +       fully ECAM compliant, in which case the pci-host-generic driver
> >> +       may be used instead.
> >
> > This doesn't quite read right.  It sounds like a controller in ECAM
> > shift mode might be fully ECAM compliant, but I don't think that's
> > what you intended.
> 
> Yes, that is what I mean. ECAM shift mode results in a fully compliant
> ECAM config space iff the IP was synthesized with a 32 KB granularity
> for the iATU windows. The default is 64 KB, though, in which case you
> need this driver.

OK.  I'm trying to figure out how I as a user would know whether to
select this option.  Maybe the config option will go away if you add
the smarts to pci-host-generic?

Bjorn
