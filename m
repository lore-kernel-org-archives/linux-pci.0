Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33261 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbHTFsL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 01:48:11 -0400
Received: by pdrh1 with SMTP id h1so10307916pdr.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2015 22:48:10 -0700 (PDT)
Date: Thu, 20 Aug 2015 00:48:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mroos@linux.ee,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-ID: <20150820054800.GB10267@google.com>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Dave, Eric, Ben, sparclinux]

On Mon, Aug 17, 2015 at 06:47:58PM +0800, Yijing Wang wrote:
> Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
> track downstream PCIe links")assumed root port is always
> the top device in pcie tree. But on sparc64 V245 and T2000
> the pcie tree has no root port device in top level, the
> upstream port device is connected directly to root bus.
> So we may get NULL parent for this upstream port device.
> 
> Upstream port ------ Downstream port ------PCIe-PCI bridge
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/probe.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 51ebb97..cd54298 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1003,7 +1003,10 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	else if (type == PCI_EXP_TYPE_UPSTREAM ||
>  		 type == PCI_EXP_TYPE_DOWNSTREAM) {
>  		parent = pci_upstream_bridge(pdev);
> -		if (!parent->has_secondary_link)
> +		/* For sparc64 V245 and T2000, upstream port may be
> +		 * the top level device, connect to root bus directly.
> +		 */
> +		if (parent && !parent->has_secondary_link)
>  			pdev->has_secondary_link = 1;
>  	}
>  }
> -- 
> 1.7.1
> 
