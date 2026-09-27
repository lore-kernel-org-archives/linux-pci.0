Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC622D5937
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528114; cv=none; b=iglzBJ0fUd4w159mJtOWMrK4Mp4uH7P72xZgK68tj2AyHwXPAl55MKx2EXfGk8HS9bP1eT3cY+byhDkmI1i/udblQt/4LFO2Q3Rau5HqMAvrr1mx/UCDS0qNEjR76atihFm/iMI/2IcpGflYkFhSQw60ZOcje7yy24JB5BVPeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528114; c=relaxed/simple;
	bh=JPrz4+g1ULrO09FkL87RuvraFiI1Jk7ZcYUgwV49fBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ewg2bnh2kWBhWD6ZAtujTgdouU/xG5O7+sFYVMZKLkBBhNchPDhL/JgqJaserwhci9loR4xB1tMdZ/OOstmGq9eY+QpBICYWCT2eY7fHODDwd1L9RUnWFIWkiwTyAV7It9JOeHqv720Fe/t0EN/r7wx9sAGOqGG4s2TqbL07ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtYiEYFX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtYiEYFX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso17077185e9.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528111; x=1791132911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yz1PsHl1EK/dk/I6+GFSPEAqum820kPR3CBi6PfY1Qg=;
        b=DtYiEYFX6g4oW3ppnvhmzQQQFs2Av0G2NsOkpoop47EE8q5evCA0CUVc2zmNUG16cw
         47kUKCUfHNofqeyLHkDIYSHtiPSWSRkb2/V1F8hDAPKgLwV3Y80Zs8kNYhooDSvL7+vP
         3D/XFhL+FbJZWr396WW5g9IZaTKXNDpje3f+mKrMJyYNxRYlCfdP60YkrQzSelLE3SII
         Ev1Lp1xXVQPBGgrDVUihsTmuuE6q5PN1eooklgbFlDoCcJ5nc4BJjoSC7r2mlXXh0ba9
         Kvn8xQDpgxPTqlI+shxzFKEdsqrXCsGkw3/Bf7STKEg3Ic5WGdvvDYKyIsd1i/ffFacJ
         IUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528111; x=1791132911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yz1PsHl1EK/dk/I6+GFSPEAqum820kPR3CBi6PfY1Qg=;
        b=z4DL0SQ1hR7JRaSsLwh7XLv87PkSz4PG0x+gt295mPpePbNWO4K2NTPZNapYbMA82g
         yFNWQgxpRz06P7tHgKEQA1Nh4k/DQe9IEE9lrQEE2MioJhdPPNduigxY/Y8zB9IswQcP
         RAwgkzUYJ6HIWZ0V2R/cm7e20C5M4K5XhpAUTDsLKuAl+4yjjfyOz4CyDiSl/Y5jyPR8
         lBcZ6ORkeSqgAaXDrqrXUcxkuwHznP7l4Dm2zgymKsmuz5VPTcY9QlQw0hDcIg7JyZmR
         Hl1i73eYh0d67K7vOcDFUSTh5bYTxYXaj49e92PHDLpUfPT3OzkwSAiZibHRwK3V8oDI
         QXRg==
X-Forwarded-Encrypted: i=1; AKwUvByvxTiD0TUxNObTgOnhmwI/Ca4r+Ni3eGglhhyLbbOBPmeJF+nkuT3p84Fq5dqJhDI1mIH/kQ3yO1w=@vger.kernel.org
X-Gm-Message-State: AFuF++kYfuLiRx9/SnPiSCYlMAE58iuSHlswDuehNbrHuYn0vcoeHlXG
	IDnAVT106AVcmOTeMmrqvC10D0PWNfxLzjplJpeinesFnaYPsC9bV+fw
