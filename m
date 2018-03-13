Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:65378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932590AbeCMXWp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 19:22:45 -0400
Date: Tue, 13 Mar 2018 17:24:40 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCHv2] PCI: vmd: Use affinity to chain child device interrupts
Message-ID: <20180313232440.GA28358@localhost.localdomain>
References: <20180206202225.1124-1-keith.busch@intel.com>
 <20180313171039.GB20373@e107981-ln.cambridge.arm.com>
 <20180313200840.GA28002@localhost.localdomain>
 <20180313201807.GA28112@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313201807.GA28112@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 02:18:07PM -0600, Keith Busch wrote:
> 
> And since you brought my attention to it, I see the 'if' is off by one.
> Let me prepare a v3, and I've one other minor optimization to add as
> well.

Ugh, I may need to request withdrawing this patch entirely. This will
completely break if the VMD interrupt vector's SMP affinity is a subset
of the child driver's, and the CPUs in the intersection of those masks
are set offline after driver initialization.

That's looking like a pretty tricky problem to fix, all for (somewhat)
obscure kernel feature... I can't see how without a new hot cpu notifier.

Let me request a pause on this one and I'll get back ASAP.
