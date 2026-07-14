Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B2D0C92;
	Tue, 14 Jul 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050397; cv=none; b=qh16Lh6Sy3fePh6PjGd6aWC2fIUtHr0ELB50Rn6G547Kj4wtKSzlHU2xghNgi2jGc5noKaaachl6ggY2YMozdyhTPX7whqYUea6wCPJVb/1loIi2mvQzV5XPgJRYetoMa+xa0lXpcDeMBFPYMDHb435P/P42Y5s8Gf8Hv2UVKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050397; c=relaxed/simple;
	bh=KxAtcBTq6Q7LICGaMbA9miPeB2LC0QoPItQufKyIsK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PsN4dkCPHzWz0zD31VW0WKWU3k9yP6CPXPPO5I3GhcTfkwTB8c5M94rHGYetkPlRkVyivL71wF1W7zFBrXHUUsLJQNEXavG5X4GVZHe3TYoukf67AVi+bJya6ei15YNUxxT0aIFnqyHqQDTcf+JcIpZ9xcXHYFFgx3T3dT6TIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmai+x3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmai+x3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24681F000E9;
	Tue, 14 Jul 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050396;
	bh=0/2Vbem4uUKn0p3ksAMM3bG5ETqwG60Y4I0HBdf6+4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Rmai+x3I1QMlpO9dVhhmod4zVfFwmljwbEWEUgT1EClhdNQCaLmHKSCEJ1b7yFsq4
	 VhdaPcEqLFwAi3zHZiMEXnPV7mQ6cBS1Vg91zUIinNxk7TV1xQisUXyDAq0cL1x3Zh
	 jK1ur5PzG0bYUSc0WKIOdI01zzJyZxWq8dOLt+BfTVrE3zafDhL7EBd2pEFC8ZhKaF
	 kYSqohgwfjZkkZxtfR761qpARxdpnccTXwMP6fHUHBbPqVFqaukLHu+vRm7sUSzLUm
	 qWFr52i5UTo3JaBNAQrZxMu9vrLif2R4BhKZfuYE6KV9I0jPEEH9Dl1kTCbtWxtc6c
	 0fEfXWoDLltcg==
Date: Tue, 14 Jul 2026 12:33:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rowan Cramer <rowan.cramer@gmail.com>
Cc: linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Nam Cao <namcao@linutronix.de>, Zide Chen <zide.chen@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org
Subject: Re: NVMe MSI-X completions lost behind VMD across package C-state
 exit (even PC2) on Arrow Lake client VMD [8086:7d0b]
Message-ID: <20260714173314.GA1365789@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPew1NKKWf7rr6eZXp=KooN43CKaTbcc-U9ZkKrBhcXaARTKUQ@mail.gmail.com>

[+cc VMD, cpuidle folks]