X-Gm-Gg: AYBFou1zcKir9tXTafW19ERG32ZYIaZ+qo+/+UZXNpfH5EDyGPHqKB03uaZO0j1wR+9
	Kps3TzLSgUA5A1BdkS3n/2wKNWwL847HbltfhjQXjwmaQpXjpPXDNWHMlxBe0ApqlOcp3Yc53cM
	Mcofm+y3m5bXmI91Dd9sazfS7UurrkFOtaWk6Rj4MzBA2Syq7sX/XtTJG/P0wGhZh+rENWuZXHO
	JJAydROqCrEwfYyJ4zzchUEXTl7jUn+qrKlUwYXlQwOgppkQ8gtEZb2T663mqwBOp/r4ZuMad0g
	e2XYwtmLjb2SS6H47V6yxyzHBe0YNrY9d0JPzZykNW7lACWDQm3lvX9QlkwIN4uQqfm/AXt6SJZ
	XvT8wUIPc4bTZ6fLRDi41bi2LBHro0LqsMu3w+tH3c7hzQ+5ZJKF5b14PyzVQg4kdb70Qkpxjmn
	NDOSEKYjB1ejsgmwT54bO2yq3uLAFWawJhlnqIE4KLNGsLR99VJa23RQMnAX6gr3qN1SeHKEau9
	HusKv2dXZwDO+M7ztmU0TTb4EBMaSMEegg+LT/tVxyslyJyxoeZy6tsAC3wD//kdjSdO6lxfOZ2
	pw==
X-Received: by 2002:a05:600c:5492:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-49fffd04049mr56203615e9.32.1790528110862;
        Sun, 27 Sep 2026 09:55:10 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:09 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v2 0/5] PCI: pciehp: Report surprise removal during safe removal
Date: Sun, 27 Sep 2026 16:54:53 +0000
Message-ID: <20260927165459.829900-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a safe removal is already in progress when the device is surprise
removed, pciehp cannot report the disconnect [1]. The removal blocks
waiting on a device interrupt or status read, and pciehp's IRQ thread is
single-threaded and is itself executing that removal, so it never runs
again to report the device gone. The removal hangs indefinitely.

pciehp_isr() does run while the IRQ thread is blocked, but pciehp_ist()
must ignore link and presence changes caused by Secondary Bus Reset or
DPC, and telling those apart takes seconds which cannot be spent in
hardirq.

Patch 4 does not do that work in hardirq. pciehp_isr() only checks
whether the card is present or the link is active, and defers the rest
to a work item in process context. The work item does not need to know
why the link changed, only whether the card is gone: it waits for DPC
recovery or a Secondary Bus Reset in progress to complete, then checks
again under reset_lock, and if the card is absent and the link is down
marks the devices below disconnected, which schedules the driver's
disconnect work from patch 1. pciehp_ist() is unchanged and
remains the only consumer of the one-shot flags PCI_DPC_RECOVERED and
PCI_LINK_CHANGED, which tell it whether a link change can be ignored.

Patches:

  1/5 Michael's "PCI: Report surprise removal event" from his RFC v5,
      which adds disconnect_work_enable and pdev->disconnect_work.
      Changed to use disable_work_sync() on teardown.

  2/5 Add pci_hp_wait_link_change(), which awaits a Secondary Bus Reset
      in progress without consuming PCI_LINK_CHANGED.

  3/5 Add pci_dpc_wait_recovery(), which awaits DPC recovery without
      consuming PCI_DPC_RECOVERED.

  4/5 The pciehp change. Adds disconnect_work to struct controller,
      scheduled from pciehp_isr() on PDC or DLLSC when neither Presence
      Detect State nor Data Link Layer Link Active indicates a card.

  5/5 A POC driver for the QEMU edu device that blocks in remove()
      waiting for an interrupt, standing in for del_gendisk() stuck in
      blk_mq_freeze_queue_wait(). Not for merge -- included so the
      hang can be reproduced.

