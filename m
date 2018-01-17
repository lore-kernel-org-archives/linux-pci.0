Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeAQQqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 11:46:01 -0500
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
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
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <298df660-1f7d-85ab-51db-11dc5d80cc75@codeaurora.org>
Date: Wed, 17 Jan 2018 11:45:57 -0500
MIME-Version: 1.0
In-Reply-To: <1516185438-31556-4-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
> +		driver = pci_find_dpc_service(udev);
> +#endif
>  #if IS_ENABLED(CONFIG_PCIEAER)
> -	/* Use the aer driver of the component firstly */
> -	driver = pci_find_aer_service(udev);

I think we need a pci_find_service function that unifies these two.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
