Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F69433E66
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717075; cv=pass; b=FrkEYIRLd/szRzRPm8N/dlD/8RY8/rWbKV6X1TpsJAx7cKJHw+ZGfMJ895A1hGmplb3Z7CWSrVO4hrgaz3aQdOi8+ul/72YmQQjxh1DeRrT+obRSqgo8He673KG0jdg6mvzilX3ndV6ReSr4k22ava5Y/CfbaP2WTFc8Qd+w1Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717075; c=relaxed/simple;
	bh=73E/PCI86XRzDyxok0ATrj7vuhBGZL4MaJiOAFX7FwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H25OKS/vJPIjGsRwSqrYcOiybERS+5Db9eCzn5qisXkK3UXtaJO8GGumr032Az3b5LTFTMHfYtWuzBzf0JQaNxpBlh8HtctMCo1S3HCx9zRhs+9TWC0NtKjDFKwaaMCWshNPfl12zSU9Jr53KDp9xose9lnttSZpDjMq48vn8Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOVQGKmz; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOVQGKmz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-824c6f137a0so267745a34.1
        for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 04:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791717072; cv=none;
        d=google.com; s=arc-20260327;
        b=cjqOx+8WMACqmRxSpahfZXd3bmvKxXX5Q7f6ZtVm3imqqst5XTpr/HYgOw3OmQOIJc
         QTSBcC+mDjUoB4hnhsUQIsUrgGygBmvLTCg4AJkzBP8Lei8cTL1cRk/7PxVunCBJgcXc
         RDKS1xH5KCMhz2r4OV/Tz0yW6fc1gd5pZEu6wjA8lcXEZ29FT6+1Y36JlqIw1YgzWe2A
         QV3HiqGR2UbH1Z742M2UXhrnagStdxQzdtdRnj2DUqO1nujsIMIZ2uowgszkh5cqXU4y
         mbQBI4mfV6iuhxkQD9PkdspVZCYO0hn2OOXQmMRN0/Vv/sX6GVJN3HmZPQePbK+xmoei
         yg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XdMmKDoSrl10NXUL3eCkZWS4Dz9V/iverKOLGhYR5OQ=;
        fh=Qi4mtw9jh4clrE0Tgk/xT4KS5wPudTmhUtr2Ka3QNQo=;
        b=OsI+pX+YsCBFEu/rC7Dh/VVKs7byOMMBljfEP9tXO8WYuTh2wrCzIXIkC29qkoQjfc
         tusGzHaV3TZAlYWg02QFD8RxwRKh0Usf7TfFolKIzeo4fCrgy3z/v8HpiOMlhpr7js74
         tDvhH3vN7QqLGANvMkgov1JA+U/1F0Zqxocm+Z3UGAKHDBrgfU7TwtLI26MG5ahzf6wx
         67cl7czcLMD7BCcf3IhP0ETSosiwxgPP3j1UcewR0bj3BXN8M8musxDOEIsnpiX/JSxQ
         cxfL2KOYCaeQf0qU2N0pyt3nH2wjYTJQk4P7Gh4JW85tK+UtMVNi/9hwyqo0AVlCOw3R
         LRwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791717072; x=1792321872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdMmKDoSrl10NXUL3eCkZWS4Dz9V/iverKOLGhYR5OQ=;
        b=TOVQGKmzC9ea0oSaAtKT4f75Abl/DuM7ccOI87IEVGaI5NbSLLT+mP3MCI68/EyUFc
         oWtvt9nCGIbFlZU3JxaR/HHltKnqyT+ahGfiSXR6eYwcf9Jgvr19uR6euMqOjzOQ6oO6
         6sFcgfLUxJ9OoC/AX1HzH2Qn0vJkQi/9M1ZSvfawsvcBIS3iTFfJO6GHx8RnB+xqigJK
         SLmD1OMmjkVHwoUAJ1Fy9k3sCjdcp7F8gGd4jqXa9rMgk5HhrMcdYlRddyv2KC6l/A5h
         V5+EpNUlNk113G2OEO+xqJ1uVPObLJCgQUqxihnDIgIgLPdE7Qq1QAZfQSdAq1HfME1N
         SN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791717072; x=1792321872;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XdMmKDoSrl10NXUL3eCkZWS4Dz9V/iverKOLGhYR5OQ=;
        b=GmjLymsGhG3IEZSurWuok/ZrnRDpDgnV9aeuALaoOkFqCXluP9tdH1Q2o/Xn3iSHg0
         y/jrfK5/pT+IZek0STXScX5/tY0wVlmonL70i8i9iL2RWo6rrXQN8PW6S4eof/IuEQby
         nYYWz5vCb6eVaewnUV9P+9C8V3V/kgN8iEzs0DvkS3j6GCyTL+FwAD86+CNr6PFFb1Nl
         0UN+mS1j6xUqLPfRd/c1CLuNGzN1Gak9ETTO1hIUXqQbGBHDjLNq+rRe2lgi5dXD/OVR
         W5TR3bpOMrr61t0ZCRFXIGbBpUMtTKkCaCJ1OmBwQnAKNRx88obGdAwKeMRsmRGL0MdC
         5hMQ==
