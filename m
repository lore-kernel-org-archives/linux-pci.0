Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36175 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965359AbdADVRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 16:17:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v04L3wHT086966
        for <linux-pci@vger.kernel.org>; Wed, 4 Jan 2017 16:05:15 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27s5bfyuer-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 04 Jan 2017 16:05:15 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <mrochs@linux.vnet.ibm.com>;
        Wed, 4 Jan 2017 14:05:14 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] PCI: Increase VPD access timeout
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Wed, 4 Jan 2017 15:05:11 -0600
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
References: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Message-Id: <F6F83A96-CC67-4920-BCE7-7C8D80F09A7A@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Nov 29, 2016, at 12:00 PM, Matthew R. Ochs <mrochs@linux.vnet.ibm.com> wrote:
> 
> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
> complete. When an access does not complete within this period, a warning
> is logged and an error returned to the caller.
> 
> While this default timeout is valid for most hardware, some devices can
> experience longer access delays under certain circumstances. For example,
> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
> scenario. These types of devices can benefit from an extended timeout.
> 
> To support devices with a longer access delay, increase the timeout in
> pci_vpd_wait() to 125ms. The PCI specification is silent with respect to
> VPD delays, therefore there is no concern for violating a threshold.

Hi Bjorn,

It's been about a month since I originally sent this, and I wanted to know
if you've had a chance to look it over. Would like to get this queued up for
4.11 if possible.


-matt

> 
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---
> drivers/pci/access.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb..61b5a6b 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -355,7 +355,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
> static int pci_vpd_wait(struct pci_dev *dev)
> {
> 	struct pci_vpd *vpd = dev->vpd;
> -	unsigned long timeout = jiffies + msecs_to_jiffies(50);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(125);
> 	unsigned long max_sleep = 16;
> 	u16 status;
> 	int ret;
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

