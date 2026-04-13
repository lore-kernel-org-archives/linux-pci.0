Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891333D6691
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089387; cv=none; b=inL0cFQb/aQofAQ/bWBZjAOA1lSfJlpr8M2YGg1BkIlFKQjMhG58u7Nwhu/dMZcV2jy2dgZP7+NLmEOIfn7+JL99+g5Krc8gKUJB6GW99hf/qVKdOdulgGYpyqpqkf2Conqxi6ba7rl6STQRMpyJ9Ujgt6zFnVsZML/KBHY5ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089387; c=relaxed/simple;
	bh=C/B1iyGzAeco8mG6XbmyXE51qKv69U4KUwCwz/s2yqs=;
	h=Message-ID:MIME-Version:Date:Subject:From:To:Cc; b=rHKgeIGSKRiwnjM1Mmn2PfbGDuf5smfi3WsZC8Lg0biy7DL3Bov93z/RXYNxyfl2s3XX/Vny5lYa4aBRykMGcwOwlaPi61SZJVZH66qggZeNGTPB34C4J0NQvs+ollhYXKXbzIj2fOneM8DP/Z3xuD+NARLu9PvXve0NiyzwOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpSExxFV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpSExxFV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2796930a91.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089385; x=1776694185; darn=vger.kernel.org;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :cc:to:from:subject:date:mime-version:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZLYidU8KdyVrc/NNKWv09N00LRazE5EQKYln5mJeJc=;
        b=GpSExxFVu6cTNX9fVAatV+xw8FNjLiqrl0VR/MWYu3nxr/Fndn0WIVTLl1j8uSEpkP
         z0r2bIjwd3RCHxFGOfjnjRPmg0znVGB724Fu1Md/ZFUrxUaDx5T+SSEuB35Lm3Rzwjkx
         Dl8XDbbCMmFNRVztO31LxBdI/uM1q+S+Or+bXQNwnJACUAPGX/rKftdM0rBD/iA3kGs/
         WZd5s92yRNiaFnad4i+7gUTECLUvopa6V6lmhRdYpg9bVxA1wkDfa/bz9SmANcK35og6
         u5mMCEB+IOKm+8SFjCqgURcR8oFd46fOBh6vSCw1re4K52GBE4HhqkH6kfHn5nBgVlSl
         NMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089385; x=1776694185;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :cc:to:from:subject:date:mime-version:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZLYidU8KdyVrc/NNKWv09N00LRazE5EQKYln5mJeJc=;
        b=O+dmMN7g93iJPnqT8eavKAs5CBKUmXo/pTr9HWudAXGJZMKweKi5mBKDc7+jcNyPo+
         V8ZAB9xiO1Z48UCDBUAByQeWc/t3InlwpPEGKTUq4pue4C2Ma4T+GqnYMMqyGxfsOGZF
         GiVzLrL8N9tSRXdM3T9Nc/glMwNho2cxynPocoxV3el5BexIJw1b0WjJjxDQ2mFVYNxq
         JzI4z6mfs9iALgX0yNV9jck3rvvzDU4uZXLee1+hXm3Dvl8U4dPvSgZNul+BE4GuXwcs
         RVlnLpsXSB/TGzHcLWzDLTMt5S9bh5I0YUuWUoRHB39XRLlAV1uzFgQxOp6TUNJEtLoW
         0IFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7AP81cifkZsrdVYezqxPzmFdsDCMmPuetP9jE7ycSLSaldb/0Q2iRNIEIxTpRIN8w/DY+eoKWAaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdmHUFOFkf0H9RYKv8mU4UxD3NJthl4UAOrfeuTERlUvWJQxl
	+M/JMJw6ZzNoALdjq+LDPiMuhEc4YZjR8Qe5ljzyeHSY//8x+9ragrwPyxp5MnKV
