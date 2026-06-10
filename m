Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC4411695
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099842; cv=none; b=EMVmLeMR3l+1wvrS6gKV/tROFX90a5xDJasFC1tcSvYWaMw4T4/jR2Beke4obG2deSAuVeq9P2Y+bcWCF/EtF6sG/XYPBj4jnxgZoJ5K0f8BFTUgZJ6C41/Bxbn6bswgGPCX4ZOu3ZLKwDMLwttfSyPGeOlOWSmWPDvsWD9A1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099842; c=relaxed/simple;
	bh=GCNb3jasKO6nopDqk9sCd2N7tayU62u18NPv4F9E5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chUJZcVxhC7an34nOQygUO4k7YEzstDw8ustwo1QaY/OtprN9q469ir1roTGiCTzntpWl6gnT/edb3By/mxZoGAEMYgIR3E4y9r4aoT/TZDGHG1rJc0kf5IADXcRy5l1f97MhHgnXRnJitA1bn+PRQnoCz9pS5X2h+cO4C9pOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgoo2i3g; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgoo2i3g"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so4147516a12.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099840; x=1781704640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=Dgoo2i3g3MRrGcO33z7qV+Hpz1zEn5UezowdVt45PCXOOlexFoT/+ayKhOvo+jl+c9
         cMY0ngh6u36jrP+q4EIgSNayagiLzmhROFo0XXVXvwkL8cc81y6EDpOolkVWGDI72kV3
         0icShtggLnmXKP9KevZMhs+Dva9PBkYyW6sj2oe96oXUasd8MHnM5k/bgzR0TUDavaxL
         nXEm/fVuL1XCikklU0IaS3fwtrxxnbaZplGNTAjnnT7hQ8ei7dRHgGcXOq/YE0lv+Bkd
         w/i82p8n73O0lT6wFwKrX18dO93IQVsFSXJybdh6yhqtU4rue5SnyZYZGxC3IA7qGQaO
         s10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099840; x=1781704640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qCxOpd6GcFF1a8SEEvdg2ZJnAIlzX8WCb8r3Ehd1kA=;
        b=gQ6lFpFK2w/0TwJawDtAYV7eYN3/q34gO87KxbnH9oYGof8rkcc2y3TE2yk8I8ggkV
         FzQKsYIwFC5aBV058X1hTKOOkbMy+s2X0RGCvEoWoAGg/s2ANbtoqI3HEYwSHrpTDeo4
         wsJrUdXKZ34JA8rF8aJGwXEzvkNXMX3UiCcu4udyY+4ohZCQlbLG3EmkiGatrRltWRZv
         XJQdDc6vqNV2IwSR170mx9ZSUkmWvx+9i5jAUQaMro4bquiVvLHZuc5izL5ch2b/PysY
         17V8HLrY/sDQ6wCBqpsSiPgeiq0ty7Y3N3P3R+5LZPkn4ThuPbHFSFDUHH3DdWJhy3LX
         jcjg==
X-Gm-Message-State: AOJu0YwGcCFjP1/JbzbK6dcZlxQdk+maT5x0dgtmgLILjrPUmYs6jy+8
	CTL45oQIRv0iILJpwkv4PJIQ7nImyq/ngdWR46p+epJDwxl+sO/8ETb6DzW4KhvKCEI=
X-Gm-Gg: Acq92OGYop9arxhwljAiG+uPFO+uDc+2tDx5+T0qe0i3L+W3K9wESqQgzrMAwGVhB5/
	UMMiOlTyfba+g1Kb88ouSOOf9ig48KeZLg5Xf+sjZPJxfRdW5eIZrmqBTbuaKF4cb2RDVBQzPqm
	zAj8ktiklRjfPuYDZHZq+eo0YJYIqc4k5v5VyE/LmhEvwIBO8aEC9aB3D/oqJ1J7LHz6TKqfyYS
	VrAvoPr8l4echVkCq3Mwr0dkTz8ECKpm6D9pXRYbTiDLdqpfnkGHJ9z0fLQLo5QK+we9bSqrydS
	wxjDf5DJGGyhL4ijA2sdUcC0OgiPfKtp/GsSJ88zB5RGGmgl5N4UdwxCfMDjA/gwCf0cF/hOMa8
	CixxHYf/nhPCDo1QXTdhPcTjCqtZQFTUTtm+BAgrg9fzHYeKUvH6NM/x0o+CK5UOQjUlpAPxQbQ
	lH1UrczLWH6lkB8ZBnkwKkzXuO/jnf92ariHtDI+QYJv/VPJRNRBIu/uO5CK/YduRNjRw=
