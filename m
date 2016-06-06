Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19545 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbcFFOhE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 10:37:04 -0400
Date: Mon, 6 Jun 2016 10:44:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / DPC: Few improvements
Message-ID: <20160606144445.GA23119@localhost.localdomain>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

Thanks, these look good to me.

Acked-by: Keith Busch <keith.busch@intel.com>
