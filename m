Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48077 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeHDMIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Aug 2018 08:08:09 -0400
Date: Sat, 4 Aug 2018 12:12:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI/xilinx: Depend on OF instead of the ARCH
Message-ID: <20180804101253.GB12948@lst.de>
References: <20180801151403.20660-1-hch@lst.de> <20180801151403.20660-4-hch@lst.de> <20180802165623.GB13725@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802165623.GB13725@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 02, 2018 at 05:56:23PM +0100, Lorenzo Pieralisi wrote:
> I could have taken it for this merge window but unfortunately it is a
> bit late (ie PCI patches queue is close), I can certainly queue it up
> for v4.20 though.

It is a little sad that we can't take a trivial kconfig patch more than a
week before the end of the merge window.  But then against given how long
a version of this patch has been around and not submitted who am I to
complain..
