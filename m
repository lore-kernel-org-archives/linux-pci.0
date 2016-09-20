Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Tue, 20 Sep 2016 22:03:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, agordeev@redhat.com,
	linux-pci@vger.kernel.org, davem@davemloft.net, shane.huang@amd.com
Subject: Re: [PATCH, RFC] PCI: use pci_intx_for_msi in pci_alloc_irq_vectors
Message-ID: <20160920200310.GA768@lst.de>
References: <1473577767-9888-1-git-send-email-hch@lst.de> <20160920194614.GE4941@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160920194614.GE4941@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 20, 2016 at 02:46:14PM -0500, Bjorn Helgaas wrote:
> If we want to do this, I'd like to have a changelog that explains
> *why*, so I'm ignoring it for now.  I'm not nacking it; I just don't
> understand why we should do it yet, and I'm too lazy to do all the
> research myself.

Can't blame you.  Alex pointed me to the function, and it seems like a
good idea, but research in git history just doesn't give me an conclusive
reason on why to do it either.
