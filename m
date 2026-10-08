Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29B34389F
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485744; cv=none; b=ULZFFhOXu6rc5pNLxBG9acrbcdY+HqJRJsH65mljiWUZWT2UZ3XsKGWjTRLiihl13EsKGW7remLSp+hf5yvL+Xw2lVYXi6j+IWFZ/ovTMfHVNE3a5hk5BuPlz/9QzM1OR3GOCpYoIrOtJt1IhVjOBuYk4Nc1EiCiXzOIUw1AvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485744; c=relaxed/simple;
	bh=XaKILT6Vr7oFqSK4R19NK4yKIDRq3YvQPZPHbq9dhzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eej+ww222tOkMd3QGRBdNYSUaSSqotjxsEt0XM925loJ4G2NyZt78EmjqWqT3y+I+T/hSUPfr3yBJI4SrCLin/T8J7YMIgLlgnNzrV3L6J8xZgaZyPP52wCY6Jlfn/j7Y0fTuYJM+bSLNmncRyiTsHoBIyqumur4vD/8rktR3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co; spf=pass smtp.mailfrom=rrell.co; dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b=ATHk4AKr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rrell.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b="ATHk4AKr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e4af975346so32466515ad.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rrell.co; s=google; t=1791485742; x=1792090542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zHHbEd808Ojq1nUxykV5iGDQiC7t8SMz3dvPEQojHXU=;
        b=ATHk4AKrBHceYXhtFL0WLQPsFSIVVvQa0cisfPsK9NuPx/Tcn2TT1ZUBe1eMh9knUL
         nuGPpGlDSS22gAqLibGFISSDiWJE3vSWw4VigW+dX/AT9D5mFGMTAEOSyMQvcniqutFV
         b4JbMTxEnXb4xR7jtuW9dhEbhO54xwo7bbCOqEjBMOdrSQlV0KujCnWbSf3+tRuHxyDx
         2X7wCx5VyIIeAxY4l8CX4tEiSEXaGsBlaGRQDqyt90PN5N9dtNKEo56AuXVz+uMofOxH
         QdVyOwR1s1Ar0zlRXe6cpqkOzt7v/WKeCYXm6eLO2Yx916U0YC0dsQ8eKGYDSbfcbKIc
         9RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791485742; x=1792090542;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHHbEd808Ojq1nUxykV5iGDQiC7t8SMz3dvPEQojHXU=;
        b=JOXUmOb17kpKsp+B+YqQCp0Y1aM1VZr2U9KV2R6z5/PXQkF58TPNl3Of6JoaSnnIDn
         YGGTv5H6ssGvL0kjFjazfbzUPtdIizf5J4VHJH385zkCY1EwE/bSrPWMaP5Y83kN8qIO
         H2RQXmi22FJMEmajMnpOaTjVO/DZvM7mbduvHKxTWH9Fy5KRRs0Q5UllV6R2sv61isUx
         fB0FB/2A8sV0sNrBOAw8oGR/MDQWcYmHtaIWtzAaNgaypb9nIHB1AqPo/gH6mw3DUiJ/
         FEi/fjZ1hoAzpwtE5uS9+5mrkfhFsC8WWYJTsTqJWweuaujvuyeiS326ODEuT0oYpoIi
         KlsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpnPzpYVR8fHBm5UFx3kzvjwpmgTxQ0wyZWxfwjbA7EygiYmxF0mbHz6gODIOntVRejMetworUS9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIacn+JY75hh5Ul3p0615PhNgVNCP05n8XeU7r2jbXOKpx673/z
	QSkdOGmXD+Ie5lasfI8cKZLRzk94bei/DRO180XGvprThMDons9zaBwL/nLQo5YzTcc=
X-Gm-Gg: AYBFou2lDhBUh8+ecshOJyikTFrC7bREpHuNDJwIechUP1C/shZ5iZCWuh3HWKkT0Ou
	9a1BSlhuOs7UIiU3hjDf24RZ57SfAglPPKH5k6f+w4kTm8gXNMY0v1eAtwVsMMslXLzoK0jdb9/
	oExaec/FvgSQ6iDW9Pjyr/esDutmzoDvmUQbQWfY9m8wEc9QYX0gsUjis5JIR9lXsu34ouxzJxS
	FfHXUHZFjU25h0Qh1SVoxh54wRpV/lq6Jnim3cHPxGQdoeojgoLvSPFAPe1KbybTIufb0jydS8q
	IEQadigrZFjMFr532SUUIVmf6Ha14cL28LcKDgELCopUPgELxmOprAivyKuykuOwvfrR3URaiEd
	aMkEiK5WbZ7RhBm9ihVtH+mcfgVSebUMV/oEJErE7JxbCd0eh3WerAGN7duqgrsgDoP4k3yKE2s
	u01f1sTdmbDOpJ3GHg95Wn7takCSgmneehV0nHfAPbSDx8vhwbljQrkvSYKXSTjmVfDvmum6NkF
	Yre7g==
X-Received: by 2002:a17:903:acc:b0:2df:9a29:aeb2 with SMTP id d9443c01a7336-2e5ffa16178mr54303495ad.3.1791485742089;
        Thu, 08 Oct 2026 11:55:42 -0700 (PDT)
