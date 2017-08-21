Return-Path: <SRS0=fMXc=7X=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=fMXc=7X=davemloft.net=davem@kernel.org>
Date: Mon, 21 Aug 2017 13:35:49 -0700 (PDT)
Message-Id: <20170821.133549.1817020810110297960.davem@davemloft.net>
To: mroos@linux.ee
Cc: hch@lst.de, helgaas@kernel.org, sparclinux@vger.kernel.org,
 linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com,
 linux-kernel@vger.kernel.org
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2
 vectors
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
References: <20170821.112747.1532639515902173100.davem@davemloft.net>
	<20170821183458.GA23205@lst.de>
	<alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: mroos@linux.ee
Date: Mon, 21 Aug 2017 22:20:22 +0300 (EEST)

>> I think with this patch from -rc6 the symptoms should be cured:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c005390374957baacbc38eef96ea360559510aa7
>> 
>> if that theory is right.
> 
> The result with 4.13-rc6 is positive but mixed: the message about MSI-X 
> affinty maks are still there but the rest of the detection works and the 
> driver is loaded successfully:

Is this an SMP system?

I ask because the commit log message indicates that this failure is
not expected to ever happen on SMP.

We really need to root cause this.
