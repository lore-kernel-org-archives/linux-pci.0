Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938697AbcKNVYE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 16:24:04 -0500
Date: Mon, 14 Nov 2016 15:24:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/4] PCI: dra7xx: Add support to force RC to work in GEN1
 mode
Message-ID: <20161114212400.GA19092@bhelgaas-glaptop.roam.corp.google.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
 <1476190715-16884-4-git-send-email-kishon@ti.com>
 <20161111211528.GF9868@bhelgaas-glaptop.roam.corp.google.com>
 <8ecc1325-365d-bdec-d435-729e0ea49d20@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ecc1325-365d-bdec-d435-729e0ea49d20@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Shawn]

On Sat, Nov 12, 2016 at 12:40:10PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 12 November 2016 02:45 AM, Bjorn Helgaas wrote:
> > Hi Kishon,
> > 
> > On Tue, Oct 11, 2016 at 06:28:34PM +0530, Kishon Vijay Abraham I wrote:
> >> PCIe in AM57x/DRA7x devices is by default
> >> configured to work in GEN2 mode.  However there
> >> may be situations when working in GEN1 mode is
> >> desired. One example is limitation i925 (PCIe GEN2
> >> mode not supported at junction temperatures < 0C).
> >>
> >> Add support to force Root Complex to work in GEN1
> >> mode if so desired, but don't force GEN1 mode on
> >> any board just yet.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
> >>  drivers/pci/host/pci-dra7xx.c                    |   27 ++++++++++++++++++++++
> >>  2 files changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> index 60e2516..a3d6ca3 100644
> >> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> >> @@ -25,6 +25,7 @@ PCIe Designware Controller
> >>  
> >>  Optional Property:
> >>   - gpios : Should be added if a gpio line is required to drive PERST# line
> >> + - ti,pcie-is-gen1 : Force the PCIe controller to work in GEN1 (2.5 GT/s).
> > 
> > Can we use "max-link-speed" so it's similar to imx6?
> 
> yeah, maybe we should make it a generic PCI property?

I forgot that Shawn has already done this!  I had already merged those
patches on pci/host-rockchip, but I moved them to pci/host since
they're not Rockchip-specific.  Can you take a look at that and see if
you can do what you need based on that pci/host branch?

Bjorn