X-Gm-Gg: AeBDiev+jTQZNMqdLyH0Ku01/99o9yrgSqEsR1XzhLbwgY/5WnFW2WZvxyw+v0FMn24
	TfXeqZ9r4x9Q999KdU3y6JwwlUq9kARmOGJbJWkHKhI7pv04pac57dO3vXE3/C7qQBxGuNnLpyT
	FfJeveuv7oV9MpzmdZ286fjZguhlqt6mpPFdpVPVdaaZ/1uZTDL9jQQdCU/14cgAceRo3U/5RUn
	LEGJHyWemcLMSnuLCd4jB9tm4+OtsIQ18rHqe88sv2AubnUboWW5SiMV9GJHCTCWbni8q4TuHXO
	BrHtIn5XgTj9fLdiblW1/iLpLiYGOAdZdogihhM73xWiK+jUFrHlMvasM7Fhbwv8aRTamwDWm8I
	Uk7DIxwWFHOEGT2+N9uIkfn9CcMLNOW/MsfnCd1488v34N97tcZtrnZiKZXToh8oo9Ejk4easY8
	1ptZnn6xnbE/JmhbltWOpFXAYcwP70bzcfc5vBdJ8uot2maj9VEBaIjLhMZYTbtUI646+r2nAQo
	E+NXOnuqL98
X-Received: by 2002:a17:90b:3e88:b0:35d:a557:e41 with SMTP id 98e67ed59e1d1-35e4281c1f9mr14616498a91.14.1776089384529;
        Mon, 13 Apr 2026 07:09:44 -0700 (PDT)
