Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA733344A
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746355; cv=pass; b=cI7LrwCnSoO4SUdW/4SfH2RIUCcavbX7gYL9/gFjMjAjbBTRpBqrYrEPEDVC4YJ0p1GUEOPdt5mPYSvj8yJezF0Z4DUqcrsvymtF4rpFO5k9Ja9ZZWTnt9OdIk6onHCxx2NDWRPSFbRnijEESWEimSOb3tZRUXOXwtPGNDhdf08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746355; c=relaxed/simple;
	bh=6ydCv6sETnUSKoy8isE6EI83BO0xCFcTHCbF2qilBVY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nEGm/5nE5lX+hendZ5R3gYVQg4kFnDGDBAbGO65Wv/PUpaIaOtCDnhlcRx/bBw1mTTew/5gT28dpXkjsWJKD5Z1kFztdPDQgOaQIArFco8dB/CxWgTtgeb6wBRJzchpY4GYLAGPQWtKxNCMzTdEOsZxFx/6bbcnIbuzPoImDoVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw/Po5ux; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw/Po5ux"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso956769f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746352; cv=none;
        d=google.com; s=arc-20240605;
        b=L3RGR3X1qYhT0nMHn1mD49FTTGhYW8ShOT6mBelP1GMJodCu3LqodCdHc/TS/mnnMW
         n+3b/sUnKoPSCp+9Fo67I4D6jcLc3cJAazN+eyvRKm2FuD5XCDvIl84EdF5nZhJ/rQz7
         TwlIMYZYSjvwhB8hx0GnLo2LqVzZuj//N6OVJhsoTRt0pzBbmt6tCnk0/DUCFjvEEhAo
         OzW86S7bgz1F48RdP2uGq5TNQg2Kc4+UItQof1DDmdDX3EsVWrVcxAnOh4ibQy4HcLAU
         wgZ7YABp1x/Ycy93SG+eHyfnO7nZJe8pIiUp+nxqH2bAENlfDV/mImyN/svjW59pquNs
         JpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        fh=6XFRCu8PjF51yZj6wPxSy4w94tjdPN62AMmNAmG4LnM=;
        b=I2thaMtKZBSNyHdl8nB5XHY0wDgqKi0QnEeW+1yKBHH/rG07DJEEtP2dbOCLs+xUZo
         xll1t5xns2F7GXbrFuIB8ryxWi6t1IwRCHBB2bhD4216DIC4/9M8m8pZm2ylAwnndrjJ
         6C3o7gJiTJ51avIAxzLrHE+ajAFSOXCttQJV/yuyBNt2tMAHebWqUx22ANAzwCt8GXGZ
         8tPvNi1HgrK/wzmLvemgbwKsPG6BykeUwZqT7bwlsBtcBwl3Q4aJfIpoyfVI5HzgFwsq
         MDoBJKe9C21X7kY8rK6/isxvY1UpZa2SAOtfDdfS+W2//GYeg7B7UEAwafzLt1m8fUqg
         oUvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746352; x=1776351152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        b=pw/Po5uxlu3Q4YOFvgnODbqCGOH9UZFHxtB5UScSpvHNzSj7Ynxyg8HTsgnBcK6d8p
         BBMzP6al3JTTj9+VgYXr7cxDzpPHqihY74gdiYRiBWUdicPQyPYMXylTUVPUbkDajl4Y
         56nRm63hkxKKEY+BRoh8dnp5IVDYpTgF+FqV2O/bhbVR0QaDs9fSbhOY2Z7D1O8waRlf
         X3/pmqMCE/2vw4i2dDGakLp/0+dROTMH90cmTweE/ZpgWANHOIjRz/BPsNFOGntoyfml
         ltajC4Z1dt1txYdERFPYP0xI4CKaqCCW0ZcNqK+EWIECQN/je8TzSNy4p6TpFx0otWXf
         QHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746352; x=1776351152;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNZu/WXUPhNb82Jv7JYsBguVQyhls8pb4s+wSnq+HH0=;
        b=rKI4Lz2W58gR0otCDVqMUnhLicVRTLDeZMK/y0wpLHPjpZkZO/trxf90xHLB3fm3ac
         SG5F4x69YOyio3d1b4DSd87wA6l9LWcOcSAkqUBbHq6dIF0VZvEOzuBvkeHVcb72Bu5V
         nJWUv0eo7OVuDd1PH+XXFgQQUlQOwZylu6RqwREn6DG06faG7ACu/Pxk4wKCMenVjQzE
         7BD5iWjwFc+dNwmyo9iBcHd5e8ivaFpYHHpahzUvvnP2RmAiCFv12rSfzUnMiov6nSwl
         ZpTPES2iPzxFv5mSG3F5MnrAcg5GPDxg8r24x6w9ub59lmx5RMZrl7bxAcDuTMnVUdyN
         SavQ==
