Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEIEia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 00:38:30 -0400
Date: Tue, 8 May 2018 21:38:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Message-ID: <20180509043828.GA9413@infradead.org>
References: <20180508160022.30954-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180508160022.30954-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2018 at 10:00:22AM -0600, Keith Busch wrote:
> Devices with slow interrupt handlers are significantly harming performance
> when their interrupt vector is shared with a fast device. This patch
> creates a class code white list for devices with known fast interrupt
> handlers, and all other devices will share a single vector so they don't
> interfere with performance.
> 
> At the moment, only the NVM Express class code is on the list, but more
> may be added if VMD users desire to use other low-latency devices in
> these domains.

I think this is far too much of a hack.   Just don't use VMD if your
care about performance.
