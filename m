Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54948 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcCONgN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 09:36:13 -0400
Date: Tue, 15 Mar 2016 08:36:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160315133605.GA19974@localhost>
References: <1457681184-20439-1-git-send-email-jonathan.yong@intel.com>
 <1457681184-20439-2-git-send-email-jonathan.yong@intel.com>
 <20160311155332.GA31716@localhost>
 <56E66BF3.4080500@intel.com>
 <20160314154215.GB13471@localhost>
 <56E7C771.6060700@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E7C771.6060700@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 04:27:29PM +0800, Yong, Jonathan wrote:
> On 03/14/2016 23:42, Bjorn Helgaas wrote:
> >
> >The nomenclature is confusing, but I think you're reading this
> >backwards.  An Upstream Port is on the downstream end of a Link.  The
> >"Upstream" definition in the PCIe spec "Terms and Acronyms" section
> >says:
> >
> >   The Port on a Switch that is closest topologically to the Root Complex
> >   is the Upstream Port. The Port on a component that contains only
> >   Endpoint or Bridge Functions is an Upstream Port.
> >
> >I think the spec is saying that PTM must be enabled in a bridge before
> >it is enabled in any device downstream from the bridge.
> >
> 
> Thanks for the explanation, looks like back to the drawing board. Do
> you recommend using pci_walk_bus on all potential PTM masters?

No, I try to avoid using pci_walk_bus().  I would try something like this
in the pci_init_capabilities() path:

  pci_ptm_init(struct pci_dev *dev)
  {
    if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
      return;

    type = pci_pcie_type(dev);
    if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END) {
      if (pci_upstream_bridge(dev)->ptm_enabled)
	enable_ptm(dev);
	return;
    }

    if (type == PCI_EXP_TYPE_DOWNSTREAM) {
      dev->ptm_enabled = pci_upstream_bridge(dev)->ptm_enabled;
      return;
    }

    enable_ptm(dev);
    dev_info(&dev->dev, "PTM enabled, root, granularity, etc...")
  }

I've only skimmed the PTM spec, so this is just a brief and incomplete
sketch.

Bjorn
