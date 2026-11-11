Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389452;
	b=gedKZTft6BvY6H6i3GOlnhKIM2Rav/bDDne9zGyv/4LeV9B6qBDxq5la3LNwER+07rVK
	 c0IOUb9niD35bzLfWrp11mCdaZI8GkdCG9cwQolmC5O4o/FMLvxxn3K5LxiTDIUflNldr
	 VRc6VVIUa5mxyG4rnugFoy9+47JN0eaiGMdKKNTG2PGZObaqTxngPq36batDcmiFKHYE8
	 Sn6PU3215uld+5507qu/+JIegshQQ+EDaHxn94b49IQL7oehYQ1bdGH8ATq2+krHyhtUQ
	 Dvtyph/rRtl5HCnnNUvc9FXTC31oap+vVFikszbD7JdfZEQbqfPGnI8sMHSGRBVWchA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
	b=T6Wa8yDkedipld/tDWdUHVRFDpKjkQrkg0YYd1TIQHa+DZrp1HbPmH5QUBeB2rFRC/am
	 QZbNH5VuyR/aWAaHnmZTV9RQeN5pduKal+n+AOI9fED2R7iBMfuPnIdIRAaCTG05MbfAw
	 URPN9xQepWQc3Lsry4WE4XOIu1Q1etXCsuHu3q42GpfHBsPajk9PbRcIF078TPKDGJ680
	 +qP+o0Mt6JfRFm5WN+KvnrRqfbkDA5zj/vc/whBOb25EUwU4tMehIvmYIU/w0yus56hxh
	 SiD0poZPUqy8AW4dfi5yzADEyT2PNCDJNjFoVHJ4cY9qlt8KM4NoscsrPP1Tm6Bd02A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E57jlpa6;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10A606A333
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D10A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E57jlpa6
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2602601f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389451; x=1794994251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
        b=E57jlpa6Vs6e1i3nKvCpjZpzm7ci9u/J/XqtTCOZMfFfoteIFJuP7zC3sPtujEAAmG
         wYTXJn3Rbk+jy+0+vDXyjlfgggPeaJIkcgOiEkiVy0OPc0B2WzyzBMlg/wYB0VMfLDie
         y8+re7NbvCoPWAZaAw0U+pf2QyHfldwnyLBqbnET+OwAlIpHSrs2xgm1BuQIkz/8Oi4v
         44g/A4qGsnjH+Gtsthd8C3Azy8y3N0deRf/ZD5GzIiir8uJPU2ipD7V0PaFLANwGIBs1
         rPU2ZSo4gsMPdAxqk4BQXMo8TGyXU7xkbG7FmFRtgdcV9CbhHKJMIOZZrAUSs1TMj423
         8cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389451; x=1794994251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
        b=Pv+LyElPairkFG+xVKZzy1Lhc6mggXG7b7+JSvIuzXp8GHURtII3x8+rwwlxCawlYz
         UcEgV+t3V8rSvMTZQq7uAankFxkvH6WDaGF4P2IR5ET8sBfhqwcnlDACea1PigWNMSbx
         Tq7LBrk0XkXkPDMv/+SV+2EX0aD43dD0W2qkXZBkl4nUuOTRvSpQ2AKCSTrIQ6Apj+xA
         fznsT2yXWB5QTSdKnOZP6NZGOLhpUiwaT2vduz63TNQReIS661yQQ2Qb945y8rv7RqWn
         VmrkIQYqnN6y2LSXk0KD78wn0bh0WEtmo/UGHNyP7HdhoO7MmAuAOoFj/1F7Wdlb82kH
         /KnQ==
X-Forwarded-Encrypted: i=1; AL+hErHqpL/+sRe/ySld+96C3Nu1wcETrRYVByNvxwoTj+bHkRYrXofVpimRL/Rt/+Hd/4ZlhYBwUBDZ82Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1YsasEfiPYjpLSP73Sq5V1LJ89DnIBKdDDFbinzwDyphWZbJB
	xXr7Hw70futgKadvhbVilqxCfzds2mV5p2wWIzT/jrgDWMGaqcN49qIc
