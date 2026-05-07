Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396833ADA0
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188465; cv=pass; b=obhKhgmWWRPzCP0NVxlIS/N3g47IQf7cXFx3i1kbLTSGFW1AaqUIJplNzR2OSWp73v0ZS91xn7QzevCuocQHb/xFNs6TaxsK21HCgH34bilET5JXeYV34r/v1SjCM71Cq9+fyNNUIEb9tFgFFqF88BL55A+xwOl7iVHMAFSPDYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188465; c=relaxed/simple;
	bh=+YT4zG9Eq3z4e9aA8IbJriU3ll2d+fnaRm2exvHrWzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nzVQisP3B0iRuTZM2yyW4/lVx06ghQx9cWf835dr1Nn5fxHTHpOTMxNxKv1gjLx51LQAgrZYXQhRYisL7zxY3b/76ETGWPO7ak5QKtezFwtHPGro+sVKw1vGqtBlEY4/q+T2zGT5ZeMtCu/iAY/C2vPVvCbmAIAgpR1LBbq381Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsYLJJd; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsYLJJd"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a860667fabso1252418e87.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 14:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188462; cv=none;
        d=google.com; s=arc-20240605;
        b=dohRdX66d+N6OKnW2k7ZKZ8DgDeZzB/rJMa+vINkl4tRp5Ng/kZRK5nLOAtvHZ61aq
         qcpDVw/DZCk5LEkTW/OU2gqAXgvRK+WYa8Xrd2gRsZSEPuZwIdKpSlTJAMS2yWSElO+4
         OP+JrSRtErxBciG9TtWQBnJfySoCmLkEoQwtNcN2dEGTcf4M7HgxrjU361zCTYzEXvqk
         3indOogsG1FdhdWewEWpSZUNSgjVJ2H+ukhvEwz2B1vdPD5+o8H5sW2HPKdZjvz0lJd3
         68iTiq+iIUp8Mw8zl/rDVeITTYFZx+rV7cq7XIKcS5ukbFc+ZuFAOtR58+SyKTiNuXJX
         K3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SIpR6LDM/E1ueXEWH4hacGpfKGlse0m5K1fGkt/y3Ec=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=RvDC+eLXqwQIe3m9VQ9dDYUBenOOFbCCJWUebTHOgrhR/hNMumcw9lEArHX8JP9/Tg
         pea3KgX3psBeXArI9Z6g+jVR5LmebBFxCY+8TciAMTb9BAXIpDOLzLddkRuO3M6fyNkq
         R/GTU4kLQ5X24encq+77zqU5Rv9uP8/kVjf1cKaoHAZzIt/LsBPXyP68ubAL4wxK2Bol
         ukaTLL5Trwa8GoQSvckjZGjy+X3RlSUcQzYIdmJkCFi+bXIVC2QMeCyN4hKzM1gWYDHv
         AZZRbI7IbVcQtL6Nca4CxvO9v8wp4T9j7PE5BfFCKHosvbjO76b7ah11iatqeonPmc3O
         o7Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778188462; x=1778793262; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SIpR6LDM/E1ueXEWH4hacGpfKGlse0m5K1fGkt/y3Ec=;
        b=iIsYLJJdMgqsWc4duN5zj30ejSf+sIk0riAPbG48dp0dxkYb/76QE4agzjy5PR3e76
         joAsQdEQAtGr86ETM26OWAaNdnohGuWMlk4lY7ldNfIlDNFkUNZhmHUVvXn9e9+wIdVJ
         CfsPubqF7RhYAIAvJgnVvvcC/mmuW4UzQXCcjMDQuo7iZg3Vhh+KTU7b3+9cKTLEC8Eb
         b5dZoRp9aIbsyNeek56L5jPGnSccSkZixGhZ7sa71xRKkLLVeleOZmoxlto0k9E7AMzg
         +XNOiaJz1XtTVIvCNqk1bSPEdEm8wNgsMoxHFrCBkClRKK/cWMJ5309mOnb6S7czuX9W
         vEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188462; x=1778793262;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIpR6LDM/E1ueXEWH4hacGpfKGlse0m5K1fGkt/y3Ec=;
        b=kZ6w25HyVMx5BPqlEzkF6OgSdzO7uML6DuLHDKY9C2/yICDuBqaSzxobeUNVsFzupl
         +BjhQyqGQrzs363rDo1369V2bLHWSIaXnXPOfDdmt+SCf13HMmctby+2RXb3cG9CShtR
         12fKlVPOCyof+yj62neA8YqvBNDBe30I7EnGfnx3cpDJvpHUXj7G+8WECfN7AhnCEbv3
         54H+tOeW1cV7txdR5evuyS/dWm4OXZBXNPO2WZHhaDX+PNWqlNiooWQdEy4lnGlaEpYc
         jNSE35KJ/W7qNEUzEDfKHMTgekMXjDpdht7R5+aJX2WPgOhnMZe98XZsgzcueTS5c1ry
         XnZw==
