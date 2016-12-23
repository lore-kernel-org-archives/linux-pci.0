Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966602AbcLWAsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Dec 2016 19:48:05 -0500
Date: Thu, 22 Dec 2016 18:48:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, rwright@hpe.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161223004801.GA1096@bhelgaas-glaptop.roam.corp.google.com>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161222162713.GF17255@8bytes.org>
 <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
 <20161222233238.GA20861@otc-nc-03>
 <20161222234508.GA20924@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161222234508.GA20924@otc-nc-03>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ashok,

On Thu, Dec 22, 2016 at 03:45:08PM -0800, Raj, Ashok wrote:
> Hi Bjorn
> 
> None in the platform group say they know about this. So i'm fairly sure
> we don't do that on Intel hardware (x86). 

I'm pretty sure there was once an x86 prototype for which PCI bus
addresses were not identical to CPU physical addresses, but I have no
idea whether it shipped that way.

Even if such a system never shipped, the x86 arch code supports _TRA,
and there's no reason to make the unnecessary assumption in this code
that _TRA is always zero.

If we didn't want to use pcibios_resource_to_bus() here for some
reason, we should at least add a comment about why we think it's OK to
use a CPU physical address as an IOVA.

Bjorn
