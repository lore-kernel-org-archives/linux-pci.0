Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdIXAUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Sep 2017 20:20:31 -0400
Subject: Re: [PATCH 5/5] PCI: add device wait after slot and bus reset
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-5-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a74c385e-f82d-1ec3-bda8-26209749bbe7@codeaurora.org>
Date: Sat, 23 Sep 2017 20:20:27 -0400
MIME-Version: 1.0
In-Reply-To: <1506212218-29103-5-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/23/2017 8:16 PM, Sinan Kaya wrote:
> @@ -4056,7 +4056,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
>  
>  	pci_reset_bridge_secondary_bus(dev->bus->self);
>  
> -	return 0;
> +	return pci_dev_wait(dev, "bus reset", 1000, 60000);
>  }

This doesn't solve the warm reset message getting broadcasted. I wanted to get
feedback on the direction first with this version.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
