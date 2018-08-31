Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29793 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIACmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:42:10 -0400
Date: Fri, 31 Aug 2018 16:33:53 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
Message-ID: <20180831223352.GE9677@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
 <01398ef7-88a8-cac1-3e15-ef68c165f7a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01398ef7-88a8-cac1-3e15-ef68c165f7a4@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:18:15PM -0700, Sinan Kaya wrote:
> On 8/31/2018 2:26 PM, Keith Busch wrote:
> > This is safe because the pciehp and DPC drivers share the same
> > interrupt. The DPC driver sets the bus state in the top-half interrupt
> > context, and the pciehp driver checks and masks off link events in its
> > bottom-half error handler.
> 
> Where is this coming from? Is there a spec reference?
> 
> DPC and HP interrupts can be implemented as MSI-x interrupts and could
> be unrelated interrupt IDs?

Darn, you're right. The kernel allocates up to 32 vectors and the port is
free to divvy them up however it wants amont its supported services. It
just so happened most of the ports I tested used the same one. There's
no way to really close this race if they are separate vectors though,
so maybe just leave this as  a 'best effort' approach and update the
change log accodingly.
