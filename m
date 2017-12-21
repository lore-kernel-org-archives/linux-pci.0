Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756538AbdLUEnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 23:43:13 -0500
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
To: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
Date: Wed, 20 Dec 2017 23:43:07 -0500
MIME-Version: 1.0
In-Reply-To: <20171219210643.24615-4-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+Oza

On 12/19/2017 4:06 PM, Keith Busch wrote:
> A DPC enabled device will suppress sending ERR_FATAL and ERR_NONFATAL,
> which prevents the AER handler from reporting the details of the
> error. This patch will have the DPC driver get the AER status registers
> from the downstream port that detected the uncorrectable error, and
> print out additional information.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---

Oza is doing some restructuring to unify DPC and AER error handling path per
feedback from Bjorn. It is almost done. He is testing it. 

Can this patch wait until you review his version? I'm thinking this could
be something that can be added to his series instead.

Coming back to this patch. The interrupt number for DPC and AER could be the
same or different. According to the spec, AER errors are always reported
regardless of DPC driver presence (see the famous flow chart).

If the interrupt IDs are the same for AER and DPC, your patch would introduce
double printing for AER errors.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
