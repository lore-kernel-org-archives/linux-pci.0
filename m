Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF235201F
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510107; cv=none; b=fGRW91RQelao7Xmca5xuW40P9XISL/0snbVGg5zWFug7tKH2TomOoTO7F6qsEEPmLklSxcQmkQ1yY0JdUbnAFjUafzi0q9HQrDp+BUmAm43uys+ND3tU/18CpGXkdmHzy6UL7kknULcVKW3p7J3KoNmwUiiO6PAD60LzEds2Fts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510107; c=relaxed/simple;
	bh=yjdXslBGbzwFdci6QHpbbFDvYKSeF4IauobuIUcSXCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T87Py1Z6omkBgP0khMBhuI3nBtg7Jk0RPon2XMlMlL/Xoo2lZECO0RQGge5mL1StqPzQhYN8HvQ06Bbon0saF56mhduhmeB+z9eeHOA29d03FRKUsfAqU1u1fc2/z27hVaJEDk9wyrBmPl8ANdKBd+V60/Epsr1U1oGaINwbTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrUNOBQu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrUNOBQu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2074710751so491463866b.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510104; x=1788114904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhR6A6pOlxFnDseZWXN693d/vUJe+c8P3tz2lrasiRw=;
        b=LrUNOBQuikwS2xIldFR8JYLDH+WHpuoz+T9ISKXV+/8P1PldHPdbx+kBlXRQyDszaS
         jhvnAFvakEOpaQ5cJy8X+7q7Uu90gPj4ydMzNCaqdS0D3WuBsSqZ5cPPfd9zR2qss3Gr
         IDiND16w82VHWldMa6MsIay4yprT8DSQENEiBhxxnxAz2BdJTEhGY/RnR5fMNSXNTkyt
         n4SvHnpyE5ZDJGRFFf+nV2M66W9xnQBLNs3hA8V2f8JoFqM57ZqHp/h/mZ0FJT0DzxIS
         0mba+WiIh/O8ZWlcRjZYAMwhgPnicBTfbTuTgzbTatJe5VH0hHCschmO+H66OnEP50lY
         1fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510104; x=1788114904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rhR6A6pOlxFnDseZWXN693d/vUJe+c8P3tz2lrasiRw=;
        b=o6gP4NCzdWPoMlmqIwva0iQnI8ioAnLrylIgrLaAyoJRQBp5pyIehGEKX8oV/PMdqc
         ZPnhiOm6qesxiBLY4uXY5V7HEO2Vd7/mAAaLmCukyyLs+WTwwHEOtwXGf6x51bJpO2Bv
         7eDnZ7pvYnwZ/Qo5G7WS7Lfh98H32FF14VM5tM9q6LY0xIzi53YWZwC940QLzFkBvRn0
         lFprX1mg5jlW5pQc6ubWXPzO67qsC4A+Q+Ean44FV/3Bfxxcw5hQCEIa227jisu6MGmq
         IxXaNLWJ2OW1ANNwXHawuhUcDtRyW675kuKSOTBYyYaaODlKuwzcsda3rQpUgHa9o4g1
         /zFA==
X-Forwarded-Encrypted: i=1; AHgh+RoAuAh79UXMdVPXablp33zGqojQigPCfEqbVrDmkl3AX8/dVrUpDkOywBARGC4/Bc+YKjCEJ5h21oI=@vger.kernel.org
X-Gm-Message-State: AFuF++mC/IjiQGpcepMaIw93wIPB1r7vrd6zT8sT+arxz744dxaLTlEW
	3Lh8rptIrQb+W7k4/Tdjiv9EZAWXYrlDzsBk6UjnkCyfuOYAzumdMLXx