On Tue, Jul 14, 2026 at 08:57:17AM -0400, Rowan Cramer wrote:
> Hi,
> 
> I have what looks like a platform/VMD interrupt-delivery bug on a
> new Arrow Lake laptop, isolated with a reliable reproducer and a
> three-arm test matrix. Reporting here because the fault sits below
> the NVMe driver, in the VMD interrupt path, and is invisible unless
> the package is allowed to idle. Happy to test patches or run any
> further diagnostics.
> 
> Summary
> -------
> NVMe MSI-X completion interrupts are intermittently lost when they
> arrive through VMD's interrupt remapper while the CPU package is in
> (or exiting) ANY idle state deeper than C1 — including plain PC2.
> The drive completes the I/O correctly (the kernel's timeout handler
> always finds the completion already in the queue: "timeout,
> completion polled"); only the interrupt vanishes. Holding PM-QoS
> /dev/cpu_dma_latency at 100 us (C1-only idle) eliminates the fault
> completely; nothing else does.
> 
> System
> ------
> - Dell 14 Premium / XPS 14 (DA14250), BIOS 1.11.0 (latest; Dell
>   ships VMD force-enabled, no BIOS toggle on this model)
> - Intel Arrow Lake; VMD controller 8086:7d0b at 0000:00:0e.0
>   (client SKU -> VMD_FEATS_CLIENT, so MSI remapping is always on;
>   no VMD_FEAT_CAN_BYPASS_MSI_REMAP, no module parameter)
> - NVMe: Micron 2650 1TB (DRAM-less/HMB), FW 26500101, at
>   10000:e1:00.0; all queues route via VMD-PCI-MSIX per
>   /proc/interrupts
> - Fault is kernel-independent: reproduced identically on 6.18.33
>   (LTS), 7.0.9 and 7.0.10 (Arch builds, clean cmdline)
> - intel_idle in ACPI mode; exposed states POLL / C1_ACPI (1 us) /
>   C2_ACPI (127 us) / C3_ACPI (1048 us)
> 
> Symptom
> -------
>   nvme nvme0: I/O tag N QID Q timeout, completion polled
> 
> Present since the machine's very first boot (3 events in the first
> 90 s of its life). Baseline ~125 events/day idle; 60-190/hr under
> gaming I/O. Each event stalls the waiting I/O for io_timeout
> seconds (we run nvme_core.io_timeout=10 as mitigation), which
> manifests as multi-second system freezes. SMART is immaculate: 0
> media errors, 0 controller error-log entries against >500 host-side
> timeouts — the device completes the I/O; the notification is lost.
> 
> Key evidence
> ------------
> 1. Load is NOT the trigger. ~4 TB of worst-case saturating stress
>    (random reads at 2+ GiB/s, plus CPU, memory-bandwidth, GPU and
>    fsync-write pressure, combined) produced ZERO events. Saturating
>    I/O never lets the platform idle.
> 
> 2. Idle->active transitions ARE the trigger. A trivial reproducer
>    (bursty random reads separated by 1-8 s idle gaps, script below)
>    produces 13-16 lost interrupts per 15 min, every run.
> 
> 3. PM-QoS bisection puts the loss boundary exactly at C1|C2:
>      /dev/cpu_dma_latency hold   idle allowed        events/15min
>      none (stock)                C1+C2+C3            13-16
>      200 us                      C1+C2               19
>      100 us                      C1 only             0
>      0 us                        none (poll)         0
> 
> 4. Ruled out: drive APST (nvme set-feature 0x0c=0: no change), link
>    ASPM (runtime-disabled via sysfs on the VMD-domain link: no
>    change; note cmdline pcie_aspm=off does not govern VMD-managed
>    links, the vmd driver enables L1.1/L1.2 itself per
>    VMD_FEAT_BIOS_PM_QUIRK), kernel version, drive health, firmware
>    updates (none available).
> 
> 5. turbostat correlation (5 s intervals alongside the reproducer):
>    the package NEVER enters PC8/PC10 on this platform under bursty
>    I/O — deepest observed is PC6 — and every lost interrupt falls
>    in intervals showing only PC2/PC3/PC6 residency:
> 
>      arm (900 s each)        Pkg%pc2/pc3/pc6/pc8/pc10   events
>      stock                   13.2 / 0.3 / 4.8 / 0 / 0     13
>      endpoint LTR clamped    19.8 /  0  /  0  / 0 / 0     14
>        to 102.4 us
>      cpu_dma_latency=100us    ~0  /  0  /  0  / 0 / 0      0
> 
> 6. LTR is irrelevant. Firmware sets the endpoint LTR to 15.7 ms
>    (0x100f100f — nonzero, so vmd's BIOS PM quirk never touches it).
>    Clamping it to 102.4 us via setpci was demonstrably honored by
>    the platform (PC3/PC6 residency dropped to zero) yet the loss
>    rate was unchanged (14 vs 13). The fault does not need deep
>    package states — losses occur with nothing deeper than PC2, with
>    cores in C6/C7.
> 
> Current mitigation
> ------------------
> A systemd unit holding /dev/cpu_dma_latency at 100 us. Fully
> effective (a full day of gaming: 1 event vs the prior 60-190/hr),
> but it costs ~2.5-4 W package power versus letting the machine
> idle properly, since it must forbid core C6/C7 and PC2 everywhere.
> 
> Questions
> ---------
> 1. Is this a known Arrow Lake (or MTL-family) VMD erratum? The
>    machine shipped this way; Windows presumably masks it via its
>    own idle policy or is equally affected but silent.
> 
> 2. The client feature set forces MSI remapping on 8086:7d0b. Is the
>    VMCONFIG_MSI_REMAP bypass (as used for 28C0) architecturally
>    possible on client VMD? I am happy to test a patch enabling
>    bypass on 7d0b, or any other diagnostic/experimental patch —
>    the reproducer gives a decisive answer in 15 minutes.
> 
> 3. If the hardware genuinely cannot deliver remapped MSIs across
>    package C-state exit, should vmd.c be constraining PM (PM-QoS /
>    LTR / DMI-quirk) on affected platforms? As it stands, every
>    affected laptop loses NVMe interrupts silently at its default
>    idle settings.
> 
> Full journals since the machine's first boot, lspci -vvv, SMART
> dumps, raw turbostat logs and the complete phase-by-phase test
> history are preserved and available on request.

Can you make these available somewhere and include a URL?

> Reproducer
> ----------
> Point ROOT at any directory with a few multi-hundred-MB files on
> the VMD-attached NVMe, run for 900 s, and count kernel "completion
> polled" events (nvme_core.io_timeout=10 makes them visible within
> 10 s):
> 
>   #!/usr/bin/env python3
>   # bursty-I/O reproducer: idle gaps let the platform enter package
>   # idle; the first read of each burst rides the wake-up.
>   import os, sys, random, time
> 
>   ROOT = os.path.expanduser("~/BG3_Game")   # adjust
>   CHUNK = 65536
>   MIN_SIZE = 200 * 1024 * 1024
> 
>   files = []
>   for dirpath, _, names in os.walk(ROOT, followlinks=True):
>       for n in names:
>           p = os.path.join(dirpath, n)
>           try:
>               s = os.path.getsize(p)
>               if s >= MIN_SIZE:
>                   files.append((p, s))
>           except OSError:
>               pass
>   if not files:
>       sys.exit("no large files under " + ROOT)
> 
>   deadline = time.time() + int(sys.argv[1])
>   bursts = 0
>   fds = {}
>   while time.time() < deadline:
>       time.sleep(random.uniform(1.0, 8.0))
>       for _ in range(random.randint(4, 40)):
>           path, size = random.choice(files)
>           fd = fds.get(path)
>           if fd is None:
>               fd = fds[path] = os.open(path, os.O_RDONLY)
>           off = random.randrange(0, max(1, size - CHUNK)) & ~4095
>           os.pread(fd, CHUNK, off)
>       bursts += 1
>   print(f"bursts={bursts}")
> 
> (Drop page caches before each run — echo 3 >
> /proc/sys/vm/drop_caches — or cached reads will suppress the rate.)
> 
> Thanks,
> Rowan Cramer
