Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFLEkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 00:40:53 -0400
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>
References: <20180611222918.1708-1-keith.busch@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <08e0ba9f-69cd-ea18-ae1b-d0795cceb306@codeaurora.org>
Date: Tue, 12 Jun 2018 00:40:50 -0400
MIME-Version: 1.0
In-Reply-To: <20180611222918.1708-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/11/2018 6:29 PM, Keith Busch wrote:
> A bridge that supports D3 but not hotplug will be subject to runtime
> power management placing it in a non-operation power state if it doesn't
> have any devices attached. This patch will prevent this power management
> during error recovery so that the rescan at the end may be successful.

If there is no card connected, why would the bridge observe a fatal error?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
