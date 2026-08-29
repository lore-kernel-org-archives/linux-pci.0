Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EB3A1A3B
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992209; cv=pass; b=RYw0Eo7Dc6JrkCYBQ0M76n7NFAxgQndXb9247+7Q7Mwsf9XZ7L1dFjtrnU34igWDc7le6DrLbGwh24Dala5Q+z4M6Ny8QyVb3Us2B+ehnW9h5DWSsL4zgiKwKgdYLc4B4R3MZtPUjOS9PgxD91AyXEUvHqXmO5tCxfdCQ4TiKoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992209; c=relaxed/simple;
	bh=xi1lrbzB7mY07CelQmvsb8STnjNlaaz/aUE/jwlo7Bw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TTzkvO715wU70gPrquaxPn0PHSAIR/4KuZ6Zl6Hdfk2jjb3gP8rsAqS3CCQaCbY2q1mbAXE2B8LUVv+IqQ5DaISpdDrx5jr6WOItyEg5uQdTsUTbAX+SN4dnZKdyKyjEH+zCrOqyhI3uv9m1szr+Zh3ipIrVLAWytIo4Tw5ZhKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvisle.no; spf=pass smtp.mailfrom=kvisle.no; dkim=pass (2048-bit key) header.d=kvisle-no.20251104.gappssmtp.com header.i=@kvisle-no.20251104.gappssmtp.com header.b=ApEcNALH; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvisle.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvisle.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvisle-no.20251104.gappssmtp.com header.i=@kvisle-no.20251104.gappssmtp.com header.b="ApEcNALH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-85aeb506b78so25903007b3.3
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 01:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787992206; cv=none;
        d=google.com; s=arc-20260327;
        b=OUbNRPOcl+3LACSPgTW6Q0ETGFaWCCwUzlRqhU66AvuHffmS3rLQXD5jQK1kspjUQ5
         5OnF1KDBA/KsF2aj3TrezMw4r+UwfMTbM/E5y/ZRSjmXJUrOl+vbDbjTZkA3Eue0uP/w
         feFy63hi8HXO+pFwJ6YoOh6DPgT4FnctYENFLDosQmc5Czi0pLmHsCYKeAlYQ8fJQQLO
         +BYxWNRq7VzevoV1rI8/SaoIxvCthTHUB5HVwJTt4Wktxm7pCQ2dSVrblDcmBss0UX6L
         rMXEcPfl6rvIMScVC1PYASYJcaoDBaJJYjs1MEHCxvRFdWWC3B3ElGNfoISWPU6Mclc6
         Q3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xi1lrbzB7mY07CelQmvsb8STnjNlaaz/aUE/jwlo7Bw=;
        fh=nwyVtBQbwuqIbAwGdpPvPWoxhMHCQnT7WhtLLZJF/vs=;
        b=g5HNKkJM1osgPrMbWQpcozrhlDN9Z8iAbWARxU7GzFhgx3PQKCEchmYsBolRCk3Oe1
         CymGIG5fBJO1i1wW0UPm0HyimlR087qh5wCNMBLitpNbyVKN7uF7/+1c3L9kV24xjtHX
         gLnXqLZd12z2+rL8PGzhEtSIb2X4JFiBp24s5EO3MDcXdrDiPa2YHCeHWhU8ZN1WYr4s
         71nvR9412PvaK0yhjottngHdAVjFf/HMkBpp6ygOuU8eD9gSkETILQ6zC1SEYcgrW7H5
         Q4ZI+0joeAoocK7/w+6iQG5Yz5I/eFQY//ADufgtAOlfBie0erHCPpQm8O09mO8UA+It
         enbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvisle-no.20251104.gappssmtp.com; s=20251104; t=1787992206; x=1788597006; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xi1lrbzB7mY07CelQmvsb8STnjNlaaz/aUE/jwlo7Bw=;
        b=ApEcNALHH17J3xBGHs5FJ9tC7GYyxrDAd6hSImtidWhyGrk9Af1Efxl+FNZ4F9FeMc
         E0G7zxg1MnG9POQefQp7QsinrWKPRPne7oVCdofV6jH4fqsPKRHYxW/7aITCBzuUSL8k
         9DpY45MPhsXyEMIZK2JlQTHGglYT8mGw8ug2obdZ652dL/96ozKi/hN621feX2LcboBL
         yPPTctITknDMOviVxMRTx63hOwQUcQjec0O3Zr6CgCwVZS7vIKb7SdNcTb9Hy20bg0pm
         pNb/2lmqiXFSe9/ldV/qs74WTKghuQMCIwWjtSb2IBPpSlBDKafuhAuZgkuRDIn3+Npf
         aPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787992206; x=1788597006;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xi1lrbzB7mY07CelQmvsb8STnjNlaaz/aUE/jwlo7Bw=;
        b=KZ8CCIfH62RdxSdqzeUoODrXciqXBZZhPZk5EeadtgK/lIeGkzlv9okrD11J2xqxiB
         Oh6zVZFJedzu3F/7DwYnel9TY6rV59U/0lBbBPdZLhm+rN8QlcikzTej5uaJSQWK+L92
         NRPxv16kMLGKQAnwy/J2DgFnlcZw/xhdUdjQyxD06MHZMMD6eIXBU7MOpE3mOnO5Xqu4
         9gcaxNZaJ6uLqx6T1HuGG2rtpwHC675c1GE8Ptqz+03FgN0U2CJGKlm3yPVGbEDQk3EG
         XqoHF/emN2/JOVIDhIC8balxRte14bh8KUMERF/9zN1XZMnD9UgHJbFAENpvTDTJrAye
         RLrA==