Received: from omarchy.tailc658b0.ts.net ([172.92.210.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e83cced75dsm658205ad.43.2026.10.08.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:55:41 -0700 (PDT)
From: Darrell Gum <d@rrell.co>
To: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI/PM: Do not save the config space of an inaccessible device
Date: Thu,  8 Oct 2026 11:55:09 -0700
Message-ID: <20261008185537.84917-1-d@rrell.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
References: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 11:19:11 -0300, Francisco Beltrán Millalén wrote:
> When a PCI device becomes inaccessible while the system is suspending,
[...]

Hi Francisco,

I tested this series on another MacBookPro14,3, together with your
Alpine Ridge SXFP quirk and the Apple native PME patch. On this
machine the combination takes S3 from never resuming to working, and
it fixes USB-C hotplug while the Thunderbolt xHCIs are
runtime-suspended.

Hardware: MacBookPro14,3 (15", 2017, T1), two Alpine Ridge 4C
controllers:

  upstream bridges    8086:1578   04:00.0, 7a:00.0
  downstream bridges  8086:15d3
  NHI                 8086:15d2   06:00.0, 7c:00.0
  xHCI                8086:15d4   07:00.0, 7d:00.0

The dGPU is a Radeon Pro 555 (1002:67ef, subsystem 106b:017a rev c7).

Kernel: 7.2.5 with the Omarchy distro patches (linux-omarchy
7.2.5-3), plus these, in this order:

  e18d1abc3bff ("PCI: Avoid saving config space state if inaccessible")
  this series, v2 1/3-3/3
  PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
  ACPI: PCI: take native PME control on Apple machines
  a5be7ad8f5f0 + a22e5e4f2ebb (amdgpu VI reset quirk, incl. 017a)

Everything applied with offsets only (no fuzz) on 7.2.5.
mem_sleep=deep, stock command line.

I applied and tested all of these together. I did not bisect them,
so beyond what the logs show directly I can't pin a result on one
patch.

Before (stock 7.2.5-3 on the same machine):

- pm_test=platform hard-hung 3 out of 3 times. That includes a fresh
  boot and runs with brcmfmac unloaded, and it did not recover after
  more than 3.5 minutes. pm_test=devices passed.
- Real S3 never resumed. Every attempt needed a forced power-off.
- With both TB xHCIs runtime-suspended (power/control=auto), plugging
  a USB 3 stick into any USB-C port produced no kernel messages at
  all. With power/control=on, it enumerated at SuperSpeed right away.

After (patched kernel):

- _OSC now reads "OS assumes control of [PCIeHotplug SHPCHotplug PME
  AER PCIeCapability LTR DPC]". PME is missing from that line on the
  stock kernel.
- Hotplug: with both xHCIs runtime-suspended, the same stick
  enumerated at SuperSpeed within about 1 s. 7d:00.0 resumed on its
  own and 07:00.0 stayed suspended. Nothing was forced.
- pm_test=platform passes. "quirk: cutting power to Thunderbolt
  controller..." is logged for both 04:00.0 and 7a:00.0.
- Real S3: every attempt resumed. That was about half a dozen real
  S3 cycles over one morning: rtcwake on AC, plus lid-close suspends
  on battery. amdgpu resumed in 1.2 s.
- With a device attached (lid-close S3 on battery, about 1 min
  asleep): a USB 3 stick was enumerated at SuperSpeed on 7d:00.0
  (behind 7a:00.0) before suspend. The quirk logged for both 7a:00.0
  and 04:00.0 with the stick attached. After resume the stick was
  still there with no USB disconnect logged, still at 5000 Mbps, and
  its filesystem mounted and listed fine. Unplugging it and plugging
  it back in about 2 min after resume re-enumerated it at SuperSpeed
  in about 3 s, with power/control=auto.
- On that cycle the xHCI of the other, empty controller logged
  "xhci_hcd 0000:07:00.0: xHC error in resume, USBSTS 0x401, Reinit"
  and recovered. I'm mentioning it only because it's on the path
  your quirk affects; I haven't looked into it further.
- noirq resume takes about 16 s (15.9 s on a real S3 cycle). About
  11 s of that is in each upstream bridge (04:00.0, 7a:00.0), then
  about 5 s in the NHIs (06:00.0, 7c:00.0). Another 14,3 owner
  reports the same split in s2idle (stock kernel plus a local
  Thunderbolt workaround), and says it drops to about 0.5 s with the
  ACPICA change proposed in
  https://github.com/open-acpica/acpica/pull/1235 . I haven't tried
  that here.

Not covered:

- The "plugging into USB-C no longer wakes it" trade-off is
  untested here.
- Only one S3 cycle had a device attached, and it was a USB stick.
  No real Thunderbolt devices and no SR-IOV.
- The stock kernel also lacked the amdgpu quirk, so the real-S3
  before/after mixes both changes. The cleaner Thunderbolt-side
  comparison is pm_test=platform: the devices stage, amdgpu included,
  already passed on stock.

Two workarounds that have nothing to do with Thunderbolt were in place
for every patched-kernel run, in case they show up in other reports:

- d3cold_allowed=0 on the NVMe SSD (02:00.0). On stock, the machine
  never even reached S3 without it. I have not retested without it on
  the patched kernel.
- brcmfmac (BCM43602, 03:00.0) unloaded before suspend and reloaded
  after. Left bound through a real S3, the Wi-Fi firmware state is
  lost.

Thanks for chasing this down. This is the first kernel on which this
machine resumes from S3 at all.

Tested-by: Darrell Gum <d@rrell.co>
