Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35306 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcCFUwQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 6 Mar 2016 15:52:16 -0500
Date: Sun, 6 Mar 2016 21:52:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: two small PCI header cleanups
Message-ID: <20160306205213.GA30838@lst.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de> <201603062147.03753.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603062147.03753.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 06, 2016 at 09:47:03PM +0100, Arnd Bergmann wrote:
> > Move a header from asm-generic to Linux because it isn't a generic arch
> > implementation, and also implement the pci_dma_* helpers in common code.
> > 
> 
> Nice cleanup!
> 
> Should I take these through the asm-generic tree?

I expected Bjoern to takes this throught the PCI tree, but as far
as I'm concerned your tree is fine as well.
