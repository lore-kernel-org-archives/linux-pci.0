Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9033A701
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575712; cv=none; b=qkJbEHVw59vFWhpVcLHhFMWfszHv5n5Lu+HWnCdLQk3xKGb8m4qNY3kO3ZUHmir9k+6ZGgrWx5TlC07WHRzjhMI1EdJmz09YNLkCwWGRTAGatnX3iF9g9E/48Vb30ue2HxufHjGq6NtK1W9JeJIOSz9FlFU823Rjkb9Fq1lZ+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575712; c=relaxed/simple;
	bh=bcZKlzzXwwY0EJtmDoUOqgBEwQ5NCQTilsLXeIa/wss=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=OLYzk4BklbiqjiqtDpKRRxcyUYP0Vp65e6CcqA/ASR29yj3pkwCRDV+/0gSs935CU07DZbcmCjf94N9vWDnR0rJh+7cuH7+N/yT05sMOijXH5HK9IcxUrqIaK2sWliyzqJrG2+zr67VVXWWsQTU2kT7M+mr6H46BbNOqePfv5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ti6TGw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ti6TGw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so43323945e9.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773575708; x=1774180508; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDKnJT0wYCQGOysz22h2bC3jeqtbf0HHcGTBrmEn6hA=;
        b=T5ti6TGwXmE0br6mUCi0AQzzW4rR97FKomaAbVRY7LXeHGN7/FJd/qz6QIc9WSV43t
         W+uLyzV4OQTUDPFqw0miRAZPMjEaUBHpfrJLKew7Xq7bCJbxG5L687SC/gg9+nVWW/Tc
         5sCCP0g1NBZ9DPXL9XVtlmnRcvEpQB+ym2KbEQ1quycOxztnZrJHXNhNnFuAq+uNpWed
         KPnuKq5B1kzzcdwcDgm62xEWdFEt8HzmbLCVHCjB7lwiN5yDnijyhLon+bj6aoyH6xfJ
         oZun+wWwmN2NJzg7qgfV1FrVbYwG4IbjldzjMNpgWpe+nxWlNaR2ukrGjxz6cPKUBHOK
         481Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575708; x=1774180508;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDKnJT0wYCQGOysz22h2bC3jeqtbf0HHcGTBrmEn6hA=;
        b=lCci9I5AAgAvpVFNMq4AkYs2/CdB1SlyckTLEDGdPkLDPpmS2h2Rw3FIA9YHHP6/x9
         Bz5NMO4AdYxgQPzrjAOlQNkT+svZrb2XBFsPzRpaTCY9jZtWNPNJH3pL97LQZ0JLVtkR
         60yRwzhaKZ95cIvwpxfbK6SZZtrplrDedIHpJVt6rhoBlyarf+aNY7fpFQ33YJkO3dsk
         Tx4XdgLNebiw57tZO/Gttnh/uG7liSQk1rCJ1K7oDIu3G1+afjGN1a/IEcb0A7faH0Zv
         7iCQ0oSi5C0B6P8zKP11EvHLwxtMVMYw/I1Y8JfyaROEH5SXUM6i6JEOMALlfBSJbOOJ
         txMw==
X-Gm-Message-State: AOJu0Yxd0BqiuMf3sJbTtlnrkbad4HlmGfI6qJulXQGKDOsDQCI7dTcM
	eIpWxkddntCarRKiodBDVdNlsJg63rrP+wWl2MvfU9QuKfkBVzjxQi4Y7s3oOANc