Changes since RFC v1 [2]:

  - 1/5: Use disable_work_sync() instead of cancel_work_sync() in
    pci_clear_disconnect_work(), so that a racing schedule_work() cannot
    queue the work after remove() has returned. (Sashiko)
  - 2/5, 3/5: New.
  - 4/5: Drop schedule_notification_work(); pci_dev_set_disconnected()
    schedules the driver's disconnect work for all callers again.
    (Michael)
  - 4/5: Don't consume PCI_DPC_RECOVERED and PCI_LINK_CHANGED in the
    work item.  In v1 it ran the same spurious link change test as
    pciehp_ist(), and whichever ran first took the flags, so pciehp_ist()
    could tear down a device that was only reset. (Sashiko)
  - 4/5: Check presence with pciehp_card_present_or_link_active() in
    both pciehp_isr() and the work item, as pciehp_ist() does, so that a
    port with Presence Detect State hardwired to zero is not mistaken
    for an empty slot.
  - 4/5: Return early from the work item if pciehp_ist() has already
    taken the pending events, and treat a read error of the presence
    check as "not present". (Sashiko)
  - 4/5: In pciehp_isr(), check presence before dropping the runtime PM
    reference on the port's parent.  In the work item, take a runtime PM
    reference and check presence under reset_lock, since a slot reset
    may make Presence Detect State and Link Active flap.
  - 5/5: Build only with CONFIG_EDU_SRPOC, which depends on PCI; don't
    claim the interrupt when the device reads all ones; clear bus
    mastering on teardown. (Sashiko)

Testing

Reproducing this needs QEMU changes, since neither device_del nor the
attention button produces a true surprise removal.  A branch with both
is here [3]:

  - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
  - a pcie_surprise_del monitor command that drops the device and
    generates PDC=1, DLLSC=1, PDS=0

Both tests use:

  ./qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 \
    -m 512 -smp 2 -kernel Image -initrd initramfs.cpio.gz \
    -device pcie-root-port,id=rp1,chassis=1,slot=1 \
    -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
    -nographic -monitor unix:/tmp/qemu-mon.sock,server,nowait

  and need a guest kernel with CONFIG_EDU_SRPOC=y.

Test 1 (Hang in remove() on a user thread, then surprise removal):

  guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove &
  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  This is the case patch 1 solves on its own: pciehp's IRQ thread is
  free and handles the removal.

Test 2 (Hang in remove() on pciehp's IRQ thread, then surprise removal):

  guest# echo 0 > /sys/bus/pci/slots/1/power &
  host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock

  Without patch 4 the safe removal does not return until the delayed
  interrupt fires 600 s later.  With it,
  pciehp_isr() schedules ctrl->disconnect_work, which marks the device
  disconnected; the POC driver's disconnect work completes the wait and
  remove() proceeds.

Open questions

  - Is this a viable approach?

[1] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
[2] https://lore.kernel.org/all/20260905183905.997833-1-abhinjoses@gmail.com/
[3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal

Assisted-by: LLM

Abhin Parekadan Jose (4):
  PCI: pciehp: Add pci_hp_wait_link_change()
  PCI/DPC: Add pci_dpc_wait_recovery()
  PCI: pciehp: Report surprise removal from pciehp_isr()
  misc: Add edu_srpoc surprise removal POC driver

Michael S. Tsirkin (1):
  PCI: Report surprise removal event

 drivers/misc/Kconfig                   |  11 ++
 drivers/misc/Makefile                  |   1 +
 drivers/misc/edu_srpoc.c               | 171 +++++++++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
 drivers/pci/hotplug/pciehp.h           |   1 +
 drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
 drivers/pci/pci.h                      |   9 ++
 drivers/pci/pcie/dpc.c                 |  54 ++++++--
 include/linux/pci.h                    |  46 +++++++
 9 files changed, 367 insertions(+), 14 deletions(-)
 create mode 100644 drivers/misc/edu_srpoc.c


base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
--
2.51.1

