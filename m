Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99A371072
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305269; cv=pass; b=oLod+qD1K3dWjFYvQGGKg43SEeOTQ9wfIuKVWl0JulpgebvkcsP9w1MJtFYFqikqFigT/9GMxBuw9HDBZdA+IEPWATYhbA7D8LH4QAlICWaq+aXsuWsFMS4G8XTG7RLhtmuK7gXjTC+9hAUzEezNQDeCFXsJHBfpVix2UYWdPko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305269; c=relaxed/simple;
	bh=nrE0aDhjgLNq3fwnuI7XYukBFgsH1fovA84RYILYFgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP4aXQZOTj4iY+Yt/eIFKoxlvucY8Vc69jyNQ5Hoku+emKHOGMoCKilce7xz+bLEoHS4QrJ3T3sDrF91qwpaa/TAjG9+nu22Mxl02Gyhf6WlJmgOOovPYJpQEOz9IfVMweBlCjwl9ZthgBcuCiKITUvRO/LhCOqUBXwzg5uT00g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=qQiFYGtM; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="qQiFYGtM"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 319853F29C
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 02:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783305258;
	bh=O8K1BMdVNsFQnG1EmX0I8oupbELNb98/C6Pqphsagy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qQiFYGtM9d6oW5yudD0w0OXFRioA4GIzDLv9v3cljsZJmP2w6J1STmjIy207tMVkO
	 jm9BJIerTwfx0zIVVMgzt519uoDf6rOdPn234D471MhmgowHZH9mMfZA4yuPPKiPqb
	 NiaoyCSlNUcF/iY5PgmwobYuYOL/zvVeoCxJyZssb1awu0DA1/GGvWPLnNlxv81sh8
	 88yZElYwJ8YQZltrL6CzUiHv+y3jJlVMd7FBhhu2PBN2gmsh3sUGmakRWUAvJJo9Ep
	 TO9zt3c92Mv2E7v5TgdZDNVy6afqeZHOHELUiIMyav9x9UTWmT0MK8QSuwFB9jCvlD
	 Qv9LvzU5W2jgVVNAB3jKP85Vk3uc+MyYvs++A5c4svAp9JtDs0rNd54LRbxqw/ZXvh
	 oHtaKaB36uE5BXfogvPSDqjFOl9MUVS34LBg6rHsezUjWJD/SX2UQHaQWWkHGsTWHR
	 W8eymxRfGUaWs5k2h1Cx/R2hAmNqqzDrMPiKkOiBMePxllMzKpFRS/3bAsp+hnOqql
	 UlNCZ9FYXgn4DmyjJ5uWYSfZTnrflRzxJaSBbFZ8LhcA2pb9KMRqNUxf+yEDr+ELl0
	 emZOdq4c15FiE2qReVU1rTRtqSBAiXnZqjJIhUjfco85MUAqDrOrOS8wNDPbGABEKc
	 GX3IyotufG+h1pE78dnVVdYw=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84770f89b99so4082125b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 05 Jul 2026 19:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305256; cv=none;
        d=google.com; s=arc-20260327;
        b=oCl7ZL89z34nk35d1zyCRy0WVjvmIoTsN1AZBZRuyr0GhpYAn9JXkqR8opcSfpy5ss
         QPU1zNdcTc8jWhLWEsi8LVGttZ8e0pDUA6E1HpcPcS1Fz5auRCO86DEFK+kkjcgB+aTH
         r8o3sx89N/GMK348nSbD/tw2sd/+tnaD2G4lL2mTzc5ckUDFXba5w+o2nK2w7TJM+SLX
         14wD32ldogrOIpmhSIS3lptaRlMdYDfhK9aR/cmwcy2ZDKUFHt8CpyGbus9CqwkCKRB4
         +2/amw1DeC06sLL3KDx+j+1NPjvR4HTFVPDQocu8Fj1iNVG61GAQTNJPeQpfpM8rIr00
         t6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=O8K1BMdVNsFQnG1EmX0I8oupbELNb98/C6Pqphsagy4=;
        fh=2FbvbSQTAuaWj9kAVFnhQ89MozJ/J7Sz7nrw9ZGxJ40=;
        b=MCf5PfV83blxv8TrX6FxV6leGl+ExKs0hlEA/sLqQ0agUyylhEb3aMf7K2vPQKZKQb
         XGRuvrTXSWR+k8n2fNm+pC+WV+meG1NrUAvKe2L1aJ/LnfBechVIo2V1x+hEejk+Gwnm
         bLMWGyf8WeTQ5w1gzSrtGXnWPNbVtM290PRWAXJ2+1YT+Wf5fIKwwfU+7QoKqwMiIye4
         V1IPR1CxH1jqrwvs+GhcYUAgeYzR+gYl7j8Zhu+ErEvyr4y16cReXJNum/N6PFMPNi+1
         jqmG3+qPK6ysdUCV9KsoSd1sTslK2Lly43SmSjHYwWMcnSqGYAF6be+KCKfGhLYO+I0R
         5CAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783305256; x=1783910056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8K1BMdVNsFQnG1EmX0I8oupbELNb98/C6Pqphsagy4=;
        b=GG44obyP5jbok+sbQ/DovOK9ehSzP2rDhLsszPrUeekn7pz9LPU28I22XWnikpPNH7
         zTmoMozak/uZrdvs/xFILbn55HBAKMaTVHkWQTJHzsF/b5PogcYroqCXg7MRETFPNWzv
         WoMqH+n7NwNKz1S5uT+mZyfW8MfNy6HAj2yMQaGofh+mINj0IAkB8TnWnbhGkzj4CM85
         kLrKo1Ttk4Sksqn4CXxiSskYKwo0yUObapvINySSl0/8RirvDGnMqEH7D1sYwyXZEfDM
         3mun48veeqNbb8TbcSK/+oE0NPTgVS5E6psB+c3K22dnVDJXaP/zpHmHMJ29BuLkYOw/
         t8pw==
