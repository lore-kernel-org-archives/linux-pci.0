Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Mar 2016 11:55:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] pci: move pci_dma_* helpers to common code
Message-ID: <20160308175554.GA21278@localhost>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
 <1457277475-8913-4-git-send-email-hch@lst.de>
 <20160307182848.GC13818@localhost>
 <20160308174346.GB19869@localhost>
 <20160308174911.GA29536@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308174911.GA29536@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 06:49:11PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 08, 2016 at 11:43:46AM -0600, Bjorn Helgaas wrote:
> > I applied the patch below to pci/misc for v4.6.
> 
> Btw, where do you keep your tree?
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/misc
> 
> hasn't been updated for a month.

Sorry, that's the right place; I just hadn't pushed it yet.
Should be there now.  I'll merge it to my "next" branch after the
robot confirms that I haven't broken the build.

Bjorn
