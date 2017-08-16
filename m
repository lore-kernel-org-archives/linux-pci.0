Return-Path: <SRS0=dI8c=7S=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=dI8c=7S=linux.ee=mroos@kernel.org>
Date: Wed, 16 Aug 2017 21:39:08 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Bjorn Helgaas <helgaas@kernel.org>
cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
    qla2xxx-upstream@qlogic.com,
    Linux Kernel list <linux-kernel@vger.kernel.org>,
    Christoph Hellwig <hch@lst.de>
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2
 vectors
In-Reply-To: <alpine.LRH.2.20.1708152321150.11510@math.ut.ee>
Message-ID: <alpine.LRH.2.20.1708162136220.16834@math.ut.ee>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee> <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.20.1708152321150.11510@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

> > > I noticed that in 4.13.0-rc4 there is a new error in dmesg on my sparc64 
> > > t5120 server: can't allocate MSI-X affinity masks.
> > > 
> > > [   30.274284] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.00-k.
> > > [   30.274648] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iobase 0x000000c100d00000.
> > > [   30.275447] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks for 2 vectors
> > > [   30.816882] scsi host1: qla2xxx
> > > [   30.877294] qla2xxx: probe of 0000:10:00.0 failed with error -22
> > > [   30.877578] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iobase 0x000000c100d04000.
> > > [   30.878387] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks for 2 vectors
> > > [   31.367083] scsi host1: qla2xxx
> > > [   31.427500] qla2xxx: probe of 0000:10:00.1 failed with error -22
> > > 
> > > I do not know if the driver works since nothing is attached to the FC 
> > > HBA at the moment, but from the error messages it looks like the driver 
> > > fails to load.
> > > 
> > > I booted 4.12 and 4.11 - the red error is not there but the failure 
> > > seems to be the same error -22:
> 
> 4.10.0 works, 4.11.0 errors out with EINVAL and 4.13-rc4 errorr sout 
> with more verbose MSI messages. So something between 4.10 and 4.11 has 
> broken it.

I can not reproduice the older kernels that misbehave. I checked out 
earlier kernels and recompiled them (old config lost, nothing changed 
AFAIK), everything works up to 4.12 inclusive.

> Also, 4.13-rc4 is broken on another sun4v here (T1000). So it seems to 
> be sun4v interrupt related.

This still holds - 4.13-rc4 has MSI trouble on at least 2 of my sun4v 
machines.

-- 
Meelis Roos (mroos@linux.ee)