X-Received: by 2002:a05:6a00:2e18:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-842b0ec6826mr26157275b3a.45.1781099839546;
        Wed, 10 Jun 2026 06:57:19 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm24411168b3a.45.2026.06.10.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:57:19 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Yinghai Lu <yinghai@kernel.org>,
	Yuguo Li <hugoolli@tencent.com>
Subject: [PATCH 1/2] PCI: Bail out of pci_read_bridge_bases() for SR-IOV virtual buses
Date: Wed, 10 Jun 2026 21:57:08 +0800
Message-ID: <20260610135709.1630627-2-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260610135709.1630627-1-hugoolli@tencent.com>
References: <20260610135709.1630627-1-hugoolli@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_iov_add_virtfn() routes through virtfn_add_bus(), which calls
pci_add_new_bus(parent, NULL, busnr) whenever a VF lands on a bus
number different from its PF.  This produces a pci_bus with a valid
parent but no bridge device (bus->self == NULL).  There is no bridge
to read, and the SR-IOV add path never invokes pci_scan_child_bus_*(),
so bus->is_added stays 0 on these buses.

That stays harmless until something invokes pci_rescan_bus() on a
virtual bus, e.g. via the per-device sysfs entry:

    echo 1 > /sys/bus/pci/devices/<VF>/rescan

On x86, pci_scan_child_bus_extend() then sees !bus->is_added and
calls pcibios_fixup_bus(), which unconditionally calls
pci_read_bridge_bases().  The function only guards against root
buses, so it dereferences child->self and oopses.  The fault address
is the offset of pci_dev->transparent, reached via the dev->transparent
test in the pci_info() call.

Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV-capable PF
whose VFs span multiple bus numbers, by writing "1" to a VF's sysfs
rescan attribute (LTP's tpci test does this implicitly via
pci_rescan_bus()):

    BUG: kernel NULL pointer dereference, address: 0000000000000860
    #PF: supervisor read access in kernel mode
    Oops: Oops: 0000 [#1] SMP NOPTI
    CPU: 12 ... 7.1.0-rc7+ ... PREEMPTLAZY
    RIP: 0010:pci_read_bridge_bases+0x39/0x120
    RBX: 0000000000000000  (= bus->self)
    Call Trace:
     <TASK>
     pcibios_fixup_bus+0xe/0xd0
     pci_scan_child_bus_extend+0x6b/0x2e0
     pci_rescan_bus+0x11/0x30
     ... (sysfs write to .../rescan)
     do_syscall_64+0xab/0x500

With this patch applied to the same tree, the trigger sequence
completes without crashing.

Triggering this only requires:

  - x86_64 (or any arch whose pcibios_fixup_bus() calls
    pci_read_bridge_bases()),
  - any SR-IOV-capable PF (e.g. mlx5, i40e, ixgbe, igb) where
    sriov_numvfs is large enough that at least one VF crosses to a
    new bus number, and
  - a write to that VF's sysfs rescan attribute.

The same NULL self pattern on SR-IOV virtual buses was already
addressed for the MSI IRQ domain path in commit 38ea72bdb65d
("PCI/MSI: Fix MSI IRQ domains for VFs on virtual buses"), but
pci_read_bridge_bases() was not updated in step.  The hidden
assumption that non-root buses always have a bridge dates back to
commit f92d4e29d785 ("PCI: fix wrong assumption in
pci_read_bridge_bases"), which tightened the entry guard from
"if (!dev)" to "if (!child->parent)" to handle root buses that do
have a self, but inadvertently exposed the "non-root + self == NULL"
SR-IOV virtual bus case.

Add an explicit early return for bus->self == NULL.  There are no
bridge windows or transparent decode flags to propagate when no
bridge device exists, so returning early is semantically correct and
matches the existing pci_is_root_bus() bail-out.

Fixes: f92d4e29d785 ("PCI: fix wrong assumption in pci_read_bridge_bases")
Cc: stable@vger.kernel.org
Signed-off-by: Yuguo Li <hugoolli@tencent.com>
---
 drivers/pci/probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..6bcc3b58031b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -577,6 +577,16 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
 		return;
 
+	/*
+	 * SR-IOV virtual buses are created by virtfn_add_bus() via
+	 * pci_add_new_bus(parent, NULL, busnr) when a VF lands on a bus
+	 * number different from its PF.  Such buses have a valid parent
+	 * but no bridge device (->self == NULL), so there are no bridge
+	 * windows to read.  Bail out before dereferencing @dev.
+	 */
+	if (!dev)
+		return;
+
 	pci_info(dev, "PCI bridge to %pR%s\n",
 		 &child->busn_res,
 		 dev->transparent ? " (subtractive decode)" : "");
-- 
2.43.7

