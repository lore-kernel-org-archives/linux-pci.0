Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15E51D523
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777994; cv=none; b=Shd6RR0QoOtTNZTKuTsOSnxgg56FB8wb2TioD3osEsosZOsPzzWoxTBew22Iml52djnyfzUtmqX1MAG0W3ckqgDrCbmZtW7t1vecVYucSJMDR5Pg1LQTHCqyzNDDzVyplhtqUinwImHYtydpUxRp3jXd+6a6/oB6H1UtHmEE+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777994; c=relaxed/simple;
	bh=tlStD2UVrqYpJjIpfpo6KwRQYtKcmscPyaVEG+C6G0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnTsDT/cy2D2Dti9vn+LScVDcnQygrK7PKmIT0a7QTzHTcadWJ24Leu17X6krG120ePc1uSzNuGfrWFoUjgOiY6bJLc3Uu9N0n5dBinNAWoP7UtTUZC6zzFT7WmwPRiWUTyyKam+yAS3IGinSEI1ZQpRKvByQalcYZYO2JLKnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ualfd+dX; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ualfd+dX"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7b58fd93b32so507773137.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777969; x=1791382769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ey+xIZJ6nvCAtKQSEHdabfa9JPHPQJSR8WdDbllbvOE=;
        b=Ualfd+dXi/cNcSLpqRnZU/pBMItg1kDSRE8CJ+53D5mox+X548j3Xq4bQRCwAJx7I4
         4xltUZee4PxhYJtS5C/rJXSlhJ39XgHqIDrOLlbO79u/xc4rNVFaQndI+THClROIdeKV
         keW19L8MRRmFmM47Vl1aAqj3170IKu0M6Wna7H44nvjKk3ciY+VX9gwqqbFowWgfz/gn
         n2gAitjbKTVgfwiNFGMUL8XNEd22rdb9XJXrRkq662zKbxojClbHNOYYv62GnJT7q504
         hAgKeQ2yOQ1aezv4PGazRU2itctnhy0H2VMMnW0qPamu3WZUFZOhRLqMnAUDG7BeYMb1
         RUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777969; x=1791382769;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ey+xIZJ6nvCAtKQSEHdabfa9JPHPQJSR8WdDbllbvOE=;
        b=DCvWQ4M3shnvBrAqtbxIXjxvn301S178FkeCiDZkUIGuK850c1iQNMA61l0ItYvZcA
         pJI92OyKxujWMbLz1wVDrtlFMMmXAtLJlso41v81V8o9rSLX6b3IbfrPW+DbVKmpyFtr
         zWlSjvzsYc4NR1h+baqOqETaLzz6z6F3abpDKt1tnevITyJtX3Qsou6MKq1RexMJo5OE
         0DpeKGMGGL+GbBWc3ErJzU7KYfPN5us+4VD4o8z2dunhVKOORW4nlNPSB1R+COaXzzAY
         S6nIp7XqZqZPlrMHmtUEC5BH/OuACZGoHlt9wR9yXO3ceWRke9NE1Rq7HZIgFuCYQ6rP
         M2sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJwM5qKLRv41dHh14b54J4LaGt1E4z6BE24d6yiww0dpUWjjRq51OrecSfwlu4KwthapJIO1S5HDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP2+6tXvBDpmZenw7jZK2eQQ2m/CbhY3eS4QG09/wjgEW7phS2
	ZyZ/2m3d1Lx687O0G+xEiHOSfjmFHAq+3bxm+lzunvpl+Rj5gGoZdRuJSy/xzA==
X-Gm-Gg: AYBFou2stoQPZ8lZWoibCvTfUNmnRFlIboM2rOLOnue6XFz5WeG/Eg90P6sj9A0RpdN
	rt6y6J42HpGxDesRiaw18nLRrbq0hUxg+WkHYhMReVN+VbPzl7jKnUWcFHtKvEMGYkwuoti0pYK
	d40exVoZ7hPb+nIdm/AT9V+4vQOgIovDFiJujr4xtmuMjOxC3znPnLFtEqzvFL/xEu2CBaCqJ0t
	a4JcZjNp6GIyR6rhaAYyAsSdAhMTM24iG2t3tShN5xnEw/ppoOSxYyy65RKSPaX7JZQIaPW+4HL
	/np07jzz3XF/Xci7tFvbMw8B0aR9q5PB+y1TLErYr//WGW5O3nzjerIJUPEgsLoKC3YtZ0rokJC
	MBUQmVShaZq/644kD/WzXYOhFt/cRVjdKmvC1T1or3Ws89LMBYiOQ5fujC3NVt6PVsgvi8rnxq3
	jHtCg3QO2scDJLvFL/fUp4G3cxkeHKhrgvSUFFKXRQcM1+4JCrc6lmNh6HS2x/++da15Rlfug3S
	2NBDc0s
