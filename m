Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165F4483BA
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033851; cv=pass; b=AbvU6Gdv4YoHvveuGUQgJWoX/NO43Ve8Fblx6juFs548JfpjO5p9yV8tIxBJV0C4prtwQyR+pf1YUBBcGKagwAfl342kt7ZXhKJ3idJvclXLOAex+as+HliUrvVSnKTcksJjUgKJG/53ZtCvYASSGgb3xjDdKhoBIpIfJ60X9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033851; c=relaxed/simple;
	bh=paq3CGgULgMVb7YetXuUAWmLKLQxlCFztC+eRmgK9+0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RTzn6qova8tkz5fd94Hz+IYeILZJaQD93076XjjziPW2tQpemyWUXIWs4DKPKHAv+c28ieteZEoqAeacB1gjxzrCAfZFMErULsM7IzjmTPZif6HC53MP4ESYjnDN4+8MxWj/GugbMWYdGK6XY4Cv+RML4oCoAFpsGNwRF1dyRPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi4Je1A6; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi4Je1A6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2626141a91.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 05:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784033849; cv=none;
        d=google.com; s=arc-20260327;
        b=sbvDtPAjtqSmXcHDBqAZPXovjaldr8u8Q5Z0wR39usDI+oUOtpM7FC02ChRpbRjiC1
         6pZzqGkNehSY1Lwv6EtN7jklLsyH9nStUCJQ/nH+/Pz0PfVbOa82nITd5S7+9o7CFgXN
         BN0swJtXT1Q5jwnG0BdgYnyFpUvF41EvkAy/1y9zVkf+7RR6mBuj0sYlLykfNAXMuv60
         6A+XfcSoK+bHfLGyNFMRtsfcVJ6vY8p/cRtCjqrXr1mLnbuD4NqefBf/YO+GGpvVJY/F
         j3FC5wvS62q5AdoH3PV6aBGarpbek6uk6xeXsLqH6pPnEVue3uqXC/LEcuKEOoD1p5qk
         4EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=AmIgJ3zXzmoQHp/Chr0+VyJhqwRqs2n4l50G9zrXZ0w=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=MP3BBgG177ClnVUJ6h4JMsOnfFNfC08cdS8ig7bk07vF3k+AxfwFVGXqD8FslHP/4g
         qCfh3LH7g3w9K7AfkxXfT+z2yHVH5svzlXGPBjr16xL6sBtN1mVZt55Pmy7TaCxCCcPR
         JDDKj7gLDoIbElyu50SxYK+xLadk5CiUUlui3Ic+YAkU14n0zPjyEftt7pCeZ9Bt2iVC
         6vT87sW55REQ4iOBkf5DvFv1bpZDEO3v1UFtZHtTKw5LFZjdZpd2r5LSz/O+/PIq0QBb
         zxGuo/DU2y8ojuOBW7Tes27YVfvDXTLo7LWjbZyuW86qeUGuF7iRpo7S0LqRHJRsNEM1
         4qgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784033849; x=1784638649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmIgJ3zXzmoQHp/Chr0+VyJhqwRqs2n4l50G9zrXZ0w=;
        b=fi4Je1A6qUlK/YZ4jLMYinrvRudIwKmZnT7Qo/fh6/TYZkekGxyV2UuXq/ud+RemvH
         ryrJkFpzh39SBthFue9Aq8Lvy2se0QHLLRr+sLibOo0vDE8OTMyE4m4jKlpK1zerXZ1Z
         +h8IK0r2clsCGKdco5OS/hVb2hAnRkd30kgF2I4Km6oSFlQsOHf6vMyCEfzXT4MQNN/v
         piWG9srbz70IWCy6txJ3t1MK7EZqtmhgSg5I4vZItkVNG3d8HbP9aQF77fU/Xr1x+Ru/
         cNyKq/oxTRtUvqpjkg1dpMkuCyhW7pw4RM2Bs+ugMyvvJtZNmOqBitt5RVM/BQbesE4A
         1eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033849; x=1784638649;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AmIgJ3zXzmoQHp/Chr0+VyJhqwRqs2n4l50G9zrXZ0w=;
        b=pmA6r/xtsb+pbK9Bl+PBlf9NK20y4dqQIT5t/s9edDx8NAVNQmAaqRbTdQBFHp5Mrn
         ePhbtcaWObzvFeSFBZqNXOAJuTtTRxivE1sj8Wpa7Q9KPnK5wLRjkWyBojn2F4HvMN6P
         5E1csN5AuJW6fZ47t7MUd6sausBWpQawYkcNIhyYTgm348bVLi7IrM8V8xeVjjwpqTq1
         zagcOl3ezKlADWDW0/2JNoKAnfWzMrvwrT6kpMqEEGdJepFxWTs3eLKhlmvSeEb4frMu
         xaiQ5TVkekupt+FTBw1IG5BYdP+4ikdJ1ZCMdmUWmzoZMY0T/Z37ewSM9bfBAqr+Inte
         0YsA==