X-Gm-Message-State: AOJu0Yx2Sy5iAUjVPAqFpoDJ59sYZmQRQ9CrY1rgJO6ekEBGOuVWQ7a/
	2wz0kmMwLoAaI167o8OJVVKflnhHymZ6j4qiNGRf/87IY6PlfW7I1vIty2gAG3k18vJEm6m4iUg
	HwRvImg34PFAGM9ODJqAmjc/kZTP1WBLI0A0S
X-Gm-Gg: AeBDietHbQXrvSPob5AcB/6ScS9OhgSAIU0irC0R8ODTivXjLf5ys0bsbFQRZWfitDE
	RvQ3takhONmhTUxz4bJ6nZjbGkYlX9ZDjXdTTm4HwAC4iUUPBzZqJ6ET/dktzNGOjkjNff3rVq7
	jbWAhFQqN1AVqXoSJZ6nW1CHNUwHuFcNw3ODtDzTC3K5zRJ+2M10Kn+MtH4+/uKIwFC0AmfVNAa
	XiNCQNEN52lEE6wi16/R4W/zF30CIqA8psmdX+PDvnZexrgnUqBTT0cCCff6QFjwB7tB3WHmbFk
	OlRy9NkauXy0goxKjaDWPc+8SCj2S+9O48jdrONXzoGkPulLFgvi6D1Qhzztf4UohZi+AxrVTdA
	Pp72q
X-Received: by 2002:a05:6512:61c5:10b0:5a8:8821:c375 with SMTP id
 2adb3069b0e04-5a88821c3d9mr2663025e87.10.1778188461312; Thu, 07 May 2026
 14:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-221482-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221482-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Thu, 7 May 2026 16:14:10 -0500
X-Gm-Features: AVHnY4L0TFL4_aYECzr5_Ho2X36RwKB0u7kkDYB-EKZonZ2MgpBfnIOKEqHbJTY
Message-ID: <CABhMZUUCAa=hB18KqxzoCOWiD9V+hFtXpRLSv9989r+qFk1o1g@mail.gmail.com>
Subject: Fwd: [Bug 221482] New: PCI/ASPM: Intel Battlemage (Arc Pro B70)
 bricks at boot when `pcie_aspm.policy=powersupersave` enables ASPM_L1.1 on
 AMD root port link
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[reporter in bcc]

---------- Forwarded message ---------

https://bugzilla.kernel.org/show_bug.cgi?id=221482

            Bug ID: 221482
           Summary: PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at
                    boot when `pcie_aspm.policy=powersupersave` enables
                    ASPM_L1.1 on AMD root port link

Created attachment 310052
  --> https://bugzilla.kernel.org/attachment.cgi?id=310052&action=edit
b70 works

PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at boot when
pcie_aspm.policy=powersupersave enables ASPM_L1.1 on AMD root port link

================================================================
SUMMARY
================================================================

On Linux 7.0.3, an Intel Arc Pro B70 (Battlemage / BMG-G31, GPU PCI
ID 8086:e223) plugged into an AMD Ryzen 9 5950X system fails to wake
from D3cold during PCI core enumeration when the kernel is booted
with pcie_aspm.policy=powersupersave. The card is permanently
inaccessible until reboot with a different policy.
pcie_aspm.policy=powersave (L0s+L1, no substates) works correctly.

The failure surfaces in PCI core first; downstream xe driver bind
then fails with -EPROTO:

    pcieport 0000:02:01.0: Unable to change power state from D3cold
                           to D0, device inaccessible
    pcieport 0000:02:02.0: Unable to change power state from D3cold
                           to D0, device inaccessible
    xe 0000:03:00.0: Unable to change power state from D3cold to D0,
                     device inaccessible
    xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
                     [misdetected: dead config space reads as 0xff]
    xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset
                     GuC state (-EPROTO)
    xe 0000:03:00.0: probe with driver xe failed with error -71

After the brick, "lspci -vvv -s 03:00.0" reports
"!!! Unknown header type 7f" -- the canonical signature of a PCI
device whose config space reads return all-ones, i.e. the link to the
device is dead.