X-Gm-Gg: ATEYQzz0gwPRxjIerx/886SREZTtTgyPxwhNXacCOkSTiIGmZ2J0u38naswsTHXAqti
	GpMkCvM15DJykOnXAly0Dgmq8ttUy/z5cAgPJ1k/t6Sb5LmZ1ucCjjECHH5Y4u8EHiAF+keAQlT
	kUX/L7frsPrXR6NkY7/IJxAnrerjIziZK4O1kAR/6e6R/uMazk7/zws6bZs2gTQ+Qw85ze+3FJF
	H+3IWJy4Zr9w67jwiY3VUhe180wVoIfHa3TUwiywOulJQkMxL6QFsPZrR3DQUq1/zlzqQ+S0C50
	lQyEK76kP+HO0TKd2gK4+cv9YW4eixdPBsI9MYgtGJS/nLIff+a49Ys2tMkdE71lLog+XLBApzS
	DqrL1/ke1vm2hvVfmr56NAN/iyRkOd8rbKTw2766Qo8pt8+irnWjBMNGM6jY1UrN2jTv7yMpOQQ
	o63L6fpv2hyTlWzsaE3MzbxwqUvsE8PcPwugZi7vZkM+re/zb9tFoVj67IAREl1H+WsoUR/PkA5
	tYWB17gJS6S4qPVqy5UwfBplcThLKUlL2lyo0US1XcsxktI6q874HkUtHjESfvJHYo=
X-Received: by 2002:a05:600d:4453:20b0:477:a54a:acba with SMTP id 5b1f17b1804b1-485567031a2mr113887695e9.17.1773575708139;
        Sun, 15 Mar 2026 04:55:08 -0700 (PDT)
