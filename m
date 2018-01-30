Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeA3CLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jan 2018 21:11:46 -0500
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling
 event
To: Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <20180129213145.26068-1-keith.busch@intel.com>
 <20180129213145.26068-2-keith.busch@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
Date: Mon, 29 Jan 2018 21:11:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180129213145.26068-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/29/2018 4:31 PM, Keith Busch wrote:
> +	if (!work_busy(&dpc->work))
> +		schedule_work(&dpc->work);

Isn't there a race condition between the time that dpc_work() clears PCI_EXP_DPC_STATUS
register and when work actually completes by returning from dpc_work()?

If the interrupt arrives just in this window, this code will not schedule the work.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