X-Gm-Message-State: AFq9FYI+YPVcAXWrNskNfQvIjsD9cm2XyohW1+AhPK6XWDg1+C7AmNzW
	sHAwEtSvm7dYDqV228dw+Bgv4FaBoFcakkR2A+6h/KIt1SYqLXtVr9JkbkMe2wDiMKv6/M7EtNe
	mYxTntYsbc8M2X2EdUiXdGcgQuLv29eNI0m4MipM=
X-Gm-Gg: AYBFou2Yu+Pt1GHQerKYnLmwC06lPZo4vlnpJcEoYhiUHqvf7FPCzOxTIoG7bZbNq1c
	S6HdO4l8dC6zzvMtaDIXtoOjAh6lKaCzyFsrW3lJDLUaQMbibo4PwpZWpgSFcl4KtV+kUyr5GT4
	+dvzsvrkjsRXQ8w403NksBU+4N3VKV6eaQLppGWGglOplIDmkcq5dSeWoyTKVU2k0gp52KOx4xB
	iKG5JABZe5QCOzqnmobkTM19wXQkrVda8voRwPUMycYzxjDdByWsFYEPj7uGcptZwd86OyIJbOi
	u6/ihsiqyXHcqGJD4Ekv1qzyF4wXCWCSszBMAvOYTyKNSXLqtiyv79GYveF/fY0plEByzs8lNd0
	UoK8l83kTh/Y=
X-Received: by 2002:a05:6808:50a8:b0:4e8:9e40:a0dc with SMTP id
 5614622812f47-50c41108624mr9860015b6e.1.1791717071231; Sun, 11 Oct 2026
 04:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com>
 <asskafIxufz8abQa@wunner.de>
In-Reply-To: <asskafIxufz8abQa@wunner.de>
From: Krittikun Wongnin <krittikunwongnin@gmail.com>
Date: Sun, 11 Oct 2026 18:10:59 +0700
X-Gm-Features: AclHuK8_EgBW7QM5IhDVuHNqjs52MzRbe16B3gJe48wmB3-iK1Fbc68JiOav11o
Message-ID: <CADS-TgDakQUvB8Sy3zpGrYMiv_pGEaQ_m9KcsmTSD+4XqJEo5Q@mail.gmail.com>
Subject: Re: [RESEND] PCI: NVIDIA GeForce MX230 (10de:1d11) falls off the bus
 right after "Enabling HDA controller" quirk on Acer Aspire A515-53G
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 11, 2026 at 07:53:45AM +0200, Lukas Wunner wrote:
> Below is a small debug patch to avoid the write to 0x488 and also
> print the current value of the register to dmesg.  Does it help?

Thanks for the quick patch! It does not help, so the HDA quirk is not
the culprit. With your patch applied (on Manjaro's 6.12.108 kernel):

  pci 0000:02:00.0: Enabling HDA controller 0x0 -> 0x2000000
  ...
  pci 0000:02:00.0: CLS mismatch (64 != 1020), using 64 bytes
  nvidia 0000:02:00.0: Unable to change power state from D3cold to D0,
device inaccessible

So 0x488 reads back 0x0 (the device is still responding at that
point), and it still disappears a few milliseconds later even without
the write.

I then looked at what else runs in that window. Right after the ACPI
bus scan, acpi_scan_init() calls acpi_turn_off_unused_power_resources().
The root port above the GPU has two power resources:

  \_SB_.PCI0.RP05.PC01  resource_in_use=1
  \_SB_.PCI0.RP05.PCRP  resource_in_use=0

and the firmware's second definitions of RP05._PR0/_PR2/_PR3/_S0W fail
to load with AE_ALREADY_EXISTS (see my first mail). My guess is that
those failed objects are what reference PCRP, so the kernel thinks it
is unused and turns it off, cutting power to the dGPU. This looks very
similar to the existing THUNDEROBOT ZERO entry in
dmi_leave_unused_power_resources_on.

Adding this machine to that DMI table fixes it. The GPU stays on the
bus, the HDA quirk runs normally, and the nvidia driver works
(nvidia-smi shows the MX230 with 2048 MiB):

  pci 0000:02:00.0: Enabling HDA controller
  ACPI: PM: Leaving unused power resources on (DMI quirk)
  nvidia 0000:02:00.0: enabling device (0106 -> 0107)
  [drm] Initialized nvidia-drm 0.0.0 for 0000:02:00.0 on minor 0

(The "Leaving unused power resources on" line is a pr_info() I added
only for testing; it is not in the diff below.)

The change I tested:

--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1048,6 +1048,17 @@
  }

  },
