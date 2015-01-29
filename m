Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:33766 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbA2NPu convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:8:2>);
	Thu, 29 Jan 2015 08:15:50 -0500
Message-Id: <54CA4092020000780005ADF6@mail.emea.novell.com>
Date: Thu, 29 Jan 2015 13:15:46 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: <bhelgaas@google.com>, "Yijing Wang" <wangyijing@huawei.com>
Cc: <david.vrabel@citrix.com>, <yinghai@kernel.org>,
	<xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
	<alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v3] PCI: Add guard to avoid mapping a
 invalid msix base address
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1422503683-19709-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 29.01.15 at 04:54, <wangyijing@huawei.com> wrote:
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>  {
>  	resource_size_t phys_addr;
>  	u32 table_offset;
> +	unsigned long flags;
>  	u8 bir;
>  
>  	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>  			      &table_offset);
>  	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
> +	flags = pci_resource_flags(dev, bir);
> +	if (!flags || (flags & IORESOURCE_UNSET))
> +		return NULL;

Mind explaining what relevance the checking of flags against zero has
(also in the Xen counterpart)? The patch description says nothing in
this regard...

Jan

