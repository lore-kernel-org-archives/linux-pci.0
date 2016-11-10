Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755560AbcKJSfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 13:35:45 -0500
Subject: Re: [PATCH] PCI: enable extended tags support for PCIe endpoints
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, vikrams@codeaurora.org
References: <1474769434-5756-1-git-send-email-okaya@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <420a9a23-79f8-41d8-c44f-b53f5000c957@codeaurora.org>
Date: Thu, 10 Nov 2016 13:35:41 -0500
MIME-Version: 1.0
In-Reply-To: <1474769434-5756-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 9/24/2016 10:10 PM, Sinan Kaya wrote:
> Each PCIe device can issue up to 32 transactions at a time by default.
> Each transaction is tracked by a tag number on the bus. 32 outstanding
> transactions is not enough for some performance critical applications
> especially when a lot of small sized frames are transmitted.
> 
> Extended tags support increases this number to 256. Devices not
> supporting extended tags tie-off this field to 0. According to ECN, it
> is safe to enable this feature for all PCIe endpoints.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/probe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 93f280d..2424f38 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1505,12 +1505,19 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	 */
>  }
>  
> +static int pci_configure_extended_tags(struct pci_dev *dev)
> +{

I should have checked the capability here before trying to enable it. 
I'll post a follow up patch on this. 

Is there any other feedback?


> +	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> +					 PCI_EXP_DEVCTL_EXT_TAG);
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	struct hotplug_params hpp;
>  	int ret;
>  
>  	pci_configure_mps(dev);
> +	pci_configure_extended_tags(dev);
>  
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret = pci_get_hp_params(dev, &hpp);
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