X-Gm-Message-State: AFuF++mcimPpgpegKNveVoixeUnEppxDGihiblsORDGmkJFjoJ8IULs1
	ykquXgMhinqxeOKoz+3i+Y3GifaXUeB7CrVHN0qUxWyl02B314XwyWUQ+F2HIA1ZQ6qvVHxXfJ0
	Z1cKQLL+qw9d+Y8HKvPLodMcCWuL6D4YA1M4sLTrpAfA6ug2WWXF2FfHCOg==
X-Gm-Gg: AYBFou0gjkZzmzGQFuWi0DnFgIorBiriEjh+YNoXAiFZsLa7+Tca+nkYBz4xoJoF1/D
	uq4MGR013W9i+D9TRVoK6HtvcjKlJJoI8s2P+CCb+II1FIuoj+ZWg0g54MN5jPiL6r97O35PNDy
	2uAKtmz/UO/aPEVjwU/xxGC1LTnZyytNPNpLtP3Oj77iTsObiPo4dNJ/HgWTNeGYBIXI7xggu8Z
	af2uBfoVpWJOhKVNJxJOzLbEHZYlN/NAvE/LwZnuc+VJFBlVRMZH+qV9feeLYXNcvfoolAnprNw
	10mZga08BDlvi4rWNgPZpnIWye54U8jmFCCpioJ7AL9nkAPrS0Z69Gi1jLtDwhHLGC+w6NQCDHf
	VmLuD8mo+qJmIXt8NNgX7Nss/h5/OgtyAwN0=
X-Received: by 2002:a53:d60e:0:b0:66e:5649:dadf with SMTP id
 956f58d0204a3-66e5649f34cmr1250166d50.25.1787992206006; Sat, 29 Aug 2026
 01:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lars-Andreas Kvisle <lars@kvisle.no>
Date: Sat, 29 Aug 2026 10:29:54 +0200
X-Gm-Features: AcwNN1VBcYGNZEJfZriNfT-E8xd4-tM3M8IxPvLRDxd33WpHd0J6QyoyCnbGjyk
Message-ID: <CAH12Smk8jRCNtkWb+-6JJUegcYrH73X_Hv3KgnoWyARUMLmEgA@mail.gmail.com>
Subject: VMD interrupt timing erratum also affects Arrow Lake (8086:7d0b), not
 just MTL
To: linux-pci@vger.kernel.org
Cc: nirmal.patel@linux.intel.com, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to report that the VMD interrupt-timing erratum discussed
here in September 2024:

https://lkml.iu.edu/2409.0/02004.html (PCI: vmd: Delay interrupt
handling on MTL VMD controller, Kai-Heng Feng, referencing erratum
MTL016 and bugzilla.kernel.org/show_bug.cgi?id=217871)

also reproduces on Arrow Lake, not only Meteor Lake. My VMD controller
PCI ID is 8086:7d0b. I've also posted this as a comment on the
bugzilla case above with attached logs.

System: Acer Swift SFG14-74, Intel Core Ultra 7 255H (Arrow Lake-H)
Kernel: 7.0.0-30-generic (Ubuntu 26.04 LTS)
NVMe drive: Micron_2500_MTFDKBA1T0QGN, firmware V8MA000

dmesg (representative sample, full log attached to the bugzilla case):
[Sat Aug 22 14:43:26 2026] nvme nvme0: I/O tag 257 (1101) QID 2
timeout, completion polled
[Sat Aug 22 14:43:28 2026] nvme nvme0: I/O tag 290 (1122) QID 5
timeout, completion polled
[Sat Aug 22 14:43:33 2026] nvme nvme0: I/O tag 301 (612d) QID 2
timeout, completion polled
[Sat Aug 22 14:43:33 2026] nvme nvme0: I/O tag 312 (8138) QID 5
timeout, completion polled

This is the exact "completion polled" signature described in the
MTL016 erratum discussion -- the driver's timeout watchdog fires,
polls the completion queue directly, and finds the command had
actually completed. The drive itself is healthy: smart-log shows
critical_warning: 0, media_errors: 0, and the error-log's 64 entries
are all "Successful Completion" -- this rules out a media or
controller-firmware fault on the NVMe side.

This is disrupting ordinary desktop use, not only heavy-I/O workloads.
Occurrences do cluster during boot and during sustained heavy I/O
(video editing with many concurrent streams), but I also regularly see
unexplained multi-second to tens-of-seconds freezes during completely
ordinary usage -- Chrome, Nautilus -- with no obvious I/O-heavy
activity running at the time.

lspci for the VMD controller: 0000:00:0e.0 RAID bus controller [0104]:
Intel Corporation Volume Management Device NVMe RAID Controller Intel
Corporation [8086:7d0b]

I've already ruled out APST/ASPM power-state transitions as the sole
cause (nvme_core.default_ps_max_latency_us=0 and pcie_aspm=off are
both active, confirmed via /proc/cmdline and
/sys/module/nvme_core/parameters/, with no change in occurrence
frequency). Setting nvme_core.io_timeout=1 masks the user-visible
symptom (shortens a 30s desktop freeze to a sub-second hiccup) but
doesn't address the root cause, and under sustained load the
accumulation of many short stalls still produces a noticeably stuttery
experience.

Since the proposed VMD_FEAT_INTERRUPT_QUIRK fix from the September
2024 thread appears to be gated per PCI device ID and, as far as I can
tell from the current mainline vmd.c, was never extended to 8086:7d0b,
I wanted to flag that Arrow Lake's VMD silicon appears to share this
erratum. I'm happy to test a patched kernel build and report back -- I
can reproduce the issue reliably within minutes under sustained I/O
load, which should make verification straightforward.

Let me know if there's additional diagnostic data that would help
(full dmesg, nvme error-log, ACPI tables, etc).

Thanks,
Lars
