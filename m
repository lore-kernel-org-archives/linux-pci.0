Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:59037 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbcKHPP5 (ORCPT
        <rfc822;groupwise-linux-pci@vger.kernel.org:4:1>);
        Tue, 8 Nov 2016 10:15:57 -0500
Message-Id: <5821FA39020000780011D1EE@prv-mh.provo.novell.com>
Date: Tue, 08 Nov 2016 08:15:53 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, <tglx@linutronix.de>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: pci_irq_get_affinity() should cope with
 NULL affinity vector
References: <5821904A020000780011CF55@prv-mh.provo.novell.com>
 <20161108145943.GD12817@lst.de>
In-Reply-To: <20161108145943.GD12817@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 08.11.16 at 15:59, <hch@lst.de> wrote:
> On Tue, Nov 08, 2016 at 12:43:54AM -0700, Jan Beulich wrote:
>> msi_setup_entry() only logs a message when the affinity vector can't be
>> allocated, and hence pci_irq_get_affinity() indexing entry->affinity is
>> wrong without a prior check.
> 
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But just curious: did you run into that case in practice?

No, I've just noticed it while re-basing other changes onto 4.9-rc.

Jan

