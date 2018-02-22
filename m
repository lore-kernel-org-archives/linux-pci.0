Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBVSnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 13:43:50 -0500
Date: Thu, 22 Feb 2018 10:43:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 6/7] PCI: Unify wait for link active into generic pci
Message-ID: <20180222184348.GE6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519315332-26852-7-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>  
> +/**
> + * pci__wait_for_link - Wait for link till its active/inactive

typo - just wants a single underscore.

> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);

no need for the !! when assigning to a boolean.

> +
> +	while ((ret != active) && (timeout > 0)) {

No need for either pair of inner braces.

> +		msleep(10);
> +		timeout -= 10;
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);

Same as above.

> +	}
> +
> +	if (ret == active)
> +		return true;

Seems like the structure is a bit odd.  Why not:

	for (;;) {
		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
		if ((lnk_status & PCI_EXP_LNKSTA_DLLLA) == active)
			return true;
		if (timeout <= 0)
			break;
		timeout -= 10;
	}
