Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbdDLRdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 13:33:54 -0400
Date: Wed, 12 Apr 2017 12:33:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci/quirks: ITE 8893 needs
 quirk_use_pcie_bridge_dma_alias
Message-ID: <20170412173350.GG25197@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411010127.57858-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411010127.57858-1-jarod@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 09:01:27PM -0400, Jarod Wilson wrote:
> This bridge has the same problems as the ITE 8892, which were resulting in
> crippling an older PCI 1Gbps NIC down to 45Mbps throughput with IOMMU and
> VT-d enabled. With the patch, this old e1000 goes back up to ~900Mbps.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> CC: linux-pci@vger.kernel.org
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Applied with Alex's reviewed-by to pci/iommu for v4.12, thanks!

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 9236e40ac055..c95fbf2431f8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3914,6 +3914,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080,
>  DECLARE_PCI_FIXUP_HEADER(0x10e3, 0x8113, quirk_use_pcie_bridge_dma_alias);
>  /* ITE 8892, https://bugzilla.kernel.org/show_bug.cgi?id=73551 */
>  DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
> +/* ITE 8893 has the same problem as the 8892 */
> +DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8893, quirk_use_pcie_bridge_dma_alias);
>  /* Intel 82801, https://bugzilla.kernel.org/show_bug.cgi?id=44881#c49 */
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>  
> -- 
> 2.12.1
> 