X-Gm-Message-State: AOJu0Yzn01kJ4wItEJlCu2JnrhRTfsv5Y4fKY1brk757VNwSq4dtevGy
	v8B3uCygHP9y6/p17Sv+RW1X0EVg5S6QjTDq+PiSGmCbSRd/CS6eoSsZREmvTtSGsXZNjMx1tMC
	oDT0DvbBuoHV+xykXvmW0Nu/H4BNPikhxDkk5iKg=
X-Gm-Gg: AfdE7cn0ucSPkfByP5UptoBOYSAMU3U8Hixvecc2Rs3ICMDg4hJ4Uoo0TWtFpaJWyaN
	BD9wEYZFJmjC96LBtCD5g3qnGF3Z39ry3lPM2wNh49lTXs0vswTFftb0xjAsPkKnRTIa3V/bmdD
	lNTysh/uHDi+/ako8SE39EEKxYEA3CNl2FyNbss2s6h/pKpKYX/f4IrojXxRNmNsMKLiPxZ8wFP
	ceqKt+xkNAmyz+lrM5Tz4OVTSXbZKKlZnHgKPjt812O273Dyanx+NLheYGqjK64QfF5yGslHtV0
	vfiT8ALnzsnMKdPTAZmTxt/AM5hgOGZZKogWBe+FlQJd8m0EvwzAGLzy+JwBxEVpt/ka/WrkcBo
	tjCpD1Y0KKkwMmMfj8jBZRXZY
X-Received: by 2002:a17:90b:2dc1:b0:387:e0cb:7f0 with SMTP id
 98e67ed59e1d1-38e17ea3eb7mr3222458a91.36.1784033848643; Tue, 14 Jul 2026
 05:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rowan Cramer <rowan.cramer@gmail.com>
Date: Tue, 14 Jul 2026 08:57:17 -0400
X-Gm-Features: AUfX_myO5Pa4DwjUBdEa5lvq2lmvZSVtbnzNY6SRoMy3hJ-zPxES9TaQKVDF0RQ
Message-ID: <CAPew1NKKWf7rr6eZXp=KooN43CKaTbcc-U9ZkKrBhcXaARTKUQ@mail.gmail.com>
Subject: NVMe MSI-X completions lost behind VMD across package C-state exit
 (even PC2) on Arrow Lake client VMD [8086:7d0b]
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have what looks like a platform/VMD interrupt-delivery bug on a
new Arrow Lake laptop, isolated with a reliable reproducer and a
three-arm test matrix. Reporting here because the fault sits below
the NVMe driver, in the VMD interrupt path, and is invisible unless
the package is allowed to idle. Happy to test patches or run any
further diagnostics.

