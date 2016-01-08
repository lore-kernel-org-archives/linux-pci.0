Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44789 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbcAHVGj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 16:06:39 -0500
Date: Fri, 8 Jan 2016 15:06:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: rcar: remove unused pci_sys_data structure
 in pcie-rcar
Message-ID: <20160108210635.GL5354@localhost>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
 <20160108015056.GB9600@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160108015056.GB9600@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 08, 2016 at 10:50:57AM +0900, Simon Horman wrote:
> Hi Phil,
> 
> On Tue, Jan 05, 2016 at 01:00:28PM +0000, Phil Edworthy wrote:
> > Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
> > with global function pointer") removed the struct pci_sys_data
> > dependency from the ARM pcibios functions, so remove it from this
> > driver.
> 
> I am a little confused by this as I still see two instances of
> the following in bios32.c as of the commit above.
> 
> 	struct pci_sys_data *sys = dev->sysdata;

This patch only removes a pci_sys_data struct from pcie-rcar.c.  That
struct was previously used by pci_common_init_dev() and by the ARM
pcibios_align_resource().

After cbce7900598c ("PCI: designware: Make driver arch-agnostic"), none of
the DesignWare drivers use pci_common_init_dev(), and after b3a72384fe29, 
ARM doesn't need pci_sys_data for pcibios_align_resource().

Phil can correct me if I'm wrong, but I think this patch is probably OK.
I guess we can tell after I apply it and get a build test :)

Bjorn
