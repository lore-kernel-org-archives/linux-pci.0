Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36058 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdAMVtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2017 16:49:35 -0500
Subject: Re: [PATCH] xen: do not re-use pirq number cached in pci device msi
 msg data
To: Dan Streetman <ddstreet@ieee.org>,
        Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20170113200751.20125-1-ddstreet@ieee.org>
Cc: Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <20d6b3fa-5a3c-a1b7-6d56-b66a9cb90b69@oracle.com>
Date: Fri, 13 Jan 2017 16:49:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170113200751.20125-1-ddstreet@ieee.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/13/2017 03:07 PM, Dan Streetman wrote:
> Revert the main part of commit:
> af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
>
> That commit introduced reading the pci device's msi message data to see
> if a pirq was previously configured for the device's msi/msix, and re-use
> that pirq.  At the time, that was the correct behavior.  However, a
> later change to Qemu caused it to call into the Xen hypervisor to unmap
> all pirqs for a pci device, when the pci device disables its MSI/MSIX
> vectors; specifically the Qemu commit:
> c976437c7dba9c7444fb41df45468968aaa326ad
> ("qemu-xen: free all the pirqs for msi/msix when driver unload")
>
> Once Qemu added this pirq unmapping, it was no longer correct for the
> kernel to re-use the pirq number cached in the pci device msi message
> data.  All Qemu releases since 2.1.0 contain the patch that unmaps the
> pirqs when the pci device disables its MSI/MSIX vectors.
>
> This bug is causing failures to initialize multiple NVMe controllers
> under Xen, because the NVMe driver sets up a single MSIX vector for
> each controller (concurrently), and then after using that to talk to
> the controller for some configuration data, it disables the single MSIX
> vector and re-configures all the MSIX vectors it needs.  So the MSIX
> setup code tries to re-use the cached pirq from the first vector
> for each controller, but the hypervisor has already given away that
> pirq to another controller, and its initialization fails.
>
> This is discussed in more detail at:
> https://lists.xen.org/archives/html/xen-devel/2017-01/msg00447.html
>
> Fixes: af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM guests")
> Signed-off-by: Dan Streetman <dan.streetman@canonical.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

> ---
>  arch/x86/pci/xen.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index bedfab9..a00a6c0 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -234,23 +234,14 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  		return 1;
>  
>  	for_each_pci_msi_entry(msidesc, dev) {
> -		__pci_read_msi_msg(msidesc, &msg);
> -		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
> -			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
> -		if (msg.data != XEN_PIRQ_MSI_DATA ||
> -		    xen_irq_from_pirq(pirq) < 0) {
> -			pirq = xen_allocate_pirq_msi(dev, msidesc);
> -			if (pirq < 0) {
> -				irq = -ENODEV;
> -				goto error;
> -			}
> -			xen_msi_compose_msg(dev, pirq, &msg);
> -			__pci_write_msi_msg(msidesc, &msg);
> -			dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
> -		} else {
> -			dev_dbg(&dev->dev,
> -				"xen: msi already bound to pirq=%d\n", pirq);
> +		pirq = xen_allocate_pirq_msi(dev, msidesc);
> +		if (pirq < 0) {
> +			irq = -ENODEV;
> +			goto error;
>  		}
> +		xen_msi_compose_msg(dev, pirq, &msg);
> +		__pci_write_msi_msg(msidesc, &msg);
> +		dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
>  		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, pirq,
>  					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
>  					       (type == PCI_CAP_ID_MSIX) ?

