Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032269AbeCAPiE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 10:38:04 -0500
Date: Thu, 1 Mar 2018 09:38:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH] PCI/DPC: Fix INT legacy interrupt in dpc_irq
Message-ID: <20180301153802.GD13722@bhelgaas-glaptop.roam.corp.google.com>
References: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Oza,

On Wed, Jan 31, 2018 at 09:48:55PM +0530, Oza Pawandeep wrote:
> Current dpc driver acknowledge the interrupt in deferred work, which works
> okay since LPI are edge triggered.
> But when RP does not have MSI support, port service driver falls back to
> legacy GIC SPI interrupts, and with current code we do not acknowledge the
> interrupt and we get dpc interrupt storm.
> This patch acknowledges the interrupt in interrupt handler.

Would you mind rephrasing this changelog in generic PCIe terms?  E.g.,
"LPI" and "GIC SPI" are meaningless to me (I assume they're
arm64-specific things), but I don't think it's any arm64-specific
thing that motivates this change.  IIUC, the issue should occur any
time we're not using MSI, so we should be able to describe it in
purely PCIe terms.

s/dpc/DPC/ in text.

It looks like this changelog is intended to be multiple paragraphs; if
so, please leave a blank line between them.  It's a little awkward to
infer "this is a new paragraph" from the fact that "the previous line
didn't look full" :)

Please rebase to my "master" branch (v4.16-rc1).  There was some minor
change that made this not apply cleanly.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 2d976a6..570b561 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -134,7 +134,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  	}
>  
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> -		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>  }
>  
>  static void dpc_rp_pio_print_tlp_header(struct device *dev,
> @@ -277,6 +277,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  
>  		schedule_work(&dpc->work);
>  	}
> +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_INTERRUPT);
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
