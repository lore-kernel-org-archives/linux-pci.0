Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdKWShR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 13:37:17 -0500
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
 <1511337146.4512.6.camel@linux.intel.com>
 <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
 <1511422959.4641.5.camel@linux.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0b12dcfe-1ee1-10ef-4db3-9c9d42dc4703@codeaurora.org>
Date: Thu, 23 Nov 2017 13:37:15 -0500
MIME-Version: 1.0
In-Reply-To: <1511422959.4641.5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/23/2017 2:42 AM, Joonas Lahtinen wrote:
> It is not longer than 80 characters when you break line before the
> PCI_DEVFN like I proposed. Or you can break it after the "=", too,
> either way works fine.

I posted V2 with this suggestion. 

https://patchwork.kernel.org/patch/10071759/

Let me know what you think about the domain number call here. 

u32 domain = pci_domain_nr(dev_priv->drm.pdev->bus);

I don't have a way to test this change. I traced the drm_device's pdev
assignment in the code. It should work fine but I don't have a proof.

If you tell me for sure that this driver will never use a non-zero domain
or this driver will never run on another architecture, I can hard-code it
as 0 as well.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
