Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933097AbeFTV7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 17:59:38 -0400
Subject: Re: [PATCH 1/7] PCI/DPC: Leave interrupts enabled while handling
 event
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <801facdf-dbdf-12c1-c470-a97db065b232@codeaurora.org>
 <20180620215442.GA25124@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b7a6d420-342b-0ad2-444f-35f4529d941d@codeaurora.org>
Date: Wed, 20 Jun 2018 17:59:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180620215442.GA25124@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/20/2018 5:54 PM, Keith Busch wrote:
> If a shared interrupt occurs for another service (say, AER) before DPC's
> bottom half handler runs, the DPC Interrupt Status won't be set, so the
> DPC driver will return IRQ_NONE.

OK. This is what I was after. I saw that you removed a bunch of checks.
I was worried that status check was gone too.

Reviewed-by: Sinan Kaya <okaya@kernel.org>

for the series.

P.S. please use my new email address: okaya@kernel.org moving forward.
I'll lose access to okaya@codeaurora.org email address in a month.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
