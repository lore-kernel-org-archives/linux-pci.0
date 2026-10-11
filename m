Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C4330B0E
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687805; cv=pass; b=kDX6l7s+he0kTTsMf4z9PI8/6ggowhjnNwiI9AfzI2T2/RL4dFjUeL65duKbDn/yeQEYaTAjHRt5wk8Cj5UnPp+F7/k/V5+QKa2nyyaH0OJIHbFu4/RL0O4W1jEtGVLvr8m94FVhGEL1m9//fVR0SUtRl8K82o1PLLjsrbvFRVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687805; c=relaxed/simple;
	bh=tkJxjp/aETroslxkSbLTCLP839mcAF+d4+l9kQmsdAg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PUYwRkYYo1FJmai37N3U/1JN9Nf/DFfF8xhBTD4YsI7jMkx0mkh2sc5Kf9yshIjMZ8spi+iLce/mpYhoqKlwSal9Krqn/aUroVH9QWO8CvMahb1322A+Jh8xryovUpA1D6xUtlad1Qy4K2Birl6BARJW6bGibPbun6TvdbUFTag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsAnXkNL; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsAnXkNL"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-824c6f137a0so229480a34.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 20:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791687802; cv=none;
        d=google.com; s=arc-20260327;
        b=LgKmeehA1CB8ISalUh+lLYDdz5NY+XClEkY9/VKn4FTOeySslZ331a7JZr8OenKQDQ
         21A7j+yuViiNy5sOh0Rsmr7HfV28bIj195kV/aeAjSNfbFN3ajmV6vbNctGzmzuYuUwj
         6Z0CFp99o7nwgGJoapzvAxM00WPHOrRfiRierhTGTUVJUwhCxcVZT8xYvwGlPl0uHhue
         3TVgWUl6i/x5XXVyD8vuN9ztOuAg4LZ+Q6me+2aklFaVXyQ32E6TChYcXsmBfCilKsfR
         muAlpBI6NKAp77yhT4Rbd1DFysFgtW+8bvEXgFXo0Zpe4VI5Z2GMWAFkaJf+tdy1O5P3
         GXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iasRde1qQJUJtGeod2YBry28Z253ABJFnpi0UR1WX/8=;
        fh=nvwg+4DtZCn98ozgy6bv9TewzWuqa+Fa2OzagB6HI2w=;
        b=B/0j1J8Nj1UPJEiKMDSHGdzLqV/l9VaJxQ3JCIS1nReu+g5lXCxMr+78awmldYX72z
         49gBYwKmzz2/eTQyx3R8E6F1O/uC9Dtsi4Ff6rCKNiKbDJrW0qBssH9f1OznQo8EDqVJ
         xShGEA7CZvhliE6xDDcLOb6BjjkUZe/dGYKFo5SLqRLsDp3MbFvQi8t5B6aeeyku0S7b
         ybixC4grDj8Sc5905eVVjvQdiDW0bVd4M+r0QmehVgwxSOjJeTXRZIor1HQb9aqNwi0h
         lmKga0zUkqDsQwRKopU0Vf+bim47UBamsEEvSnYAfO7KWiemHeTJBhfLcBo2d7UuOGhk
         DhmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791687802; x=1792292602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iasRde1qQJUJtGeod2YBry28Z253ABJFnpi0UR1WX/8=;
        b=RsAnXkNLqO8JuuFFOhnCAJqIzPgYpgBqFCmunNHanYuzP/6nQ8H+MzqKWj6H5ev+gJ
         ejxo8gpKqlkdRQ+RwUjtUMoH4qqK6ndBiiL86XiUNy8Krs1Xr6wU8jq+YjYmNm3qWf3S
         DMnJI+MPIqxmmZIvZzCCIGQ32sDBZCqalD2cx01Eeos7xWIAKuVgkMJNHq0frLtvK3PO
         ChIQ9+TvUL2uvPGaww73ZeuWA7O49PcA2+0YypLyxamgfjkxS/a8wsAkNV8ooZFXDwnD
         sr8C8RGEfYTPDeaiwQJnt1349Ol6GuZ8iKccaszEWfuqukxhGQvgO+O4lCODK/nLpsAk
         xd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791687802; x=1792292602;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iasRde1qQJUJtGeod2YBry28Z253ABJFnpi0UR1WX/8=;
        b=jbTnfhaxG9+WoT+dPXBYDCpVCMhOseeCCOVOX27O24doapibz1PHwIr7JPytcyEB4w
         6n+yOv5BsULT7XZwxu0++6mOmsUvqhvuUQ04bkjwYzETQmuIsB79HfWOU8K6b1mwAm96
         94Ft7kEQDBw+5un4uopeUx8Qd+V+c0PCJcU0o3zXck1gCL0QqCTlbxapOLWva8kgPNQI
         GlLLsRvpiwm/VMJ62u6EWJFgNZ5rF39cvxFDQuLUnHLDy4NKRoMGsEtWIB7CA9ieJ0ui
         MhS8CM1NAAJ99TvmgETvYWMI1S37XSo/pyIcxS9xC94n7DiXK+4l7p578ot58kAngRUy
         Gmiw==
