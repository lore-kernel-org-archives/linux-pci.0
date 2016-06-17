Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3484 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbcFQJ6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 05:58:13 -0400
Date: Fri, 17 Jun 2016 12:57:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / DPC: Few improvements
Message-ID: <20160617095758.GJ1739@lahna.fi.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gentle ping on this.

On Mon, Jun 06, 2016 at 04:06:04PM +0300, Mika Westerberg wrote:
> Hi,
> 
> This series includes few improvements for the PCIe DPC driver. First we
> introduce module_pci_port_service() which allows reducing of boilerblate
> code used in the DPC driver. In addition we convert the driver to use
> managed resource functions (devm) to get rid of even more boilerblate.
> 
> I do not have hardware supporting DPC so these are only compile tested.
> 
> Mika Westerberg (4):
>   PCI / PCIe: Introduce module_pci_port_service()
>   PCI / DPC: Convert to use module_pcie_port_service()
>   PCI / DPC: Convert the driver to use devm_* functions
>   PCI / DPC: Fix whitespace in struct dpc_dev
> 
>  drivers/pci/pcie/pcie-dpc.c | 30 +++++++-----------------------
>  include/linux/pcieport_if.h | 13 +++++++++++++
>  2 files changed, 20 insertions(+), 23 deletions(-)
> 
> -- 
> 2.8.1
