Return-Path: <SRS0=D3nn=7Y=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=D3nn=7Y=linux.ee=mroos@kernel.org>
Date: Tue, 22 Aug 2017 08:02:00 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: David Miller <davem@davemloft.net>
cc: hch@lst.de, helgaas@kernel.org, sparclinux@vger.kernel.org,
    linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com,
    linux-kernel@vger.kernel.org
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2
 vectors
In-Reply-To: <20170821.133549.1817020810110297960.davem@davemloft.net>
Message-ID: <alpine.LRH.2.20.1708220801450.31611@math.ut.ee>
References: <20170821.112747.1532639515902173100.davem@davemloft.net> <20170821183458.GA23205@lst.de> <alpine.LRH.2.20.1708212209280.31611@math.ut.ee> <20170821.133549.1817020810110297960.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

> 
> >> I think with this patch from -rc6 the symptoms should be cured:
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c005390374957baacbc38eef96ea360559510aa7
> >> 
> >> if that theory is right.
> > 
> > The result with 4.13-rc6 is positive but mixed: the message about MSI-X 
> > affinty maks are still there but the rest of the detection works and the 
> > driver is loaded successfully:
> 
> Is this an SMP system?

Yes, T5120.

-- 
Meelis Roos (mroos@linux.ee)