Summary
-------
NVMe MSI-X completion interrupts are intermittently lost when they
arrive through VMD's interrupt remapper while the CPU package is in
(or exiting) ANY idle state deeper than C1 =E2=80=94 including plain PC2.
The drive completes the I/O correctly (the kernel's timeout handler
always finds the completion already in the queue: "timeout,
completion polled"); only the interrupt vanishes. Holding PM-QoS
/dev/cpu_dma_latency at 100 us (C1-only idle) eliminates the fault
completely; nothing else does.

System
------
- Dell 14 Premium / XPS 14 (DA14250), BIOS 1.11.0 (latest; Dell
  ships VMD force-enabled, no BIOS toggle on this model)
- Intel Arrow Lake; VMD controller 8086:7d0b at 0000:00:0e.0
  (client SKU -> VMD_FEATS_CLIENT, so MSI remapping is always on;
  no VMD_FEAT_CAN_BYPASS_MSI_REMAP, no module parameter)
- NVMe: Micron 2650 1TB (DRAM-less/HMB), FW 26500101, at
  10000:e1:00.0; all queues route via VMD-PCI-MSIX per
  /proc/interrupts
- Fault is kernel-independent: reproduced identically on 6.18.33
  (LTS), 7.0.9 and 7.0.10 (Arch builds, clean cmdline)
- intel_idle in ACPI mode; exposed states POLL / C1_ACPI (1 us) /
  C2_ACPI (127 us) / C3_ACPI (1048 us)

Symptom
-------
  nvme nvme0: I/O tag N QID Q timeout, completion polled

Present since the machine's very first boot (3 events in the first
90 s of its life). Baseline ~125 events/day idle; 60-190/hr under
gaming I/O. Each event stalls the waiting I/O for io_timeout
seconds (we run nvme_core.io_timeout=3D10 as mitigation), which
manifests as multi-second system freezes. SMART is immaculate: 0
media errors, 0 controller error-log entries against >500 host-side
timeouts =E2=80=94 the device completes the I/O; the notification is lost.

Key evidence
------------
1. Load is NOT the trigger. ~4 TB of worst-case saturating stress
   (random reads at 2+ GiB/s, plus CPU, memory-bandwidth, GPU and
   fsync-write pressure, combined) produced ZERO events. Saturating
   I/O never lets the platform idle.

2. Idle->active transitions ARE the trigger. A trivial reproducer
   (bursty random reads separated by 1-8 s idle gaps, script below)
   produces 13-16 lost interrupts per 15 min, every run.

3. PM-QoS bisection puts the loss boundary exactly at C1|C2:
     /dev/cpu_dma_latency hold   idle allowed        events/15min
     none (stock)                C1+C2+C3            13-16
     200 us                      C1+C2               19
     100 us                      C1 only             0
     0 us                        none (poll)         0

4. Ruled out: drive APST (nvme set-feature 0x0c=3D0: no change), link
   ASPM (runtime-disabled via sysfs on the VMD-domain link: no
   change; note cmdline pcie_aspm=3Doff does not govern VMD-managed
   links, the vmd driver enables L1.1/L1.2 itself per
   VMD_FEAT_BIOS_PM_QUIRK), kernel version, drive health, firmware
   updates (none available).

5. turbostat correlation (5 s intervals alongside the reproducer):
   the package NEVER enters PC8/PC10 on this platform under bursty
   I/O =E2=80=94 deepest observed is PC6 =E2=80=94 and every lost interrupt=
 falls
   in intervals showing only PC2/PC3/PC6 residency:

     arm (900 s each)        Pkg%pc2/pc3/pc6/pc8/pc10   events
     stock                   13.2 / 0.3 / 4.8 / 0 / 0     13
     endpoint LTR clamped    19.8 /  0  /  0  / 0 / 0     14
       to 102.4 us
     cpu_dma_latency=3D100us    ~0  /  0  /  0  / 0 / 0      0