Received: from smtpclient.apple (dynamic-2a00-1028-83a2-5386-5c13-9ccd-a54b-eed2.ipv6.o2.cz. [2a00:1028:83a2:5386:5c13:9ccd:a54b:eed2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm401505415e9.15.2026.03.15.04.55.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 04:55:07 -0700 (PDT)
From: =?utf-8?Q?Michal_Babi=C4=8Dka?= <michal.babka@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window /
 BAR allocation failure prevents NVIDIA and AMD GPUs from initializing 
Message-Id: <FCEB17D3-3DC5-49C8-8C56-8051C875E2F9@gmail.com>
Date: Sun, 15 Mar 2026 12:54:56 +0100
Cc: linux-usb@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
To: linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3864.400.21)

Subject: Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window / =
BAR allocation failure prevents NVIDIA and AMD GPUs from initializing

Hardware / platform:
- Host: Apple Mac mini 2018
- Connection: Thunderbolt 3
- eGPU enclosure: Razer Core X Chroma
- Tested GPUs:
  - NVIDIA Quadro P400
  - NVIDIA Quadro P4000
  - AMD Radeon Vega 64

Linux distributions / kernels tested:
- Ubuntu-based systems
- Zorin OS 18 Pro
- Multiple kernels tested, including 6.12.x and 6.17.x

Problem summary:
On Apple Mac mini 2018, an external GPU connected through Thunderbolt 3 =
in a Razer Core X Chroma enclosure is detected and enumerates on the PCI =
bus, but GPU initialization fails because PCI bridge windows / BAR =
resources are not assigned correctly.

This is reproducible across different Linux installations and with GPUs =
from different vendors, which strongly suggests a =
platform/topology-level PCIe resource allocation problem rather than a =
bug in one specific GPU driver.

Observed behavior:
- The Thunderbolt enclosure is detected correctly.
- boltctl shows the enclosure as connected / authorized.
- The GPU appears in lspci.
- The kernel loads the vendor driver module.
- GPU initialization then fails.

For NVIDIA, nvidia-smi reports:
  "NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA =
driver."

Relevant NVIDIA kernel messages include:
- "BAR 1 [mem size 0x10000000 64bit pref]: can't assign; no space"
- "BAR 3 [mem size 0x02000000 64bit pref]: can't assign; no space"
- "This PCI I/O region assigned to your NVIDIA device is invalid"
- "BAR1 is 0M @ 0x0"
- "RmInitAdapter failed"
- in some attempts also:
  "fallen off the bus and is not responding to commands"

With NVIDIA Quadro P4000, the same general failure pattern was observed:
- the GPU is detected on the PCI bus,
- the NVIDIA kernel module loads,
- initialization fails,
- and the logs again point to invalid / missing BAR assignments and =
resource allocation problems behind the Thunderbolt PCIe bridge =
hierarchy.

For nouveau, the failure is visible as BAR/resource allocation failure =
as well, for example:
- "bar: one-time init failed, -12"
- "init failed with -12"
- "Device allocation failed: -12"

With AMD Radeon Vega 64 installed in the same enclosure on the same =
host, the same fundamental problem occurs:
- the enclosure is detected,
- the GPU enumerates,
- initialization fails,
- and the overall behavior indicates the same lower-level PCI resource / =
bridge window allocation issue.

This strongly suggests the issue is not NVIDIA-specific.

Thunderbolt state:
boltctl reports the Razer Core X Chroma enclosure as =
connected/authorized correctly, for example:
- type: peripheral
- generation: Thunderbolt 3
- status: authorized
- rx speed: 40 Gb/s
- tx speed: 40 Gb/s

Important conclusion:
Thunderbolt authorization itself appears to work.
PCI enumeration also works.
The failure happens later, at PCI resource assignment / bridge window =
sizing / BAR allocation time.

Key dmesg patterns observed:
- multiple "can't assign; no space" messages for PCI bridges and BARs
- BAR1 / BAR3 of the GPU not assigned
- bridge windows under the Thunderbolt hierarchy not large enough
- reassignment attempts that still leave required windows unassigned or =
invalid
- vendor driver subsequently failing device initialization

Examples of affected topology in logs:
- 0000:00:01.1
- 0000:05:00.0
- 0000:06:01.0
- 0000:0b:00.0
- in other boots, the same problem may appear under a different BDF =
address after Thunderbolt re-enumeration

Representative log excerpts:
- pci 0000:0b:00.0: BAR 1 [mem size 0x10000000 64bit pref]: can't =
assign; no space
- pci 0000:0b:00.0: BAR 3 [mem size 0x02000000 64bit pref]: can't =
assign; no space
- pci 0000:06:01.0: bridge window [mem size 0x10000000]: can't assign; =
no space
- pci 0000:05:00.0: bridge window [mem size 0x20200000]: can't assign; =
no space
- NVRM: BAR1 is 0M @ 0x0
- NVRM: RmInitAdapter failed
- NVRM: The NVIDIA GPU ... has fallen off the bus and is not responding =
to commands
- nouveau ... Device allocation failed: -12

Kernel command line options already tested:
The following boot parameters were tested in various combinations:
- pci=3Drealloc=3Don
- pci=3Dhpbussize=3D0x33,hpmemsize=3D256M,hpiosize=3D2M
- pcie_aspm=3Doff
- pci=3Dnommconf
- pci=3Dnoaer

These mitigations did not resolve the issue.

Why this looks platform/topology specific:
- The same Thunderbolt eGPU enclosure is recognized correctly.
- The same failure pattern appears with NVIDIA Quadro P400, NVIDIA =
Quadro P4000, and AMD Radeon Vega 64.
- The common denominator is Apple Mac mini 2018 + Thunderbolt PCIe =
topology under Linux.
- The failure mode is centered around PCI bridge window sizing / BAR =
placement, not around one vendor-specific driver alone.

Expected behavior:
The Thunderbolt eGPU should receive valid PCI bridge windows and valid =
BAR assignments so that the GPU driver can initialize the device =
successfully.

Actual behavior:
The GPU is visible on the bus, but bridge windows and BAR resources are =
not fully assigned, which leaves the device unusable and prevents the =
driver from completing initialization.

Request:
Please investigate PCI resource allocation / bridge window sizing for =
Thunderbolt eGPU topologies on Apple Mac mini 2018 under Linux, =
especially where large GPU BARs must be assigned behind multiple =
Thunderbolt / PCIe bridges.

Cross-vendor reproducibility on the same enclosure and same host =
strongly suggests that the root cause is in PCIe/Thunderbolt resource =
allocation on this platform rather than in a specific NVIDIA or AMD =
driver.=
