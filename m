Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIAC1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:27:46 -0400
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <01398ef7-88a8-cac1-3e15-ef68c165f7a4@kernel.org>
Date: Fri, 31 Aug 2018 15:18:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180831212639.10196-15-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 2:26 PM, Keith Busch wrote:
> This is safe because the pciehp and DPC drivers share the same
> interrupt. The DPC driver sets the bus state in the top-half interrupt
> context, and the pciehp driver checks and masks off link events in its
> bottom-half error handler.

Where is this coming from? Is there a spec reference?

DPC and HP interrupts can be implemented as MSI-x interrupts and could
be unrelated interrupt IDs?
