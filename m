Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA34BB5CC
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838681; cv=none; b=mTnP1N43lg0xMUl7zKgIaBQipIcndQngGdww2DerXgFhDscYAPXeykHa3BHiCPfEd0qSCD5sABwdxNlVPo7Ewnyb94XnbI9hb3PlEoq5xVlmWCnMsRK4zkql5RAPuYBrC8cWb8YQbNpKKLqUadMGXv6fy26FWmGcRkuHQaRoPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838681; c=relaxed/simple;
	bh=69wTGs4Xn/TUvF1hRWSuKqp7L2UjaEJpt8IiVUoiboQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LZYn1E1ELmQqFmjSczVFi+eK0G29xV7xiTLxE48mklh5SWZB54D2iJyNLu1wbvVpJgwCIBo1Xx8QGIN1ghl6/Vu1g5AxTvCtjo/Jkd1/6hIRR08uYHM0QJdxCGnHC9HO6Z5/ev/k0aXreL6QBrJ4WnDAJSogP2D/EJ2DIwB35rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NP+l9G46; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NP+l9G46"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so4906282eec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791838679; x=1792443479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3lYEjUykJzoWYMUJo97frndFTA57IALGq9VPrtnj7o=;
        b=NP+l9G468y3hSZlhhcR8SUp5CwE4FrZZ33kvgu/64agUXmXe3+Zwbv4BUHiS2wJlLI
         kkq/sRwSJxMgpL/SQDlfkN4oGpcfHWJV8K/7vgb5jFBmXTG4enHdYQg9uuAT+6wClOat
         AF59SEas0WQQ33g9e5+Mi/LnlmaEaA8tHfhYD0JuXIT027U/cwB7KYpzpXdv7HwK8Cwx
         JLmRP3ItceTJTfrxbq1JHkX83vRe1dMnth0XxPXfNetVYCpaY+GbaAMgvsPcGWfAPWT4
         DgWGuhwr5o5poGLptRDFH0iyoVeSXqbvbXAV0NB4eZgpTYygCTmcBnPOt0LBxtGWpmHW
         cwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838679; x=1792443479;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3lYEjUykJzoWYMUJo97frndFTA57IALGq9VPrtnj7o=;
        b=oDz/g0+bErpQaNKu4tCcNAHBCPKiBhjzkO3A+xVrMFzxZj1kwVnUD2/K+snrMtonUJ
         CH5xilINBGhPl4g4jfHRP1aAPmA+sFShv5tgiezzh9GSK8AvJuVQWg9jgCHGVgYi+jYc
         9/sumvxdn3drzrD4adxF2aLZ/OdqEzy5qC7LnGdiufq2wmVkkXBtKWzNeiD1Iftx4aQi
         CxyNLOCfmIG2RYElSrmhn59WwsrTQbbRnas2Ez1OOK7OlPA6aLJ+QYS/0bcndENejUXT
         5VDlbq/BZazhmHN2icaeslkRcq2PyStqagiOblL7FQE6KpahvpO6vVrkxIRBxa+t0lU0
         fq4A==
X-Forwarded-Encrypted: i=1; AKwUvBw1dIQZ0LPMuoUboXoceoD5IIm2KjDgWPQPrh8P01dtGCNAgy5hPtWujR3NMGyMpMw3FrRerUyI6vg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEsQdk4KRs3JqTMjPhrfcgYwsk6WifGoeJQQlCqi+/zv8jvUVN
	AnvJa5r9AFy6mmRIZzolOGfTvKo4ienEpbr6BNrUdxNTIbStKm2kSfw9PgB6ZUDbX7JjRYfMatn
	PVtbf8uAgZuhW07h4Ot/5SOdnjmjjEFRE0g==
X-Received: from dycmb8-n1.prod.google.com ([2002:a05:693c:20c8:10b0:351:731f:c917])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id 5a478bee46e88-3537e03ce72mr14556990eec.11.1791838678452;
 Mon, 12 Oct 2026 13:57:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:53:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM9IzWoC/x2MWwqAIBAAryL73UJaGHSV6MN0qyV6sIIE4t2TP
 gdmJkMkYYowqgxCiSPfVwXdKPC7uzZCDpXBtMbqVhtc+UVHgqeLB96JRDgQ2mUIvba+C4OH2j5 CVfy/01zKB+uEsTBnAAAA
X-Change-Id: 20261012-fix-aer-mask-override-6b7d416c3d7c
X-Mailer: b4 0.14.3
Message-ID: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
Subject: [PATCH 0/2] PCI/AER: Fix and document aer_inject's aer_mask_override
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@linux.alibaba.com>, 
	Terry Bowman <terry.bowman@amd.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"

The aer_mask_override parameter of aer_inject does not work for
Correctable or Non-Fatal injections: the hardware Mask registers are
restored before the threaded AER handler reads them, so
aer_get_device_error_info() drops the injected error as masked.  The
only injections for which the parameter ever produced a handled error
were Fatal errors on device types whose AER registers
aer_get_device_error_info() doesn't read (e.g., Endpoints or Upstream
Ports), and even there only because the -EINVAL pre-check was skipped,
not because of the mask writes.  The '!' vs '~' operator bug in the
same code is a separate defect that transiently unmasks every error of
the device.