X-Gm-Gg: AR+sD11RJhtEWQK7/Wj3hiHgtj8AKt9RXHgVr0EF3ZoR03NZs9uG4DmxpacHryhoHHg
	KdO5vGI+vUgeqdhJFnMVpSF6U30j6mhqJccLrMaUxce1F2UfUIav/fl/R9gzwcYoFFlvwwfP0hl
	olbto2n5Ti9Qq4SE/H1dfyS25n76pPgA0Y2B3HIjZAoMd+RKEbQ41h8jplLXPJ6k3+N61FbKGD0
	1Xc9b3eU1v6E+osjcUZtaQeMMiiNRjztlU0soeEJV0nUqDD+1r9wzuT1oqfKOZypwD0VNimSdhI
	Siir0iGo0zXSB1TKY7kGWm7swg2RyCb69NpnPVTo7znSQujMlNz98Y8EjaF87JT7TEgsJcT3AFI
	7up6ar4VcFaTpvXTwbsVBZn/z1sFOxdYnjiH9N0qfKMJHAKNcAMtBNe8ZXpQt8TUIo5j6ore0en
	df773sBUEMDSn4sIVRj/aLkp1dhp190wZejT+qsGDm4qPv5nX6PaX0pmwB7gaEfO3KwVzwOGLe5
	d+641oP8j8XJCQ7G6y3SeAur28pL1vOOFk+fXCtfsmZ8uBlhZmnDx8=
X-Received: by 2002:a17:907:72c4:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c2491e838dcmr1642086166b.11.1787510104071;
        Sun, 23 Aug 2026 11:35:04 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:03 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 0/3] pci_hp: fix surprise removal hang during safe removal
Date: Sun, 23 Aug 2026 18:34:52 +0000
Message-ID: <20260823183458.982699-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on top of MST's RFC v5
(cover.1752094439.git.mst@redhat.com) and tries to address the architectural
gap identified by Lukas Wunner in that thread.

Context:

MST's RFC v5 adds disconnect_work infrastructure so drivers can be
notified of surprise removal. Lukas identified a race that the
series cannot address: if safe removal is already in progress when the
device is yanked, pciehp_ist() is blocked and cannot deliver the
disconnect event.

Potential fix:

I reproduced this with a simple edu device driver (patch 1) that blocks
in remove() waiting for an interrupt. Same as blk_mq_freeze_queue_wait().

deadlock in pciehp_ist() is avoided by adding a workaround in pciehp_isr() (patch 3)
where a disconnect_work is scheduled and as this is a different thread it runs and
dispatches the disconnect event to the driver. The driver can then unblock and complete
the remove() and thus breaking the deadlock and also overcoming the problem of
not waiting in pciehp_isr().This is only schduled if the PDS is set to 0
indicating that there is no card attached at this slot in pciehp_isr().

Tested using qemu:
- Hacked the edu device to raise a delayed interrupt.
- Hacked qemu to actually act like suprise removal by adding a simple monitor cmd
  `pcie_surprise_del` to remove the device and genrate PDC=1, DLLSC = 1 and PDS=0.
1. Launched qemu with the edu device:
    `-device pcie-root-port,id=rp1,chassis=1,slot=1   -device edu,bus=rp1,id=edu0`
2. Ran `echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove` to start safe removal
3. Ran `pcie_surprise_del edu0` to surprise remove the device while safe removal
    is in progress.
4. Verified that `edu_remove()` and `edu_disconnect()` are called.

Without the fix: remove() hangs permanently.
With the fix: pciehp_isr() fires, pciehp_disconnect_work() schedules
pci_dev_set_disconnected(), edu_disconnect() completes the wait, remove()
proceeds.

Would this be a viable approach?

Assisted-by: Claude:claude-sonnet-4-6

Abhin Parekadan Jose (3):
  misc: add edu_srpoc surprise removal POC driver
  pciehp: add disconnect_work work_struct
  pciehp_hpc: workaround to not wait in pciehp_isr on surprise removal

 drivers/misc/Makefile            |   1 +
 drivers/misc/edu_srpoc.c         | 180 +++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp.h     |   1 +
 drivers/pci/hotplug/pciehp_hpc.c |  47 ++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/misc/edu_srpoc.c

--
2.51.1