Received: from smtp.rather.puzzling.org (122-199-47-107.ip4.superloop.au. [122.199.47.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb38eb48bsm4490998a91.2.2026.04.13.07.09.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:09:43 -0700 (PDT)
Message-ID: <69dcf927.170a0220.178d61.04c3@mx.google.com>
Received: from dirac.rather.puzzling.org (dirac.rather.puzzling.org [192.168.1.17])
	by smtp.rather.puzzling.org (Postfix) with ESMTPS id 77CFD2017A
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 00:09:39 +1000 (AEST)
Received: by dirac.rather.puzzling.org (Postfix, from userid 738)
	id 5CB841FF81; Tue, 14 Apr 2026 00:09:39 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by dirac.rather.puzzling.org (Postfix) with ESMTP id 4CF911FE8E
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 00:09:39 +1000 (AEST)
X-Return-Path: <tim.w.connors@gmail.com>
X-Delivered-To: tconnors@rather.puzzling.org
X-Received: by smtp.rather.puzzling.org (Postfix, from userid 738)
	id A2E3420219; Tue, 14 Apr 2026 00:01:38 +1000 (AEST)
X-Received: from imap.gmail.com [172.253.118.108]
	by smtp.rather.puzzling.org with IMAP (fetchmail-6.4.37 polling imap.gmail.com account tim.w.connors@gmail.com folder INBOX)
	for <tconnors@localhost> (single-drop); Tue, 14 Apr 2026 00:01:37 +1000 (AEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 00:01:29 +1000
Subject: Re: RE: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64:
 system does not shut down - GHES: Fatal hardware error
From: Tim Connors <tim.w.connors@gmail.com>
To: 1104670@bugs.debian.org
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Hutchings, Ben"
 <ben@decadent.org.uk>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, linux-pci <linux-pci@vger.kernel.org>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
 Laurent Bonnaud <L.Bonnaud@laposte.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
ReSent-Date: Tue, 14 Apr 2026 00:09:36 +1000 (AEST)
ReSent-From: Tim Connors <tconnors@rather.puzzling.org>
ReSent-To: linux-pci@vger.kernel.org
ReSent-Subject: Re: RE: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64:
 system does not shut down - GHES: Fatal hardware error
ReSent-Message-ID: <dc9a882b-fbcb-9e2d-4e5d-7326497406e5@rather.puzzling.org>

On Mon, 14 Jul 2025 09:21:25 +0000 "Loktionov, Aleksandr" <
aleksandr.loktionov@intel.com> wrote:
> > On Sun, 2025-05-04 at 13:45 +0200, Laurent Bonnaud wrote:
> > [...]
> > >   - Previously the kernel would output an error in
> > /var/lib/systemd/pstore/ but would shutdown anyway.
> > >
> > >   - Now, with kernel 6.1.135-1, the shutdown is blocked as with
> > 6.12.x kernels (see below).
> > > <30>[  961.098671] systemd-shutdown[1]: Rebooting.
> > > <6>[  961.098743] kvm: exiting hardware virtualization <6>[
> > > 961.361878] megaraid_sas 0000:17:00.0: megasas_disable_intr_fusion
> > is
> > > called outbound_intr_mask:0x40000009 <6>[  961.414526] ACPI: PM:
> > > Preparing to enter system sleep state S5 <0>[  963.828210]
> > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error
> > > Source: 5 <0>[  963.828213] {1}[Hardware Error]: event severity:
> > fatal <0>[  963.828214] {1}[Hardware Error]:  Error 0, type: fatal
> > > <0>[  963.828216] {1}[Hardware Error]:   section_type: PCIe error
> > > <0>[  963.828216] {1}[Hardware Error]:   port_type: 0, PCIe end
> > point
> > > <0>[  963.828217] {1}[Hardware Error]:   version: 3.0
> > > <0>[  963.828218] {1}[Hardware Error]:   command: 0x0002, status:
> > 0x0010
> > > <0>[  963.828220] {1}[Hardware Error]:   device_id: 0000:01:00.1
> > > <0>[  963.828221] {1}[Hardware Error]:   slot: 6
>>> <0>[  963.828222] {1}[Hardware Error]:   secondary_bus: 0x00
>>> <0>[  963.828223] {1}[Hardware Error]:   vendor_id: 0x8086,
>> device_id: 0x1563
>>> <0>[  963.828224] {1}[Hardware Error]:   class_code: 020000
>>> <0>[  963.828225] {1}[Hardware Error]:   aer_uncor_status:
>> 0x00100000, aer_uncor_mask: 0x00018000
>>> <0>[  963.828226] {1}[Hardware Error]:   aer_uncor_severity:
>> 0x000ef010
>>> <0>[  963.828227] {1}[Hardware Error]:   TLP Header: 40000001
>> 0000000f 90028090 00000000
>> [...]
>>
>> It seems that this is a known bug in the BIOS of several Dell
>> PowerEdge models including (in this case) the R540.

Yup, R730XD here.

>> A workaround was added to the tg3 driver
>> <https://git.kernel.org/linus/e0efe83ed325277bb70f9435d4d9fc70bebdcca8
>>
>> and a similar change was proposed (but not accepted) in the i40e
>> driver <https://lore.kernel.org/all/20241227035459.90602-1-
>> yue.zhao@shopee.com/>.
>> On tihis system the erorr log points to a deivce handled by the ixgbe
>> driver, and no workaround has been implemented for that.
>>
>> Since this issue seems to affect multiple different NIC vendors and
>> drivers, would it make more sense to implement this workaround as a
>> PCI quirk?

It's not just network devices either.

<5>[965917.449277] sd 4:0:0:0: [sda] Synchronizing SCSI cache
<6>[965917.614364] [drm] PCIE GART of 256M enabled (table at
0x000000F47FF80000).
<6>[965917.820364] [drm] UVD and UVD ENC initialized successfully.
<6>[965917.921559] [drm] VCE initialized successfully.
<6>[965917.926574] amdgpu 0000:04:00.0: [drm] Cannot find any crtc or sizes
<6>[965917.934684] amdgpu 0000:04:00.0: [drm] Cannot find any crtc or sizes
<0>[965919.725575] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 3
<0>[965919.725582] {1}[Hardware Error]: event severity: fatal
<0>[965919.725587] {1}[Hardware Error]:  Error 0, type: fatal
<0>[965919.725591] {1}[Hardware Error]:   section_type: PCIe error
<0>[965919.725595] {1}[Hardware Error]:   port_type: 1, legacy PCI end point
<0>[965919.725598] {1}[Hardware Error]:   version: 1.16
<0>[965919.725602] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
<0>[965919.725607] {1}[Hardware Error]:   device_id: 0000:04:00.1
<0>[965919.725611] {1}[Hardware Error]:   slot: 0
<0>[965919.725614] {1}[Hardware Error]:   secondary_bus: 0x00
<0>[965919.725617] {1}[Hardware Error]:   vendor_id: 0x1002, device_id:
0xaae0
<0>[965919.725622] {1}[Hardware Error]:   class_code: 040300
<0>[965919.725625] {1}[Hardware Error]:   aer_cor_status: 0x00002000,
aer_cor_mask: 0x000031c0
<0>[965919.725630] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
<0>[965919.725635] {1}[Hardware Error]:   aer_uncor_severity: 0x004e7030
<0>[965919.725638] {1}[Hardware Error]:   TLP Header: 40008001 00000a0f
96a121a0 00000000
<0>[965919.725646] GHES: Fatal hardware error but panic disabled
<0>[965919.725650] Kernel panic - not syncing: GHES: Fatal hardware error
<4>[965919.725662] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: P
  O       6.14.11-5-bpo12-pve #1
<4>[965919.725676] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
<4>[965919.725689] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS
2.19.0 12/12/2023
<4>[965919.725694] Call Trace:
<4>[965919.725700]  <NMI>
<4>[965919.725706]  dump_stack_lvl+0x27/0xa0
<4>[965919.725722]  dump_stack+0x10/0x20
<4>[965919.725729]  panic+0x358/0x3b0
<4>[965919.725742]  __ghes_panic+0x60/0x80
<4>[965919.725756]  ghes_notify_nmi+0x1d5/0x380
<4>[965919.725768]  nmi_handle.part.0+0x58/0x160
<4>[965919.725781]  default_do_nmi+0x131/0x170
<4>[965919.725792]  exc_nmi+0x1c4/0x290
<4>[965919.725799]  end_repeat_nmi+0xf/0x53
<4>[965919.725816] RIP: 0010:intel_idle+0x51/0x90
<4>[965919.725824] Code: 2d 80 ca 2b 00 eb 52 cc cc cc 48 89 f0 0f 1f 00 31
d2 48 89 d1 0f 01 c8 48 8b 06 a8 08 75 0b b9 01 00 00 00 4c 89 c0 0f 01 c9
<f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 ea
<4>[965919.725830] RSP: 0018:ffffffff8ec03db0 EFLAGS: 00000046
<4>[965919.725837] RAX: 0000000000000020 RBX: ffff8aa2ffa44680 RCX:
0000000000000001
<4>[965919.725841] RDX: 0000000000000000 RSI: ffffffff8ec107c0 RDI:
0000000000000004
<4>[965919.725849] RBP: ffffffff8ec03df0 R08: 0000000000000020 R09:
0000000000000000
<4>[965919.725854] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000004
<4>[965919.725857] R13: ffffffff8ee86960 R14: ffffffff8ee86b18 R15:
0000000000000004
<4>[965919.725866]  ? intel_idle+0x51/0x90
<4>[965919.725873]  ? intel_idle+0x51/0x90
<4>[965919.725879]  </NMI>
<4>[965919.725882]  <TASK>
<4>[965919.725884]  ? cpuidle_enter_state+0x85/0x450
<4>[965919.725895]  cpuidle_enter+0x2e/0x50
<4>[965919.725908]  call_cpuidle+0x22/0x60
<4>[965919.725918]  do_idle+0x1de/0x240
<4>[965919.725925]  cpu_startup_entry+0x29/0x30
<4>[965919.725930]  rest_init+0xd0/0xd0
<4>[965919.725934]  start_kernel+0x779/0xb60
<4>[965919.725941]  ? load_ucode_intel_bsp+0x43/0xa0
<4>[965919.725952]  x86_64_start_reservations+0x18/0x30
<4>[965919.725961]  x86_64_start_kernel+0xbf/0x110
<4>[965919.725968]  common_startup_64+0x13e/0x141
<4>[965919.725980]  </TASK>
<0>[965919.726136] Kernel Offset: 0xb600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c7) (prog-if 00
[VGA controller])
        Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Lexa PRO [Radeon
540/540X/550/550X / RX 540X/550/550X]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 174
        NUMA node: 0
        IOMMU group: 29
        Region 0: Memory at 38000000000 (64-bit, prefetchable) [size=2G]
        Region 2: Memory at 38080000000 (64-bit, prefetchable) [size=2M]
        Region 4: I/O ports at 2000 [size=256]
        Region 5: Memory at 96a00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at 96a60000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu

04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP
Audio [Radeon RX 550 640SP / RX 560/560X]
        Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP
Audio [Radeon RX 550 640SP / RX 560/560X]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 172
        NUMA node: 0
        IOMMU group: 30
        Region 0: Memory at 96a40000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

Was completely idle and unused all boot session, and reboot was routine
after patching. kernel 6.14.11-5-bpo12 from proxmox backports (so ubuntu
backports, essentially).

> I support the idea of PCI workaround, but who will implement it ?