X-Forwarded-Encrypted: i=1; AHgh+Rq31FlnwTe/VFtdORWCYUf+/dYV+aaiXfSUY4ZxHpUMvn4tMwUP/Zw1Spjsiye5vzuh3uDTCfj+o3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4AiFx7Cu7r6FfZTpzLfYbS4FepddSEH2jn2/DzApUx+Z8G8l
	2ropDb8wTcmoP9+q+IkauqJZR5BNzYSUp7quVsyVmM3LBSPMEeBc+F1UIaWcoBE9bcbrPIC730d
	EABCgfx+gYqB+N/8BLwjuGULV9jXA7pijK9bcdPq8jfp2rpDC6jOc2js+zJttcXaq9wzP4hRCA6
	Gk41J9Rx/sQ73n6oF5oAQ3iYn7qXhR4LoNPOdncG6uOX5GH7rW8lV5
X-Gm-Gg: AfdE7clLBBVFk4BoTF+37b178CGWerCD/hBmMbUhiQzJ+voBnjPHruoe7atQ5sHNBeR
	Em3vrpTYY2BwMYupNf7twDHJFjgQsqsLRd4D6ttquU+D272cbMfCaQcM1X1Ug3kiZI6bgtPRhSS
	doO+ZCLG8OMfhramLzBsUQs26GEm9cuzQrLWAWTEggfYQYXqUmEvUb+Vuzg5+VHRx1mq1q
X-Received: by 2002:a05:6a00:8d81:b0:845:dedd:89b1 with SMTP id d2e1a72fcca58-847f6ef4e59mr7035648b3a.34.1783305256403;
        Sun, 05 Jul 2026 19:34:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d81:b0:845:dedd:89b1 with SMTP id
 d2e1a72fcca58-847f6ef4e59mr7035627b3a.34.1783305255958; Sun, 05 Jul 2026
 19:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
 <20260701204201.GA302478@bhelgaas> <akXy1gsijpfslOJm@wunner.de>
 <CA+YcyLx3XS3LEeVzPEfD+OdktsLFyLuN4mQGk9EyEgQUmKPLBA@mail.gmail.com> <akZ448o-YMGfEEOP@wunner.de>
In-Reply-To: <akZ448o-YMGfEEOP@wunner.de>
From: Max Lee <max.lee@canonical.com>
Date: Mon, 6 Jul 2026 10:34:04 +0800
X-Gm-Features: AVVi8CfXfQdb8_CfDd0b3PV8S98QpOeIcsJuOPPxI9Qi3G1EKg4okk_D0h5SBLs
Message-ID: <CA+YcyLw0HpR1Dnz-mOL1Ryym89ytc=1a_Ri9buMt3at-9mib+g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Victor Shih <victorshihgli@gmail.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 02, 2026 at 04:42:43PM +0200, Lukas Wunner wrote:
> There were Advisory Non-Fatal Errors on both ends of the links.
> The upstream kernel does not support ANFE so far, but this
> development branch contains three tentative patches to add it:
>
> https://github.com/l1k/linux/commits/anfe_v1/
>
> So far this is compile-tested only. You may want to give these
> patches a spin to see which Non-Fatal Errors are signaled. The
> kernel should also dump the TLP Prefix Log for those errors and
> you can use this tool to decode it:
>
> https://github.com/mmpg-x86/tlp-tool
>
> See the example usage in: Documentation/PCI/pcieaer-howto.rst
>
> The TLP Prefix Log might give a hint as to the root cause.
>
> [...]
>
> Bjorn mentioned commit eeee3b5e6d0b, which states that the Replay Timer
> Timeout errors (only) occur when ASPM is enabled. That may be the
> actual root cause, so you may want to play with ASPM settings (disable
> L1 substates etc) to see if it makes the issue go away. Disabling
> non-working ASPM settings in a quirk would be better than silencing
> the ensuing errors.

Thanks Lukas for the suggestions

I tested Lukas' anfe_v1 branch on the affected system:

