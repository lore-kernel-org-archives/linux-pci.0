Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17030 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbaHODvg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Aug 2014 23:51:36 -0400
Date: Thu, 14 Aug 2014 23:51:22 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 3/3] xen/MSI: Retrieve MSI msg from cached msi_desc->msg
Message-ID: <20140815035122.GB27697@laptop.dumpdata.com>
References: <1408072477-10008-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408072477-10008-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 15, 2014 at 11:14:37AM +0800, Yijing Wang wrote:
> We had cached the MSI msg in __write_msi_msg(),
> so we should retrieve the cached MSI msg directly,
> not to access the MSI address/data hardware registers
> again.

Is this fixing a particular problem?

Could you kindly explain to me when you do the __write_msi_msg
before doing an read_msi_msg? The order of operation in this
function is read, and then write.

> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> CC: xen-devel@lists.xenproject.org
> ---
>  arch/x86/pci/xen.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 4656099..7a74404 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -228,7 +228,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  		return 1;
>  
>  	list_for_each_entry(msidesc, &dev->msi_list, list) {
> -		read_msi_msg(msidesc, &msg);
> +		get_cached_msi_msg(msidesc, &msg);
>  		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
>  			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
>  		if (msg.data != XEN_PIRQ_MSI_DATA ||
> -- 
> 1.7.1
> 
