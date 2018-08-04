Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48073 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeHDMHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Aug 2018 08:07:08 -0400
Date: Sat, 4 Aug 2018 12:11:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for
        adding a new device
Message-ID: <20180804101151.GA12948@lst.de>
References: <20180801151403.20660-1-hch@lst.de> <20180801151403.20660-2-hch@lst.de> <20180802165430.GA13725@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802165430.GA13725@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 02, 2018 at 05:54:30PM +0100, Lorenzo Pieralisi wrote:
> while at it, IMHO it would be good to match the current
> pcibios_add_device() prototype (ie returning an int error value)
> so that this change can pave the way to removing yet another
> pcibios call.

Replacing pcibios_add_device sounds like a good idea.  But then
again we can't actually handle the error of that one either
right now..