+ {
+ /*
+ * Acer Aspire A515-53G: duplicate RP05 _PR0/_PR3 in firmware
+ * leaves power resource 'PCRP' unreferenced, so it is shut
+ * down on initialization and the NVIDIA dGPU falls off the bus.
+ */
+ .matches = {
+ DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+ DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A515-53G"),
+ },
+ },
  {}
 };


I have not directly confirmed that PCRP is the resource being turned
off; I can boot an unpatched kernel with
dyndbg="file drivers/acpi/power.c +p" to see the "Turning OFF"
message if that is useful, and I can also provide acpidump output.

Adding linux-acpi and Rafael since this is drivers/acpi/power.c.

> Yes, output of "lspci -vvvxxxx" would be appreciated.

Below, taken as root on the fixed kernel with the GPU working:

02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX230] (rev a1)
Subsystem: Acer Incorporated [ALI] Device 130f
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupts: pin B disabled, MSI(X) routed to IRQ 144
Region 0: Memory at a3000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at 90000000 (64-bit, prefetchable) [size=256M]
Region 3: Memory at a0000000 (64-bit, prefetchable) [size=32M]
Region 5: I/O ports at 4000 [size=128]
Capabilities: [60] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00538  Data: 0000
Capabilities: [78] Express (v2) Endpoint, IntMsgNum 0
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25W TEE-IO-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<512ns, L1 <16us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
LnkSta: Speed 2.5GT/s (downgraded), Width x4
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- TPHComp- ExtTPHComp-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
AtomicOpsCtl: ReqEn-
IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+
EqualizationPhase1+
EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [250 v1] Latency Tolerance Reporting
Max snoop latency: 34326183936ns
Max no snoop latency: 34326183936ns
Capabilities: [258 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
  T_CommonMode=0us LTR1.2_Threshold=81920ns
L1SubCtl2: T_PwrOn=10us
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [420 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
CorrIntErr- HeaderOF-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
CorrIntErr- HeaderOF+
AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
Capabilities: [900 v1] Secondary PCI Express
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
LaneErrStat: 0
Kernel driver in use: nvidia
Kernel modules: nouveau, nvidia_drm, nvidia
00: de 10 11 1d 07 05 10 00 a1 00 02 03 00 00 00 00
10: 00 00 00 a3 0c 00 00 90 00 00 00 00 0c 00 00 a0
20: 00 00 00 00 01 40 00 00 00 00 00 00 25 10 0f 13
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00
40: 25 10 0f 13 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
60: 01 68 03 00 08 00 00 00 05 78 81 00 38 05 e0 fe
70: 00 00 00 00 00 00 00 00 10 00 02 00 e1 8d e8 07
80: 30 29 00 00 43 3c 46 00 40 01 41 10 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 13 08 04 00
a0: 00 04 00 00 0e 00 00 00 03 00 1e 00 00 00 00 00
b0: 00 00 00 00 09 00 14 01 00 00 10 80 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 02 00 01 25 00 00 00 00 00 00 00 00 00 00 00 00
110: 00 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 04 00 01 42 00 00 00 00
130: 21 81 07 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 30 00 00 01 00 00 00 00 1b 00 00 88
150: 15 01 00 e0 40 71 50 06 00 00 00 00 21 81 07 00
160: 21 81 05 00 02 80 03 00 02 80 01 00 06 80 1f 00
170: 06 80 1d 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 18 00 81 25 ff 17 ff 17 1e 00 81 12 1f ff 28 00
260: 00 00 50 40 28 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 05 b4 00
420: 01 00 02 60 00 00 00 00 00 00 00 00 30 20 46 00
430: 00 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 f4 d1 07 00
480: 02 00 00 00 02 00 00 00 00 00 00 02 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 03 03 18 00 00 00 00 00 00 00 00 00 30 30 40 01
4d0: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 ff ff ff 00 44 00 00 00 fe ff 03 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 30 00 00 00 00 00 00
510: 00 00 00 00 00 30 00 00 00 00 00 00 0f 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 0b 00 01 90 01 00 41 02 02 00 41 01 01 18 00 00
610: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 06 0f 00 00 00 00 00 00
660: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: fe 0f 02 00 00 00 00 00 8d e0 00 00 48 00 10 00
710: 00 00 00 02 0a 48 00 00 a2 80 14 00 00 00 00 00
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 06 00 00 00 06 00 00 f0 f0 2c 00 00 00 00 00
810: cc 2c 00 00 00 00 00 00 00 00 00 00 01 00 00 00
820: 21 04 00 00 01 01 00 00 01 00 01 00 01 b0 07 00
830: 21 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
840: 00 00 00 00 44 08 00 00 00 00 00 40 00 00 e0 00
850: 00 00 00 00 00 00 00 00 ff 3f 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 ff ff 00 00 11 00 00 00
8a0: 0c 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff
8b0: 00 00 00 00 1b 00 00 7d 1b 00 c0 8e 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 68 55 01 00
8e0: 00 00 00 00 5a 00 00 00 10 10 10 00 02 20 20 00
8f0: 88 38 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 19 00 01 00 00 00 00 00 00 00 00 00 00 75 00 75
910: 00 75 00 75 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
930: 00 00 00 00 f8 a5 10 00 34 12 00 00 00 7a 01 a0
940: 00 00 00 00 07 00 00 00 ff 00 01 3f 00 70 08 00
950: ff 7f 08 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 b0 a5 10 00
990: b0 a5 10 00 2c 26 00 00 38 26 00 00 00 00 80 00
9a0: ff ff 80 00 00 00 07 00 ff 0f 07 00 00 00 70 00
9b0: ff ff 7f 00 f0 26 00 00 f0 26 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 f4 01
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 01 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 64 08 64 08 28 08 28 08 0f 00 00 00 fa 00 01 80
a20: 00 06 00 00 64 28 19 2a 00 00 00 80 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 01 00 00 00 3b 78 00 00 94 74 00 00
a50: c5 0c 18 03 c6 0c 18 03 00 00 00 00 00 00 00 00
a60: 00 00 00 00 b2 02 00 00 1f ff 28 00 21 00 00 00
a70: 21 00 00 00 25 01 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 ff 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Thanks,
Krittikun Wongnin

On Sun, 11 Oct 2026 at 12:53, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Oct 11, 2026 at 10:03:11AM +0700, Krittikun Wongnin wrote:
> > On an Acer Aspire A515-53G (Intel Whiskey Lake + NVIDIA GeForce MX230,
> > Optimus), the discrete GPU becomes inaccessible within ~15 ms of being
> > enumerated at boot, immediately after quirk_nvidia_hda() logs
> > "Enabling HDA controller". From then on, config space reads return all
> > ones and no driver can use the device.
>
> That's unusual, I don't recall seeing any other report about
> such behavior.
>
> > - I have not yet built a kernel with quirk_nvidia_hda() disabled to
> >   prove the quirk is the trigger. I plan to do this and will report
> >   the result. The 4.15 test differs from 7.1 in many ways besides the
> >   quirk.
>
> Below is a small debug patch to avoid the write to 0x488 and also
> print the current value of the register to dmesg.  Does it help?
>
> > If the quirk is the cause, would a DMI- or subsystem-ID-based exclusion
> > (Acer 1025:130f), or skipping the quirk for class 0x0302 devices that
> > report no HDA codec, be acceptable? I am happy to test patches and
> > provide full dmesg, lspci -vvv (as root), and acpidump output.
>
> Yes, output of "lspci -vvvxxxx" would be appreciated.
>
> Let's first try to find the root cause before thinking about possible
> solutions.
>
> Thanks,
>
> Lukas
>
> -- >8 --
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbcc..51d3b65 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5863,8 +5863,8 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
>         if (val & BIT(25))
>                 return;
>
> -       pci_info(gpu, "Enabling HDA controller\n");
> -       pci_write_config_dword(gpu, 0x488, val | BIT(25));
> +       pci_info(gpu, "Enabling HDA controller %#x -> %#x\n", val, val | BIT(25));
> +       // pci_write_config_dword(gpu, 0x488, val | BIT(25));
>
>         /* The GPU becomes a multi-function device when the HDA is enabled */
>         pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
