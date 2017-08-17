Return-Path: <SRS0=DbGE=7T=lst.de=hch@kernel.org>
Return-Path: <SRS0=DbGE=7T=lst.de=hch@kernel.org>
Date: Thu, 17 Aug 2017 12:09:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sparclinux@vger.kernel.org,
	linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2
	vectors
Message-ID: <20170817100921.GA29888@lst.de>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee> <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.20.1708152321150.11510@math.ut.ee> <alpine.LRH.2.20.1708162136220.16834@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.20.1708162136220.16834@math.ut.ee>
List-ID: <linux-pci.vger.kernel.org>

Just curious:  these are all SMP builds, right?

Just got burnt again by an UP kernel issue in that area that I sent
a patch for (to Jens) a long time ago, but that didn't get fixed.