================================================================
HARDWARE
================================================================

CPU / root complex:
    AMD Ryzen 9 5950X (Starship/Matisse). The root port hosting the
    BMG card is 0000:00:01.1 -- "Advanced Micro Devices, Inc. [AMD]
    Starship/Matisse GPP Bridge" (subsystem 1022:1453).

GPU:
    Intel Arc Pro B70 -- 8086:e223 (BMG-G31, subsystem 8086:1701).

On-card topology -- the card has a two-layer on-board PCIe switch:
    0000:01:00.0  Intel 8086:e2ff -- BMG card upstream switch port,
                                     PCIe 5.0 x16 capable (currently
                                     downgraded to Gen4 x16).
    0000:02:01.0  Intel 8086:e2f0 -- BMG card downstream switch
                                     port, PCIe Gen1 x1 internal.
    0000:03:00.0  Intel 8086:e223 -- GPU endpoint, PCIe Gen1 x1
                                     internal.

Other:
    BIOS has PCIe ASPM enabled in firmware. pcie_aspm=force is NOT
    set on the kernel command line. Motherboard: ASRock X570
    (specifics in attached dmidecode.txt).


================================================================
REPRODUCER
================================================================

Boot any kernel >= 7.0 with kernel command line containing:

    pcie_aspm.policy=powersupersave xe.force_probe=*

(Also reproduces under earlier 6.x kernels.)

Reverting the cmdline to "pcie_aspm.policy=powersave" and rebooting
restores the card. No firmware reset is required between attempts --
the brick is purely a runtime link-state failure during kernel boot.


================================================================
ASPM NEGOTIATION
================================================================

Captured with "lspci -vvv" on a working policy=powersave boot
(attached: 20260507-204348-powersave-7.0.3.tar.zst).

Link 1: 00:01.1 AMD root  <->  01:00.0 BMG upstream
    Lower end (AMD root, L1SubCap):
        PCI-PM_L1.2-  PCI-PM_L1.1+  ASPM_L1.2-  ASPM_L1.1+
    Upper end (BMG upstream, L1SubCap):
        PCI-PM_L1.2+  PCI-PM_L1.1+  ASPM_L1.2+  ASPM_L1.1+
    Active L1SubCtl1 under policy=powersave:
        PCI-PM_L1.2-  PCI-PM_L1.1-  ASPM_L1.2-  ASPM_L1.1-

Link 2: 01:00.0  <->  02:01.0   (card-internal switch)
    No L1SS capability advertised on either end.

Link 3: 02:01.0  <->  03:00.0   (card-internal to GPU)
    No L1SS capability advertised on either end.

Conclusion: only Link 1 -- the platform-facing AMD<->BMG link -- is
L1SS-capable on both ends, and the intersection is ASPM_L1.1 only
(the AMD GPP root port advertises L1.1 but not L1.2). With
policy=powersupersave, the kernel arms ASPM_L1.1 on this link. After
that, every D3cold->D0 transition fails.

Both ends advertise multi-retimer support (Retimer+ 2Retimers+ on
the AMD root port and on the BMG upstream port). Retimers + L1SS
have a history of wake-recovery problems on other platforms; this
may be the same class of issue.


================================================================
TIMELINE -- failed boot, kernel 7.0.3
================================================================

Excerpted from dmesg-relevant.txt in the powersupersave capture:

    28.792s  pcieport 0000:00:01.1: PME: Signaling with IRQ 48
                     [AMD root port for BMG]
    28.842s  pcieport 0000:02:01.0: Unable to change power state from
                     D3cold to D0, device inaccessible
    28.843s  pcieport 0000:02:02.0: Unable to change power state from
                     D3cold to D0, device inaccessible
    ...
    29.034s  xe 0000:03:00.0: Unable to change power state from
                     D3cold to D0, device inaccessible
    29.035s  xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
    29.035s  xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed
                     to reset GuC state (-EPROTO)
    29.035s  xe 0000:03:00.0: probe with driver xe failed with
                     error -71

The PCI core's first wake attempt at 28.842s (the immediate parent
bridge of the BMG GPU) fails before any driver probe runs. This
confirms the failure is in the PCI/ASPM layer, not in xe; xe just
sees the resulting dead config space and misclassifies the PF as a
VF.


================================================================
WORKING-POLICY LSPCI EXCERPTS  (relevant capabilities)
================================================================

