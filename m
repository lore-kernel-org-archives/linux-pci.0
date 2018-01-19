Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeASOII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 09:08:08 -0500
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
Message-ID: <a61cd3d4-ae7b-9ef3-944d-952021cca0e4@codeaurora.org>
Date: Fri, 19 Jan 2018 09:08:05 -0500
MIME-Version: 1.0
In-Reply-To: <1516360204-1586-8-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/19/2018 6:10 AM, Oza Pawandeep wrote:
> +check_link:
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +
> +	if (ret == active) {
> +		dev_printk(KERN_DEBUG, &pdev->dev,
> +			   "%s: lnk_status = %x\n", __func__, lnk_status);
> +		return true;
> +	}
> +
> +	while (timeout > 0) {
> +		msleep(10);
> +		timeout -= 10;
> +		goto check_link;
> +	}


this is weird. 

I think following is a simpler approach.

pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);

while ((ret != active) && (timeout > 0)) {
	msleep(10);
	timeout -= 10;

	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
}


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