X-Gm-Message-State: AOJu0Ywhf81reH/NeUv9j2ufCH+Haj9+ywP3OL0yg25XRi4YItr9bs9d
	9MZCn7Nw4qUfjNxHAACUcEjrlWvnRJl3gTB2xiyAVtqSFh1JGPub4OtAP5rwU5TkViOtwO0Budz
	2UYPU05YU5KvODUX6HP52ceHFl7ivj9Ld49unhtI=
X-Gm-Gg: AeBDiet3KDhT6LVHMNV28Y+G792/a1x4fcv5h1ljRiuxGrcrWpAuhtgVk9fe/vDdKiB
	0KBPzi9Qptel6DZOcEay6bFwfLKSp2ZnO8du4RF+KF99dK1uzasc1c8+UDMYPICsUJETNVTYcSi
	2ImuSzU60ZnsFCmieBYN3yVAPibdsK3mDc1RqVkEwQKBcXXE2A7FkHCA119BL87z4aZ6YEn7Sv+
	BpHJWhGkt+c53/03Wdf6tPuhHIfJ1gX5pVed4lUw+/oelT4VMl9W1lLaEPbwDzSjxkD+pm7NXN/
	aXmY2EBrzGYZgx/MQr56KhNXVGaEloNSUZI073Hzm4zcZnPOXJxtP2ZFAgC1PE9w0UxA+6ZltXM
	gwqZNcQw=
X-Received: by 2002:a05:6000:2886:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43d5a17d094mr5680009f8f.41.1775746351772; Thu, 09 Apr 2026
 07:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jacopo Labardi <jacopolabardi@gmail.com>
Date: Thu, 9 Apr 2026 16:52:20 +0200
X-Gm-Features: AQROBzDpPEvaNlnVmlmhfvPxhs83kPXCAWpTOryoryMklVGb7FgCNhTSL7jhSmA
Message-ID: <CANrGBMBDftu58R71jvEcZ94D8vJB2Y_dHG=BbNSsNMOS=3k0+g@mail.gmail.com>
Subject: [BUG] Lenovo 83JL / WD SN7100S: intermittent loss of secondary NVMe
 after s2idle resume, root port 00:02.1 retraining fails
To: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting an intermittent suspend/resume failure on a Lenovo IdeaPad Pro 5
14AKP10 (machine type 83JL) where the secondary NVMe drive can become unusable
after s2idle resume on Linux.

I am CCing linux-nvme, linux-pci and linux-pm because the visible failure path
starts with PCIe root-port link retraining on 0000:00:02.1 during resume and
ends with nvme reset failure on the downstream device at 0000:bf:00.0.

Summary
- The problem is intermittent. It does not always happen on a fixed cycle.
- On this machine it may happen on the first resume or only after several
  suspend/resume cycles.
- The clean reproducer below failed on the third suspend/resume cycle, but that
  cycle count is not stable and should not be interpreted as deterministic.
- When it fails, the secondary/data NVMe is effectively lost until a full
  reboot.
- The system NVMe on 0000:c2:00.0 survives.

Hardware
- Laptop: Lenovo IdeaPad Pro 5 14AKP10 (83JL)
- BIOS: LENOVO QKCN29WW, release date 2025-12-23
- Platform: AMD Krackan / Ryzen AI 350
- Root port for failing device: 0000:00:02.1, AMD [1022:1126]
- System NVMe: Lexar NM790 2TB at 0000:c2:00.0
- Secondary/data NVMe: Sandisk/WD PC SN7100S M.2 2242 NVMe SSD (DRAM-less)
  [15b7:5044] at 0000:bf:00.0
- PCIe topology:
  0000:00:02.1 -> 0000:bf:00.0

Software
- Kernel for the clean reproducer: 6.19.11-arch1-1
- Kernel taint during reproducer: 0
- Sleep mode exposed by the platform on Linux: [s2idle]
- acpi_call-dkms is installed on disk, but the acpi_call module was not loaded
  during the reproducer and the kernel was not tainted
- Boot command line used for the clean reproducer:
  quiet nowatchdog rw rootflags=subvol=/@ rootfstype=btrfs
  root=UUID=<redacted> amd_pstate=active iommu=pt i8042.nopnp loglevel=3
  8250.nr_uarts=0 tpm_tis.interrupts=0 random.trust_cpu=on
  snd_hda_intel.power_save=10 snd_hda_intel.power_save_controller=Y

At boot on this kernel, both NVMe controllers log:
- nvme 0000:c2:00.0: platform quirk: setting simple suspend
- nvme 0000:bf:00.0: platform quirk: setting simple suspend

