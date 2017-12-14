Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbdLNOqt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 09:46:49 -0500
Date: Thu, 14 Dec 2017 07:50:31 -0700
From: Keith Busch <keith.busch@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        liudongdong3@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix shared interrupt handling
Message-ID: <20171214145030.GA25329@localhost.localdomain>
References: <20171214000051.30999.6989.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214000051.30999.6989.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 05:01:58PM -0700, Alex Williamson wrote:
> @@ -109,6 +109,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>  	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
>  	struct pci_bus *parent = pdev->subordinate;
> +	u16 ctl;
>  
>  	pci_lock_rescan_remove();
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> @@ -135,6 +136,10 @@ static void interrupt_event_handler(struct work_struct *work)
>  
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> +
> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
> +			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);

Did you mean to re-enable the interrupt here rather than mask it off?
