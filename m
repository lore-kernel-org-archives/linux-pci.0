Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Apr 2018 17:25:28 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 5/6] PCI: Unify wait for link active into generic PCI
Message-ID: <20180409232528.GE6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523284914-2037-6-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:53AM -0400, Oza Pawandeep wrote:
> +/**
> + * pcie_wait_for_link - Wait for link till it's active/inactive
> + * @pdev: Bridge device
> + * @active: waiting for active or inactive ?
> + *
> + * Use this to wait till link becomes active or inactive.
> + */
> +bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
> +{
> +	int timeout = 1000;
> +	bool ret;
> +	u16 lnk_status;
> +
> +	for (;;) {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +		if (ret == active)
> +			return true;
> +		if (timeout <= 0)
> +			break;
> +		timeout -= 10;
> +	}

This is missing an msleep(10) at each iteration.

> +
> +	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> +		 active ? "set" : "cleared");
> +
> +	return false;
> +}