Clean reproduction used for this report
- No NVMe-specific udev overrides were active
- No custom NVMe-related systemd sleep hooks or suspend services were active
- No NVMe-specific kernel parameters were active

Reproducer
1. Boot the machine into 6.19.11-arch1-1.
2. Confirm tainted=0 and that both NVMe devices are present.
3. Suspend to s2idle and resume.
4. Repeat suspend/resume until the failure occurs.

Observed behavior
- In one clean run used for this report:
  - first cycle resumed successfully
  - second cycle resumed successfully
  - third cycle resumed with the WD drive lost
- In prior testing on the same machine, the failure sometimes happened on the
  first cycle and sometimes only after several cycles.

Relevant kernel log excerpt from the failing run
  Apr 09 16:24:34 kernel: PM: suspend entry (s2idle)
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: broken device,
retraining non-functional downstream link at 2.5GT/s
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: retraining failed
  Apr 09 16:24:54 kernel: pcieport 0000:00:02.1: Data Link Layer Link
Active not set in 100 msec
  Apr 09 16:24:54 kernel: nvme nvme1: Disabling device after reset failure: -19
  Apr 09 16:24:54 kernel: PM: suspend exit
  Apr 09 16:25:04 kernel: ntfs3(nvme1n1p5): failed to read volume at
offset 0x10c000
  Apr 09 16:25:26 kernel: ntfs3: 107 callbacks suppressed
  Apr 09 16:25:40 kernel: nvme nvme1: Identify namespace failed (-5)

State after the failure
- nvme list shows only the system Lexar drive; the WD is no longer listed
- lspci -nnvv -s bf:00.0 still shows the device, but with:
  - !!! Unknown header type 7f
  - Kernel driver in use: nvme
- sysfs state at collection time:
  - /sys/bus/pci/devices/0000:bf:00.0/power_state = D3cold
  - /sys/bus/pci/devices/0000:bf:00.0/power/runtime_status = active
  - /sys/bus/pci/devices/0000:bf:00.0/d3cold_allowed = 1
  - /sys/bus/pci/devices/0000:bf:00.0/power/control = on
  - /sys/bus/pci/devices/0000:00:02.1/power_state = D0
  - /sys/bus/pci/devices/0000:00:02.1/power/runtime_status = active
  - /sys/bus/pci/devices/0000:00:02.1/d3cold_allowed = 1
  - /sys/bus/pci/devices/0000:00:02.1/power/control = auto
- smartctl -x /dev/nvme1 failed with "Resource temporarily unavailable"

Expected behavior
- The secondary WD NVMe should resume normally and remain usable after s2idle.

Previous mitigation/debug attempts on the same machine
These are not part of the clean reproducer above; they are prior experiments
done to narrow the failure mode.

- The issue also reproduced while the machine was configured with
  pcie_aspm.policy=performance; removing that option did not eliminate it
- nvme_core.default_ps_max_latency_us=2000
  - no fix; failure still reproduced
- Force power/control=on and d3cold_allowed=0 on both 0000:00:02.1 and
  0000:bf:00.0
  - no fix; in failing runs the WD could still end up inaccessible / in D3cold
- pm_async=off
  - same failure mode
- SuspendState=freeze via systemd sleep configuration
  - ineffective on this platform; kernel still reported s2idle behavior and the
    issue remained
- nvme.noacpi=1
  - removed the "platform quirk: setting simple suspend" message, but resume
    often degraded into a black screen / forced reboot instead of fixing the WD
- pcie_port_pm=off
  - no usable fix; often resulted in black-screen resume / forced reboot
- pcie_ports=compat
  - no usable fix; often resulted in black-screen resume / forced reboot
- User-space suspend/resume hooks that tried unbind/bind/remove/rescan around
  the WD path
  - no reliable recovery; they only lengthened resume and still ended in reset
    failure / missing device

Additional context
- Linux on this machine exposes only s2idle.
- The issue was reproduced on multiple Linux distributions, not only one
  userspace/kernel packaging combination.
- Windows on the same hardware resumes correctly.
- I do not currently have a known-good Linux kernel version on this machine, so
  I am not claiming this is a regression in a specific upstream release.

I am not sure whether the underlying bug belongs primarily in nvme/pci, PCIe
power-management, or a platform/firmware interaction. The first failing
messages in the clean repro are from the root-port retraining path, which is
why I am CCing PCI/PM in addition to NVMe.

I collected a local bundle containing:
- full kernel log from the reproducer boot
- systemd suspend log
- lspci -nnvv for 0000:00:02.1 and 0000:bf:00.0
- sysfs power-state snapshots
- dmidecode output

The raw bundle contains machine serial/UUID, so I am not attaching it publicly
as-is. I can provide redacted logs or specific files immediately if requested.

If useful, I can also test additional debug options or a current mainline/-rc
kernel.

Thanks.
