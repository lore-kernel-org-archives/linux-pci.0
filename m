Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971510AbdDTROy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2017 13:14:54 -0400
Subject: Re: [PATCH v2] PCI: disable SERR for kdump kernel
To: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170419003130.5302-1-yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
Date: Thu, 20 Apr 2017 13:14:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170419003130.5302-1-yinghai@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/18/2017 8:31 PM, Yinghai Lu wrote:
> * pci_setup_device - fill in class and map information of a device
>   * @dev: the device structure to fill
> @@ -1572,6 +1592,9 @@ int pci_setup_device(struct pci_dev *dev
>  	/* device class may be changed after fixup */
>  	class = dev->class >> 8;
>  
> +	if (is_kdump_kernel())
> +		pci_disable_serr(dev);
> +

This sounds like something that needs to be done while shutting down
the first kernel as part of the kdump procedure rather than boot of 
the kdump kernel in pci setup.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
