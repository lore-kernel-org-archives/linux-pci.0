Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403726B2AD
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762324; cv=pass; b=DiYgDoKDXHWYXIGY2nIMdNB9dyc7iVE1Se983wwJlj/UAHDZf/ly9+51OaM7jPe/8y73TPIsGrtzyQXi5Tz8M3lyThqhW/pwlbSKJeQwb3mjUGINrFoGgx1mqYxWNTODCNroMoibTJFLiLAJhu79fEtqI7Zx6ZLs18WB8FHsLCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762324; c=relaxed/simple;
	bh=EpzM/5L8FooyID2LcQbZXZ6oacxPwkgJ8qHXwZ2oVKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TR0ZwVR/bSn4/YgX5jJCBx0St5ta4p3LN9WcoeKGjz7KaQkGt9wk8JMBZfp4nX6VMUWl8g2EbR6UoL08sD9qlynFg4DJennr2czFEZ+0SIqAGwnFGjx/s0mktHiQSLHg9TWW8sozW8W9MhgiKZ4ejgdsqE8nAAFJRIPdsOf5vaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKwcqtwk; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKwcqtwk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfbd17589so901500f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 12:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775762316; cv=none;
        d=google.com; s=arc-20240605;
        b=SSRy4hVUJODI69RQHi9PB7Hpmi8W87W3maHwxo+kpLOGsBfjphyu0U0SSG4KTRy8Cm
         /6JnDf7BEgAM3kIs6IO7kfIyTgsyucnUXV523vtkxyRodIpl84C2jCwKQGi+1eYcIN59
         da/7H3J/8a6JiCD4YNmEb9YJIBBf0/+ll0ugh8X9Qagz+4qHOKAaef0dssy3m9JKyOi3
         fBYE64ctWi2KUYXXejo0ERTy0NcQkCRIRTAzyMXX2QlQyFbcCHkMtB1OPjQt8vCmZz4M
         wFWeeramBh18ojiDyBkaU0KXj/jeTRcNUaZoZ+iToR8jRUpY/qyCRezR0j37ZOz/7Xt1
         5tLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cZeZTwcvJ0eM5Ad7XhC6xB+n4PoOUQR3ltRmrpo+NXU=;
        fh=gzJTMKYedD92WedpHn1WQsqXlLXCPKY12dVTVx8a+SE=;
        b=FOvj1/feTwx1Ldg/dGBMAzwF+hHmPbu8wo9D+Gg5pZii5X6P6EA498ybRemrr4RG0f
         IXw+VhPio+nhDo67sUO7Ka44VRWdUMDHbWleARfhYao2u/ZDmmh5UozOXy2xy/ggZenz
         PQsEKkP1E894pLxuTAS5CMeZqq/JkF+2sMnm+PyX5jrLM9WoJaMPsIFXhjiC5N9qjxXq
         gbGeVpZjaLwJC23fjPXdPzPfosL55B6bYXfx494fkvjtpKEP/QfaQBeTIbscfEzWsvoc
         xHGAZUTIz+gqXT52qDyIdtgDCfBuX50mhKsEAGSpGXvfi/9jERKVo8tvslL40sWH1RJR
         tfZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762316; x=1776367116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZeZTwcvJ0eM5Ad7XhC6xB+n4PoOUQR3ltRmrpo+NXU=;
        b=VKwcqtwkAxSXLv0OEcKyHzdv3iN41UP0Z84X4PbdaEtC1QuilgkgeoQEY/uC9e/YJI
         htNFWq4QuG3907GxL7MVDNnE8PtgAGwt1qSLts/4vcHiDG1ElyNxp3F4yzgVEVBT5396
         wkj3BvveJ4SaP3UrIES46ArA+1SxTXDs0VKLqGHLwKEB/IzvLe1gIeth00KuaBQpxdwp
         LYOc7pd6B+ssiKCmKvLLN2g+WRhOi4GDb4khFJzlr1CNqNRFiGUafQS97aBY7kxAX2hB
         EhXbr1fTbq3l+tokM6UYaycQ9s90Skj/dJjUPZdVZGHN/JqcgHh2qtiAcs164xIeUB0I
         FA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762316; x=1776367116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZeZTwcvJ0eM5Ad7XhC6xB+n4PoOUQR3ltRmrpo+NXU=;
        b=AXrp6rtVFI4vzHY2BI1sGRXKVLMtItwZUvd7Hn07KtO9HgnhVTpJfwjiNDjt1efeHh
         QDb3FH8I5vcqNO0f2k3H8aUIACVKsD82RgkltolrAssPc4mmEmsq1F9udI+2DcTTEnYS
         RKvJOC9kYb4iaNDmR+Hsx8/MHs5NnckdBFLJkJrv8xkboiHj89zCl97JAPRJ6RhnS/Lo
         D50unZaUmlVotU7M9g3cDfRkdmyfSkGnqAlb5ihxv/HhotkqcThza/YqlU12Rv6REdVT
         zsV98qQRKVf4YJMIjgct/tmFztyKDKonHviMsgcw+34jSlPVN15+/R1GngOHGNLvNpcG
         xytw==
X-Forwarded-Encrypted: i=1; AJvYcCWDgyRXlt9KYcwDnnlqTNMHbXlx2OKM+UR8bAV8SvdXJrJ+ItOdb39hgK7BC7CEyx1XzqTN/Hm+U6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7qJaFvWkx1mZE6iwHsJkA3lSjWCZdkrwkYUJdCx5czBevDhr
	CX19tOfFK9G70BKu/iE3R7icCsq8Rg1k/96E7OQWzNQLovSKdgqkSgJr+L3mGjOWD9SKOXSMRuV
	qinxamuHMtSL7t8zUSEXAUJ/YoKgCcRk=
X-Gm-Gg: AeBDieseVwFyKWCHwFKIDGMswJ9OhzcSMpf5gnLgj7bXTxbELr6D57f7JVHmTc2smsv
	gP0Jv0d5jSwOSaUMQ1QqbWOi5IvHj4Nf+vpwOEQgGb0FflDG5AEJz9niSNAsvqQyTQWbdhMQPnl
	iqfkpv5FD+Z7+ePa7Aq71vuLqsYxgY6nOo5e2rfCWYa+zFTBAHRXOy/BH9m08DshHF1s5Wm5MKW
	JT1jbSWXWSx41yYoinaD0cW7Eg8eAr0D0j7cQbQxujs+2VHQmwiJFLCm2G/Y6/3s+bwXJ/uJHnB
	PmAHMEgDTPvL6Uwq2uwaq4xZbfXevoihqYtpFGU5wrX6ffkTAKPidnJbMLEKmFpRMNpR0RI=
X-Received: by 2002:a5d:588b:0:b0:43d:1c21:ead3 with SMTP id
 ffacd0b85a97d-43d64253580mr413533f8f.16.1775762314545; Thu, 09 Apr 2026
 12:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrGBMBDftu58R71jvEcZ94D8vJB2Y_dHG=BbNSsNMOS=3k0+g@mail.gmail.com>
 <20260409190515.GA407093@bhelgaas>
In-Reply-To: <20260409190515.GA407093@bhelgaas>
From: Jacopo Labardi <jacopolabardi@gmail.com>
Date: Thu, 9 Apr 2026 21:18:23 +0200
X-Gm-Features: AQROBzAPphtcHmdKplBxqePm7zQQFIEfYoMScxImF7S8MnS46Hm5QxMCWVRKUqk
Message-ID: <CANrGBMAamoj5wDJnbFCkp88r_rq88mrOo3HYi7gz9jtnZA5L9g@mail.gmail.com>
Subject: Re: [BUG] Lenovo 83JL / WD SN7100S: intermittent loss of secondary
 NVMe after s2idle resume, root port 00:02.1 retraining fails
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bjorn,

Thanks. Below are the redacted logs from the reproducer boot. In that
specific run the failure occurred on the third suspend/resume cycle,
but the issue is intermittent in general and may happen on the first
cycle or only after several cycles.

Redactions are limited to:
- system serial number
- SMBIOS UUID
- root filesystem UUID
- hostname
- Wi-Fi MAC/BSSID
- NVMe serial numbers

===== uname =====

### COMMAND: uname -a

Linux <HOST> 6.19.11-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 02 Apr 2026
23:33:01 +0000 x86_64 GNU/Linux


===== root_cmdline =====

### COMMAND: cat /proc/cmdline

quiet nowatchdog rw rootflags=subvol=/@ rootfstype=btrfs
root=UUID=<ROOT_UUID> amd_pstate=active iommu=pt i8042.nopnp
loglevel=3 8250.nr_uarts=0 tpm_tis.interrupts=0 random.trust_cpu=on
snd_hda_intel.power_save=10 snd_hda_intel.power_save_controller=Y


===== kernel_tainted =====

### COMMAND: cat /proc/sys/kernel/tainted

0


===== mem_sleep =====

### COMMAND: cat /sys/power/mem_sleep

[s2idle]


===== pacman_versions =====

### COMMAND: pacman -Q linux linux-headers linux-cachyos
linux-cachyos-headers acpi_call-dkms

linux 6.19.11.arch1-1
linux-headers 6.19.11.arch1-1
linux-cachyos 6.19.11-1
linux-cachyos-headers 6.19.11-1
acpi_call-dkms 1.2.2-3


===== nvme_list =====

### COMMAND: nvme list

Node                  Generic               SN                   Model
                                   Namespace  Usage
  Format           FW Rev
--------------------- --------------------- --------------------
---------------------------------------- ----------
-------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            <LEXAR_SN>   Lexar SSD
NM790 2TB                      0x1          2.05  TB /   2.05  TB
512   B +  0 B   18950


===== lspci_rootport =====

### COMMAND: lspci -nnvv -s 00:02.1

00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1126] (prog-if 00 [Normal decode])
    Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupts: MSI(X) routed to IRQ 32
    IOMMU group: 5
    Bus: primary=00, secondary=bf, subordinate=bf, sec-latency=0
    I/O behind bridge: [disabled] [32-bit]
    Memory behind bridge: 90c00000-90cfffff [size=1M] [32-bit]
    Prefetchable memory behind bridge: [disabled] [64-bit]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport
    Kernel modules: shpchp



===== lspci_wd =====

### COMMAND: lspci -nnvv -s bf:00.0

bf:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD PC
SN7100S M.2 2242 NVMe SSD (DRAM-less) [15b7:5044] (rev 01) (prog-if 02
[NVM Express])
    Subsystem: Sandisk Corp WD PC SN7100S M.2 2242 NVMe SSD
(DRAM-less) [15b7:5044]
    !!! Unknown header type 7f
    IOMMU group: 16
    Region 0: Memory at 90c00000 (64-bit, non-prefetchable) [size=16K]
    Kernel driver in use: nvme
    Kernel modules: nvme



===== lspci_tree =====

### COMMAND: lspci -tv

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Krackan Root Complex
           +-00.2  Advanced Micro Devices, Inc. [AMD] Krackan IOMMU
           +-01.0  Advanced Micro Devices, Inc. [AMD] Device 1124
           +-01.1-[01-5f]--
           +-01.2-[60-be]--
           +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1124
           +-02.1-[bf]----00.0  Sandisk Corp WD PC SN7100S M.2 2242
NVMe SSD (DRAM-less)
           +-02.2-[c0]----00.0  O2 Micro, Inc. OZ711 SD/MMC Card
Reader Controller
           +-02.3-[c1]----00.0  Intel Corporation Wi-Fi 6E(802.11ax)
AX210/AX1675* 2x2 [Typhoon Peak]
           +-03.0  Advanced Micro Devices, Inc. [AMD] Device 1124
           +-03.2-[c2]----00.0  Shenzhen Longsys Electronics Co., Ltd.
Lexar NM790 / Patriot Viper VP4300 Lite NVMe SSD (DRAM-less)
           +-08.0  Advanced Micro Devices, Inc. [AMD] Device 1124
           +-08.1-[c3]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI]
Krackan [Radeon 840M / 860M Graphics]
           |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI]
Radeon High Definition Audio Controller
           |            +-00.2  Advanced Micro Devices, Inc. [AMD]
Strix/Krackan/Strix Halo CCP/ASP
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device 1128
           |            +-00.5  Advanced Micro Devices, Inc. [AMD]
Audio Coprocessor
           |            \-00.6  Advanced Micro Devices, Inc. [AMD]
Ryzen HD Audio Controller
           +-08.2-[c4]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Krackan PCIe Dummy Function
           |            \-00.1  Advanced Micro Devices, Inc. [AMD]
Strix/Krackan/Strix Halo Neural Processing Unit
           +-08.3-[c5]--+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1118
           |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device 111c
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device 111e
           |            +-00.5  Advanced Micro Devices, Inc. [AMD] Device 1120
           |            \-00.6  Advanced Micro Devices, Inc. [AMD] Device 1121
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
           +-18.0  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 4
           +-18.5  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 5
           +-18.6  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 6
           \-18.7  Advanced Micro Devices, Inc. [AMD] Krackan Data
Fabric; Function 7


===== journal_suspend_current =====

### COMMAND: sudo journalctl -b -u systemd-suspend.service --no-pager

apr 09 16:23:10 <HOST> systemd[1]: Starting System Suspend...
apr 09 16:23:10 <HOST> systemd-sleep[3579]: Successfully froze unit
'user.slice'.
apr 09 16:23:10 <HOST> systemd-sleep[3579]: Performing sleep operation
'suspend'...
apr 09 16:23:37 <HOST> systemd-sleep[3579]: System returned from sleep
operation 'suspend'.
apr 09 16:23:37 <HOST> systemd-sleep[3579]: Successfully thawed unit
'user.slice'.
apr 09 16:23:37 <HOST> systemd[1]: systemd-suspend.service:
Deactivated successfully.
apr 09 16:23:37 <HOST> systemd[1]: Finished System Suspend.
apr 09 16:24:10 <HOST> systemd[1]: Starting System Suspend...
apr 09 16:24:10 <HOST> systemd-sleep[3861]: Successfully froze unit
'user.slice'.
apr 09 16:24:10 <HOST> systemd-sleep[3861]: Performing sleep operation
'suspend'...
apr 09 16:24:14 <HOST> systemd-sleep[3861]: System returned from sleep
operation 'suspend'.
apr 09 16:24:14 <HOST> systemd-sleep[3861]: Successfully thawed unit
'user.slice'.
apr 09 16:24:14 <HOST> systemd[1]: systemd-suspend.service:
Deactivated successfully.
apr 09 16:24:14 <HOST> systemd[1]: Finished System Suspend.
apr 09 16:24:34 <HOST> systemd[1]: Starting System Suspend...
apr 09 16:24:34 <HOST> systemd-sleep[4078]: Successfully froze unit
'user.slice'.
apr 09 16:24:34 <HOST> systemd-sleep[4078]: Performing sleep operation
'suspend'...
apr 09 16:24:54 <HOST> systemd-sleep[4078]: System returned from sleep
operation 'suspend'.
apr 09 16:24:54 <HOST> systemd-sleep[4078]: Successfully thawed unit
'user.slice'.
apr 09 16:24:54 <HOST> systemd[1]: systemd-suspend.service:
Deactivated successfully.
apr 09 16:24:54 <HOST> systemd[1]: Finished System Suspend.


===== journal_kernel_current =====

### COMMAND: sudo journalctl -k -b --no-pager

