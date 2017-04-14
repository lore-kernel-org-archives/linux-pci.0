Return-Path: <SRS0=WdvV=3W=lst.de=hch@kernel.org>
Return-Path: <SRS0=WdvV=3W=lst.de=hch@kernel.org>
Date: Fri, 14 Apr 2017 17:58:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI/irq: add pci_request_irq and pci_free_irq
	helpers
Message-ID: <20170414155807.GD22412@lst.de>
References: <20170413070643.32165-1-hch@lst.de> <20170413070643.32165-4-hch@lst.de> <20170414144649.GC29349@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170414144649.GC29349@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 09:46:49AM -0500, Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Let me know if you'd like me to take this series (given an appropriate
> ack for the genirq parts).

I want to hear from Thomas on the genirq bits.  But if he's fine with
it might be a good idea to take it through your tree.