policy=powersave baseline, root port 00:01.1:

    LnkCap:  Speed 16GT/s, Width x16, ASPM L1, Exit Latency L1 <64us
    LnkCtl:  ASPM L1 Enabled
    LnkSta:  Speed 16GT/s, Width x16
    Capabilities: [370 v1] L1 PM Substates
        L1SubCap:  PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
                   L1_PM_Substates+
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
        L1SubCtl2:

policy=powersave baseline, BMG upstream 01:00.0:

    LnkCap:  Speed 32GT/s, Width x16, ASPM L1, Exit Latency L1 <32us
    LnkCtl:  ASPM L1 Enabled
    LnkSta:  Speed 16GT/s (downgraded), Width x16
    Capabilities: [244 v1] L1 PM Substates
        L1SubCap:  PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                   L1_PM_Substates+
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
        L1SubCtl2: T_PwrOn=14us


================================================================
PROPOSED FIX
================================================================

Disable both L1SS substates on the BMG card's upstream switch port
(8086:e2ff) via a DECLARE_PCI_FIXUP_FINAL. Standard ASPM L1 still
applies, so the link still benefits from the deepest substate the
BMG silicon handles correctly. The quirk keys on the card upstream
port, which is shared across the BMG product family, so it covers
all current BMG SKUs without enumerating individual GPU-endpoint
IDs.

The patch is in the attached intel-bmg-disable-l1ss.patch. With the
patch applied, pcie_aspm.policy=powersupersave boots cleanly on this
hardware (verification in progress at time of report).

Open questions for review:

  1. Is L1.1 (not L1.2) genuinely the trigger? The AMD root port
     does not advertise L1.2, so the kernel cannot have armed L1.2
     -- yet "powersupersave" is what flips this from a non-failure
     to a failure. Confirming that L1.1 alone reproduces (e.g. via a
     more targeted fixup that only disables L1.1) would narrow the
     root cause and help decide whether the quirk should also apply
     to other AMD-platform <-> BMG combinations or only to specific
     root-port stepping.

  2. Is the underlying defect in the AMD Starship root port (cannot
     wake the link from L1.1) or in the BMG e2ff upstream port
     (cannot exit L1.1 cleanly)? If the former, future BMG cards on
     Intel platforms may not need this quirk; if the latter, the
     quirk is correct for BMG everywhere. We don't have a non-AMD
     reproducer to disambiguate.

  3. Should the quirk also apply to the AMD Starship/Matisse GPP
     Bridge itself (1022:1483 / 1022:1484-class IDs, see
     lspci-nn.txt)? That would be a broader brushstroke but might
     protect other devices presenting the same negotiation.


================================================================
WORKAROUND IN USE
================================================================

Until the quirk lands upstream, downstream users on this hardware
must boot with pcie_aspm.policy=powersave (or default), losing
~25 W of idle savings that the deeper substates would otherwise
provide.


================================================================
ATTACHMENTS
================================================================

Tarballs produced by debug/20260507-aspm-capture.sh:

    20260507-204348-powersave-7.0.3.tar.zst
        -- working baseline

    20260507-205055-powersupersave-7.0.3.tar.zst
        -- failed reproduction

Each tarball contains:

    manifest.txt           kernel, policy, hostname, GPU BDFs
    cmdline.txt            kernel command line
    uname.txt              kernel version
    nixos.txt              userspace metadata
    dmidecode.txt          BIOS/board info
    lspci-tree.txt         PCI topology
    lspci-nn.txt           PCI device list
    lspci-vvv-all.txt      full system lspci -vvv

    gpu-03_00_0/           per-device captures for the GPU and
                           every PCI ancestor up to the root
                           complex:
        lspci-vvv.txt          GPU
        parent-0-02_01_0.txt   BMG card-internal downstream switch
        parent-1-01_00_0.txt   BMG card upstream port (e2ff)
        parent-2-00_01_1.txt   AMD root port
        sysfs.txt              selected sysfs attributes

    dmesg-full.txt                full kernel ring buffer
    dmesg-relevant.txt            filtered for PCI/xe/ASPM/L1
    journal-kernel-current-boot.txt
    journal-kernel-prev-boot.txt
    drivers.txt                   xe / i915 driver state,
                                  /sys/class/drm

Patch: intel-bmg-disable-l1ss.patch  (attached separately)

NixOS 26.05 (nixpkgsRevision:
    549bd84d6279f9852cae6225e372cc67fb91a4c1)

Kernel:
    7.0.3 #1-NixOS SMP PREEMPT_DYNAMIC Thu Apr 30 09:13:05 UTC 2026
