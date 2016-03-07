Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38667 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbcCGQhI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 11:37:08 -0500
Date: Mon, 7 Mar 2016 17:37:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] pci: move pci-bridge.h out of asm-generic
Message-ID: <20160307163705.GA25780@lst.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de> <1457277475-8913-3-git-send-email-hch@lst.de> <20160307163529.GA13818@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160307163529.GA13818@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 07, 2016 at 10:35:29AM -0600, Bjorn Helgaas wrote:
> I did something similar with
> http://lkml.kernel.org/r/20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com
> 
> The generic things in include/asm-generic/pci-bridge.h weren't really
> bridge-related, so I moved them to include/linux/pci.h instead of creating
> include/linux/pci-bridge.h.
> 
> Then include/asm-generic/pci-bridge.h was empty, so I removed it and the
> includes of it.
> 
> There were a few arch-specific asm/pci-bridge.h files, but they do contain
> arch-specific things, and they're only included by arch code, so I left
> them alone.
> 
> My changes are in linux-next, and I plan to merge them during the v4.6
> merge window.

Even better.  Let's drop this patch, but it would still be good to get
the other two through one of the trees.
