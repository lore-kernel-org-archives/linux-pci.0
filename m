Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56492 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 14:23:46 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v9 4/7] PCI/DPC: Unify and plumb error handling into DPC
To: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-5-git-send-email-poza@codeaurora.org>
Message-ID: <fc5351ba-1310-5ccf-b0cb-8565679d4c22@infradead.org>
Date: Thu, 22 Feb 2018 11:23:35 -0800
MIME-Version: 1.0
In-Reply-To: <1519285571-5634-5-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pci_do_recovery.

Hi,
What does DPC mean?

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 

> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6..208b427 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c

> @@ -82,12 +137,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  		dev_warn(dev, "Link state not disabled for DPC event\n");
>  }
>  
> +/**
> + * dpc_reset_link - reset link DPC  routine
 + * @dev: pointer to Root Port's pci_dev data structure

   * @pdev: ...

> + *
> + * Invoked by Port Bus driver when performing link reset at Root Port.
> + */
> +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {

You can use 'make W=1 ...' to find kernel-doc warnings like this.

thanks,
-- 
~Randy
