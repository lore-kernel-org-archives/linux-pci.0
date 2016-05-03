Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Tue, 3 May 2016 23:19:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 6/8] pci: provide sensible irq vector alloc/free
	routines
Message-ID: <20160503211945.GA25167@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de> <1460770552-31260-7-git-send-email-hch@lst.de> <20160429211638.GB28261@localhost> <20160501180149.GA11131@lst.de> <20160502131124.GA18527@localhost> <20160502144203.GA32221@lst.de> <20160502152929.GA24851@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160502152929.GA24851@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I've implemented your suggestion and I'm getting ready to send out
a new version.  One thing that came to mind is:  do you prefer this
code in irq.c or would you rather have it in msi.c?  While it
also has a legacy irq fallback most of it tied pretty closely to
the msi.c code, so I wonder if we should group them together.
