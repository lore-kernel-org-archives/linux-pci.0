Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933227AbeFTVmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 17:42:53 -0400
Subject: Re: [PATCH 1/7] PCI/DPC: Leave interrupts enabled while handling
 event
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>
References: <20180620213833.25072-1-keith.busch@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <801facdf-dbdf-12c1-c470-a97db065b232@codeaurora.org>
Date: Wed, 20 Jun 2018 17:42:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/20/2018 5:38 PM, Keith Busch wrote:
> Now that the DPC driver clears the interrupt status before exiting the
> irq handler, we don't need to abuse the DPC control register to know if
> a shared interrupt is for a new DPC event: a DPC port can not trigger
> a second interrupt until the host clears the trigger status later in the
> work queue handler.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Isn't this a problem with legacy interrupts on the root ports with no MSI?
(can be tested with pci=nomsi)

DPC interrupt handler gets called for all service driver interrupts like AER, PME and
HP.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