https://github.com/l1k/linux.git anfe_v1
ca3701e1b037 ("PCI/AER: Support Advisory Non-Fatal Errors")

The tested kernel was:

Linux localhost 7.2.0-rc1+ #2 SMP PREEMPT_DYNAMIC Fri Jul 3 08:00:24 UTC 2026

With that kernel, the storm still reproduced, but the reported error
remained a Correctable Replay Timer Timeout. I did not see Advisory
Non-Fatal Error or TLP Prefix/Header Log output for this storm.

The relevant dmesg lines were still:

pcieport 0000:00:1c.6: AER: Correctable error message received from 0000:58:00.0
pci 0000:58:00.0: PCIe Bus Error: severity=Correctable
pci 0000:58:00.0: device [10ec:525a] error status/mask=00001000/00004000
pci 0000:58:00.0: [12] Timeout | Transmitter | Data Link Layer

In that boot, dmesg contained 767 printed Correctable/Timeout messages
and 76 aer_ratelimit lines. The actual interrupt/counter volume was much
higher. Before stopping the storm, /proc/interrupts showed:

IR-PCI-MSI-0000:00:1c.6 ... 37981589 ... PCIe PME, aerdrv, PCIe bwctrl

The AER sysfs counters showed:

Endpoint 0000:58:00.0:
Timeout 12018352
TOTAL_ERR_COR 12018352
TOTAL_ERR_FATAL 0
TOTAL_ERR_NONFATAL 0

Root Port 0000:00:1c.6:
aer_rootport_total_err_cor 12062319
aer_rootport_total_err_fatal 0
aer_rootport_total_err_nonfatal 0

I then tested the ASPM settings directly. With OS-native AER active,
disabling only L0s on the RTS525A link stopped new AER interrupt and
counter growth while leaving L1 enabled:

echo 0 > /sys/bus/pci/devices/0000:58:00.0/link/l0s_aspm

After that, over a 10 second interval:

irq_delta=0
endpoint_cor_delta=0
rootport_cor_delta=0
link_l0s=0
link_l1=1

Disabling L1, L1 substates, or Clock PM alone did not stop the storm.
The storm also did not require the rtsx_pci driver to bind: it was
reproducible while rtsx_pci/rtsx_pci_sdmmc were blacklisted and the
endpoint was not enabled by a driver.

Based on this, I agree that disabling the non-working ASPM state is a
better direction than masking the resulting AER reports.

I tested a v3 patch that disables L0s for the RTS525A by removing L0s
from the device's ASPM link capability:

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x525a,
quirk_disable_aspm_l0s);

I tested that patch on top of Lukas' anfe_v1 branch. The patched kernel
booted as:

Linux localhost 7.2.0-rc1-rts525a-l0s+ #4 SMP PREEMPT_DYNAMIC Mon Jul
6 02:08:30 UTC 2026

The quirk ran during enumeration:

pci 0000:58:00.0: ASPM: Link Capabilities L0s treated as unsupported
to avoid device defect

With the temporary rtsx_pci blacklist removed and the initramfs rebuilt,
the card reader driver bound normally:

  rtsx_pci 0000:58:00.0: enabling device (0000 -> 0002)

  rtsx_pci_sdmmc         36864  0
  rtsx_pci              143360  1 rtsx_pci_sdmmc

The endpoint was enabled and bound to rtsx_pci:

  0000:58:00.0 enable=1
  0000:58:00.0 power_state=D3hot
  driver=/sys/bus/pci/drivers/rtsx_pci

L0s was no longer enabled, while L1 remained enabled on both ends of the
link:

  0000:00:1c.6:
    LnkCtl: ASPM L1 Enabled

  0000:58:00.0:
    LnkCtl: ASPM L1 Enabled

The endpoint link sysfs state also showed L1 and L1 substates still
enabled:

  clkpm=1
  l1_1_aspm=1
  l1_1_pcipm=1
  l1_2_aspm=1
  l1_2_pcipm=1
  l1_aspm=1

The l0s_aspm sysfs file was no longer present for the endpoint link,
consistent with L0s being removed from the ASPM capability.

After booting the patched kernel with rtsx_pci bound, there were no AER
Correctable Replay Timer Timeout messages and no aer_ratelimit lines in
dmesg:

  aer_correctable=0
  timeout_lines=0
  ratelimit_lines=0

Over a 10 second interval after boot, IRQ and AER counters did not
increase:

  irq_delta=0
  endpoint_cor_delta=0
  rootport_cor_delta=0

The counters stayed at zero:

  Endpoint 0000:58:00.0:
    Timeout 0
    TOTAL_ERR_COR 0

  Root Port 0000:00:1c.6:
    aer_rootport_total_err_cor 0

So for this system, the evidence points specifically at L0s on the
RTS525A link: enabling L0s triggers the Correctable Replay Timer Timeout
storm, and disabling L0s stops it while leaving L1 enabled.

I will send v3 changing the quirk from masking AER Replay Timer Timeout
to disabling ASPM L0s for the RTS525A.

Thanks,
Max