6. LTR is irrelevant. Firmware sets the endpoint LTR to 15.7 ms
   (0x100f100f =E2=80=94 nonzero, so vmd's BIOS PM quirk never touches it).
   Clamping it to 102.4 us via setpci was demonstrably honored by
   the platform (PC3/PC6 residency dropped to zero) yet the loss
   rate was unchanged (14 vs 13). The fault does not need deep
   package states =E2=80=94 losses occur with nothing deeper than PC2, with
   cores in C6/C7.

Current mitigation
------------------
A systemd unit holding /dev/cpu_dma_latency at 100 us. Fully
effective (a full day of gaming: 1 event vs the prior 60-190/hr),
but it costs ~2.5-4 W package power versus letting the machine
idle properly, since it must forbid core C6/C7 and PC2 everywhere.

Questions
---------
1. Is this a known Arrow Lake (or MTL-family) VMD erratum? The
   machine shipped this way; Windows presumably masks it via its
   own idle policy or is equally affected but silent.

2. The client feature set forces MSI remapping on 8086:7d0b. Is the
   VMCONFIG_MSI_REMAP bypass (as used for 28C0) architecturally
   possible on client VMD? I am happy to test a patch enabling
   bypass on 7d0b, or any other diagnostic/experimental patch =E2=80=94
   the reproducer gives a decisive answer in 15 minutes.

3. If the hardware genuinely cannot deliver remapped MSIs across
   package C-state exit, should vmd.c be constraining PM (PM-QoS /
   LTR / DMI-quirk) on affected platforms? As it stands, every
   affected laptop loses NVMe interrupts silently at its default
   idle settings.

Full journals since the machine's first boot, lspci -vvv, SMART
dumps, raw turbostat logs and the complete phase-by-phase test
history are preserved and available on request.

Reproducer
----------
Point ROOT at any directory with a few multi-hundred-MB files on
the VMD-attached NVMe, run for 900 s, and count kernel "completion
polled" events (nvme_core.io_timeout=3D10 makes them visible within
10 s):

  #!/usr/bin/env python3
  # bursty-I/O reproducer: idle gaps let the platform enter package
  # idle; the first read of each burst rides the wake-up.
  import os, sys, random, time

  ROOT =3D os.path.expanduser("~/BG3_Game")   # adjust
  CHUNK =3D 65536
  MIN_SIZE =3D 200 * 1024 * 1024

  files =3D []
  for dirpath, _, names in os.walk(ROOT, followlinks=3DTrue):
      for n in names:
          p =3D os.path.join(dirpath, n)
          try:
              s =3D os.path.getsize(p)
              if s >=3D MIN_SIZE:
                  files.append((p, s))
          except OSError:
              pass
  if not files:
      sys.exit("no large files under " + ROOT)

  deadline =3D time.time() + int(sys.argv[1])
  bursts =3D 0
  fds =3D {}
  while time.time() < deadline:
      time.sleep(random.uniform(1.0, 8.0))
      for _ in range(random.randint(4, 40)):
          path, size =3D random.choice(files)
          fd =3D fds.get(path)
          if fd is None:
              fd =3D fds[path] =3D os.open(path, os.O_RDONLY)
          off =3D random.randrange(0, max(1, size - CHUNK)) & ~4095
          os.pread(fd, CHUNK, off)
      bursts +=3D 1
  print(f"bursts=3D{bursts}")

(Drop page caches before each run =E2=80=94 echo 3 >
/proc/sys/vm/drop_caches =E2=80=94 or cached reads will suppress the rate.)

Thanks,
Rowan Cramer

