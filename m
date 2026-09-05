Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDD4E66A3
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633561; cv=none; b=lqthznUgz8BHlmT67Fm8A5CaoCXA8xsMv5cO88pcDBKnBAZhe/+Xf5oiUzE4osUL6M0BNkS8xzd+pk1apyv9r8rsfobwvleAggR/OLUuwrHmZi56S1LDLSs8FZ0721Y5aBp3mqKh8uIGf6CROYrTOjxO6TJ6DcCmENAGK4i7PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633561; c=relaxed/simple;
	bh=Svz1IuwoQTajBVbl5c+TCPmX0LIWaT9lWEEXDkGkwK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3ER1R981rQ803OoBehls2EnDjz9XAUcu3dKH2k7XoONBZhW3VxTlBmi5HZu68sTU1iJWwZ9+ujixOZnJsh2irnD+wMdhf4pOjAvg+GL6FUp5XAy/1+9ZxjU/JgQ2YJtEEKX6xXBspc275Vk3vbz1WnSltiAviHHGyEHtn0cFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+UJFCYw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+UJFCYw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso17225055e9.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788633558; x=1789238358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G24wlXpv5jwJX+hVi7UVbTBsj2H8ilHw4YJYDN3z2zY=;
        b=U+UJFCYw36Lo56mdIs7na2MRzfVdrRFa2ZTcp8I7Kcatp//OuPzkA5cjYpjYWkpkVa
         JDg6Zp7GAzcvi6aCH2TXmkyzjVCVtUgzxlWPbpGydnjq/gKu4i58eEtv9qVwhTtEqy23
         /zJul1Ob0khDqntIqINndNz9qyBb/+CKpYzfN637WnDZ6SbndMAQifUYnGw57/0SXLZo
         hXBFKy575V4ohh5J8jA5grumtA258zIjF3O23kS2Yz0M2dBPtlB86fXtoM8gadxinRm/
         3ZUvmUaZ4dngv21nDIc+VQ7vK480PZnCu0wiF2uOcEi447Fi84iJcPaQ/FcIc1/EI7N8
         PBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633558; x=1789238358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G24wlXpv5jwJX+hVi7UVbTBsj2H8ilHw4YJYDN3z2zY=;
        b=fX8e98o00C8l8JDh6ZjtwnZwIU80LwU8jqXpNbg/QIJyYXxbHPddhd8ERQkW6YfL/K
         ZcfGycA01iRJjKaYrAHUduoSkigqC4AbfQ3lXj94xuWhlTZMGiLourvhN2GIuQ4/mQN/
         6a7UXVfZ/8RHWYobMyob7Al05dzexb8/Br9lH17Nk8WKcNoiCL+b7S0v6y77cf/yeh/k
         TS4jxLBI+wogDGnNfLKUOb7p+lHC4sKEauqqpQ22kIAwMRzkUnggQ2MyQlcDXfc2wfpa
         yiAIW4j7rGAOYacVIQxSI+bmNBh/ZExKj89e7EwNDBrt5OfvVl+mU+UfvELzmurfHC9q
         MWyA==
X-Gm-Message-State: AFuF++niVTc0lTMosRwG9quCuveY71kN/MzUxwG8WINbiPFTKQbb5EqJ
	4hFZ8wIKiOtnYaQE5IhN/+lzDl5SmvVqNvVzmQXjspg17rSa4T1VnWXa
X-Gm-Gg: AYBFou2GZJ51O16wRSuM1gnB9IZUxnZRk7BlLSNABWXoyYsJ8/sAkx/URxIolytIEdh
	IDMOcT1nc7Jdp3wfV5UwfH2CmzENT/I33aHLx2y+HCtaVSvROcnqGrbOg7PdrWnhnKYybcjRO8V
	TRFmlHDqU4jDk/l2Ti0md2zvovHEvN71HDUD5fy6k7CyajIdY1/naM7osdrekaJJ1MZD5UTzHDz
	lidc1X1sZol7BwIJtug+hpLHXgfX2aSyUSr0JMpXw+OMXmPVdskf76VSA8NqdsmDBJv0F8373D8
	9xSd+TduHjfJatsOJtY70pmQNpV5ohlJ/GzrrHwV05UC3DDnl9AqjLfVnNL4jT6ysenTKU1Gnue
	oeJSSEHyDHWkQYeFxTxxcAQrl44SP6YgjRNdpOnluYObRNWwqdKzii589LFqyknkxiI0CAF3r9e
	+MXKN5qs2lW59eeP5+S/FwfsBUFMmfbgrjeZ2ZrEMXXTNjA2boiEeCfuRCOhhOodseugaNB3PjP
	A==