X-Received: by 2002:a05:6102:6112:10b0:7ab:9152:1c6e with SMTP id ada2fe7eead31-7be733a556emr251588137.27.1790777968800;
        Wed, 30 Sep 2026 07:19:28 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-988d909c4cbsm1793220241.1.2026.09.30.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:19:28 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI/PM: Do not save the config space of an inaccessible device
Date: Wed, 30 Sep 2026 11:19:11 -0300
Message-ID: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a PCI device becomes inaccessible while the system is suspending,
pci_save_state() stores all ones over its saved config space, and
pci_restore_state() writes that back on resume to a device that answers
again.  On a MacBookPro14,3 this happens to the upstream bridge of a
Thunderbolt 3 controller that drops off the bus while the system is
suspending: after resume the bridge has bus numbers ff/ff/ff and
Secondary Bus Reset asserted, and the xHCI controllers behind it are
removed.  Resume also waits about 65 seconds for a device behind a dead
bridge, because an all-ones Link Status reads as an active link.

Patch 2 makes pci_save_state() refuse to save an inaccessible device,
using pci_dev_config_accessible() from commit e18d1abc3bff ("PCI: Avoid
saving config space state if inaccessible"), so that system suspend is
covered and not only resets.  Patch 1 prepares the USB PCI HCD for it;
without patch 1, patch 2 makes pci_pm_suspend_noirq() warn.  Patch 3
stops the link wait code from taking an all-ones Link Status for an
active link.

Patch 1 touches drivers/usb.  Bjorn, if you take the series, it would
need an ack from Greg or Alan.

Changes since v1:
- v1 2/4 and 3/4 took an all-ones Vendor and Device ID to mean that the
  device was inaccessible, but that is always the case for SR-IOV VFs,
  so they broke saving and restoring VFs (as I said in reply to v1).
  2/3 now uses pci_dev_config_accessible(), which reads the Command and
  Status registers.
- Dropped v1 3/4 ("PCI/PM: Do not restore a config space snapshot that
  is all ones"): it would never restore a VF, and it did not protect
  what it claimed to, as pci_restore_state() restores the PCIe
  capability state before the standard header.
- 1/3: rewrote the commit message and moved the wakeup handling for a
  dead root hub ahead of the early return.  Alan's Acked-by is dropped.
- 2/3: the second accessibility check now runs after the capabilities
  are saved, and state_saved is only set if both checks pass.
- 3/3: also cover pcie_wait_for_link_status().
- The v1 cover letter spoke of an earlier version; that version was
  never posted.
- Based on pci/next.

v1: https://lore.kernel.org/all/20260924124221.12374-1-fbeltranmillalen@gmail.com/

Testing:
On a MacBookPro14,3 (two Alpine Ridge controllers), v6.18.49 with
e18d1abc3bff backported and this series, S3 entered by closing the lid
(158 s asleep), a USB disk on one controller and nothing on the other:

- In pci_pm_suspend_noirq() the bridges of both controllers, including
  the upstream bridge 04:00.0, were inaccessible and their state was not
  saved ("Device config space inaccessible; unable to save state").
- On resume the controller with nothing attached came back: 04:00.0
  kept bus numbers 04/05/79 and Bridge Control 0x0002, the link came up
  at 8 GT/s and its xHCI controller resumed.  Before the series the same
  bridge came back with ff/ff/ff and Bridge Control 0x005f (Secondary
  Bus Reset asserted), and both xHCI controllers were removed.
- The controller with the disk did not come back (its link does not
  train, which is a separate problem); resume waited 1 s for its xHCI
  controller instead of 65 s.
- No "State of device not saved" warning.

With the separate Alpine Ridge quirk applied, the xHCI controllers of an
empty controller are inaccessible in hcd_pci_suspend_noirq(); four S3
cycles went through patch 1 without warnings and everything resumed.

When the machine wakes up again after a few seconds (with the lid open
it does, after about 3.5 s), the empty controller does not come back
either, with v1 as with v2, so there is nothing for the series to
preserve.  The "1 of 2 controllers instead of 0 of 2" in the v1 cover
letter holds only for the longer sleeps.

I have no SR-IOV hardware, so the VF case is untested, and the machine
never reaches the pcie_wait_for_link_status() change.

Francisco Beltrán Millalén (3):
  usb: hcd-pci: Honour pci_save_state() failure
  PCI/PM: Do not save the config space of an inaccessible device
  PCI: Do not mistake an absent device for an active link

 drivers/pci/pci.c          | 69 ++++++++++++++++++++++++++------------
 drivers/usb/core/hcd-pci.c | 15 +++++++--
 2 files changed, 61 insertions(+), 23 deletions(-)
