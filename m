Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeFAPEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:04:00 -0400
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <35a67b5b-5f37-c779-64a3-eb5e21362e9c@codeaurora.org>
Date: Fri, 1 Jun 2018 11:03:57 -0400
MIME-Version: 1.0
In-Reply-To: <20180601150129.10486-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/1/2018 11:01 AM, Alexandru Gagniuc wrote:
> +	/* Multi-function PCIe share the same link/status. */
> +	if (PCI_FUNC(dev->devfn) != 0)
> +		return;

How about virtual functions?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
