Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbeASOR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 09:17:26 -0500
Subject: Re: [PATCH v6 7/7] PCI: Unify wait for link active into generic pci
To: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
References: <1516360204-1586-1-git-send-email-poza@codeaurora.org>
 <1516360204-1586-8-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <10da80a3-e058-1a21-7af2-405c99b7991e@codeaurora.org>
Date: Fri, 19 Jan 2018 09:17:23 -0500
MIME-Version: 1.0
In-Reply-To: <1516360204-1586-8-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/19/2018 6:10 AM, Oza Pawandeep wrote:
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -150,37 +150,9 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  	struct pci_dev *pdev = dpc->dev->port;
>  	struct device *dev = &dpc->dev->device;
>  	u16 lnk_status;
> +	bool active = false;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
> -					!time_after(jiffies, timeout)) {
> -		msleep(10);
> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	}
> -	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
> -		dev_warn(dev, "Link state not disabled for DPC event\n");
> -}

I think you should reorder 6 and 7 to eliminate this.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