X-Gm-Gg: AYBFou2T8eqBl+jszLt4HvIn8fxcTomQvbZoCzf6G5b1/dOo513FL9kWXG1YvEur7Up
	EtblC1EZIjf3aoiXDHadAL4rIQyMhktVSek0mbebrw2T2NVwf0K+63aqjNDqUo0VJGP3I9gDJwe
	ucHCPVzK5ou1E/exUCwP4aI/CKRTQ81AVAR6Iji+PCW/gh9ScPljHnmszh/5njROFxV/+/l6KAS
	ZNqQibtqdKn9MUZExsbkk7jZm4/+opGc940IcxLvEtFbiK6RgIA9MBjXmC7Cunnluviw35GeJcE
	nwjb6qbLIgRUOdH0+RXgPoIuPSwWlFa0yU+RGskNuABbj4Rde/1yVaBa74o+k92Eu+mrqz1adv2
	MTM9RnSrAmoL8PFLqBT3OmX4dPhuTK4Q3EwECeJdAnN95le5XL4Aiu68ku9mVxYBPtCDMLcDnEC
	sm8NEzBMTgSd8n+JEqMDl3DProOd8eq432zJF2OZF09Pzn1zlJCQLd391Y07fzfvjzR7p1wEmSh
	xuMgzSI1MjzjI0CLsOF35MU+fN1621mnEFlj4nP0pDkyQkS30GdMf+AaPhi2MMWeoclwNsvnBRX
	3NKGeA1WJpe0/M2yUcq4cB06w7TTYa9AjZ4OsMz/Eth4qmfKeYBW/tNt2YfK8cP3UQKgHFRSoeC
	KXUoaDx7abC9pxB47TfiVBUVOY6vuwmFTiAzVkPtK9eIod/NEgvjwQdEnBNp63LAjHsm7RSyrrI
	k1Aw8cn22iIW0=
X-Received: by 2002:a05:6000:4917:b0:490:6e0f:a024 with SMTP id ffacd0b85a97d-499c69ca529mr2701747f8f.13.1794389450677;
        Wed, 11 Nov 2026 01:30:50 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:50 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 1/2] igc: don't disable ASPM L1.2 from __igc_resume()
Date: Wed, 11 Nov 2026 10:30:34 +0100
Message-ID: <20261111093035.513635-2-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
performance issue") disables L1.2 on I226 in probe, in __igc_resume()
and in igc_io_slot_reset(). The resume path uses
pci_disable_link_state(), which takes pci_bus_sem for read.

__igc_resume() is also the runtime resume callback, and it can be
called with pci_bus_sem already held: pcie_do_recovery() runtime-
resumes all affected devices through

  pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)

i.e. from within pci_walk_bus(), which holds pci_bus_sem for read. If
the igc device is runtime-suspended at that point, the call chain is

  pci_walk_bus()                      down_read(&pci_bus_sem)
    pci_pm_runtime_get_sync()
      igc_runtime_resume()
        __igc_resume()
          pci_disable_link_state()    down_read(&pci_bus_sem)

A recursive down_read() deadlocks if a writer (e.g. a hot-plug event
adding or removing a device) queues on pci_bus_sem between the two
acquisitions. pci_disable_link_state_locked() cannot be used instead,
because on the system suspend/resume and ordinary runtime resume paths
the lock is not held.

The call is not needed on resume in the first place. The disable done
in igc_probe() is recorded in the link's aspm_disable mask, which is
only cleared through the ASPM sysfs interface. The PCI core honours
that mask whenever it reconfigures the link, including when the device
returns to D0 (pcie_aspm_pm_state_change()), and pci_restore_state()
restores the L1 PM Substates control registers saved with L1.2
already disabled. Drop the call from __igc_resume().

The issue was found by the Sashiko AI review of an earlier version of
this series.

Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 62a7c5178..1b5dcc166 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7585,9 +7585,6 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	if (igc_is_device_id_i226(hw))
-		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
-
 	if (igc_init_interrupt_scheme(adapter, true)) {
 		netdev_err(netdev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
-- 
2.53.0