apr 09 16:19:36 archlinux kernel: Linux version 6.19.11-arch1-1
(linux@archlinux) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU Binutils)
2.46) #1 SMP PREEMPT_DYNAMIC Thu, 02 Apr 2026 23:33:01 +0000
apr 09 16:19:36 archlinux kernel: Command line: quiet nowatchdog rw
rootflags=subvol=/@ rootfstype=btrfs root=UUID=<ROOT_UUID>
amd_pstate=active iommu=pt i8042.nopnp loglevel=3 8250.nr_uarts=0
tpm_tis.interrupts=0 random.trust_cpu=on snd_hda_intel.power_save=10
snd_hda_intel.power_save_controller=Y
apr 09 16:19:36 archlinux kernel: x86/split lock detection: #DB:
warning on user-space bus_locks
apr 09 16:19:36 archlinux kernel: BIOS-provided physical RAM map:
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000000000000-0x000000000009efff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000000009f000-0x00000000000fffff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000000100000-0x0000000009afffff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000009b00000-0x0000000009dfffff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000009e00000-0x0000000009efffff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000009f3c000-0x000000006894dfff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006894e000-0x000000006ab4dfff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006ab4e000-0x000000006ab66fff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006ab67000-0x000000006ab6cfff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006ab6d000-0x000000006ab6efff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006ab6f000-0x000000006ab6ffff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000006ab70000-0x0000000076d7efff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000076d7f000-0x000000007977efff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000007977f000-0x0000000079f7efff] ACPI NVS
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000079f7f000-0x0000000079ffefff] ACPI data
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000079fff000-0x0000000079ffffff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000007a000000-0x000000007bffffff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x000000007d675000-0x00000000ffffffff] reserved
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x0000000100000000-0x00000007fe27ffff] usable
apr 09 16:19:36 archlinux kernel: BIOS-e820: [mem
0x00000007fe280000-0x00000008a01fffff] reserved
apr 09 16:19:36 archlinux kernel: NX (Execute Disable) protection: active
apr 09 16:19:36 archlinux kernel: APIC: Static calls initialized
apr 09 16:19:36 archlinux kernel: efi: EFI v2.9 by INSYDE Corp.
apr 09 16:19:36 archlinux kernel: efi: ACPI=0x79ffe000 ACPI
2.0=0x79ffe014 TPMFinalLog=0x79f3e000 SMBIOS=0x77e6e000 SMBIOS
3.0=0x77e6b000 MEMATTR=0x7236a018 ESRT=0x72396a98
apr 09 16:19:36 archlinux kernel: efi: [Firmware Bug]: Invalid EFI
memory map entries:
apr 09 16:19:36 archlinux kernel: efi: mem65:
[type=1605912689|attr=0xed5d4358e11d435c]
range=[0xee55f47ae215f47e-0xd66cb75821dbf35b47d] (invalid)
apr 09 16:19:36 archlinux kernel: efi: mem66:
[type=1159884594|attr=0xcd65669ac125669e]
range=[0x4a6ad814462ad810-0xf65a9ae87b5a56eb80f] (invalid)
apr 09 16:19:36 archlinux kernel: efi: Removing 2 invalid memory map entries.
apr 09 16:19:36 archlinux kernel: efi: Remove mem62: MMIO
range=[0x80000000-0xffffffff] (2048MB) from e820 map
apr 09 16:19:36 archlinux kernel: e820: remove [mem
0x80000000-0xffffffff] reserved
apr 09 16:19:36 archlinux kernel: efi: Remove mem64: MMIO
range=[0x880000000-0x8a01fffff] (514MB) from e820 map
apr 09 16:19:36 archlinux kernel: e820: remove [mem
0x880000000-0x8a01fffff] reserved
apr 09 16:19:36 archlinux kernel: SMBIOS 3.3.0 present.
apr 09 16:19:36 archlinux kernel: DMI: LENOVO 83JL/LNVNB161216, BIOS
QKCN29WW 12/23/2025
apr 09 16:19:36 archlinux kernel: DMI: Memory slots populated: 4/4
apr 09 16:19:36 archlinux kernel: tsc: Fast TSC calibration using PIT
apr 09 16:19:36 archlinux kernel: tsc: Detected 1996.356 MHz processor
apr 09 16:19:36 archlinux kernel: e820: update [mem
0x00000000-0x00000fff] usable ==> reserved
apr 09 16:19:36 archlinux kernel: e820: remove [mem
0x000a0000-0x000fffff] usable
apr 09 16:19:36 archlinux kernel: last_pfn = 0x7fe280 max_arch_pfn = 0x400000000
apr 09 16:19:36 archlinux kernel: MTRR map: 8 entries (3 fixed + 5
variable; max 20), built from 9 variable MTRRs
apr 09 16:19:36 archlinux kernel: x86/PAT: Configuration [0-7]: WB  WC
 UC- UC  WB  WP  UC- WT