X-Received: by 2002:a05:600c:1d0d:b0:49d:99c:3bd9 with SMTP id 5b1f17b1804b1-49d099c3fc9mr9409175e9.33.1788633558060;
        Sat, 05 Sep 2026 11:39:18 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box ([2.210.128.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm16333603f8f.34.2026.09.05.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:39:16 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: bhelgaas@google.com,
	lukas@wunner.de,
	mst@redhat.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kees@kernel.org,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 0/3] PCI: pciehp: Report surprise removal during safe removal
Date: Sat,  5 Sep 2026 18:38:57 +0000
Message-ID: <20260905183905.997833-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bjorn asked for this to be pulled out of the dormant virtio thread and
posted separately as a purely PCI series [1]. This is that repost. It
carries one patch from Michael's RFC v5 as a dependency and drops the
virtio side entirely.

The problem, as identified by Lukas [2]: if a safe removal is already in
progress when the device is surprise removed, pciehp cannot report the
disconnect.  The removal blocks waiting on a device interrupt or status
read, and the IRQ thread is single-threaded and is itself executing that
removal, so it never runs again to report the device gone. The removal
hangs indefinitely.

Lukas noted that pciehp_isr() does run while the IRQ thread is blocked,
but argued this was not viable either, because pciehp_ist() must ignore
link and presence changes caused by SBR or DPC, and telling those apart
takes seconds which cannot be spent in hardirq.

Patch 2 sidesteps that by not doing the work in hardirq. pciehp_isr()
only checks PDS, and defers everything else to a work item running in
process context, where it is free to sleep and to repeat the spurious
link change test.

Patches:

  1/3 Michael's "PCI: Report surprise removal event" from RFC v5,
      unchanged apart from the fixing commit subject. Needed for
      disconnect_work_enable and the disconnect_work.

  2/3 The pciehp change. Adds disconnect_work to struct controller,
      scheduled from pciehp_isr() on PDC or DLLSC when
      !pciehp_card_present().  pciehp_disconnect_work() then runs in
      process context, where it re-tests for spurious link changes and
      confirms the card is still absent before scheduling the driver's
      disconnect work.

  3/3 A POC driver for the QEMU edu device that blocks in remove()
      waiting for an interrupt, standing in for del_gendisk() stuck in
      blk_mq_freeze_queue_wait().  Not for merge -- included so the
      hang can be reproduced.

Testing

Reproducing this needs QEMU changes, since neither device_del nor the
attention button produces a true surprise removal.  A branch with both
is here [3]:

  - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
  - a pcie_surprise_del monitor command that drops the device and
    generates PDC=1, DLLSC=1, PDS=0

Test 1 (Hang in remove() on the user thread, then suprise remove):

  ./qemu-system-aarch64 -machine virt,gic-version=3   -cpu cortex-a57 \
    -m 512 -smp 2   -kernel Image  -initrd initramfs.cpio.gz  \
    -device pcie-root-port,id=rp1,chassis=1,slot=1 \
    -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
    -nographic  -monitor unix:/tmp/qemu-mon.sock,server,nowait

  guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove

  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  This is the test that MST had solved.

Test 2 (Hang in remove() on the IRQ thread, then suprise remove):

  ./qemu-system-aarch64 -machine virt,gic-version=3   -cpu cortex-a57 \
    -m 512 -smp 2   -kernel Image  -initrd initramfs.cpio.gz  \
    -device pcie-root-port,id=rp1,chassis=1,slot=1 \
    -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
    -nographic  -monitor unix:/tmp/qemu-mon.sock,server,nowait

  guest# echo 0 > /sys/bus/pci/slots/1/power

  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  This is the test I am trying to solve.

Without patch 2 the safe removal never returns. With it, pciehp_isr()
schedules ctrl->disconnect_work, which walks the bus and schedules
pdev->disconnect_work; the wait in the POC driver completes and
remove() proceeds.

Open questions

  - Is this a viable approach?

[1] https://lore.kernel.org/all/20260826194815.GA1552818@bhelgaas/
[2] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
[3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal

Assisted-by: LLM

Abhin Parekadan Jose (2):
  PCI: pciehp: Report surprise removal from pciehp_isr()
  misc: Add edu_srpoc surprise removal POC driver

Michael S. Tsirkin (1):
  PCI: Report surprise removal event

 drivers/misc/Makefile            |   1 +
 drivers/misc/edu_srpoc.c         | 169 +++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp.h     |   1 +
 drivers/pci/hotplug/pciehp_hpc.c |  56 ++++++++--
 drivers/pci/pci.h                |  12 +++
 include/linux/pci.h              |  45 ++++++++
 6 files changed, 276 insertions(+), 8 deletions(-)
 create mode 100644 drivers/misc/edu_srpoc.c

--
2.51.1