X-Gm-Message-State: AFq9FYKbaQ24MQ6aida6RINS9bKF540ReOgGsi7vRNz35+2b5gSGnJbH
	Sg3gf2YiefFrYCu72BPdhuqEfuoVlnSC3LlqNvTrGVtomoerKI51Yj1kc69nI95KT6Y1DnYqsAw
	tUkMl8pv5w55i7wYR1NI269WgqlQF17Q3mWveJoM=
X-Gm-Gg: AYBFou3+OR7EwHuPVViybsRHoAY5mSp4rao0cDrWsRHL7ydpfcF6fQffjZew6qyrrhT
	zmyU4NYx+GRB87k72PH/dyGbPOPNOLywyYNy8PcTfblqCbcJygKU1hX3ZB715w6MfDTgNB+XWPe
	39aHRlePUeXrqckIE1oqKexFQEoeA0qV71bi45fkTfNQEPh8GCff91E5L+F8gM+SraO/pSciatM
	h6Tm95jp2loQfSCcGcbMOnf38DZTmGnhhh6wdcART/HaNOc2sx86PLRvIC6CFkB3SzNHkuP1RRt
	QFwO6Zzsg4LI4JeOkPUvNNk5Vt4f9sPGhNpCYIA3eec7puirOKOzsqPTL/BDOALTsRhBdxd+Pjc
	pzmAtstPA2Q==
X-Received: by 2002:a05:6808:19a0:b0:4c6:9ff2:60fa with SMTP id
 5614622812f47-50c55b85f28mr8316441b6e.4.1791687802255; Sat, 10 Oct 2026
 20:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Krittikun Wongnin <krittikunwongnin@gmail.com>
Date: Sun, 11 Oct 2026 10:03:11 +0700
X-Gm-Features: AclHuK__Ka175ULfZMcXXIAeiT13R30GPMagJgK2Q_s8AnWqkxww5BQtMg9uHQQ
Message-ID: <CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com>
Subject: [RESEND] PCI: NVIDIA GeForce MX230 (10de:1d11) falls off the bus
 right after "Enabling HDA controller" quirk on Acer Aspire A515-53G
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"

Hello again..,

On an Acer Aspire A515-53G (Intel Whiskey Lake + NVIDIA GeForce MX230,
Optimus), the discrete GPU becomes inaccessible within ~15 ms of being
enumerated at boot, immediately after quirk_nvidia_hda() logs
"Enabling HDA controller". From then on, config space reads return all
ones and no driver can use the device. The same GPU works under Windows
10 on the same machine, and under an older kernel (4.15) that predates
the NVIDIA HDA quirk.

The MX230 (GP108M, class 0x0302 3D controller) has no display outputs
in this laptop design, so its audio function should not be needed. I
suspect that setting bit 25 of config register
0x488 on this device/board breaks the link.


Hardware
--------
  System:   Acer Aspire A515-53G (board "Pikachu_WL")
  BIOS:     Insyde Corp. V1.08, 10/17/2019 (latest available from Acer)
  iGPU:     00:02.0 Intel UHD Graphics 620 [8086:3ea0]
  Root port:00:1c.4 Intel Cannon Point-LP PCIe Root Port #5 [8086:9dbc]
            (ACPI \_SB.PCI0.RP05)
  dGPU:     02:00.0 NVIDIA GP108M [GeForce MX230] [10de:1d11] (rev a1)
            class 0x0302, ACPI \_SB.PCI0.RP05.PXSX


Kernels tested
--------------
  7.1.13-2-MANJARO  (Manjaro linux71)   - GPU falls off the bus
  6.12.108-1-MANJARO (Manjaro linux612) - GPU falls off the bus
  4.15.0 (Ubuntu 18.04.1 live USB)      - GPU works (see below)
  Windows 10                            - GPU works, no errors in
                                          Device Manager


