Return-Path: <SRS0=Kuf8=7X=lst.de=hch@kernel.org>
Return-Path: <SRS0=Kuf8=7X=lst.de=hch@kernel.org>
Date: Mon, 21 Aug 2017 20:34:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Miller <davem@davemloft.net>
Cc: helgaas@kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org,
	linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com,
	linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2
	vectors
Message-ID: <20170821183458.GA23205@lst.de>
References: <alpine.LRH.2.20.1708152321150.11510@math.ut.ee> <alpine.LRH.2.20.1708162136220.16834@math.ut.ee> <20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com> <20170821.112747.1532639515902173100.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821.112747.1532639515902173100.davem@davemloft.net>
List-ID: <linux-pci.vger.kernel.org>

I think with this patch from -rc6 the symptoms should be cured:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c005390374957baacbc38eef96ea360559510aa7

if that theory is right.
