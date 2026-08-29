Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81A341650
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997303; cv=none; b=o0WxnogYkZPWGuLfcjvgkhL9MMDTtC+T0zoLJ76SvNp1IqqVtIM2Q92MxPVyyBWFXtJFeTEBdyDE4OofJ4p9vN9PtOtgV3kiw/+Ah/dUQmQBWRyvHSgdK/4v9Eit8KGX2fNYbC279ZvrS/joJkDlKrd8oTdmf3J1eMyh5GoJIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997303; c=relaxed/simple;
	bh=tGg7OnyL8/9JmC2shM+2pm7rQpu1dy5h3ZLrB4k//cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2VPOgw62FTAjq5Ecs4R2KPu4KEQ8YNWzvIGeKobHC6SJaHBpMDJ4mLY5z/PhBGZc6YIargtxjuwPuI1E5D/jB2Zm7sO8wBXhYwuK+8BDZSediRtG9MDyLQSTuy1FVpj6+Nc4e2YKe/CQ2xv82cBOCRqWw8hGnwtRX/Q6YkaCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTB0P2os; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTB0P2os"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e4efb18c9so150647b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997301; x=1788602101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+XYc/uhp00twA6hJyfMPfZH8ZjPnbMc9r1vC8WbHMM=;
        b=kTB0P2osEwYH7u+U9W9rnjkE1jsj5xpqGXD7R6EJLXyvjV/gtzAYRTjZ+irtalDgeD
         gM2X+o+6/cLbTPaHr9Ybfleyqge4eTX8tqwAQv7PEMbwAf6zb1dZ+PHk+TEVuFKR9uT6
         AL5YvsdNoqHH+kHXanuZEqeKCoC5FQEOI+gtD1e7UVIzXBW/kLWYamBHVq/F4CTGNLjZ
         qlYXKh+4lpvXUeCPYQpe0NR8nZdiGyl3tOeivAJkXz5gBZVI7RKxX3kNeT618UXtLaWC
         C4eARuRrFyMuhGkqMzcp3U5Ylzt/BQj54CX4bVsmkvbrGa32LAdzVBHLsH4CJrNzVmbu
         VOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997301; x=1788602101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+XYc/uhp00twA6hJyfMPfZH8ZjPnbMc9r1vC8WbHMM=;
        b=pHS4fCqsyD2R4nORDIJE9vo1PYhGJNV8AdDUATMHc/M/Zspc87i41eHBpSCsN3M9f9
         8OhHjY9tZKGut99Qb3hn9TFqTQq2WUw2xh6lSKuIWVR/IUo8cZ+jNi6XjIPhShKURFL7
         bdrw3YrzJfw8mK4TUchUb+JJHJ7QYEjuoniom33i8AVdrMq4VeFZdnMsBb8NKVdY/Omv
         t6uiBPoojcvswsuLCQHBuQQ1AbsIi1r4LtKgr0slXHICQWi4M5yuefm1CXcZIQhCYoU5
         /wOusUOYkD6ZwLvwUSz3+DYJW311zOEkUz4mx7p+NFVnsW3NyttNrBqsp3wS1281M7dY
         9o0A==
X-Forwarded-Encrypted: i=1; AKwUvByDQWIUO4BzCeqKooMo1ZlDiQC8f6LXeTXUoeVFQyQ1YbVCaLU+wGQqWyamalF37Ta/QPd2MYxoUZo=@vger.kernel.org
X-Gm-Message-State: AFuF++nS4A98UGWXmJRiJI2H+daT5RInxT1vmfdFhGkwUw2mrv+TpbZT
	pU973bsRoNSscw3Di5fspEIbPO4J7hffgiWbbq07GTyce5qpi1nhfwjA
X-Gm-Gg: AYBFou3LY54Kx3oOTvGBuz3WCkg5G0VNILOMHy0nd4z78meYu4FNdFWjCbQpxug3g0q
	072QXgrzg3DIwxG4uA3GgolvMuVDsHs19wBdEn7Kce1Kmz9HrjrGtxb46KpDD64WoNQuy6ur5Cv
	LmZeTdpJ6xxcneLSlVxF/bmxj2oDmJfTbakayFG1DDFdjseRloggIcVave3OIfo1n9bAqI7uUfC
	kdYqKRBNyuZdfsNr+QsWC7M0f2Qd/zNWenqPgn/6+AlZY9j8dizrjHdKqxW0t3+5cqedzVs6K2B
	aaGw5IX+QOav5WH8cJJtCQ0DZeH99trBlXADjTM3EmEBArfDzClt866Ls+LuyOsTxm39pNzbVGg
	PSDnjXFcRKS4vPmGRNoa8algbNd5opBK0GXif5qXMZ/OuEHK5CMCqkVELPj8sUu2rVzsS09EQ+Q
	pAUVeLNSmxNDxSLen+BpqNgXMcy+eHWhhZPaClCHaPpeh1peAa8O3Xh7eU13fn7TRCMGQjPmzuo
	JMseSRFOofGSOpqGui9wngZXFO9xJkrJBs=
X-Received: by 2002:a17:903:228a:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d74df53523mr116538065ad.3.1787997301027;
        Sat, 29 Aug 2026 02:55:01 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:3104:d691:c7eb:3b03:2c8d:127f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm15775697eec.6.2026.08.29.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:55:00 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: nika@nikableh.moe,
	emmanuel.grumbach@intel.com,
	helgaas@kernel.org,
	markpearson@lenovo.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>
Subject: [PATCH wireless 2/2] wifi: iwlwifi: pcie: request a product reset when the device is gone after resume
Date: Sat, 29 Aug 2026 15:24:37 +0530
Message-ID: <20260829095437.44716-3-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829095437.44716-1-navonjohnlukose@gmail.com>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms where D3cold removes the WiFi module's power rail, the
device can come back from suspend completely absent from the bus: config
space reads 0xffffffff and the downstream link never trains.
_iwl_pci_resume() currently notices only a subset of this (scratch ==
~0U, and only when the device was enabled), then "hopes for the best" by
re-initialising over PCI, which cannot work - the hardware is not there.
The result is several seconds of handshake timeouts and a bogus
ADVANCED_SYSASSERT dump before giving up, and the device stays gone
until reboot.

Check whether the device answers config cycles at all, and if not ask
for a product reset, which power-cycles the module and re-enumerates it.

The check is deliberately placed before the STATUS_DEVICE_ENABLED block:
that block is skipped entirely when the device was idle or down at
suspend time, which is a common case (e.g. the radio was switched off)
and one where the device is just as dead.

Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP errors")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221695
Cc: stable@vger.kernel.org
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1232,6 +1232,18 @@
 	if (!trans->op_mode)
 		return 0;
 
+	/* Not answering config cycles: it fell off the bus and will not come
+	 * back from a PCI-level re-init. Deliberately checked before the
+	 * STATUS_DEVICE_ENABLED block below, which is skipped entirely if the
+	 * device was idle or down when we suspended.
+	 */
+	if (!pci_device_is_present(pdev)) {
+		IWL_ERR(trans,
+			"device is not on the bus after resume, requesting product reset\n");
+		iwl_trans_pcie_reset(trans, IWL_RESET_MODE_PROD_RESET);
+		return 0;
+	}
+
 	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		/*
 		 * Scratch value was altered, this means the device was powered