Why fix rather than remove the parameter: it dates from 2011
(457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers"))
and is mentioned in the RHEL 6.2 Technical Notes, so test scripts may
still rely on it; it is also the only way to exercise handling of
errors that are masked by default (e.g., Header Log Overflow or
Poisoned TLP Egress Blocked, or the Internal Errors on non-CXL
devices) without reprogramming the device via setpci, which the
kernel's own pci_restore_aer_state() may later undo.

Patch 1 stops touching the hardware Mask registers, emulates the
override in config space reads while the injected error is pending in
the emulated Status registers, like the status emulation itself, and
keeps the emulated value from being written back to hardware by
pci_restore_state().  The '!' vs '~' fix is folded in because on its
own it has no observable effect on the injection outcome (the masks
were restored before the interrupt anyway) and the lines are removed
by the emulation.

Patch 2 documents the parameter in the AER HOWTO, which never
mentioned it.

What the mask writes in aer_inject() do today, with the register
values of the sample session below (PCI_ERR_COR_MASK 0000c040 with
BadTLP masked, PCI_ERR_UNCOR_MASK 02400000 untouched, COR_STATUS
BAD_TLP = 00000040 injected):

  intended:  cor_mask   &= ~00000040   0000c040 -> 0000c000
             uncor_mask &= ~00000000   02400000 -> 02400000
  actual:    cor_mask   &= !00000040   0000c040 & 0 -> 00000000
             uncor_mask &= !00000000   02400000 & 1 -> 00000000

So between the write and the restore every Correctable and every
Uncorrectable error of the device is unmasked, including the ones it
masks by default (CorrIntErr, HeaderOF, UncorrIntErr, ...).  Both
registers are restored to 0000c040/02400000 before
irq_inject_interrupt() is called, so when the threaded AER handler
reads them through the emulated config space it gets the hardware
value and evaluates

  status & ~mask == 00000040 & ~0000c040 == 0

i.e. it drops the injected error as masked and the emulated status bit
is left pending.  With the patch the hardware is never written and the
override is applied where it is consumed, in the read:

  aer_isr() reads PCI_ERR_COR_MASK while 00000040 is pending in the
  emulated COR_STATUS:  0000c040 & ~00000040 -> 0000c000, so
  status & ~mask == 00000040 and "[ 6] BadTLP" is handled.
  Any read after the status was cleared, or after rmmod: 0000c040.

The write side, for a pending Unsupported Request with
PCI_ERR_UNCOR_MASK 02500000 (UR masked):

  pci_save_state()     reads 02500000 & ~00100000 -> 02400000
  pci_restore_state()  writes 02400000; aer_inject sets the hidden bit
                       again: 02400000 | 00100000 -> 02500000

Sample session in a QEMU q35 VM (pcie-root-port + e1000e at 01:00.0,
pcie_ports=native, v7.3-rc1 with aer_inject built before and after the
patch, injections done with the aer-inject tool):

  # setpci -s 01:00.0 ECAP_AER+0x14.L
  0000c000
  # setpci -s 01:00.0 ECAP_AER+0x14.L=0000c040        (mask BadTLP)
  # insmod aer_inject.ko aer_mask_override=1
  # aer-inject -s 01:00.0 cor.conf                    (COR_STATUS BAD_TLP)

Before:

  pcieport 0000:00:01.0: AER: Correctable Error message received from 0000:01:00.0
  # grep BadTLP /sys/bus/pci/devices/0000:01:00.0/aer_dev_correctable
  BadTLP 0
  # setpci -s 01:00.0 ECAP_AER+0x10.L                 (emulated COR_STATUS)
  00000040                                            (left pending)

After:

  pcieport 0000:00:01.0: AER: Correctable Error message received from 0000:01:00.0
  e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable
  e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000c000
  e1000e 0000:01:00.0:   [ 6] BadTLP            | Receiver    | Data Link Layer
  # grep BadTLP /sys/bus/pci/devices/0000:01:00.0/aer_dev_correctable
  BadTLP 1
  # setpci -s 01:00.0 ECAP_AER+0x10.L
  00000000
  # rmmod aer_inject; setpci -s 01:00.0 ECAP_AER+0x14.L
  0000c040                                            (hardware untouched)

The same with a masked Unsupported Request (UNCOR_STATUS UNSUP,
PCI_ERR_UNCOR_MASK 02500000): before, only "Uncorrectable (Non-Fatal)
Error message received", UnsupReq count 0 and the emulated status
00100000 left pending; after, "[20] UnsupReq" is decoded, the count is
1 and pcie_do_recovery() runs.  Recovery fails in this VM ("Data Link
Layer Link Active not set in 100 msec"), which leaves the injected
error pending for the last test.  With aer_mask_override=0 the
injection is still refused: "The correctable error(s) is masked by
device".

Reset while the injected UR is still pending, i.e. pci_save_state()
reads the Mask register through the emulation and pci_restore_state()
writes it back:

  # setpci -s 01:00.0 ECAP_AER+0x08.L           (emulated: UR unmasked)
  02400000
  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
  # rmmod aer_inject; setpci -s 01:00.0 ECAP_AER+0x08.L
  02500000                                            (hardware untouched)

With the read-side emulation alone (an earlier version of this patch)
the last read returned 02400000: pci_restore_state() had written the
emulated value to the device and UR stayed unmasked in hardware after
the unload.  That is why the patch also keeps the hidden Mask bits set
in writes to the Mask registers.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Priyank Rathod (2):
      PCI/AER: Make aer_mask_override effective for injected errors
      Documentation: PCI: Document aer_inject's aer_mask_override parameter

 Documentation/PCI/pcieaer-howto.rst | 23 ++++++++++++
 drivers/pci/pcie/aer_inject.c       | 73 +++++++++++++++++++++++++------------
 2 files changed, 73 insertions(+), 23 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261012-fix-aer-mask-override-6b7d416c3d7c

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>

