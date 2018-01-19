Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:54228 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755739AbeASOT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jan 2018 09:19:26 -0500
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
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
References: <1516360204-1586-1-git-send-email-poza@codeaurora.org>
 <1516360204-1586-8-git-send-email-poza@codeaurora.org>
From: Stefan Roese <sr@denx.de>
Message-ID: <d8573bed-3517-bc9b-1e4a-c0107be9ea13@denx.de>
Date: Fri, 19 Jan 2018 15:19:09 +0100
MIME-Version: 1.0
In-Reply-To: <1516360204-1586-8-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19.01.2018 12:10, Oza Pawandeep wrote:
> Clients such as pciehp, dpc are using pcie_wait_link_active, which waits
> till the link becomes active or inactive.
> 
> Made generic function and moved it to drivers/pci/pci.c
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7bab060..26afeff 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -245,25 +245,12 @@ bool pciehp_check_link_active(struct controller *ctrl)
>   	return ret;
>   }
>   
> -static void __pcie_wait_link_active(struct controller *ctrl, bool active)
> +static bool pcie_wait_link_active(struct controller *ctrl)
>   {
> -	int timeout = 1000;
> -
> -	if (pciehp_check_link_active(ctrl) == active)
> -		return;
> -	while (timeout > 0) {
> -		msleep(10);
> -		timeout -= 10;
> -		if (pciehp_check_link_active(ctrl) == active)
> -			return;
> -	}
> -	ctrl_dbg(ctrl, "Data Link Layer Link Active not %s in 1000 msec\n",
> -			active ? "set" : "cleared");
> -}
> +	struct pci_dev *pdev = ctrl_dev(ctrl);
> +	bool active = true;
>   
> -static void pcie_wait_link_active(struct controller *ctrl)
> -{
> -	__pcie_wait_link_active(ctrl, true);
> +	return pci_wait_for_link(pdev, active);
>   }
>   
>   static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4a7c686..0de83ea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2805,7 +2805,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>   	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
>   
>   	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> +//	ctrl |= (cap & PCI_ACS_SV);

Could it be, that you missed to fix / clean something up here?

Thanks,
Stefan
