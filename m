Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: two small PCI header cleanups
Date: Sun, 6 Mar 2016 21:47:03 +0100
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1457277475-8913-1-git-send-email-hch@lst.de>
In-Reply-To: <1457277475-8913-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201603062147.03753.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 06 March 2016, Christoph Hellwig wrote:
> Move a header from asm-generic to Linux because it isn't a generic arch
> implementation, and also implement the pci_dma_* helpers in common code.
> 

Nice cleanup!

Should I take these through the asm-generic tree?

	Arnd
