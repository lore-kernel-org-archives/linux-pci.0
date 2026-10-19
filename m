Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E736B913;
	Mon, 19 Oct 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392284; cv=none; b=dW0ywi3kzWZ2ChPuAfhpGnMgqI1AMLn/HHd8qD/DU8zPgTOCqrbkw6cDs08y/Okv/Lf4xIYjECchjRWPp1akpYGV9EbR34urfQ+D5HNQRySImRRzOAzW7iJKfObwbJ6hFcEiMH9sSjj5D96ey/ODfavVK83WVZ+LkwwqN0YuD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392284; c=relaxed/simple;
	bh=TaxUYCazpzjqvEXq1Wn1UVrlD7Nftpov0ZTJAH6790k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+30jsGZN6bIBL9L8haq/J/FkG1X7tIRzQPsXiPQrK6qsUKedXg/QQRj+NrxQHXlZMv6DShif0fDnQ3axIyTPRqqZT+vxvehvvIqsIPhrU75d1BNbHcsQjNnLJxfhxpnsufRox/C5WGogkngHhNE0YF2b/NesP9Tw3Vn8Myh/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NgUBhXNE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NgUBhXNE"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.17])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C72320B7168;
	Sun, 18 Oct 2026 23:44:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C72320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792392275;
	bh=2DFMNxT5EAxE+zkNjVZeNr8HwIMDEtuggVJLWaMvr2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgUBhXNEskg+Kitot3pNbm0DXRI7kLB5TKAysCy3gYO5WJHpWyZ95Dm+X20a1dfi5
	 3EGWHYcVFej4i3PT5Km2+czyAsE52woC6Yo/Rn7ib0URfAzhgT+cBxQ08/pWDW48ap
	 stwwGHGotaFO/1k4ZoaFX6RbJ2cxk1K0exFJ+/yw=
From: Naman Jain <namjain@linux.microsoft.com>
To: changfengnan@bytedance.com
Cc: lrizzo@google.com,
	hch@infradead.org,
	tglx@linutronix.de,
	maz@kernel.org,
	rizzo.unipi@gmail.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	guzebing@bytedance.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
Date: Mon, 19 Oct 2026 06:44:29 +0000
Message-ID: <20261019064429.362555-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8e816cdc-a714-49d8-943f-677617682352@bytedance.com>
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org> <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com> <8e816cdc-a714-49d8-943f-677617682352@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2026 at 04:52:27PM +0800, Fengnan wrote:
> 在 2026/9/9 16:06, Luigi Rizzo 写道:
> > On Wed, Sep 9, 2026 at 8:25 AM Christoph Hellwig <hch@infradead.org> wrote:
> >> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> >>>> it appears that GSIM is only effective in scenarios where multi disks at very high
> >>>> IOPS; in some cases, there was a noticeable performance regression.
> >>>> If there’s something wrong with my configuration, please correct me.
> >>> So we have a NVME specific mechanism to tackle the same problem and a
> >>> more generic version which is subsystem "independent".
> >> I'm not sure they tackle the entirely same problem, although they are
> >> very related.
> > There is overlap but it is accidental.
> > The difference between the two mechanism is the following:
> >
> > - GSIM addresses hardware limitations (SoCs that create huge PCIe
> >    backpressure on each MSIx interrupt, eventually reducing the available
> >    bandwidth too much, regardless of how many CPUs can process interrupts).
> >    The goal here is to throttle the total MSIx rate, blocking them at
> >    the source (PCIe device) rather than later in the interrupt controller.
> >
> > - the NVME mechanism (and NAPI) aim to amortize interrupt processing
> >    overhead. It does so by recreating some fine grained single-source
> >    interrupt moderation (something that NICs do in hardware, but NVME
> >    does not, with 100us being way too coarse for modern SSDs) and an
> >    adaptive scheme to adjust the delay and decide when to kick in.
> That's a great summary.
>
> As for generic solutions, I've tried several approaches before, but none
> of them
> could achieve the same or close results as NVMe adaptive interrupt polling.
> I'm still experimenting with different options.
>
>
> >
> > I think there is a reason for both.
> >
> > GSIM because it is more general and addresses an issue the others cannot handle
> > the subsystem-specific scheme because they can be more efficient
> > (eg they can hook into existing helpers like the threaded irq handler,
> > call directly the handler without going through the full irq chain,
> > use more targeted heuristics to decide when to kick in).
> >
> > cheers
> > luigi

Sharing the test results with GSIM and other NVME specific approaches
here as well. Previously discussed in
https://lore.kernel.org/all/1d12109d-2f47-4ca5-af7b-66c032a379a7@linux.microsoft.com/

There are couple of implementations posted on NVME list, including mine,
to solve nvme issues. Below data also suggests that while GSIM may bring
generic improvements in certain cases, we may still need some NVME
specific changes to address hardirq workload problems.

Background: I was debugging soft lockup issues where sufficiently high FIO
workload can lockup the CPU cores on which high number of NVME PCI MSI
interrupts are affined.

System: 128 ARM64 vCPUs, two NUMA nodes (CPUs 0-63 / 64-127),
There are four data NVMe controllers, each with 14 interrupt-driven I/O 
queues. Corresponding queue vectors from the four controllers are routed
to the same CPU. Therefore:

   vectors per affected CPU:       4
   affected interrupt CPUs:       14
   total data-NVMe I/O vectors:   56

The affected CPUs are:
   0, 10, 19, 28, 37, 46, 55,
   64, 74, 83, 92, 101, 110, 119
The reproduced soft lockups happen on exactly those 14 CPUs.

The production fio command is equivalent to:
   --filename=dev1:dev2:dev3:dev4
   --numjobs=128
   --iodepth=256
   --group_reporting

so the potential total is:
   128 x 256 = 32,768 requests

The NVMe hardware queue depth is 1,024, with 1,023 usable entries.

Default GSIM changes could not prevent soft lockup. Luigi suggested
a timer push change in addition to GSIM changes, which prevents the
lockups, but has an impact on latency and throughput. These are marked as
"push" in below tables.

NVMe fallback: changes I proposed in NVME, here:
https://lore.kernel.org/all/20261009050556.2817978-1-namjain@linux.microsoft.com/
threaded NVMe IRQs: Default kernel with nvme.use_threaded_interrupts=1

High-load results are medians of three runs, you can find complete 
minimum-to-maximum range:

                               IOPS median       complete range
   NVMe fallback                 5.004M          5.002-5.004M
   threaded NVMe IRQs            3.140M          3.100-3.169M
   GSIM fixed 10 us + push       1.962M          1.935-2.025M
   GSIM fixed 30 us + push       1.790M          1.775-1.822M
   GSIM fixed 50 us + push       1.744M          1.736-1.746M

Completion latency:
                               mean        p99          p99.9
   NVMe fallback              6.533 ms    14.352 ms     16.908 ms
   threaded NVMe IRQs        10.421 ms    22.151 ms     24.510 ms
   GSIM fixed 10 us + push   16.570 ms    38.011 ms    270.533 ms
   GSIM fixed 30 us + push   18.283 ms    40.108 ms    492.831 ms
   GSIM fixed 50 us + push   18.743 ms    40.632 ms    541.065 ms

More details and numbers in my RFC series.

Regards,
Naman