apr 09 16:19:36 archlinux kernel: last_pfn = 0x7a000 max_arch_pfn = 0x400000000
apr 09 16:19:36 archlinux kernel: esrt: Reserving ESRT space from
0x0000000072396a98 to 0x0000000072396b98.
apr 09 16:19:36 archlinux kernel: e820: update [mem
0x72396000-0x72396fff] usable ==> reserved
apr 09 16:19:36 archlinux kernel: Using GB pages for direct mapping
apr 09 16:19:36 archlinux kernel: Secure boot could not be determined
apr 09 16:19:36 archlinux kernel: RAMDISK: [mem 0x5d100000-0x60f2afff]
apr 09 16:19:36 archlinux kernel: ACPI: Early table checksum
verification disabled
apr 09 16:19:36 archlinux kernel: ACPI: RSDP 0x0000000079FFE014 000024
(v02 LENOVO)
apr 09 16:19:36 archlinux kernel: ACPI: XSDT 0x0000000079F9F228 0001CC
(v01 LENOVO CB-01    00000001      01000013)
apr 09 16:19:36 archlinux kernel: ACPI: FACP 0x0000000079FDE000 000114
(v06 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: DSDT 0x0000000079FB4000 0091FB
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: FACS 0x0000000079EB1000 000040
apr 09 16:19:36 archlinux kernel: ACPI: UEFI 0x0000000079F66000 0001CF
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FFC000 000103
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FEF000 00C922
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FEE000 00094F
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FED000 000033
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FEB000 001011
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FE3000 007F18
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FE2000 00033E
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: MSDM 0x0000000079FE1000 000055
(v03 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: ASF! 0x0000000079FE0000 0000A5
(v32 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: BOOT 0x0000000079FDF000 000028
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: HPET 0x0000000079FDD000 000038
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: MCFG 0x0000000079FDC000 00003C
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SLIC 0x0000000079FDB000 000176
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: APIC 0x0000000079FCF000 0000EA
(v06 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: VFCT 0x0000000079FC9000 005484
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: ABLT 0x0000000079FC8000 0002C2
(v00 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FFD000 0000FA
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SDEV 0x0000000079FC6000 000144
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FC5000 00021A
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: PCCT 0x0000000079FC4000 0000D4
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FBE000 00547E
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD8000 000D54
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD6000 001504
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD5000 000A70
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD3000 001DB7
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD2000 0006CD
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD1000 000CA9
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FB1000 002AA6
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FA7000 009A53
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: FPDT 0x0000000079FD0000 000044
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: BGRT 0x0000000079FA6000 000038
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: WSMT 0x0000000079FA5000 000028
(v01 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: TPM2 0x0000000079FDA000 000050
(v05 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FA3000 001B4C
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FD9000 00010D
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FA2000 000051
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: IVRS 0x0000000079FA1000 0001F6
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FA0000 000B9B
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079FC7000 000D1E
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F9E000 000D1E
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F9D000 0004AE
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F9B000 00192F
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F9A000 000500
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F99000 000813
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F97000 00101C
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F8D000 0097CD
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F88000 004606
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F87000 0008DF
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F86000 00096A
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F85000 00008D
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: SSDT 0x0000000079F84000 000F5C
(v02 LENOVO CB-01    00000001 ACPI 00040000)
apr 09 16:19:36 archlinux kernel: ACPI: Reserving FACP table memory at
[mem 0x79fde000-0x79fde113]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving DSDT table memory at
[mem 0x79fb4000-0x79fbd1fa]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving FACS table memory at
[mem 0x79eb1000-0x79eb103f]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving UEFI table memory at
[mem 0x79f66000-0x79f661ce]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79ffc000-0x79ffc102]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fef000-0x79ffb921]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fee000-0x79fee94e]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fed000-0x79fed032]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79feb000-0x79fec010]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fe3000-0x79feaf17]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fe2000-0x79fe233d]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving MSDM table memory at
[mem 0x79fe1000-0x79fe1054]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving ASF! table memory at
[mem 0x79fe0000-0x79fe00a4]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving BOOT table memory at
[mem 0x79fdf000-0x79fdf027]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving HPET table memory at
[mem 0x79fdd000-0x79fdd037]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving MCFG table memory at
[mem 0x79fdc000-0x79fdc03b]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SLIC table memory at
[mem 0x79fdb000-0x79fdb175]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving APIC table memory at
[mem 0x79fcf000-0x79fcf0e9]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving VFCT table memory at
[mem 0x79fc9000-0x79fce483]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving ABLT table memory at
[mem 0x79fc8000-0x79fc82c1]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79ffd000-0x79ffd0f9]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SDEV table memory at
[mem 0x79fc6000-0x79fc6143]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fc5000-0x79fc5219]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving PCCT table memory at
[mem 0x79fc4000-0x79fc40d3]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fbe000-0x79fc347d]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd8000-0x79fd8d53]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd6000-0x79fd7503]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd5000-0x79fd5a6f]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd3000-0x79fd4db6]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd2000-0x79fd26cc]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd1000-0x79fd1ca8]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fb1000-0x79fb3aa5]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fa7000-0x79fb0a52]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving FPDT table memory at
[mem 0x79fd0000-0x79fd0043]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving BGRT table memory at
[mem 0x79fa6000-0x79fa6037]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving WSMT table memory at
[mem 0x79fa5000-0x79fa5027]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving TPM2 table memory at
[mem 0x79fda000-0x79fda04f]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fa3000-0x79fa4b4b]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fd9000-0x79fd910c]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fa2000-0x79fa2050]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving IVRS table memory at
[mem 0x79fa1000-0x79fa11f5]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fa0000-0x79fa0b9a]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79fc7000-0x79fc7d1d]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f9e000-0x79f9ed1d]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f9d000-0x79f9d4ad]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f9b000-0x79f9c92e]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f9a000-0x79f9a4ff]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f99000-0x79f99812]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f97000-0x79f9801b]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f8d000-0x79f967cc]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f88000-0x79f8c605]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f87000-0x79f878de]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f86000-0x79f86969]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f85000-0x79f8508c]
apr 09 16:19:36 archlinux kernel: ACPI: Reserving SSDT table memory at
[mem 0x79f84000-0x79f84f5b]
apr 09 16:19:36 archlinux kernel: No NUMA configuration found
apr 09 16:19:36 archlinux kernel: Faking a node at [mem
0x0000000000000000-0x00000007fe27ffff]
apr 09 16:19:36 archlinux kernel: NODE_DATA(0) allocated [mem
0x7fe255280-0x7fe27ffff]
apr 09 16:19:36 archlinux kernel: Zone ranges:
apr 09 16:19:36 archlinux kernel:   DMA      [mem
0x0000000000001000-0x0000000000ffffff]
apr 09 16:19:36 archlinux kernel:   DMA32    [mem
0x0000000001000000-0x00000000ffffffff]
apr 09 16:19:36 archlinux kernel:   Normal   [mem
0x0000000100000000-0x00000007fe27ffff]
apr 09 16:19:36 archlinux kernel:   Device   empty
apr 09 16:19:36 archlinux kernel: Movable zone start for each node
apr 09 16:19:36 archlinux kernel: Early memory node ranges
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000000001000-0x000000000009efff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000000100000-0x0000000009afffff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000009e00000-0x0000000009efffff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000009f3c000-0x000000006894dfff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x000000006ab4e000-0x000000006ab66fff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x000000006ab6d000-0x000000006ab6efff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x000000006ab70000-0x0000000076d7efff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000079fff000-0x0000000079ffffff]
apr 09 16:19:36 archlinux kernel:   node   0: [mem
0x0000000100000000-0x00000007fe27ffff]
apr 09 16:19:36 archlinux kernel: Initmem setup node 0 [mem
0x0000000000001000-0x00000007fe27ffff]
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA: 1 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA: 97 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 768 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 60 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 8704 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 6 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 1 pages in
unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone DMA32: 12928 pages
in unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone Normal: 24576 pages
in unavailable ranges
apr 09 16:19:36 archlinux kernel: On node 0, zone Normal: 7552 pages
in unavailable ranges
apr 09 16:19:36 archlinux kernel: ACPI: PM-Timer IO Port: 0x408
apr 09 16:19:36 archlinux kernel: ACPI: X2APIC_NMI (uid[0xffffffff]
high level lint[0x1])
apr 09 16:19:36 archlinux kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high
level lint[0x1])
apr 09 16:19:36 archlinux kernel: IOAPIC[0]: apic_id 33, version 33,
address 0xfec00000, GSI 0-23
apr 09 16:19:36 archlinux kernel: IOAPIC[1]: apic_id 34, version 33,
address 0xfd280000, GSI 24-55
apr 09 16:19:36 archlinux kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
apr 09 16:19:36 archlinux kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
apr 09 16:19:36 archlinux kernel: ACPI: Using ACPI (MADT) for SMP
configuration information
apr 09 16:19:36 archlinux kernel: ACPI: HPET id: 0x10228201 base: 0xfed00000
apr 09 16:19:36 archlinux kernel: e820: update [mem
0x70e19000-0x71078fff] usable ==> reserved
apr 09 16:19:36 archlinux kernel: CPU topo: Max. logical packages:   1
apr 09 16:19:36 archlinux kernel: CPU topo: Max. logical nodes:      1
apr 09 16:19:36 archlinux kernel: CPU topo: Num. nodes per package:  1
apr 09 16:19:36 archlinux kernel: CPU topo: Max. logical dies:       1
apr 09 16:19:36 archlinux kernel: CPU topo: Max. dies per package:   1
apr 09 16:19:36 archlinux kernel: CPU topo: Max. threads per core:   2
apr 09 16:19:36 archlinux kernel: CPU topo: Num. cores per package:     8
apr 09 16:19:36 archlinux kernel: CPU topo: Num. threads per package:  16
apr 09 16:19:36 archlinux kernel: CPU topo: Allowing 16 present CPUs
plus 0 hotplug CPUs
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x00000000-0x00000fff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x0009f000-0x000fffff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x09b00000-0x09dfffff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x09f00000-0x09f3bfff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x6894e000-0x6ab4dfff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x6ab67000-0x6ab6cfff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x6ab6f000-0x6ab6ffff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x70e19000-0x71078fff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x72396000-0x72396fff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x76d7f000-0x79ffefff]
apr 09 16:19:36 archlinux kernel: PM: hibernation: Registered nosave
memory: [mem 0x7a000000-0xffffffff]
apr 09 16:19:36 archlinux kernel: [mem 0x80000000-0xffffffff]
available for PCI devices
apr 09 16:19:36 archlinux kernel: Booting paravirtualized kernel on
bare hardware
apr 09 16:19:36 archlinux kernel: clocksource: refined-jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
apr 09 16:19:36 archlinux kernel: setup_percpu: NR_CPUS:8192
nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
apr 09 16:19:36 archlinux kernel: percpu: Embedded 63 pages/cpu
s221184 r8192 d28672 u262144
apr 09 16:19:36 archlinux kernel: pcpu-alloc: s221184 r8192 d28672
u262144 alloc=1*2097152
apr 09 16:19:36 archlinux kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06
07 [0] 08 09 10 11 12 13 14 15
apr 09 16:19:36 archlinux kernel: Kernel command line: quiet
nowatchdog rw rootflags=subvol=/@ rootfstype=btrfs
root=UUID=<ROOT_UUID> amd_pstate=active iommu=pt i8042.nopnp
loglevel=3 8250.nr_uarts=0 tpm_tis.interrupts=0 random.trust_cpu=on
snd_hda_intel.power_save=10 snd_hda_intel.power_save_controller=Y
apr 09 16:19:36 archlinux kernel: random: crng init done
apr 09 16:19:36 archlinux kernel: printk: log buffer data + meta data:
131072 + 458752 = 589824 bytes
apr 09 16:19:36 archlinux kernel: Dentry cache hash table entries:
4194304 (order: 13, 33554432 bytes, linear)
apr 09 16:19:36 archlinux kernel: Inode-cache hash table entries:
2097152 (order: 12, 16777216 bytes, linear)
apr 09 16:19:36 archlinux kernel: software IO TLB: area num 16.
apr 09 16:19:36 archlinux kernel: Fallback order for Node 0: 0
apr 09 16:19:36 archlinux kernel: Built 1 zonelists, mobility grouping
on.  Total pages: 7809627
apr 09 16:19:36 archlinux kernel: Policy zone: Normal
apr 09 16:19:36 archlinux kernel: mem auto-init: stack:all(zero), heap
alloc:on, heap free:off
apr 09 16:19:36 archlinux kernel: SLUB: HWalign=64, Order=0-3,
MinObjects=0, CPUs=16, Nodes=1
apr 09 16:19:36 archlinux kernel: ftrace: allocating 57677 entries in 228 pages
apr 09 16:19:36 archlinux kernel: ftrace: allocated 228 pages with 4 groups
apr 09 16:19:36 archlinux kernel: Dynamic Preempt: full
apr 09 16:19:36 archlinux kernel: rcu: Preemptible hierarchical RCU
implementation.
apr 09 16:19:36 archlinux kernel: rcu:         RCU restricting CPUs
from NR_CPUS=8192 to nr_cpu_ids=16.
apr 09 16:19:36 archlinux kernel: rcu:         RCU priority boosting:
priority 1 delay 500 ms.
apr 09 16:19:36 archlinux kernel:         Trampoline variant of Tasks
RCU enabled.
apr 09 16:19:36 archlinux kernel:         Rude variant of Tasks RCU enabled.
apr 09 16:19:36 archlinux kernel:         Tracing variant of Tasks RCU enabled.
apr 09 16:19:36 archlinux kernel: rcu: RCU calculated value of
scheduler-enlistment delay is 100 jiffies.
apr 09 16:19:36 archlinux kernel: rcu: Adjusting geometry for
rcu_fanout_leaf=16, nr_cpu_ids=16
apr 09 16:19:36 archlinux kernel: RCU Tasks: Setting shift to 4 and
lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
apr 09 16:19:36 archlinux kernel: RCU Tasks Rude: Setting shift to 4
and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
apr 09 16:19:36 archlinux kernel: RCU Tasks Trace: Setting shift to 4
and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
apr 09 16:19:36 archlinux kernel: NR_IRQS: 524544, nr_irqs: 1096,
preallocated irqs: 16
apr 09 16:19:36 archlinux kernel: rcu: srcu_init: Setting srcu_struct
sizes based on contention.
apr 09 16:19:36 archlinux kernel: kfence: initialized - using 2097152
bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
apr 09 16:19:36 archlinux kernel: Console: colour dummy device 80x25
apr 09 16:19:36 archlinux kernel: printk: legacy console [tty0] enabled
apr 09 16:19:36 archlinux kernel: ACPI: Core revision 20250807
apr 09 16:19:36 archlinux kernel: clocksource: hpet: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
apr 09 16:19:36 archlinux kernel: APIC: Switch to symmetric I/O mode setup
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:AMDI0020,
uid:ID00, rdevid:0xa0
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:AMDI0020,
uid:ID01, rdevid:0xa0
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:AMDI0020,
uid:ID02, rdevid:0xa0
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:AMDI0020,
uid:ID03, rdevid:0x98
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:MSFT0201,
uid:1, rdevid:0x60
apr 09 16:19:36 archlinux kernel: AMD-Vi: ivrs, add hid:AMDI0020,
uid:ID04, rdevid:0x98
apr 09 16:19:36 archlinux kernel: AMD-Vi: Using global IVHD
EFR:0x246577efa2254afa, EFR2:0x10
apr 09 16:19:36 archlinux kernel: ..TIMER: vector=0x30 apic1=0 pin1=2
apic2=-1 pin2=-1
apr 09 16:19:36 archlinux kernel: clocksource: tsc-early: mask:
0xffffffffffffffff max_cycles: 0x398d7801cfe, max_idle_ns:
881590659101 ns
apr 09 16:19:36 archlinux kernel: Calibrating delay loop (skipped),
value calculated using timer frequency.. 3992.71 BogoMIPS
(lpj=1996356)
apr 09 16:19:36 archlinux kernel: x86/cpu: User Mode Instruction
Prevention (UMIP) activated
apr 09 16:19:36 archlinux kernel: LVT offset 1 assigned for vector 0xf9
apr 09 16:19:36 archlinux kernel: LVT offset 2 assigned for vector 0xf4
apr 09 16:19:36 archlinux kernel: Last level iTLB entries: 4KB 64, 2MB
64, 4MB 32
apr 09 16:19:36 archlinux kernel: Last level dTLB entries: 4KB 128,
2MB 128, 4MB 64, 1GB 0
apr 09 16:19:36 archlinux kernel: process: using mwait in idle threads
apr 09 16:19:36 archlinux kernel: mitigations: Enabled attack vectors:
user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
apr 09 16:19:36 archlinux kernel: Speculative Store Bypass:
Mitigation: Speculative Store Bypass disabled via prctl
apr 09 16:19:36 archlinux kernel: Spectre V2 : Mitigation: Enhanced /
Automatic IBRS
apr 09 16:19:36 archlinux kernel: Spectre V2 : User space: Mitigation:
STIBP always-on protection
apr 09 16:19:36 archlinux kernel: Speculative Return Stack Overflow:
Mitigation: IBPB on VMEXIT only
apr 09 16:19:36 archlinux kernel: VMSCAPE: Mitigation: IBPB on VMEXIT
apr 09 16:19:36 archlinux kernel: Spectre V1 : Mitigation:
usercopy/swapgs barriers and __user pointer sanitization
apr 09 16:19:36 archlinux kernel: Spectre V2 : mitigation: Enabling
conditional Indirect Branch Prediction Barrier
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x001: 'x87 floating point registers'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x002: 'SSE registers'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x004: 'AVX registers'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x020: 'AVX-512 opmask'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x040: 'AVX-512 Hi256'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x080: 'AVX-512 ZMM_Hi256'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x200: 'Protection Keys User registers'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x800: 'Control-flow User registers'
apr 09 16:19:36 archlinux kernel: x86/fpu: Supporting XSAVE feature
0x1000: 'Control-flow Kernel registers (KVM only)'
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[2]:  576,
xstate_sizes[2]:  256
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[5]:  832,
xstate_sizes[5]:   64
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[6]:  896,
xstate_sizes[6]:  512
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[7]: 1408,
xstate_sizes[7]: 1024
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[9]: 2432,
xstate_sizes[9]:    8
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[11]: 2440,
xstate_sizes[11]:   16
apr 09 16:19:36 archlinux kernel: x86/fpu: xstate_offset[12]: 2456,
xstate_sizes[12]:   24
apr 09 16:19:36 archlinux kernel: x86/fpu: Enabled xstate features
0x1ae7, context size is 2480 bytes, using 'compacted' format.
apr 09 16:19:36 archlinux kernel: Freeing SMP alternatives memory: 56K
apr 09 16:19:36 archlinux kernel: pid_max: default: 32768 minimum: 301
apr 09 16:19:36 archlinux kernel: landlock: Up and running.
apr 09 16:19:36 archlinux kernel: Yama: becoming mindful.
apr 09 16:19:36 archlinux kernel: LSM support for eBPF active
apr 09 16:19:36 archlinux kernel: Mount-cache hash table entries:
65536 (order: 7, 524288 bytes, linear)
apr 09 16:19:36 archlinux kernel: Mountpoint-cache hash table entries:
65536 (order: 7, 524288 bytes, linear)
apr 09 16:19:36 archlinux kernel: smpboot: CPU0: AMD Ryzen AI 7 350 w/
Radeon 860M (family: 0x1a, model: 0x60, stepping: 0x0)
apr 09 16:19:36 archlinux kernel: Performance Events: Fam17h+ 16-deep
LBR, core perfctr, AMD PMU driver.
apr 09 16:19:36 archlinux kernel: ... version:                   2
apr 09 16:19:36 archlinux kernel: ... bit width:                 48
apr 09 16:19:36 archlinux kernel: ... generic counters:          6
apr 09 16:19:36 archlinux kernel: ... generic bitmap:
000000000000003f
apr 09 16:19:36 archlinux kernel: ... fixed-purpose counters:    0
apr 09 16:19:36 archlinux kernel: ... fixed-purpose bitmap:
0000000000000000
apr 09 16:19:36 archlinux kernel: ... value mask:
0000ffffffffffff
apr 09 16:19:36 archlinux kernel: ... max period:
00007fffffffffff
apr 09 16:19:36 archlinux kernel: ... global_ctrl mask:
000000000000003f
apr 09 16:19:36 archlinux kernel: signal: max sigframe size: 3376
apr 09 16:19:36 archlinux kernel: rcu: Hierarchical SRCU implementation.
apr 09 16:19:36 archlinux kernel: rcu:         Max phase no-delay
instances is 400.
apr 09 16:19:36 archlinux kernel: Timer migration: 2 hierarchy levels;
8 children per group; 2 crossnode level
apr 09 16:19:36 archlinux kernel: MCE: In-kernel MCE decoding enabled.
apr 09 16:19:36 archlinux kernel: smp: Bringing up secondary CPUs ...
apr 09 16:19:36 archlinux kernel: smpboot: x86: Booting SMP configuration:
apr 09 16:19:36 archlinux kernel: .... node  #0, CPUs:        #1  #2
#3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
apr 09 16:19:36 archlinux kernel: Spectre V2 : Update user space SMT
mitigation: STIBP always-on
apr 09 16:19:36 archlinux kernel: smp: Brought up 1 node, 16 CPUs
apr 09 16:19:36 archlinux kernel: smpboot: Total of 16 processors
activated (63883.39 BogoMIPS)
apr 09 16:19:36 archlinux kernel: Memory: 30350944K/31238508K
available (20570K kernel code, 2951K rwdata, 16744K rodata, 4776K
init, 4596K bss, 869516K reserved, 0K cma-reserved)
apr 09 16:19:36 archlinux kernel: devtmpfs: initialized
apr 09 16:19:36 archlinux kernel: x86/mm: Memory block size: 128MB
apr 09 16:19:36 archlinux kernel: ACPI: PM: Registering ACPI NVS
region [mem 0x09f00000-0x09f3bfff] (245760 bytes)
apr 09 16:19:36 archlinux kernel: ACPI: PM: Registering ACPI NVS
region [mem 0x7977f000-0x79f7efff] (8388608 bytes)
apr 09 16:19:36 archlinux kernel: clocksource: jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
apr 09 16:19:36 archlinux kernel: posixtimers hash table entries: 8192
(order: 5, 131072 bytes, linear)
apr 09 16:19:36 archlinux kernel: futex hash table entries: 4096
(262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
apr 09 16:19:36 archlinux kernel: PM: RTC time: 14:19:34, date: 2026-04-09
apr 09 16:19:36 archlinux kernel: NET: Registered PF_NETLINK/PF_ROUTE
protocol family
apr 09 16:19:36 archlinux kernel: DMA: preallocated 4096 KiB
GFP_KERNEL pool for atomic allocations
apr 09 16:19:36 archlinux kernel: DMA: preallocated 4096 KiB
GFP_KERNEL|GFP_DMA pool for atomic allocations
apr 09 16:19:36 archlinux kernel: DMA: preallocated 4096 KiB
GFP_KERNEL|GFP_DMA32 pool for atomic allocations
apr 09 16:19:36 archlinux kernel: audit: initializing netlink subsys (disabled)
apr 09 16:19:36 archlinux kernel: audit: type=2000
audit(1775744373.159:1): state=initialized audit_enabled=0 res=1
apr 09 16:19:36 archlinux kernel: thermal_sys: Registered thermal
governor 'fair_share'
apr 09 16:19:36 archlinux kernel: thermal_sys: Registered thermal
governor 'bang_bang'
apr 09 16:19:36 archlinux kernel: thermal_sys: Registered thermal
governor 'step_wise'
apr 09 16:19:36 archlinux kernel: thermal_sys: Registered thermal
governor 'user_space'
apr 09 16:19:36 archlinux kernel: thermal_sys: Registered thermal
governor 'power_allocator'
apr 09 16:19:36 archlinux kernel: cpuidle: using governor ladder
apr 09 16:19:36 archlinux kernel: cpuidle: using governor menu
apr 09 16:19:36 archlinux kernel: Detected 1 PCC Subspaces
apr 09 16:19:36 archlinux kernel: Registering PCC driver as Mailbox controller
apr 09 16:19:36 archlinux kernel: Simple Boot Flag at 0x44 set to 0x1
apr 09 16:19:36 archlinux kernel: efi: Freeing EFI boot services memory: 129648K
apr 09 16:19:36 archlinux kernel: acpiphp: ACPI Hot Plug PCI
Controller Driver version: 0.5
apr 09 16:19:36 archlinux kernel: PCI: ECAM [mem
0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
apr 09 16:19:36 archlinux kernel: PCI: Using configuration type 1 for
base access
apr 09 16:19:36 archlinux kernel: kprobes: kprobe jump-optimization is
enabled. All kprobes are optimized if possible.
apr 09 16:19:36 archlinux kernel: HugeTLB: registered 1.00 GiB page
size, pre-allocated 0 pages
apr 09 16:19:36 archlinux kernel: HugeTLB: 16380 KiB vmemmap can be
freed for a 1.00 GiB page
apr 09 16:19:36 archlinux kernel: HugeTLB: registered 2.00 MiB page
size, pre-allocated 0 pages
apr 09 16:19:36 archlinux kernel: HugeTLB: 28 KiB vmemmap can be freed
for a 2.00 MiB page
apr 09 16:19:36 archlinux kernel: raid6: skipped pq benchmark and
selected avx512x4
apr 09 16:19:36 archlinux kernel: raid6: using avx512x2 recovery algorithm
apr 09 16:19:36 archlinux kernel: ACPI: Added _OSI(Module Device)
apr 09 16:19:36 archlinux kernel: ACPI: Added _OSI(Processor Device)
apr 09 16:19:36 archlinux kernel: ACPI: Added _OSI(Processor Aggregator Device)
apr 09 16:19:36 archlinux kernel: ACPI BIOS Error (bug): Failure
creating named object [\_SB.PCI0.GPP5.WLAN._DSM], AE_ALREADY_EXISTS
(20250807/dswload2-326)
apr 09 16:19:36 archlinux kernel: ACPI Error: AE_ALREADY_EXISTS,
During name lookup/catalog (20250807/psobject-220)
apr 09 16:19:36 archlinux kernel: ACPI: Skipping parse of AML opcode:
Method (0x0014)
apr 09 16:19:36 archlinux kernel: ACPI: 36 ACPI AML tables
successfully acquired and loaded
apr 09 16:19:36 archlinux kernel: ACPI: USB4 _OSC: OS supports USB3+
DisplayPort+ PCIe+ XDomain+
apr 09 16:19:36 archlinux kernel: ACPI: USB4 _OSC: OS controls USB3+
DisplayPort+ PCIe+ XDomain+
apr 09 16:19:36 archlinux kernel: ACPI: EC: EC started
apr 09 16:19:36 archlinux kernel: ACPI: EC: interrupt blocked
apr 09 16:19:36 archlinux kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot
DSDT EC used to handle transactions
apr 09 16:19:36 archlinux kernel: ACPI: Interpreter enabled
apr 09 16:19:36 archlinux kernel: ACPI: PM: (supports S0 S4 S5)
apr 09 16:19:36 archlinux kernel: ACPI: Using IOAPIC for interrupt routing
apr 09 16:19:36 archlinux kernel: PCI: Using host bridge windows from
ACPI; if necessary, use "pci=nocrs" and report a bug
apr 09 16:19:36 archlinux kernel: PCI: Ignoring E820 reservations for
host bridge windows
apr 09 16:19:36 archlinux kernel: ACPI: Enabled 3 GPEs in block 00 to 1F
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP0.PWRS: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP0.SWUS.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP1.PWRS: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP1.SWUS.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP3.P0NV: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPP5.PWSR: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GP10.P0NV: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.PWRS: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.VGA_.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.ACP_.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.AZAL.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.HDAU.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPA.XHC1.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPC.XHC0.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPC.XHC3.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPC.XHC4.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPC.NHI0.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.GPPC.NHI1.PWRS: New
power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PRWL: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PRWB: New power resource
apr 09 16:19:36 archlinux kernel: ACPI: PCI Root Bridge [PCI0] (domain
0000 [bus 00-ff])
apr 09 16:19:36 archlinux kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
apr 09 16:19:36 archlinux kernel: acpi PNP0A08:00: _OSC: platform does
not support [SHPCHotplug AER]
apr 09 16:19:36 archlinux kernel: acpi PNP0A08:00: _OSC: OS now
controls [PCIeHotplug PME PCIeCapability LTR DPC]
apr 09 16:19:36 archlinux kernel: PCI host bridge to bus 0000:00
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[io  0x0000-0x0cf7 window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[io  0x0d00-0xfeff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0x000a0000-0x000bffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0x000c0000-0x000cffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0x000d0000-0x000effff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0x80000000-0xdfffffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xf0000000-0xfcffffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfec00000-0xfec01fff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfed45000-0xfed811ff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfed81900-0xfed81fff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfedc0000-0xfedc0fff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfedc6000-0xfedc6fff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0xfee01000-0xffffffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource
[mem 0x8a0200000-0x833fffffff window]
apr 09 16:19:36 archlinux kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:00.0: [1022:1122] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:00.2: [1022:1123] type
00 class 0x080600 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.0: [1022:1124] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1: [1022:1125] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1: PCI bridge to [bus 01-5f]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[io  0x6000-0x9fff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[mem 0xac000000-0xc3ffffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[mem 0x3000000000-0x4fffffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2: [1022:1125] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2: PCI bridge to [bus 60-be]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[io  0x2000-0x5fff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[mem 0x94000000-0xabffffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[mem 0x1000000000-0x2fffffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.0: [1022:1124] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1: [1022:1126] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1: PCI bridge to [bus bf]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1:   bridge window
[mem 0x90c00000-0x90cfffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2: [1022:1126] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2: PCI bridge to [bus c0]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2:   bridge window
[mem 0x90b00000-0x90bfffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.3: [1022:1126] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.3: PCI bridge to [bus c1]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.3:   bridge window
[mem 0x90a00000-0x90afffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.3: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.0: [1022:1124] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.2: [1022:1126] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.2: PCI bridge to [bus c2]
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.2:   bridge window
[mem 0x90900000-0x909fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.2: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.0: [1022:1124] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1: [1022:1110] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1: PCI bridge to [bus c3]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1:   bridge window
[io  0x1000-0x1fff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1:   bridge window
[mem 0x80000000-0x902fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1:   bridge window
[mem 0x5000000000-0x50807fffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2: [1022:1111] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2: PCI bridge to [bus c4]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2:   bridge window
[mem 0x90700000-0x908fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2:   bridge window
[mem 0x5080800000-0x50808fffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3: [1022:1112] type
01 class 0x060400 PCIe Root Port
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3: PCI bridge to [bus c5]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3:   bridge window
[mem 0x90300000-0x906fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:14.0: [1022:790b] type
00 class 0x0c0500 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:14.3: [1022:790e] type
00 class 0x060100 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.0: [1022:1248] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.1: [1022:1249] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.2: [1022:124a] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.3: [1022:124b] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.4: [1022:124c] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.5: [1022:124d] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.6: [1022:124e] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:18.7: [1022:124f] type
00 class 0x060000 conventional PCI endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1: PCI bridge to [bus 01-5f]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2: PCI bridge to [bus 60-be]
apr 09 16:19:36 archlinux kernel: pci 0000:bf:00.0: [15b7:5044] type
00 class 0x010802 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:bf:00.0: BAR 0 [mem
0x90c00000-0x90c03fff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1: PCI bridge to [bus bf]
apr 09 16:19:36 archlinux kernel: pci 0000:c0:00.0: [1217:8621] type
00 class 0x080501 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c0:00.0: BAR 0 [mem
0x90b01000-0x90b01fff]
apr 09 16:19:36 archlinux kernel: pci 0000:c0:00.0: BAR 1 [mem
0x90b00000-0x90b007ff]
apr 09 16:19:36 archlinux kernel: pci 0000:c0:00.0: PME# supported
from D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2: PCI bridge to [bus c0]
apr 09 16:19:36 archlinux kernel: pci 0000:c1:00.0: [8086:2725] type
00 class 0x028000 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c1:00.0: BAR 0 [mem
0x90a00000-0x90a03fff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c1:00.0: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.3: PCI bridge to [bus c1]
apr 09 16:19:36 archlinux kernel: pci 0000:c2:00.0: [1d97:1602] type
00 class 0x010802 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c2:00.0: BAR 0 [mem
0x90900000-0x90903fff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:00:03.2: PCI bridge to [bus c2]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: [1002:1114] type
00 class 0x038000 PCIe Legacy Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: BAR 0 [mem
0x5000000000-0x507fffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: BAR 2 [mem
0x80000000-0x8fffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: BAR 4 [io  0x1000-0x10ff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: BAR 5 [mem
0x90200000-0x9027ffff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.0: PME# supported
from D1 D2 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.1: [1002:1640] type
00 class 0x040300 PCIe Legacy Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.1: BAR 0 [mem
0x902c8000-0x902cbfff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.1: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.1: PME# supported
from D1 D2 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.2: [1022:17e0] type
00 class 0x108000 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.2: BAR 2 [mem
0x90100000-0x901fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.2: BAR 5 [mem
0x902cc000-0x902cdfff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.2: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.4: [1022:1128] type
00 class 0x0c0330 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.4: BAR 0 [mem
0x90000000-0x900fffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.4: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.4: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.5: [1022:15e2] type
00 class 0x048000 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.5: BAR 0 [mem
0x90280000-0x902bffff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.5: BAR 2 [mem
0x5080000000-0x50807fffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.5: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.5: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.6: [1022:15e3] type
00 class 0x040300 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.6: BAR 0 [mem
0x902c0000-0x902c7fff]
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.6: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c3:00.6: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.1: PCI bridge to [bus c3]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.0: [1022:1116] type
00 class 0x130000 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.0: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: [1022:17f0] type
00 class 0x118000 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: BAR 0 [mem
0x90700000-0x907fffff]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: BAR 1 [mem
0x90800000-0x90801fff]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: BAR 2 [mem
0x5080800000-0x508087ffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: BAR 4 [mem
0x90803000-0x90803fff]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: BAR 5 [mem
0x90802000-0x90802fff]
apr 09 16:19:36 archlinux kernel: pci 0000:c4:00.1: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.2: PCI bridge to [bus c4]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.0: [1022:1118] type
00 class 0x0c0330 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.0: BAR 0 [mem
0x90300000-0x903fffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.0: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.0: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.3: [1022:111c] type
00 class 0x0c0330 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.3: BAR 0 [mem
0x90400000-0x904fffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.3: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.3: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.4: [1022:111e] type
00 class 0x0c0330 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.4: BAR 0 [mem
0x90500000-0x905fffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.4: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.4: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.5: [1022:1120] type
00 class 0x0c0340 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.5: BAR 0 [mem
0x90600000-0x9067ffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.5: Max Payload Size
set to 128 (was 256, max 256)
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.5: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.5: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.6: [1022:1121] type
00 class 0x0c0340 PCIe Endpoint
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.6: BAR 0 [mem
0x90680000-0x906fffff 64bit]
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.6: Max Payload Size
set to 128 (was 256, max 256)
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.6: enabling Extended Tags
apr 09 16:19:36 archlinux kernel: pci 0000:c5:00.6: PME# supported
from D0 D3hot D3cold
apr 09 16:19:36 archlinux kernel: pci 0000:00:08.3: PCI bridge to [bus c5]
apr 09 16:19:36 archlinux kernel: Low-power S0 idle used by default
for system suspend
apr 09 16:19:36 archlinux kernel: ACPI: EC: interrupt unblocked
apr 09 16:19:36 archlinux kernel: ACPI: EC: event unblocked
apr 09 16:19:36 archlinux kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
apr 09 16:19:36 archlinux kernel: ACPI: EC: GPE=0xa
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: Boot
DSDT EC initialization complete
apr 09 16:19:36 archlinux kernel: ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used
to handle transactions and events
apr 09 16:19:36 archlinux kernel: iommu: Default domain type:
Passthrough (set via kernel command line)
apr 09 16:19:36 archlinux kernel: SCSI subsystem initialized
apr 09 16:19:36 archlinux kernel: libata version 3.00 loaded.
apr 09 16:19:36 archlinux kernel: ACPI: bus type USB registered
apr 09 16:19:36 archlinux kernel: usbcore: registered new interface driver usbfs
apr 09 16:19:36 archlinux kernel: usbcore: registered new interface driver hub
apr 09 16:19:36 archlinux kernel: usbcore: registered new device driver usb
apr 09 16:19:36 archlinux kernel: EDAC MC: Ver: 3.0.0
apr 09 16:19:36 archlinux kernel: efivars: Registered efivars operations
apr 09 16:19:36 archlinux kernel: NetLabel: Initializing
apr 09 16:19:36 archlinux kernel: NetLabel:  domain hash size = 128
apr 09 16:19:36 archlinux kernel: NetLabel:  protocols = UNLABELED
CIPSOv4 CALIPSO
apr 09 16:19:36 archlinux kernel: NetLabel:  unlabeled traffic allowed
by default
apr 09 16:19:36 archlinux kernel: mctp: management component transport
protocol core
apr 09 16:19:36 archlinux kernel: NET: Registered PF_MCTP protocol family
apr 09 16:19:36 archlinux kernel: PCI: Using ACPI for IRQ routing
apr 09 16:19:36 archlinux kernel: PCI: pci_cache_line_size set to 64 bytes
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x0009f000-0x0009ffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x09b00000-0x0bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x09f00000-0x0bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x6894e000-0x6bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x6ab67000-0x6bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x6ab6f000-0x6bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x70e19000-0x73ffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x72396000-0x73ffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x76d7f000-0x77ffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x7a000000-0x7bffffff]
apr 09 16:19:36 archlinux kernel: e820: reserve RAM buffer [mem
0x7fe280000-0x7ffffffff]
apr 09 16:19:36 archlinux kernel: vgaarb: loaded
apr 09 16:19:36 archlinux kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
apr 09 16:19:36 archlinux kernel: hpet0: 3 comparators, 32-bit
14.318180 MHz counter
apr 09 16:19:36 archlinux kernel: clocksource: Switched to clocksource tsc-early
apr 09 16:19:36 archlinux kernel: VFS: Disk quotas dquot_6.6.0
apr 09 16:19:36 archlinux kernel: VFS: Dquot-cache hash table entries:
512 (order 0, 4096 bytes)
apr 09 16:19:36 archlinux kernel: pnp: PnP ACPI init
apr 09 16:19:36 archlinux kernel: system 00:00: [mem
0xe0000000-0xefffffff] has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0400-0x04cf]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x04d0-0x04d1]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x04d6] has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0c00-0x0c01]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0c14] has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0c50-0x0c52]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0c6c] has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0c6f] has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0cd0-0x0cdb]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0700-0x0707]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:02: [io  0x0d00-0x0d07]
has been reserved
apr 09 16:19:36 archlinux kernel: system 00:03: [mem
0xff000000-0xffffffff] has been reserved
apr 09 16:19:36 archlinux kernel: pnp: PnP ACPI: found 5 devices
apr 09 16:19:36 archlinux kernel: clocksource: acpi_pm: mask: 0xffffff
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
apr 09 16:19:36 archlinux kernel: NET: Registered PF_INET protocol family
apr 09 16:19:36 archlinux kernel: IP idents hash table entries: 262144
(order: 9, 2097152 bytes, linear)
apr 09 16:19:36 archlinux kernel: tcp_listen_portaddr_hash hash table
entries: 16384 (order: 6, 262144 bytes, linear)
apr 09 16:19:36 archlinux kernel: Table-perturb hash table entries:
65536 (order: 6, 262144 bytes, linear)
apr 09 16:19:36 archlinux kernel: TCP established hash table entries:
262144 (order: 9, 2097152 bytes, linear)
apr 09 16:19:36 archlinux kernel: TCP bind hash table entries: 65536
(order: 9, 2097152 bytes, linear)
apr 09 16:19:36 archlinux kernel: TCP: Hash tables configured
(established 262144 bind 65536)
apr 09 16:19:36 archlinux kernel: MPTCP token hash table entries:
32768 (order: 8, 786432 bytes, linear)
apr 09 16:19:36 archlinux kernel: UDP hash table entries: 16384
(order: 8, 1048576 bytes, linear)
apr 09 16:19:36 archlinux kernel: UDP-Lite hash table entries: 16384
(order: 8, 1048576 bytes, linear)
apr 09 16:19:36 archlinux kernel: NET: Registered PF_UNIX/PF_LOCAL
protocol family
apr 09 16:19:36 archlinux kernel: NET: Registered PF_XDP protocol family
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1: PCI bridge to [bus 01-5f]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[io  0x6000-0x9fff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[mem 0xac000000-0xc3ffffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.1:   bridge window
[mem 0x3000000000-0x4fffffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2: PCI bridge to [bus 60-be]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[io  0x2000-0x5fff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[mem 0x94000000-0xabffffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:01.2:   bridge window
[mem 0x1000000000-0x2fffffffff 64bit pref]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1: PCI bridge to [bus bf]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.1:   bridge window
[mem 0x90c00000-0x90cfffff]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2: PCI bridge to [bus c0]
apr 09 16:19:36 archlinux kernel: pci 0000:00:02.2:   bridge window
[mem 0x90b00000-0x90bfffff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.3: PCI bridge to [bus c1]
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.3:   bridge window
[mem 0x90a00000-0x90afffff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:03.2: PCI bridge to [bus c2]
apr 09 16:19:37 archlinux kernel: pci 0000:00:03.2:   bridge window
[mem 0x90900000-0x909fffff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.1: PCI bridge to [bus c3]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.1:   bridge window
[io  0x1000-0x1fff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.1:   bridge window
[mem 0x80000000-0x902fffff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.1:   bridge window
[mem 0x5000000000-0x50807fffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.2: PCI bridge to [bus c4]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.2:   bridge window
[mem 0x90700000-0x908fffff]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.2:   bridge window
[mem 0x5080800000-0x50808fffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.3: PCI bridge to [bus c5]
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.3:   bridge window
[mem 0x90300000-0x906fffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 4 [io
0x0000-0x0cf7 window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 5 [io
0x0d00-0xfeff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 6 [mem
0x000a0000-0x000bffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 7 [mem
0x000c0000-0x000cffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 8 [mem
0x000d0000-0x000effff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 9 [mem
0x80000000-0xdfffffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 10 [mem
0xf0000000-0xfcffffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 11 [mem
0xfec00000-0xfec01fff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 12 [mem
0xfed45000-0xfed811ff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 13 [mem
0xfed81900-0xfed81fff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 14 [mem
0xfedc0000-0xfedc0fff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 15 [mem
0xfedc6000-0xfedc6fff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 16 [mem
0xfee01000-0xffffffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:00: resource 17 [mem
0x8a0200000-0x833fffffff window]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:01: resource 0 [io
0x6000-0x9fff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:01: resource 1 [mem
0xac000000-0xc3ffffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:01: resource 2 [mem
0x3000000000-0x4fffffffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:60: resource 0 [io
0x2000-0x5fff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:60: resource 1 [mem
0x94000000-0xabffffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:60: resource 2 [mem
0x1000000000-0x2fffffffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:bf: resource 1 [mem
0x90c00000-0x90cfffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c0: resource 1 [mem
0x90b00000-0x90bfffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c1: resource 1 [mem
0x90a00000-0x90afffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c2: resource 1 [mem
0x90900000-0x909fffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c3: resource 0 [io
0x1000-0x1fff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c3: resource 1 [mem
0x80000000-0x902fffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c3: resource 2 [mem
0x5000000000-0x50807fffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c4: resource 1 [mem
0x90700000-0x908fffff]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c4: resource 2 [mem
0x5080800000-0x50808fffff 64bit pref]
apr 09 16:19:37 archlinux kernel: pci_bus 0000:c5: resource 1 [mem
0x90300000-0x906fffff]
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.1: D0 power state
depends on 0000:c3:00.0
apr 09 16:19:37 archlinux kernel: PCI: CLS 64 bytes, default 64
apr 09 16:19:37 archlinux kernel: pci 0000:00:00.2: AMD-Vi: IOMMU
performance counters supported
apr 09 16:19:37 archlinux kernel: Trying to unpack rootfs image as initramfs...
apr 09 16:19:37 archlinux kernel: platform MSFT0201:00: Adding to iommu group 0
apr 09 16:19:37 archlinux kernel: pci 0000:00:01.0: Adding to iommu group 1
apr 09 16:19:37 archlinux kernel: pci 0000:00:01.1: Adding to iommu group 2
apr 09 16:19:37 archlinux kernel: pci 0000:00:01.2: Adding to iommu group 3
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.0: Adding to iommu group 4
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.1: Adding to iommu group 5
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.2: Adding to iommu group 6
apr 09 16:19:37 archlinux kernel: pci 0000:00:02.3: Adding to iommu group 7
apr 09 16:19:37 archlinux kernel: pci 0000:00:03.0: Adding to iommu group 8
apr 09 16:19:37 archlinux kernel: pci 0000:00:03.2: Adding to iommu group 9
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.0: Adding to iommu group 10
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.1: Adding to iommu group 11
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.2: Adding to iommu group 12
apr 09 16:19:37 archlinux kernel: pci 0000:00:08.3: Adding to iommu group 13
apr 09 16:19:37 archlinux kernel: pci 0000:00:14.0: Adding to iommu group 14
apr 09 16:19:37 archlinux kernel: pci 0000:00:14.3: Adding to iommu group 14
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.0: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.1: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.2: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.3: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.4: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.5: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.6: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:00:18.7: Adding to iommu group 15
apr 09 16:19:37 archlinux kernel: pci 0000:bf:00.0: Adding to iommu group 16
apr 09 16:19:37 archlinux kernel: pci 0000:c0:00.0: Adding to iommu group 17
apr 09 16:19:37 archlinux kernel: pci 0000:c1:00.0: Adding to iommu group 18
apr 09 16:19:37 archlinux kernel: pci 0000:c2:00.0: Adding to iommu group 19
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.0: Adding to iommu group 20
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.1: Adding to iommu group 21
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.2: Adding to iommu group 22
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.4: Adding to iommu group 23
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.5: Adding to iommu group 24
apr 09 16:19:37 archlinux kernel: pci 0000:c3:00.6: Adding to iommu group 25
apr 09 16:19:37 archlinux kernel: pci 0000:c4:00.0: Adding to iommu group 26
apr 09 16:19:37 archlinux kernel: pci 0000:c4:00.1: Adding to iommu group 27
apr 09 16:19:37 archlinux kernel: pci 0000:c5:00.0: Adding to iommu group 28
apr 09 16:19:37 archlinux kernel: pci 0000:c5:00.3: Adding to iommu group 29
apr 09 16:19:37 archlinux kernel: pci 0000:c5:00.4: Adding to iommu group 30
apr 09 16:19:37 archlinux kernel: pci 0000:c5:00.5: Adding to iommu group 31
apr 09 16:19:37 archlinux kernel: pci 0000:c5:00.6: Adding to iommu group 32
apr 09 16:19:37 archlinux kernel: AMD-Vi: Extended features
(0x246577efa2254afa, 0x10): PPR NX GT [5] IA GA PC GA_vAPIC
apr 09 16:19:37 archlinux kernel: AMD-Vi: Interrupt remapping enabled
apr 09 16:19:37 archlinux kernel: AMD-Vi: Virtual APIC enabled
apr 09 16:19:37 archlinux kernel: PCI-DMA: Using software bounce
buffering for IO (SWIOTLB)
apr 09 16:19:37 archlinux kernel: software IO TLB: mapped [mem
0x000000006ce19000-0x0000000070e19000] (64MB)
apr 09 16:19:37 archlinux kernel: LVT offset 0 assigned for vector 0x400
apr 09 16:19:37 archlinux kernel: perf: AMD IBS detected (0x00081bff)
apr 09 16:19:37 archlinux kernel: perf/amd_iommu: Detected AMD IOMMU
#0 (2 banks, 4 counters/bank).
apr 09 16:19:37 archlinux kernel: Initialise system trusted keyrings
apr 09 16:19:37 archlinux kernel: Key type blacklist registered
apr 09 16:19:37 archlinux kernel: workingset: timestamp_bits=36
max_order=23 bucket_order=0
apr 09 16:19:37 archlinux kernel: fuse: init (API version 7.45)
apr 09 16:19:37 archlinux kernel: integrity: Platform Keyring initialized
apr 09 16:19:37 archlinux kernel: integrity: Machine keyring initialized
apr 09 16:19:37 archlinux kernel: xor: automatically using best
checksumming function   avx
apr 09 16:19:37 archlinux kernel: Key type asymmetric registered
apr 09 16:19:37 archlinux kernel: Asymmetric key parser 'x509' registered
apr 09 16:19:37 archlinux kernel: Block layer SCSI generic (bsg)
driver version 0.4 loaded (major 245)
apr 09 16:19:37 archlinux kernel: io scheduler mq-deadline registered
apr 09 16:19:37 archlinux kernel: io scheduler kyber registered
apr 09 16:19:37 archlinux kernel: io scheduler bfq registered
apr 09 16:19:37 archlinux kernel: ledtrig-cpu: registered to indicate
activity on CPUs
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:01.1: PME:
Signaling with IRQ 30
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:01.1: pciehp: Slot
#0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Interlock- NoCompl+ IbPresDis- LLActRep+
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:01.2: PME:
Signaling with IRQ 31
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:01.2: pciehp: Slot
#0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Interlock- NoCompl+ IbPresDis- LLActRep+
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:02.1: PME:
Signaling with IRQ 32
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:02.2: PME:
Signaling with IRQ 33
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:02.3: PME:
Signaling with IRQ 34
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:03.2: PME:
Signaling with IRQ 35
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:08.1: PME:
Signaling with IRQ 36
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:08.2: PME:
Signaling with IRQ 37
apr 09 16:19:37 archlinux kernel: pcieport 0000:00:08.3: PME:
Signaling with IRQ 38
apr 09 16:19:37 archlinux kernel: ACPI: AC: AC Adapter [ACAD] (on-line)
apr 09 16:19:37 archlinux kernel: input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:40/PNP0C0D:00/input/input0
apr 09 16:19:37 archlinux kernel: ACPI: button: Lid Switch [LID0]
apr 09 16:19:37 archlinux kernel: input: Sleep Button as
/devices/LNXSYSTM:00/PNP0C0E:00/input/input1
apr 09 16:19:37 archlinux kernel: ACPI: button: Sleep Button [SLPB]
apr 09 16:19:37 archlinux kernel: Monitor-Mwait will be used to enter C-1 state
apr 09 16:19:37 archlinux kernel: Estimated ratio of average max
frequency by base frequency (times 1024): 1815
apr 09 16:19:37 archlinux kernel: thermal LNXTHERM:00: registered as
thermal_zone0
apr 09 16:19:37 archlinux kernel: ACPI: thermal: Thermal Zone [TZ01] (37 C)
apr 09 16:19:37 archlinux kernel: Non-volatile memory driver v1.3
apr 09 16:19:37 archlinux kernel: Linux agpgart interface v0.103
apr 09 16:19:37 archlinux kernel: ACPI: battery: Slot [BAT1] (battery present)
apr 09 16:19:37 archlinux kernel: Freeing initrd memory: 63660K
apr 09 16:19:37 archlinux kernel: tsc: Refined TSC clocksource
calibration: 1996.222 MHz
apr 09 16:19:37 archlinux kernel: clocksource: tsc: mask:
0xffffffffffffffff max_cycles: 0x398c7ae93a9, max_idle_ns:
881590667579 ns
apr 09 16:19:37 archlinux kernel: clocksource: Switched to clocksource tsc
apr 09 16:19:37 archlinux kernel: tpm_crb MSFT0101:00: Disabling hwrng
apr 09 16:19:37 archlinux kernel: ACPI: bus type drm_connector registered
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: new USB bus
registered, assigned bus number 1
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: hcc params
0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: new USB bus
registered, assigned bus number 2
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c3:00.4: Host supports
USB 3.1 Enhanced SuperSpeed
apr 09 16:19:37 archlinux kernel: usb usb1: New USB device found,
idVendor=1d6b, idProduct=0002, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb1: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb1: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb1: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb1: SerialNumber: 0000:c3:00.4
apr 09 16:19:37 archlinux kernel: hub 1-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 1-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: usb usb2: We don't know the
algorithms for LPM for this host, disabling LPM.
apr 09 16:19:37 archlinux kernel: usb usb2: New USB device found,
idVendor=1d6b, idProduct=0003, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb2: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb2: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb2: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb2: SerialNumber: 0000:c3:00.4
apr 09 16:19:37 archlinux kernel: hub 2-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 2-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: new USB bus
registered, assigned bus number 3
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: hcc params
0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: new USB bus
registered, assigned bus number 4
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.0: Host supports
USB 3.1 Enhanced SuperSpeed
apr 09 16:19:37 archlinux kernel: usb usb3: New USB device found,
idVendor=1d6b, idProduct=0002, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb3: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb3: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb3: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb3: SerialNumber: 0000:c5:00.0
apr 09 16:19:37 archlinux kernel: hub 3-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 3-0:1.0: 5 ports detected
apr 09 16:19:37 archlinux kernel: usb usb4: We don't know the
algorithms for LPM for this host, disabling LPM.
apr 09 16:19:37 archlinux kernel: usb usb4: New USB device found,
idVendor=1d6b, idProduct=0003, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb4: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb4: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb4: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb4: SerialNumber: 0000:c5:00.0
apr 09 16:19:37 archlinux kernel: hub 4-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 4-0:1.0: 2 ports detected
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: new USB bus
registered, assigned bus number 5
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: hcc params
0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: new USB bus
registered, assigned bus number 6
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.3: Host supports
USB 3.1 Enhanced SuperSpeed
apr 09 16:19:37 archlinux kernel: usb usb5: New USB device found,
idVendor=1d6b, idProduct=0002, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb5: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb5: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb5: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb5: SerialNumber: 0000:c5:00.3
apr 09 16:19:37 archlinux kernel: hub 5-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 5-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: usb usb6: We don't know the
algorithms for LPM for this host, disabling LPM.
apr 09 16:19:37 archlinux kernel: usb usb6: New USB device found,
idVendor=1d6b, idProduct=0003, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb6: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb6: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb6: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb6: SerialNumber: 0000:c5:00.3
apr 09 16:19:37 archlinux kernel: hub 6-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 6-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: new USB bus
registered, assigned bus number 7
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: hcc params
0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: new USB bus
registered, assigned bus number 8
apr 09 16:19:37 archlinux kernel: xhci_hcd 0000:c5:00.4: Host supports
USB 3.1 Enhanced SuperSpeed
apr 09 16:19:37 archlinux kernel: usb usb7: New USB device found,
idVendor=1d6b, idProduct=0002, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb7: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb7: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb7: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb7: SerialNumber: 0000:c5:00.4
apr 09 16:19:37 archlinux kernel: hub 7-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 7-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: usb usb8: We don't know the
algorithms for LPM for this host, disabling LPM.
apr 09 16:19:37 archlinux kernel: usb usb8: New USB device found,
idVendor=1d6b, idProduct=0003, bcdDevice= 6.19
apr 09 16:19:37 archlinux kernel: usb usb8: New USB device strings:
Mfr=3, Product=2, SerialNumber=1
apr 09 16:19:37 archlinux kernel: usb usb8: Product: xHCI Host Controller
apr 09 16:19:37 archlinux kernel: usb usb8: Manufacturer: Linux
6.19.11-arch1-1 xhci-hcd
apr 09 16:19:37 archlinux kernel: usb usb8: SerialNumber: 0000:c5:00.4
apr 09 16:19:37 archlinux kernel: hub 8-0:1.0: USB hub found
apr 09 16:19:37 archlinux kernel: hub 8-0:1.0: 1 port detected
apr 09 16:19:37 archlinux kernel: usbcore: registered new interface
driver usbserial_generic
apr 09 16:19:37 archlinux kernel: usbserial: USB Serial support
registered for generic
apr 09 16:19:37 archlinux kernel: i8042: PNP detection disabled
apr 09 16:19:37 archlinux kernel: usb 3-1: new full-speed USB device
number 2 using xhci_hcd
apr 09 16:19:37 archlinux kernel: usb 1-1: new high-speed USB device
number 2 using xhci_hcd
apr 09 16:19:37 archlinux kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
apr 09 16:19:37 archlinux kernel: rtc_cmos 00:01: RTC can wake from S4
apr 09 16:19:37 archlinux kernel: rtc_cmos 00:01: registered as rtc0
apr 09 16:19:37 archlinux kernel: rtc_cmos 00:01: setting system clock
to 2026-04-09T14:19:36 UTC (1775744376)
apr 09 16:19:37 archlinux kernel: rtc_cmos 00:01: alarms up to one
month, y3k, 114 bytes nvram
apr 09 16:19:37 archlinux kernel: input: AT Translated Set 2 keyboard
as /devices/platform/i8042/serio0/input/input2
apr 09 16:19:37 archlinux kernel: simple-framebuffer
simple-framebuffer.0: [drm] Registered 1 planes with drm panic
apr 09 16:19:37 archlinux kernel: [drm] Initialized simpledrm 1.0.0
for simple-framebuffer.0 on minor 0
apr 09 16:19:37 archlinux kernel: fbcon: Deferring console take-over
apr 09 16:19:37 archlinux kernel: simple-framebuffer
simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
apr 09 16:19:37 archlinux kernel: hid: raw HID events driver (C) Jiri Kosina
apr 09 16:19:37 archlinux kernel: usbcore: registered new interface
driver usbhid
apr 09 16:19:37 archlinux kernel: usbhid: USB HID core driver
apr 09 16:19:37 archlinux kernel: rust_binder: Loaded Rust Binder.
apr 09 16:19:37 archlinux kernel: drop_monitor: Initializing network
drop monitor service
apr 09 16:19:37 archlinux kernel: NET: Registered PF_INET6 protocol family
apr 09 16:19:37 archlinux kernel: Segment Routing with IPv6
apr 09 16:19:37 archlinux kernel: RPL Segment Routing with IPv6
apr 09 16:19:37 archlinux kernel: In-situ OAM (IOAM) with IPv6
apr 09 16:19:37 archlinux kernel: NET: Registered PF_PACKET protocol family
apr 09 16:19:37 archlinux kernel: x86/amd: Previous system reset
reason [0x00200800]: ACPI power state transition occurred
apr 09 16:19:37 archlinux kernel: microcode: Current revision: 0x0b600037
apr 09 16:19:37 archlinux kernel: microcode: Updated early from: 0x0b600037
apr 09 16:19:37 archlinux kernel: resctrl: L3 allocation detected
apr 09 16:19:37 archlinux kernel: resctrl: MB allocation detected
apr 09 16:19:37 archlinux kernel: resctrl: SMBA allocation detected
apr 09 16:19:37 archlinux kernel: resctrl: L3 monitoring detected
apr 09 16:19:37 archlinux kernel: IPI shorthand broadcast: enabled
apr 09 16:19:37 archlinux kernel: sched_clock: Marking stable
(2272000686, 1705177)->(2294144713, -20438850)
apr 09 16:19:37 archlinux kernel: registered taskstats version 1
apr 09 16:19:37 archlinux kernel: Loading compiled-in X.509 certificates
apr 09 16:19:37 archlinux kernel: Loaded X.509 cert 'Build time
autogenerated kernel key: 3a9ca8bee785b4bb1fe8be4990c52511f4d6bad3'
apr 09 16:19:37 archlinux kernel: zswap: loaded using pool zstd
apr 09 16:19:37 archlinux kernel: Demotion targets for Node 0: null
apr 09 16:19:37 archlinux kernel: Key type .fscrypt registered
apr 09 16:19:37 archlinux kernel: Key type fscrypt-provisioning registered
apr 09 16:19:37 archlinux kernel: Btrfs loaded, zoned=yes, fsverity=yes
apr 09 16:19:37 archlinux kernel: Key type big_key registered
apr 09 16:19:37 archlinux kernel: integrity: Loading X.509 certificate: UEFI:db
apr 09 16:19:37 archlinux kernel: integrity: Loaded X.509 cert
'Microsoft Windows Production PCA 2011:
a92902398e16c49778cd90f99e4f9ae17c55af53'
apr 09 16:19:37 archlinux kernel: integrity: Loading X.509 certificate: UEFI:db
apr 09 16:19:37 archlinux kernel: integrity: Loaded X.509 cert
'Microsoft Corporation: Windows UEFI CA 2023:
aefc5fbbbe055d8f8daa585473499417ab5a5272'
apr 09 16:19:37 archlinux kernel: integrity: Loading X.509 certificate: UEFI:db
apr 09 16:19:37 archlinux kernel: integrity: Loaded X.509 cert 'Lenovo
Consumer SMB UEFI: 5252936d671a8a37b34d76030d24385e3589d606'
apr 09 16:19:37 archlinux kernel: integrity: Loading X.509 certificate: UEFI:db
apr 09 16:19:37 archlinux kernel: integrity: Loaded X.509 cert 'OK
Certificate: c8c73a37546046ab495c33f4d0856052'
apr 09 16:19:37 archlinux kernel: PM:   Magic number: 6:419:333
apr 09 16:19:37 archlinux kernel: tty tty54: hash matches
apr 09 16:19:37 archlinux kernel: memory memory183: hash matches
apr 09 16:19:37 archlinux kernel: RAS: Correctable Errors collector initialized.
apr 09 16:19:37 archlinux kernel: clk: Disabling unused clocks
apr 09 16:19:37 archlinux kernel: PM: genpd: Disabling unused power domains
apr 09 16:19:37 archlinux kernel: Freeing unused decrypted memory: 2028K
apr 09 16:19:37 archlinux kernel: Freeing unused kernel image
(initmem) memory: 4776K
apr 09 16:19:37 archlinux kernel: Write protecting the kernel
read-only data: 40960k
apr 09 16:19:37 archlinux kernel: Freeing unused kernel image
(text/rodata gap) memory: 1956K
apr 09 16:19:37 archlinux kernel: Freeing unused kernel image
(rodata/data gap) memory: 1688K
apr 09 16:19:37 archlinux kernel: x86/mm: Checked W+X mappings:
passed, no W+X pages found.
apr 09 16:19:37 archlinux kernel: rodata_test: all tests were successful
apr 09 16:19:37 archlinux kernel: Run /init as init process
apr 09 16:19:37 archlinux kernel:   with arguments:
apr 09 16:19:37 archlinux kernel:     /init
apr 09 16:19:37 archlinux kernel:   with environment:
apr 09 16:19:37 archlinux kernel:     HOME=/
apr 09 16:19:37 archlinux kernel:     TERM=linux
apr 09 16:19:37 archlinux systemd[1]: Successfully made /usr/ read-only.
apr 09 16:19:37 archlinux kernel: usb 1-1: New USB device found,
idVendor=04f2, idProduct=b829, bcdDevice=78.01
apr 09 16:19:37 archlinux kernel: usb 1-1: New USB device strings:
Mfr=3, Product=1, SerialNumber=2
apr 09 16:19:37 archlinux kernel: usb 1-1: Product: Integrated Camera
apr 09 16:19:37 archlinux kernel: usb 1-1: Manufacturer: Chicony
Electronics Co.,Ltd.
apr 09 16:19:37 archlinux kernel: usb 1-1: SerialNumber: 0001
apr 09 16:19:37 archlinux kernel: usb 3-1: New USB device found,
idVendor=046d, idProduct=c52b, bcdDevice=24.10
apr 09 16:19:37 archlinux kernel: usb 3-1: New USB device strings:
Mfr=1, Product=2, SerialNumber=0
apr 09 16:19:37 archlinux kernel: usb 3-1: Product: USB Receiver
apr 09 16:19:37 archlinux kernel: usb 3-1: Manufacturer: Logitech
apr 09 16:19:37 archlinux kernel: input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.0/0003:046D:C52B.0001/input/input3
apr 09 16:19:37 archlinux kernel: hid-generic 0003:046D:C52B.0001:
input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on
usb-0000:c5:00.0-1/input0
apr 09 16:19:37 archlinux kernel: input: Logitech USB Receiver Mouse
as /devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.1/0003:046D:C52B.0002/input/input4
apr 09 16:19:37 archlinux kernel: input: Logitech USB Receiver
Consumer Control as
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.1/0003:046D:C52B.0002/input/input5
apr 09 16:19:37 archlinux kernel: input: Logitech USB Receiver System
Control as /devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.1/0003:046D:C52B.0002/input/input6
apr 09 16:19:37 archlinux kernel: hid-generic 0003:046D:C52B.0002:
input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:c5:00.0-1/input1
apr 09 16:19:37 archlinux kernel: hid-generic 0003:046D:C52B.0003:
hiddev97,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:c5:00.0-1/input2
apr 09 16:19:37 archlinux systemd[1]: systemd 260.1-1-arch running in
system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP
+GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
+BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +LIBARCHIVE)
apr 09 16:19:37 archlinux systemd[1]: Detected architecture x86-64.
apr 09 16:19:37 archlinux systemd[1]: Running in initrd.
apr 09 16:19:37 archlinux systemd[1]: Initializing machine ID from
random generator.
apr 09 16:19:37 archlinux kernel: usb 3-5: new full-speed USB device
number 3 using xhci_hcd
apr 09 16:19:37 archlinux systemd[1]: Queued start job for default
target Initrd Default Target.
apr 09 16:19:37 archlinux systemd[1]: Expecting device
/dev/disk/by-uuid/<ROOT_UUID>...
apr 09 16:19:37 archlinux systemd[1]: Reached target Path Units.
apr 09 16:19:37 archlinux systemd[1]: Reached target Slice Units.
apr 09 16:19:37 archlinux systemd[1]: Reached target Swaps.
apr 09 16:19:37 archlinux systemd[1]: Reached target Timer Units.
apr 09 16:19:37 archlinux systemd[1]: Listening on Journal Socket (/dev/log).
apr 09 16:19:37 archlinux systemd[1]: Listening on Journal Sockets.
apr 09 16:19:37 archlinux systemd[1]: Listening on udev Control Socket.
apr 09 16:19:37 archlinux systemd[1]: Listening on udev Kernel Socket.
apr 09 16:19:37 archlinux systemd[1]: Reached target Socket Units.
apr 09 16:19:37 archlinux systemd[1]: Create List of Static Device
Nodes skipped, unmet condition check
ConditionFileNotEmpty=/lib/modules/6.19.11-arch1-1/modules.devname
apr 09 16:19:37 archlinux systemd[1]: Starting Journal Service...
apr 09 16:19:37 archlinux systemd[1]: Starting Load Kernel Modules...
apr 09 16:19:37 archlinux systemd[1]: TPM PCR Barrier (initrd)
skipped, unmet condition check ConditionSecurity=measured-uki
apr 09 16:19:37 archlinux systemd[1]: Starting Create Static Device
Nodes in /dev...
apr 09 16:19:37 archlinux systemd[1]: Starting Coldplug All udev Devices...
apr 09 16:19:37 archlinux systemd[1]: Starting Virtual Console Setup...
apr 09 16:19:37 archlinux systemd[1]: Finished Create Static Device
Nodes in /dev.
apr 09 16:19:37 archlinux systemd-journald[233]: Collecting audit
messages is disabled.
apr 09 16:19:37 archlinux systemd[1]: Finished Virtual Console Setup.
apr 09 16:19:37 archlinux systemd[1]: Reached target Preparation for
Local File Systems.
apr 09 16:19:37 archlinux systemd[1]: Reached target Local File Systems.
apr 09 16:19:37 archlinux systemd[1]: Starting Rule-based Manager for
Device Events and Files...
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WQA4 data block query control method not found
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WQA6 data block query control method not found
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WQA7 data block query control method not found
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WQA8 data block query control method not found
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WQA9 data block query control method not found
apr 09 16:19:37 archlinux kernel: wmi_bus wmi_bus-PNP0C14:02:
[Firmware Bug]: WMA9 method block execution control method not found
apr 09 16:19:37 archlinux kernel: ACPI: video: Video Device [VGA]
(multi-head: yes  rom: no  post: no)
apr 09 16:19:37 archlinux kernel: input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:16/LNXVIDEO:00/input/input8
apr 09 16:19:37 archlinux systemd[1]: Started Rule-based Manager for
Device Events and Files.
apr 09 16:19:37 archlinux systemd[1]: Started Journal Service.
apr 09 16:19:37 archlinux kernel: usb 3-5: New USB device found,
idVendor=8087, idProduct=0032, bcdDevice= 0.00
apr 09 16:19:37 archlinux kernel: usb 3-5: New USB device strings:
Mfr=0, Product=0, SerialNumber=0
apr 09 16:19:37 archlinux kernel: fbcon: Taking over console
apr 09 16:19:37 archlinux kernel: Console: switching to colour frame
buffer device 180x56
apr 09 16:19:38 archlinux kernel: Key type psk registered
apr 09 16:19:38 archlinux kernel: sdhci: Secure Digital Host
Controller Interface driver
apr 09 16:19:38 archlinux kernel: sdhci: Copyright(c) Pierre Ossman
apr 09 16:19:38 archlinux kernel: sdhci-pci 0000:c0:00.0: SDHCI
controller found [1217:8621] (rev 1)
apr 09 16:19:38 archlinux kernel: sdhci-pci 0000:c0:00.0: enabling
device (0000 -> 0002)
apr 09 16:19:38 archlinux kernel: nvme 0000:c2:00.0: platform quirk:
setting simple suspend
apr 09 16:19:38 archlinux kernel: nvme 0000:bf:00.0: platform quirk:
setting simple suspend
apr 09 16:19:38 archlinux kernel: nvme nvme0: pci function 0000:c2:00.0
apr 09 16:19:38 archlinux kernel: nvme nvme1: pci function 0000:bf:00.0
apr 09 16:19:38 archlinux kernel: amdgpu: Virtual CRAT table created for CPU
apr 09 16:19:38 archlinux kernel: amdgpu: Topology: Add CPU node
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: enabling device
(0006 -> 0007)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
initializing kernel modesetting (IP DISCOVERY 0x1002:0x1114
0x17AA:0x3801 0xC2).
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
register mmio base: 0x90200000
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
register mmio size: 524288
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 0 <common_v1_0_0> (soc21_common)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 2 <ih_v6_0_0> (ih_v6_1)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 3 <psp_v13_0_0> (psp)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 4 <smu_v14_0_0> (smu)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 5 <dce_v1_0_0> (dm)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 8 <vcn_v4_0_5> (vcn_v4_0_5)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 9 <jpeg_v4_0_5> (jpeg_v4_0_5)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
detected ip block number 11 <vpe_v6_1_0> (vpe_v6_1)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: Fetched
VBIOS from VFCT
apr 09 16:19:38 archlinux kernel: amdgpu: ATOM BIOS: 113-STRIXEMU-001
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: VPE:
collaborate mode false
apr 09 16:19:38 archlinux kernel: nvme nvme0: allocated 40 MiB host
memory buffer (10 segments).
apr 09 16:19:38 archlinux kernel: mmc0: SDHCI controller on PCI
[0000:c0:00.0] using ADMA
apr 09 16:19:38 archlinux kernel: Console: switching to colour dummy
device 80x25
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: Trusted
Memory Zone (TMZ) feature disabled as experimental (default)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: vm size
is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: VRAM:
2048M 0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: GART:
512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
apr 09 16:19:38 archlinux kernel: [drm] Detected VRAM RAM=2048M, BAR=2048M
apr 09 16:19:38 archlinux kernel: [drm] RAM width 128bits LPDDR5
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: amdgpu:
2048M of VRAM memory ready
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: amdgpu:
14928M of GTT memory ready.
apr 09 16:19:38 archlinux kernel: [drm] GART: num cpu pages 131072,
num gpu pages 131072
apr 09 16:19:38 archlinux kernel: [drm] PCIE GART of 512M enabled
(table at 0x000000807FB00000).
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
Loading DMUB firmware via PSP: version=0x09003E00
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [VCN
instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0
Revision: 16
apr 09 16:19:38 archlinux kernel: nvme nvme0: 16/0/0 default/read/poll queues
apr 09 16:19:38 archlinux kernel: logitech-djreceiver
0003:046D:C52B.0003: hiddev96,hidraw0: USB HID v1.11 Device [Logitech
USB Receiver] on usb-0000:c5:00.0-1/input2
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: reserve
0x1100000 from 0x807c000000 for PSP TMR
apr 09 16:19:38 archlinux kernel: nvme nvme1: allocated 32 MiB host
memory buffer (8 segments).
apr 09 16:19:38 archlinux kernel: nvme nvme1: 16/0/0 default/read/poll queues
apr 09 16:19:38 archlinux kernel:  nvme0n1: p1 p2
apr 09 16:19:38 archlinux kernel:  nvme1n1: p1 p2 p3 p4 p5
apr 09 16:19:38 archlinux kernel: BTRFS: device label cachyos devid 1
transid 68735 /dev/nvme0n1p2 (259:2) scanned by mount (350)
apr 09 16:19:38 archlinux kernel: BTRFS info (device nvme0n1p2): first
mount of filesystem <ROOT_UUID>
apr 09 16:19:38 archlinux kernel: BTRFS info (device nvme0n1p2): using
crc32c (crc32c-lib) checksum algorithm
apr 09 16:19:38 archlinux kernel: BTRFS info (device nvme0n1p2):
enabling ssd optimizations
apr 09 16:19:38 archlinux kernel: BTRFS info (device nvme0n1p2):
turning on async discard
apr 09 16:19:38 archlinux kernel: BTRFS info (device nvme0n1p2):
enabling free space tree
apr 09 16:19:38 archlinux kernel: input: Logitech Wireless Device
PID:404a Keyboard as
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.2/0003:046D:C52B.0003/0003:046D:404A.0004/input/input9
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: RAS:
optional ras ta ucode is not available
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: RAP:
optional rap ta ucode is not available
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu:
SECUREDISPLAY: optional securedisplay ta ucode is not available
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is
initialized successfully!
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
Display Core v3.2.359 initialized on DCN 3.5
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-HDMI FRL PCON supported
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DMUB hardware initialized: version=0x09003E00
apr 09 16:19:38 archlinux kernel: input: Logitech Wireless Device
PID:404a Mouse as
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.2/0003:046D:C52B.0003/0003:046D:404A.0004/input/input10
apr 09 16:19:38 archlinux kernel: hid-generic 0003:046D:404A.0004:
input,hidraw1: USB HID v1.11 Keyboard [Logitech Wireless Device
PID:404a] on usb-0000:c5:00.0-1/input2:1
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
Using ACPI provided EDID for eDP-1
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
eDP-1: PSR support 1, DC PSR ver 0, sink PSR ver 1 DPCD caps 0x76
su_y_granularity 4
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-4: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
DP-7: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0
su_y_granularity 0
apr 09 16:19:38 archlinux kernel: kfd kfd: amdgpu: Allocated 3969056
bytes on gart
apr 09 16:19:38 archlinux kernel: kfd kfd: amdgpu: Total number of KFD
nodes to be created: 1
apr 09 16:19:38 archlinux kernel: amdgpu: Virtual CRAT table created for GPU
apr 09 16:19:38 archlinux kernel: amdgpu: Topology: Add dGPU node
[0x1114:0x1002]
apr 09 16:19:38 archlinux kernel: kfd kfd: amdgpu: added device 1002:1114
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: SE 1,
SH per SE 2, CU per SH 4, active_cu_number 8
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
gfx_0.0.0 uses VM inv eng 0 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 6 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 7 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 8 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 9 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 10 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 11 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
sdma0 uses VM inv eng 12 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
vcn_unified_0 uses VM inv eng 0 on hub 8
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
jpeg_dec_0 uses VM inv eng 1 on hub 8
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: ring
vpe uses VM inv eng 4 on hub 8
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: Runtime
PM not available
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: amdgpu: [drm]
Using custom brightness curve
apr 09 16:19:38 archlinux kernel: amdgpu 0000:c3:00.0: [drm]
Registered 4 planes with drm panic
apr 09 16:19:38 archlinux kernel: [drm] Initialized amdgpu 3.64.0 for
0000:c3:00.0 on minor 1
apr 09 16:19:38 archlinux kernel: fbcon: amdgpudrmfb (fb0) is primary device
apr 09 16:19:38 archlinux kernel: [drm] pre_validate_dsc:1667 MST_DSC
dsc precompute is not needed
apr 09 16:19:38 archlinux kernel: input: Logitech MX Anywhere 2 as
/devices/pci0000:00/0000:00:08.3/0000:c5:00.0/usb3/3-1/3-1:1.2/0003:046D:C52B.0003/0003:046D:404A.0004/input/input14
apr 09 16:19:38 archlinux kernel: logitech-hidpp-device
0003:046D:404A.0004: input,hidraw1: USB HID v1.11 Keyboard [Logitech
MX Anywhere 2] on usb-0000:c5:00.0-1/input2:1
apr 09 16:19:40 archlinux kernel: Console: switching to colour frame
buffer device 180x56
apr 09 16:19:40 archlinux kernel: amdgpu 0000:c3:00.0: [drm] fb0:
amdgpudrmfb frame buffer device
apr 09 16:19:41 <HOST> systemd-journald[233]: Received SIGTERM from
PID 1 (systemd).
apr 09 16:19:41 <HOST> systemd[1]: systemd 260.1-1-arch running in
system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP
+GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
+BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +LIBARCHIVE)
apr 09 16:19:41 <HOST> systemd[1]: Detected architecture x86-64.
apr 09 16:19:41 <HOST> systemd[1]: Hostname set to <<HOST>>.
apr 09 16:19:41 <HOST> systemd[1]: bpf-restrict-fs: LSM BPF program attached
apr 09 16:19:41 <HOST> kernel: zram: Added device: zram0
apr 09 16:19:41 <HOST> systemd[1]: initrd-switch-root.service:
Deactivated successfully.
apr 09 16:19:41 <HOST> systemd[1]: Stopped Switch Root.
apr 09 16:19:41 <HOST> systemd[1]: systemd-journald.service: Scheduled
restart job, restart counter is at 1.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/dirmngr.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/getty.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/gpg-agent.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice
/system/gpg-agent-browser.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/gpg-agent-extra.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/gpg-agent-ssh.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/keyboxd.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/modprobe.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice /system/systemd-fsck.
apr 09 16:19:41 <HOST> systemd[1]: Created slice Slice
/system/systemd-zram-setup.
apr 09 16:19:41 <HOST> systemd[1]: Created slice User and Session Slice.
apr 09 16:19:41 <HOST> systemd[1]: systemd-ask-password-plymouth.path:
Deactivated successfully.
apr 09 16:19:41 <HOST> systemd[1]: Stopped Forward Password Requests
to Plymouth Directory Watch.
apr 09 16:19:41 <HOST> systemd[1]: Started Forward Password Requests
to Wall Directory Watch.
apr 09 16:19:41 <HOST> systemd[1]: Set up automount Arbitrary
Executable File Formats File System Automount Point.
apr 09 16:19:41 <HOST> systemd[1]: Expecting device
/dev/disk/by-uuid/A25D-6277...
apr 09 16:19:41 <HOST> systemd[1]: Expecting device
/dev/disk/by-uuid/<ROOT_UUID>...
apr 09 16:19:41 <HOST> systemd[1]: Expecting device /dev/zram0...
apr 09 16:19:41 <HOST> systemd[1]: Reached target Login Prompts.
apr 09 16:19:41 <HOST> systemd[1]: Reached target Image Downloads.
apr 09 16:19:41 <HOST> systemd[1]: Stopped target Switch Root.
apr 09 16:19:41 <HOST> systemd[1]: Stopped target Initrd File Systems.
apr 09 16:19:41 <HOST> systemd[1]: Stopped target Initrd Root File System.
apr 09 16:19:41 <HOST> systemd[1]: Reached target Local Integrity
Protected Volumes.
apr 09 16:19:41 <HOST> systemd[1]: Reached target Remote File Systems.
apr 09 16:19:41 <HOST> systemd[1]: Reached target Slice Units.
apr 09 16:19:41 <HOST> systemd[1]: Reached target Local Verity
Protected Volumes.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Device-mapper event
daemon FIFOs.
apr 09 16:19:41 <HOST> systemd[1]: Listening on LVM2 poll daemon socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Query the User
Interactively for a Password.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Process Core Dump Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Credential
Encryption/Decryption.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Factory Reset Management.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Console Output Muting
Service Socket.
apr 09 16:19:41 <HOST> systemd[1]: TPM PCR Measurements skipped, unmet
condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: Make TPM PCR Policy skipped, unmet
condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: Listening on Disk Repartitioning
Service Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Resolve Monitor Varlink Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on Resolve Service Varlink Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on udev Control Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on udev Varlink Socket.
apr 09 16:19:41 <HOST> systemd[1]: Listening on User Database Manager Socket.
apr 09 16:19:41 <HOST> systemd[1]: Mounting Huge Pages File System...
apr 09 16:19:41 <HOST> systemd[1]: Mounting POSIX Message Queue File System...
apr 09 16:19:41 <HOST> systemd[1]: Mounting Kernel Debug File System...
apr 09 16:19:41 <HOST> systemd[1]: Mounting Kernel Trace File System...
apr 09 16:19:41 <HOST> systemd[1]: Starting Create List of Static
Device Nodes...
apr 09 16:19:41 <HOST> systemd[1]: Starting Monitoring of LVM2
mirrors, snapshots etc. using dmeventd or progress polling...
apr 09 16:19:41 <HOST> systemd[1]: Load Kernel Module configfs
skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
apr 09 16:19:41 <HOST> systemd[1]: Mounting Kernel Configuration File System...
apr 09 16:19:41 <HOST> systemd[1]: Load Kernel Module drm skipped,
unmet condition check ConditionKernelModuleLoaded=!drm
apr 09 16:19:41 <HOST> systemd[1]: Load Kernel Module fuse skipped,
unmet condition check ConditionKernelModuleLoaded=!fuse
apr 09 16:19:41 <HOST> systemd[1]: Mounting FUSE Control File System...
apr 09 16:19:41 <HOST> systemd[1]: Stopping plymouth-start.service...
apr 09 16:19:41 <HOST> systemd[1]: plymouth-switch-root.service:
Deactivated successfully.
apr 09 16:19:41 <HOST> systemd[1]: Stopped Plymouth switch root service.
apr 09 16:19:41 <HOST> systemd[1]: Clear Stale Hibernate Storage Info
skipped, unmet condition check
ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
apr 09 16:19:41 <HOST> systemd[1]: Starting Journal Service...
apr 09 16:19:41 <HOST> systemd[1]: Starting Load Kernel Modules...
apr 09 16:19:41 <HOST> systemd[1]: TPM PCR Machine ID Measurement
skipped, unmet condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: TPM NvPCR Product ID Measurement
skipped, unmet condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: Starting Remount Root and Kernel
File Systems...
apr 09 16:19:41 <HOST> systemd[1]: Early TPM SRK Setup skipped, unmet
condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: Starting Load udev Rules from Credentials...
apr 09 16:19:41 <HOST> systemd[1]: Starting Coldplug All udev Devices...
apr 09 16:19:41 <HOST> systemd[1]: systemd-vconsole-setup.service:
Deactivated successfully.
apr 09 16:19:41 <HOST> systemd[1]: Stopped Virtual Console Setup.
apr 09 16:19:41 <HOST> systemd[1]: Mounted Huge Pages File System.
apr 09 16:19:41 <HOST> systemd[1]: Mounted POSIX Message Queue File System.
apr 09 16:19:41 <HOST> systemd[1]: Mounted Kernel Debug File System.
apr 09 16:19:41 <HOST> systemd[1]: Mounted Kernel Trace File System.
apr 09 16:19:41 <HOST> systemd[1]: Finished Create List of Static Device Nodes.
apr 09 16:19:41 <HOST> systemd[1]: Mounted Kernel Configuration File System.
apr 09 16:19:41 <HOST> systemd[1]: Mounted FUSE Control File System.
apr 09 16:19:41 <HOST> systemd[1]: Starting Create Static Device Nodes
in /dev gracefully...
apr 09 16:19:41 <HOST> kernel: BTRFS info (device nvme0n1p2 state M):
use zstd compression, level 1
apr 09 16:19:41 <HOST> systemd[1]: Finished Remount Root and Kernel
File Systems.
apr 09 16:19:41 <HOST> systemd[1]: Finished Load udev Rules from Credentials.
apr 09 16:19:41 <HOST> kernel: Asymmetric key parser 'pkcs8' registered
apr 09 16:19:41 <HOST> systemd[1]: Rebuild Hardware Database skipped,
unmet condition check ConditionNeedsUpdate=/etc
apr 09 16:19:41 <HOST> kernel: i2c_dev: i2c /dev entries driver
apr 09 16:19:41 <HOST> systemd[1]: Starting Load/Save OS Random Seed...
apr 09 16:19:41 <HOST> systemd[1]: TPM SRK Setup skipped, unmet
condition check ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: TPM PCR NvPCR Initialization
Separator skipped, unmet condition check
ConditionSecurity=measured-uki
apr 09 16:19:41 <HOST> systemd[1]: Finished Load Kernel Modules.
apr 09 16:19:41 <HOST> systemd-journald[589]: Collecting audit
messages is disabled.
apr 09 16:19:41 <HOST> systemd[1]: Starting Apply Kernel Variables...
apr 09 16:19:41 <HOST> systemd[1]: Started Journal Service.
apr 09 16:19:41 <HOST> kernel: device-mapper: uevent: version 1.0.3
apr 09 16:19:41 <HOST> kernel: device-mapper: ioctl: 4.50.0-ioctl
(2025-04-28) initialised: dm-devel@lists.linux.dev
apr 09 16:19:42 <HOST> kernel: zram0: detected capacity change from 0
to 61145088
apr 09 16:19:42 <HOST> kernel: ccp 0000:c3:00.2: enabling device (0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: ccp 0000:c3:00.2: tee enabled
apr 09 16:19:42 <HOST> kernel: ccp 0000:c3:00.2: psp enabled
apr 09 16:19:42 <HOST> kernel: amdxdna 0000:c4:00.1: enabling device
(0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: ACPI: bus type thunderbolt registered
apr 09 16:19:42 <HOST> kernel: cfg80211: Loading compiled-in X.509
certificates for regulatory database
apr 09 16:19:42 <HOST> kernel: mc: Linux media interface: v0.10
apr 09 16:19:42 <HOST> kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
apr 09 16:19:42 <HOST> kernel: Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
apr 09 16:19:42 <HOST> kernel: ACPI: battery: new hook: Ideapad
Battery Extension
apr 09 16:19:42 <HOST> kernel: input: Ideapad extra buttons as
/devices/pci0000:00/0000:00:14.3/PNP0C09:00/VPC2004:00/input/input15
apr 09 16:19:42 <HOST> kernel: RAPL PMU: API unit is 2^-32 Joules, 2
fixed counters, 163840 ms ovfl timer
apr 09 16:19:42 <HOST> kernel: RAPL PMU: hw unit of domain package 2^-16 Joules
apr 09 16:19:42 <HOST> kernel: RAPL PMU: hw unit of domain core 2^-16 Joules
apr 09 16:19:42 <HOST> kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input16
apr 09 16:19:42 <HOST> kernel: mousedev: PS/2 mouse device common for all mice
apr 09 16:19:42 <HOST> kernel: Bluetooth: Core ver 2.22
apr 09 16:19:42 <HOST> kernel: NET: Registered PF_BLUETOOTH protocol family
apr 09 16:19:42 <HOST> kernel: Bluetooth: HCI device and connection
manager initialized
apr 09 16:19:42 <HOST> kernel: Bluetooth: HCI socket layer initialized
apr 09 16:19:42 <HOST> kernel: Bluetooth: L2CAP socket layer initialized
apr 09 16:19:42 <HOST> kernel: Bluetooth: SCO socket layer initialized
apr 09 16:19:42 <HOST> kernel: input: SYNA2BA6:00 06CB:CF00 Mouse as
/devices/platform/AMDI0010:00/i2c-0/i2c-SYNA2BA6:00/0018:06CB:CF00.0005/input/input17
apr 09 16:19:42 <HOST> kernel: input: SYNA2BA6:00 06CB:CF00 Touchpad
as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA2BA6:00/0018:06CB:CF00.0005/input/input18
apr 09 16:19:42 <HOST> kernel: hid-generic 0018:06CB:CF00.0005:
input,hidraw2: I2C HID v1.00 Mouse [SYNA2BA6:00 06CB:CF00] on
i2c-SYNA2BA6:00
apr 09 16:19:42 <HOST> kernel: hid-generic 0018:048D:8353.0006:
hidraw3: I2C HID v1.00 Device [ITE8353:00 048D:8353] on i2c-ITE8353:00
apr 09 16:19:42 <HOST> kernel: [drm] Initialized amdxdna_accel_driver
0.6.0 for 0000:c4:00.1 on minor 0
apr 09 16:19:42 <HOST> kernel: piix4_smbus 0000:00:14.0: SMBus Host
Controller at 0xb00, revision 0
apr 09 16:19:42 <HOST> kernel: piix4_smbus 0000:00:14.0: Using
register 0x02 for SMBus port selection
apr 09 16:19:42 <HOST> kernel: videodev: Linux video capture interface: v2.00
apr 09 16:19:42 <HOST> kernel: Adding 30572540k swap on /dev/zram0.
Priority:100 extents:1 across:30572540k SSDsc
apr 09 16:19:42 <HOST> kernel: piix4_smbus 0000:00:14.0: Auxiliary
SMBus Host Controller at 0xb20
apr 09 16:19:42 <HOST> kernel: i2c i2c-23: Successfully instantiated SPD at 0x50
apr 09 16:19:42 <HOST> kernel: i2c i2c-23: Successfully instantiated SPD at 0x51
apr 09 16:19:42 <HOST> kernel: i2c i2c-23: Successfully instantiated SPD at 0x52
apr 09 16:19:42 <HOST> kernel: i2c i2c-23: Successfully instantiated SPD at 0x53
apr 09 16:19:42 <HOST> kernel: lenovo_wmi_other
DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-16: bound
7A8F5407-CB67-4D6E-B547-39B3BE018154-10 (ops lwmi_cd01_component_ops
[lenovo_wmi_capdata01])
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: enabling device
(0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: usbcore: registered new interface driver btusb
apr 09 16:19:42 <HOST> kernel: input: gpio-keys as
/devices/platform/ACPI0011:00/gpio-keys.1.auto/input/input20
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Device revision is 0
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Secure boot is enabled
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: OTP lock is enabled
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: API lock is enabled
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Debug lock is disabled
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Minimum firmware build
1 week 10 2014
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Bootloader timestamp
2019.40 buildtype 1 build 38
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: No dsm support to set
reset delay
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: Detected crf-id
0x400410, cnv-id 0x400410 wfpm id 0x80000000
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: PCI dev
2725/0024, rev=0x420, rfid=0x10d000
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: Detected Intel(R)
Wi-Fi 6E AX210 160MHz
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-0041-0041.sfi
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Boot Address: 0x100800
apr 09 16:19:42 <HOST> kernel: Bluetooth: hci0: Firmware Version: 202-5.26
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: loaded firmware
version 89.123cf747.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm
apr 09 16:19:42 <HOST> kernel: snd_acp_pci 0000:c3:00.5: enabling
device (0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: kvm_amd: TSC scaling supported
apr 09 16:19:42 <HOST> kernel: kvm_amd: Nested Virtualization enabled
apr 09 16:19:42 <HOST> kernel: kvm_amd: Nested Paging enabled
apr 09 16:19:42 <HOST> kernel: kvm_amd: LBR virtualization supported
apr 09 16:19:42 <HOST> kernel: kvm_amd: AVIC enabled
apr 09 16:19:42 <HOST> kernel: kvm_amd: x2AVIC enabled (max 512 vCPUs)
apr 09 16:19:42 <HOST> kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
apr 09 16:19:42 <HOST> kernel: kvm_amd: Virtual GIF supported
apr 09 16:19:42 <HOST> kernel: kvm_amd: Virtual NMI enabled
apr 09 16:19:42 <HOST> kernel: uvcvideo 1-1:1.0: Found UVC 1.50 device
Integrated Camera (04f2:b829)
apr 09 16:19:42 <HOST> kernel: hid-sensor-hub 0018:048D:8353.0006:
hidraw3: I2C HID v1.00 Device [ITE8353:00 048D:8353] on i2c-ITE8353:00
apr 09 16:19:42 <HOST> kernel: pps_core: LinuxPPS API ver. 1 registered
apr 09 16:19:42 <HOST> kernel: pps_core: Software ver. 5.3.6 -
Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
apr 09 16:19:42 <HOST> kernel: PTP clock support registered
apr 09 16:19:42 <HOST> kernel: snd_hda_intel 0000:c3:00.1: enabling
device (0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: snd_hda_intel 0000:c3:00.1: Handle
vga_switcheroo audio client
apr 09 16:19:42 <HOST> kernel: snd_hda_intel 0000:c3:00.6: enabling
device (0000 -> 0002)
apr 09 16:19:42 <HOST> kernel: uvcvideo 1-1:1.2: Found UVC 1.50 device
Integrated Camera (04f2:b829)
apr 09 16:19:42 <HOST> kernel: amd-pmf AMDI0107:00: No Smart PC policy present
apr 09 16:19:42 <HOST> kernel: amd-pmf AMDI0107:00: registered PMF
device successfully
apr 09 16:19:42 <HOST> kernel: usbcore: registered new interface driver uvcvideo
apr 09 16:19:42 <HOST> kernel: snd_hda_intel 0000:c3:00.1: bound
0000:c3:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic HDMI/DP,pcm=3
as /devices/pci0000:00/0000:00:08.1/0000:c3:00.1/sound/card0/input21
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic HDMI/DP,pcm=7
as /devices/pci0000:00/0000:00:08.1/0000:c3:00.1/sound/card0/input22
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic HDMI/DP,pcm=8
as /devices/pci0000:00/0000:00:08.1/0000:c3:00.1/sound/card0/input23
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic HDMI/DP,pcm=9
as /devices/pci0000:00/0000:00:08.1/0000:c3:00.1/sound/card0/input24
apr 09 16:19:42 <HOST> kernel: input: SYNA2BA6:00 06CB:CF00 Mouse as
/devices/platform/AMDI0010:00/i2c-0/i2c-SYNA2BA6:00/0018:06CB:CF00.0005/input/input25
apr 09 16:19:42 <HOST> kernel: input: SYNA2BA6:00 06CB:CF00 Touchpad
as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA2BA6:00/0018:06CB:CF00.0005/input/input26
apr 09 16:19:42 <HOST> kernel: hid-multitouch 0018:06CB:CF00.0005:
input,hidraw2: I2C HID v1.00 Mouse [SYNA2BA6:00 06CB:CF00] on
i2c-SYNA2BA6:00
apr 09 16:19:42 <HOST> kernel: amd_atl: AMD Address Translation
Library initialized
apr 09 16:19:42 <HOST> kernel: intel_rapl_common: Found RAPL domain package
apr 09 16:19:42 <HOST> kernel: intel_rapl_common: Found RAPL domain core
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:
ALC287: picked fixup  for PCI SSID 17aa:0000
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:
autoconfig for ALC287: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:
hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:
mono: mono_out=0x0
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:    inputs:
apr 09 16:19:42 <HOST> kernel: snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x19
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:c3:00.6/sound/card1/input28
apr 09 16:19:42 <HOST> kernel: input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:c3:00.6/sound/card1/input29
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: Detected RF GF,
rfid=0x10d000
apr 09 16:19:42 <HOST> kernel: iwlwifi 0000:c1:00.0: base HW address: <WLAN_MAC>
apr 09 16:19:43 <HOST> systemd-journald[589]: Received client request
to flush runtime journal.
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Waiting for firmware
download to complete
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Firmware loaded in 1080100 usecs
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Waiting for device to boot
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Device booted in 27116 usecs
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Found Intel DDC
parameters: intel/ibt-0041-0041.ddc
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Applying Intel DDC
parameters completed
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Firmware timestamp
2026.5 buildtype 1 build 82122
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Firmware SHA1: 0x2925677d
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Fseq status: Success (0x00)
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Fseq executed: 00.00.02.41
apr 09 16:19:43 <HOST> kernel: Bluetooth: hci0: Fseq BT Top: 00.00.02.41
apr 09 16:19:51 <HOST> kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
apr 09 16:19:51 <HOST> kernel: Bluetooth: BNEP filters: protocol multicast
apr 09 16:19:51 <HOST> kernel: Bluetooth: BNEP socket layer initialized
apr 09 16:19:51 <HOST> kernel: Bluetooth: MGMT ver 1.23
apr 09 16:19:51 <HOST> kernel: NET: Registered PF_ALG protocol family
apr 09 16:19:51 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:19:51 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:19:51 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:19:51 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:19:52 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:19:52 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:19:52 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:19:52 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:19:52 <HOST> kernel: Bluetooth: RFCOMM TTY layer initialized
apr 09 16:19:52 <HOST> kernel: Bluetooth: RFCOMM socket layer initialized
apr 09 16:19:52 <HOST> kernel: Bluetooth: RFCOMM ver 1.11
apr 09 16:19:53 <HOST> kernel: wlan0: authenticate with <AP_BSSID>
(local address=<WLAN_MAC>)
apr 09 16:19:53 <HOST> kernel: wlan0: send auth to <AP_BSSID> (try 1/3)
apr 09 16:19:53 <HOST> kernel: wlan0: authenticated
apr 09 16:19:53 <HOST> kernel: wlan0: associate with <AP_BSSID> (try 1/3)
apr 09 16:19:53 <HOST> kernel: wlan0: RX AssocResp from <AP_BSSID>
(capab=0x1011 status=0 aid=16)
apr 09 16:19:53 <HOST> kernel: wlan0: associated
apr 09 16:19:53 <HOST> kernel: wlan0: Limiting TX power to 30 (30 - 0)
dBm as advertised by <AP_BSSID>
apr 09 16:19:53 <HOST> systemd-journald[589]: Time jumped backwards, rotating.
apr 09 16:19:57 <HOST> kernel: ntfs3: Enabled Linux POSIX ACLs support
apr 09 16:19:57 <HOST> kernel: ntfs3: Read-only LZX/Xpress compression included
apr 09 16:19:57 <HOST> kernel: nvme nvme0: using unchecked data buffer
apr 09 16:19:57 <HOST> kernel: block nvme0n1: No UUID available
providing old NGUID
apr 09 16:19:58 <HOST> kernel: logitech-hidpp-device
0003:046D:404A.0004: HID++ 4.5 device connected.
apr 09 16:19:59 <HOST> kernel: warning: `kdeconnectd' uses wireless
extensions which will stop working for Wi-Fi 7 hardware; use nl80211
apr 09 16:19:59 <HOST> kernel: ideapad_acpi VPC2004:00:
conservation_mode attribute has been deprecated, see charge_types.
apr 09 16:23:09 <HOST> kernel: wlan0: deauthenticating from <AP_BSSID>
by local choice (Reason: 3=DEAUTH_LEAVING)
apr 09 16:23:10 <HOST> kernel: PM: suspend entry (s2idle)
apr 09 16:23:10 <HOST> kernel: Filesystems sync: 0.011 seconds
apr 09 16:23:37 <HOST> kernel: Freezing user space processes
apr 09 16:23:37 <HOST> kernel: Freezing user space processes completed
(elapsed 0.001 seconds)
apr 09 16:23:37 <HOST> kernel: OOM killer disabled.
apr 09 16:23:37 <HOST> kernel: Freezing remaining freezable tasks
apr 09 16:23:37 <HOST> kernel: Freezing remaining freezable tasks
completed (elapsed 0.001 seconds)
apr 09 16:23:37 <HOST> kernel: printk: Suspending console(s) (use
no_console_suspend to debug)
apr 09 16:23:37 <HOST> kernel: ACPI: EC: interrupt blocked
apr 09 16:23:37 <HOST> kernel: ACPI: EC: interrupt unblocked
apr 09 16:23:37 <HOST> kernel: [drm] PCIE GART of 512M enabled (table
at 0x000000807FB00000).
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is resuming...
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is
resumed successfully!
apr 09 16:23:37 <HOST> kernel: nvme nvme1: 16/0/0 default/read/poll queues
apr 09 16:23:37 <HOST> kernel: nvme nvme0: 16/0/0 default/read/poll queues
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
gfx_0.0.0 uses VM inv eng 0 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 6 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 7 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 8 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 9 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 10 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 11 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring sdma0
uses VM inv eng 12 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
vcn_unified_0 uses VM inv eng 0 on hub 8
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
jpeg_dec_0 uses VM inv eng 1 on hub 8
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
apr 09 16:23:37 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring vpe
uses VM inv eng 4 on hub 8
apr 09 16:23:37 <HOST> kernel: OOM killer enabled.
apr 09 16:23:37 <HOST> kernel: Restarting tasks: Starting
apr 09 16:23:37 <HOST> kernel: Restarting tasks: Done
apr 09 16:23:37 <HOST> kernel: efivarfs: resyncing variable state
apr 09 16:23:37 <HOST> kernel: efivarfs: finished resyncing variable state
apr 09 16:23:37 <HOST> kernel: random: crng reseeded on system resumption
apr 09 16:23:37 <HOST> kernel: PM: suspend exit
apr 09 16:23:37 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:23:37 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:23:37 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:23:37 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:23:39 <HOST> kernel: wlan0: authenticate with <AP_BSSID>
(local address=<WLAN_MAC>)
apr 09 16:23:39 <HOST> kernel: wlan0: send auth to <AP_BSSID> (try 1/3)
apr 09 16:23:39 <HOST> kernel: wlan0: authenticated
apr 09 16:23:39 <HOST> kernel: wlan0: associate with <AP_BSSID> (try 1/3)
apr 09 16:23:39 <HOST> kernel: wlan0: RX AssocResp from <AP_BSSID>
(capab=0x1011 status=0 aid=8)
apr 09 16:23:39 <HOST> kernel: wlan0: associated
apr 09 16:23:39 <HOST> kernel: wlan0: Limiting TX power to 30 (30 - 0)
dBm as advertised by <AP_BSSID>
apr 09 16:24:09 <HOST> kernel: wlan0: deauthenticating from <AP_BSSID>
by local choice (Reason: 3=DEAUTH_LEAVING)
apr 09 16:24:10 <HOST> kernel: PM: suspend entry (s2idle)
apr 09 16:24:10 <HOST> kernel: Filesystems sync: 0.013 seconds
apr 09 16:24:14 <HOST> kernel: Freezing user space processes
apr 09 16:24:14 <HOST> kernel: Freezing user space processes completed
(elapsed 0.001 seconds)
apr 09 16:24:14 <HOST> kernel: OOM killer disabled.
apr 09 16:24:14 <HOST> kernel: Freezing remaining freezable tasks
apr 09 16:24:14 <HOST> kernel: Freezing remaining freezable tasks
completed (elapsed 0.000 seconds)
apr 09 16:24:14 <HOST> kernel: printk: Suspending console(s) (use
no_console_suspend to debug)
apr 09 16:24:14 <HOST> kernel: ACPI: EC: interrupt blocked
apr 09 16:24:14 <HOST> kernel: ACPI: EC: interrupt unblocked
apr 09 16:24:14 <HOST> kernel: [drm] PCIE GART of 512M enabled (table
at 0x000000807FB00000).
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is resuming...
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is
resumed successfully!
apr 09 16:24:14 <HOST> kernel: nvme nvme1: 16/0/0 default/read/poll queues
apr 09 16:24:14 <HOST> kernel: nvme nvme0: 16/0/0 default/read/poll queues
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
gfx_0.0.0 uses VM inv eng 0 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 6 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 7 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 8 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 9 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 10 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 11 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring sdma0
uses VM inv eng 12 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
vcn_unified_0 uses VM inv eng 0 on hub 8
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
jpeg_dec_0 uses VM inv eng 1 on hub 8
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
apr 09 16:24:14 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring vpe
uses VM inv eng 4 on hub 8
apr 09 16:24:14 <HOST> kernel: OOM killer enabled.
apr 09 16:24:14 <HOST> kernel: Restarting tasks: Starting
apr 09 16:24:14 <HOST> kernel: Restarting tasks: Done
apr 09 16:24:14 <HOST> kernel: efivarfs: resyncing variable state
apr 09 16:24:14 <HOST> kernel: efivarfs: finished resyncing variable state
apr 09 16:24:14 <HOST> kernel: random: crng reseeded on system resumption
apr 09 16:24:14 <HOST> kernel: PM: suspend exit
apr 09 16:24:14 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:24:14 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:24:14 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:24:14 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:24:16 <HOST> kernel: wlan0: authenticate with <AP_BSSID>
(local address=<WLAN_MAC>)
apr 09 16:24:16 <HOST> kernel: wlan0: send auth to <AP_BSSID> (try 1/3)
apr 09 16:24:16 <HOST> kernel: wlan0: authenticated
apr 09 16:24:16 <HOST> kernel: wlan0: associate with <AP_BSSID> (try 1/3)
apr 09 16:24:16 <HOST> kernel: wlan0: RX AssocResp from <AP_BSSID>
(capab=0x1011 status=0 aid=9)
apr 09 16:24:16 <HOST> kernel: wlan0: associated
apr 09 16:24:16 <HOST> kernel: wlan0: Limiting TX power to 30 (30 - 0)
dBm as advertised by <AP_BSSID>
apr 09 16:24:33 <HOST> kernel: wlan0: deauthenticating from <AP_BSSID>
by local choice (Reason: 3=DEAUTH_LEAVING)
apr 09 16:24:34 <HOST> kernel: PM: suspend entry (s2idle)
apr 09 16:24:34 <HOST> kernel: Filesystems sync: 0.019 seconds
apr 09 16:24:54 <HOST> kernel: Freezing user space processes
apr 09 16:24:54 <HOST> kernel: Freezing user space processes completed
(elapsed 0.001 seconds)
apr 09 16:24:54 <HOST> kernel: OOM killer disabled.
apr 09 16:24:54 <HOST> kernel: Freezing remaining freezable tasks
apr 09 16:24:54 <HOST> kernel: Freezing remaining freezable tasks
completed (elapsed 0.001 seconds)
apr 09 16:24:54 <HOST> kernel: printk: Suspending console(s) (use
no_console_suspend to debug)
apr 09 16:24:54 <HOST> kernel: ACPI: EC: interrupt blocked
apr 09 16:24:54 <HOST> kernel: ACPI: EC: interrupt unblocked
apr 09 16:24:54 <HOST> kernel: pcieport 0000:00:02.1: broken device,
retraining non-functional downstream link at 2.5GT/s
apr 09 16:24:54 <HOST> kernel: pcieport 0000:00:02.1: retraining failed
apr 09 16:24:54 <HOST> kernel: pcieport 0000:00:02.1: Data Link Layer
Link Active not set in 100 msec
apr 09 16:24:54 <HOST> kernel: nvme nvme1: Disabling device after
reset failure: -19
apr 09 16:24:54 <HOST> kernel: [drm] PCIE GART of 512M enabled (table
at 0x000000807FB00000).
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is resuming...
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: SMU is
resumed successfully!
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
gfx_0.0.0 uses VM inv eng 0 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 6 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 7 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 8 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 9 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 10 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 11 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring sdma0
uses VM inv eng 12 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
vcn_unified_0 uses VM inv eng 0 on hub 8
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
jpeg_dec_0 uses VM inv eng 1 on hub 8
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring
mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
apr 09 16:24:54 <HOST> kernel: amdgpu 0000:c3:00.0: amdgpu: ring vpe
uses VM inv eng 4 on hub 8
apr 09 16:24:54 <HOST> kernel: OOM killer enabled.
apr 09 16:24:54 <HOST> kernel: Restarting tasks: Starting
apr 09 16:24:54 <HOST> kernel: Restarting tasks: Done
apr 09 16:24:54 <HOST> kernel: efivarfs: resyncing variable state
apr 09 16:24:54 <HOST> kernel: efivarfs: finished resyncing variable state
apr 09 16:24:54 <HOST> kernel: random: crng reseeded on system resumption
apr 09 16:24:54 <HOST> kernel: PM: suspend exit
apr 09 16:24:54 <HOST> kernel: nvme nvme0: 16/0/0 default/read/poll queues
apr 09 16:24:55 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_UMAC_PD_NOTIFICATION: 0x20
apr 09 16:24:55 <HOST> kernel: iwlwifi 0000:c1:00.0:
WFPM_LMAC2_PD_NOTIFICATION: 0x1f
apr 09 16:24:55 <HOST> kernel: iwlwifi 0000:c1:00.0: WFPM_AUTH_KEY_0: 0x90
apr 09 16:24:55 <HOST> kernel: iwlwifi 0000:c1:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
apr 09 16:24:56 <HOST> kernel: wlan0: authenticate with <AP_BSSID>
(local address=<WLAN_MAC>)
apr 09 16:24:56 <HOST> kernel: wlan0: send auth to <AP_BSSID> (try 1/3)
apr 09 16:24:56 <HOST> kernel: wlan0: authenticated
apr 09 16:24:56 <HOST> kernel: wlan0: associate with <AP_BSSID> (try 1/3)
apr 09 16:24:56 <HOST> kernel: wlan0: RX AssocResp from <AP_BSSID>
(capab=0x1011 status=0 aid=11)
apr 09 16:24:56 <HOST> kernel: wlan0: associated
apr 09 16:24:56 <HOST> kernel: wlan0: Limiting TX power to 30 (30 - 0)
dBm as advertised by <AP_BSSID>
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10b000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10b000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10b000
apr 09 16:25:04 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:26 <HOST> kernel: ntfs3: 107 callbacks suppressed
apr 09 16:25:26 <HOST> kernel: ntfs3(nvme1n1p5): failed to read volume
at offset 0x10c000
apr 09 16:25:40 <HOST> kernel: nvme nvme1: Identify namespace failed (-5)


===== sysfs_bridge_power =====

### COMMAND: sh -c for\ f\ in\
/sys/bus/pci/devices/0000:00:02.1/power_state\
/sys/bus/pci/devices/0000:00:02.1/power/runtime_status\
/sys/bus/pci/devices/0000:00:02.1/d3cold_allowed\
/sys/bus/pci/devices/0000:00:02.1/power/control\;\ do\ echo\ \"##\
\$f\"\;\ cat\ \"\$f\"\;\ echo\;\ done

## /sys/bus/pci/devices/0000:00:02.1/power_state
D0

## /sys/bus/pci/devices/0000:00:02.1/power/runtime_status
active

## /sys/bus/pci/devices/0000:00:02.1/d3cold_allowed
1

## /sys/bus/pci/devices/0000:00:02.1/power/control
auto



===== sysfs_wd_power =====

### COMMAND: sh -c for\ f\ in\
/sys/bus/pci/devices/0000:bf:00.0/power_state\
/sys/bus/pci/devices/0000:bf:00.0/power/runtime_status\
/sys/bus/pci/devices/0000:bf:00.0/d3cold_allowed\
/sys/bus/pci/devices/0000:bf:00.0/power/control\;\ do\ echo\ \"##\
\$f\"\;\ cat\ \"\$f\"\;\ echo\;\ done

## /sys/bus/pci/devices/0000:bf:00.0/power_state
D3cold

## /sys/bus/pci/devices/0000:bf:00.0/power/runtime_status
active

## /sys/bus/pci/devices/0000:bf:00.0/d3cold_allowed
1

## /sys/bus/pci/devices/0000:bf:00.0/power/control
on



===== dmidecode_system =====

### COMMAND: sudo dmidecode -t system -t bios

# dmidecode 3.7
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0000, DMI type 0, 26 bytes
Platform Firmware Information
    Vendor: LENOVO
    Version: QKCN29WW
    Release Date: 12/23/2025
    ROM Size: 32 MiB
    Characteristics:
        PCI is supported
        PNP is supported
        Firmware is upgradeable
        Firmware shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        EDD is supported
        ACPI is supported
        USB legacy is supported
        BIOS boot specification is supported
        Function key-initiated network boot is supported
        Targeted content distribution is supported
        UEFI is supported
    Platform Firmware Revision: 1.29
    Embedded Controller Firmware Revision: 1.29

Handle 0x0001, DMI type 1, 27 bytes
System Information
    Manufacturer: LENOVO
    Product Name: 83JL
    Version: IdeaPad Pro 5 14AKP10
    Serial Number: <SYSTEM_SERIAL>
    UUID: <DMI_UUID>
    Wake-up Type: Power Switch
    SKU Number: LENOVO_MT_83JL_BU_idea_FM_IdeaPad Pro 5 14AKP10
    Family: IdeaPad Pro 5 14AKP10

Handle 0x001B, DMI type 12, 5 bytes
System Configuration Options
    Option 1: String1 for Type12 Equipment Manufacturer
    Option 2: String2 for Type12 Equipment Manufacturer
    Option 3: String3 for Type12 Equipment Manufacturer
    Option 4: String4 for Type12 Equipment Manufacturer

Handle 0x001C, DMI type 13, 22 bytes
Firmware Language Information
    Language Description Format: Long
    Installable Languages: 4
        en|US|iso8859-1
        fr|FR|iso8859-1
        ja|JP|unicode
        zh|TW|unicode
    Currently Installed Language: en|US|iso8859-1

Handle 0x0030, DMI type 32, 11 bytes
System Boot Information
    Status: No errors detected





Il giorno gio 9 apr 2026 alle ore 21:05 Bjorn Helgaas
<helgaas@kernel.org> ha scritto:
> Providing the complete logs with private information redacted would be
> a good first step.
