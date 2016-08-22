Return-Path: <agordeev@redhat.com>
Return-Path: <agordeev@redhat.com>
Date: Mon, 22 Aug 2016 13:02:25 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: call pci_intx when using legacy interrupts in
 pci_alloc_irq_vectors
Message-ID: <20160822110225.GA3478@agordeev.lab.eng.brq.redhat.com>
References: <1470924665-25860-1-git-send-email-hch@lst.de>
 <1470924665-25860-3-git-send-email-hch@lst.de>
 <20160818092007.GD27949@agordeev.lab.eng.brq.redhat.com>
 <20160818152649.GA12340@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818152649.GA12340@lst.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 05:26:49PM +0200, Christoph Hellwig wrote:
> It probably should be pci_intx_for_msi.  For now I'm not touching
> drivers that need the quirk, so how about getting the intx in
> now so that the conversion can start, and I'll send a follow on
> to convert to pci_intx_for_msi with Cc to all the relevant parties
> for the quirk as a follow on?

Probably should work.