Failing boot (7.1.13, relevant lines)
-------------------------------------
[    6.110437] pci 0000:02:00.0: [10de:1d11] type 00 class 0x030200
PCIe Endpoint
[    6.110695] pci 0000:02:00.0: BAR 0 [mem 0xa3000000-0xa3ffffff]
[    6.110932] pci 0000:02:00.0: BAR 1 [mem 0x90000000-0x9fffffff 64bit pref]
[    6.111178] pci 0000:02:00.0: BAR 3 [mem 0xa0000000-0xa1ffffff 64bit pref]
[    6.111411] pci 0000:02:00.0: BAR 5 [io  0x4000-0x407f]
[    6.111650] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    6.111903] pci 0000:02:00.0: Enabling HDA controller
[    6.119454] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]:
can't claim; no compatible bridge window
[    6.121240] pci 0000:02:00.0: ROM [mem size 0x00080000 pref]: can't
assign; no space
[    6.121367] pci 0000:02:00.0: ROM [mem size 0x00080000 pref]:
failed to assign
[    6.125725] pci 0000:02:00.0: CLS mismatch (64 != 1020), using 64 bytes
[    6.881073] nvidia 0000:02:00.0: Unable to change power state from
D3cold to D0, device inaccessible
[    6.881299] NVRM: The NVIDIA GPU 0000:02:00.0
               NVRM: (PCI ID: 10de:1d11) installed in this system has
               NVRM: fallen off the bus and is not responding to commands.
[    6.881320] nvidia 0000:02:00.0: probe with driver nvidia failed
with error -1

The "CLS mismatch (64 != 1020)" line shows that by ~6.125 s the
device's Cache Line Size register already reads back as 0xff, i.e. the
device stopped responding between enumeration (6.110 s, IDs read fine)
and the final fixups. The only operation on the device logged in that
window is the HDA quirk.

Afterwards, lspci shows:

  02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX230] (rev a1)
          Subsystem: Acer Incorporated [ALI] Device 130f
          !!! Unknown header type 7f

The "D3cold" in the nvidia message is presumably just the
all-ones PMCSR read being interpreted as D3cold.

The behavior is identical on 6.12.108.


Working boot (Ubuntu 18.04.1 live, kernel 4.15.0)
-------------------------------------------------
No "Enabling HDA controller" line is printed. lspci shows a normal
config space:

  02:00.0 3D controller: NVIDIA Corporation Device 1d11 (rev a1)
          Subsystem: Acer Incorporated [ALI] Device 130f
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

and nouveau initializes the device:

  pci 0000:02:00.0: optimus capabilities: enabled, status dynamic
power, hda bios codec supported
  nouveau: detected PR support, will not use DSM
  nouveau 0000:02:00.0: enabling device (0106 -> 0107)
  nouveau 0000:02:00.0: NVIDIA GP108 (138000a1)
  nouveau 0000:02:00.0: bios: version 86.08.2d.00.8b
  nouveau 0000:02:00.0: fb: 2048 MiB GDDR5

(nouveau later logs PMU reset timeouts, which I believe are the known
GP108 nouveau limitation on 4.15 and unrelated; the device also
survived a runtime suspend/resume cycle at ~127 s.)


Things already ruled out on the failing kernels
-----------------------------------------------
- pcie_port_pm=off: no change.
- pcie_aspm=off: no change. The FADT already declares ASPM unsupported
  ("ACPI FADT declares the system doesn't support PCIe ASPM"), so the
  kernel does not touch ASPM anyway.
- acpi_osi=! acpi_osi="Windows 2015": no change.
- Keeping the GPU and root port out of runtime PM / D3cold via udev
  (d3cold_allowed=0, power/control=on) and disabling
  NVreg_DynamicPowerManagement: no change (the device is already dead
  before userspace starts).
- Removing 02:00.0 via sysfs and rescanning: the device is not found
  again at all.
- Full power-off and EC reset: no change.
- Windows Fast Startup is disabled.


Possibly related firmware errors
--------------------------------
The firmware defines the root port's power methods twice:

  ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.RP05._PR0], AE_ALREADY_EXISTS
  ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.RP05._PR2], AE_ALREADY_EXISTS
  ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.RP05._PR3], AE_ALREADY_EXISTS
  ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.RP05._S0W], AE_ALREADY_EXISTS

I mention these for completeness; they appear on the failing kernels,
but the timing above points to the HDA quirk rather than ACPI power
management.


Open questions / what I have not done yet
-----------------------------------------
- I have not yet built a kernel with quirk_nvidia_hda() disabled to
  prove the quirk is the trigger. I plan to do this and will report
  the result. The 4.15 test differs from 7.1 in many ways besides the
  quirk.
- The failing kernels are Manjaro distribution kernels, not vanilla
  mainline. I can test a vanilla kernel if needed.

If the quirk is the cause, would a DMI- or subsystem-ID-based exclusion
(Acer 1025:130f), or skipping the quirk for class 0x0302 devices that
report no HDA codec, be acceptable? I am happy to test patches and
provide full dmesg, lspci -vvv (as root), and acpidump output.

Thanks,
Krittikun Wongnin