On Tue, Jul 14, 2026 at 8:13=E2=80=AFAM <linux-pci+owner@vger.kernel.org> w=
rote:
>
> Greetings!
>
> This is the mlmmj program managing the <linux-pci@vger.kernel.org> mailin=
g
> list.
>
> Your message to <linux-pci@vger.kernel.org> was not delivered to the list
> because it contained a HTML part. Only text/plain messages are allowed on
> this list.
>
> Please configure your mail client to only send plain text mail.
>
> For your reference, the rejected message follows below.
>
>
>
> ---------- Forwarded message ----------
> From: Rowan Cramer <rowan.cramer@gmail.com>
> To: linux-pci@vger.kernel.org, nirmal.patel@linux.intel.com, jonathan.der=
rick@linux.dev, bhelgaas@google.com
> Cc:
> Bcc:
> Date: Tue, 14 Jul 2026 07:55:43 -0400
> Subject: NVMe MSI-X completions lost behind VMD across package C-state ex=
it (even PC2) on Arrow Lake client VMD [8086:7d0b]
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
> (or exiting) ANY idle state deeper than C1 =E2=80=94 including plain PC2.
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
> seconds (we run nvme_core.io_timeout=3D10 as mitigation), which
> manifests as multi-second system freezes. SMART is immaculate: 0
> media errors, 0 controller error-log entries against >500 host-side
> timeouts =E2=80=94 the device completes the I/O; the notification is lost=
.
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
> 4. Ruled out: drive APST (nvme set-feature 0x0c=3D0: no change), link
>    ASPM (runtime-disabled via sysfs on the VMD-domain link: no
>    change; note cmdline pcie_aspm=3Doff does not govern VMD-managed
>    links, the vmd driver enables L1.1/L1.2 itself per
>    VMD_FEAT_BIOS_PM_QUIRK), kernel version, drive health, firmware
>    updates (none available).
>
> 5. turbostat correlation (5 s intervals alongside the reproducer):
>    the package NEVER enters PC8/PC10 on this platform under bursty
>    I/O =E2=80=94 deepest observed is PC6 =E2=80=94 and every lost interru=
pt falls
>    in intervals showing only PC2/PC3/PC6 residency:
>
>      arm (900 s each)        Pkg%pc2/pc3/pc6/pc8/pc10   events
>      stock                   13.2 / 0.3 / 4.8 / 0 / 0     13
>      endpoint LTR clamped    19.8 /  0  /  0  / 0 / 0     14
>        to 102.4 us
>      cpu_dma_latency=3D100us    ~0  /  0  /  0  / 0 / 0      0
>
> 6. LTR is irrelevant. Firmware sets the endpoint LTR to 15.7 ms
>    (0x100f100f =E2=80=94 nonzero, so vmd's BIOS PM quirk never touches it=
).
>    Clamping it to 102.4 us via setpci was demonstrably honored by
>    the platform (PC3/PC6 residency dropped to zero) yet the loss
>    rate was unchanged (14 vs 13). The fault does not need deep
>    package states =E2=80=94 losses occur with nothing deeper than PC2, wi=
th
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
>    bypass on 7d0b, or any other diagnostic/experimental patch =E2=80=94
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
>
> Reproducer
> ----------
> Point ROOT at any directory with a few multi-hundred-MB files on
> the VMD-attached NVMe, run for 900 s, and count kernel "completion
> polled" events (nvme_core.io_timeout=3D10 makes them visible within
> 10 s):
>
>   #!/usr/bin/env python3
>   # bursty-I/O reproducer: idle gaps let the platform enter package
>   # idle; the first read of each burst rides the wake-up.
>   import os, sys, random, time
>
>   ROOT =3D os.path.expanduser("~/BG3_Game")   # adjust
>   CHUNK =3D 65536
>   MIN_SIZE =3D 200 * 1024 * 1024
>
>   files =3D []
>   for dirpath, _, names in os.walk(ROOT, followlinks=3DTrue):
>       for n in names:
>           p =3D os.path.join(dirpath, n)
>           try:
>               s =3D os.path.getsize(p)
>               if s >=3D MIN_SIZE:
>                   files.append((p, s))
>           except OSError:
>               pass
>   if not files:
>       sys.exit("no large files under " + ROOT)
>
>   deadline =3D time.time() + int(sys.argv[1])
>   bursts =3D 0
>   fds =3D {}
>   while time.time() < deadline:
>       time.sleep(random.uniform(1.0, 8.0))
>       for _ in range(random.randint(4, 40)):
>           path, size =3D random.choice(files)
>           fd =3D fds.get(path)
>           if fd is None:
>               fd =3D fds[path] =3D os.open(path, os.O_RDONLY)
>           off =3D random.randrange(0, max(1, size - CHUNK)) & ~4095
>           os.pread(fd, CHUNK, off)
>       bursts +=3D 1
>   print(f"bursts=3D{bursts}")
>
> (Drop page caches before each run =E2=80=94 echo 3 >
> /proc/sys/vm/drop_caches =E2=80=94 or cached reads will suppress the rate=
.)
>
> Thanks,
> Rowan Cramer
