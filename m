Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920D46D085
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590648; cv=none; b=W824L0Lpt0uuxEdyCO377183qiL8PhS6bcl31DDdx7GE4vucm7ONtYL/6nj1scucMQ1pZxz8l0UhD6iAxw3lPDEVGoqWjlJvNrWDpY28c9AZaegnN5vmgBlOmTcH4wZNHh9dDfAa4adYgLpQ45SiyuzjSBi+36+xPZfD68zjtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590648; c=relaxed/simple;
	bh=go4n6ZuQRhYmWKvNHMZ8SaBHasMSdrMAkVmjL3Xy3Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnHciPpFX1K1j95xZb5x5/HiREaACsrU2eXLjwgstOBFXEnVjlPXs9gYgWKP/e+NvgqoJFf6Me7KKHkIPEOvVxuocweaXAur1SENZ8zqsL/ocF3ma9YB21ClOqF8N4i2ToMPGltNkYyzfR+O00dTOkJ1ypG0TriGn9ZEl9zGOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=IZYpIrpP; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="IZYpIrpP"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66ce4a63e17so4459288d50.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1787590645; x=1788195445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxmgsXZEQFkN2JV6d5wK/Y1ilbmlZEBc59h1qR2MPM8=;
        b=IZYpIrpPQABD/TF9aE7F2X+elvOUf2Qz1oS5n6wBEo3F2fLQA+sRzNYCZ07tIitHv/
         hvIekK+RCDzsXiN2xqgjiWQM6w6+U+XJY91Rf4MiBXIz0Bt/esessruaPDUEJnhDhhA5
         TPIChC9gbVyltU1Sue72rzsb5SwdwYhlZsoLgaBzeSLzGQzQAx6vpEgO8NGuxRAVLGSD
         5p5qsGwDW/tL7LSMUeZ7Lf/bCjGJUZFmkVTJ9Gt2kum9mz2ZRoVw2tf0q0qFs73MwWh5
         vJJtFAb/9j/PRC0/oWCwumy5jgf1S1F2k1Ld9Lt98zlg628kSej+vkyQ8TXrC9i2T0Qj
         joJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590645; x=1788195445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxmgsXZEQFkN2JV6d5wK/Y1ilbmlZEBc59h1qR2MPM8=;
        b=qvM5ZfUaj1l+jMckrqq3oyGaTOnoX4KJfYTpu7IQlOAEOhMjaPjxBxcaAZujutD+yI
         1YB88pes5+X7exl+cmQ99ZRTa3fcnEtavNZh3LosFfPZ/j/9K3h3fdVmG9YlwRalbeMl
         R5350Uyj8HKhtpdMc5Y6jaRNbThtlOTmSwcRYyyO5Ou+SZtHuBZ+sfSqzwdPxSI348/U
         qJLpNeJ5CMDLOp9XzNCv6ZUX4Q9Fifk2g4vuDCk/4GhaaSXxPLapGJ7SAVghqdgiXmAI
         izxBa/xRq4Ie+9IB9TSeKZieT/QcMgZMcr1IbdAwZbfV1sVmKCIlBZAJMdFgYLgJ4Cg1
         rdzQ==
X-Gm-Message-State: AFuF++mYWhWmtENNkbE5LjAkv9Aq1K5G4ddv3AyYXR+SxynE4+tLqPm2
	LvcaNJQiMppg2K+NjHq45wochmNjBgoP/zHilPXMRDBlaz4QxgLcfP55BcSKDKw6Zak=
X-Gm-Gg: AR+sD12457ySLFmDVjBGZ/KdgGDs1HNYfix7YOtnSF+HNhfimSYiByF9Wbc73NlXn3z
	oEdyB2wvJLtVqCTMr+NfqFyt+Qo3kibzZxO2kU/3Xm0q+5peNx47A32vgA4k2Vo/FPcTzPOiRyH
	2V5ZlaU+rDA/Z3Jmbx3YyzzD2B3JRs83p1HTgdWKCwME0A3+jyF0P1EfAUrE8dNVB2Ed+6mXKfF
	gaVTF+si7RISKrqFq47jy7RRsli6tEKaljHCDz2Sog8RyAcJmyVA0asW6AmFGR4Rbkl2hd6PcmS
	t+lZtypm9zGwwDqpYL91w80BpmntfJNLYveYrlRen1BWhjKUA8iZXGeE+w/dx3/tBVAbtr/5xoA
	qUhHFmjd/d0PL/wAadsZT/RJ9Qnmd2TQbua06ZpdaoYINfpxjukuomwJ6d969by9WZul3HIISVE
	3AmPkmgRj1NzTJpv13Z/0GZ6uhiFtgqKRJsLSf3E9KbWxueyCHgME+k5B+NWMjZw2QKkcLssGe5
	PpxbSRDJzotDtYJ8sUDbeXsIqk48TYDHVTj65E=
X-Received: by 2002:a53:df83:0:b0:66d:11b0:ac59 with SMTP id 956f58d0204a3-66d11b0aef7mr641221d50.12.1787590643998;
        Mon, 24 Aug 2026 09:57:23 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4665056sm4137612d50.8.2026.08.24.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:57:23 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 24 Aug 2026 11:57:07 -0500
Subject: [PATCH 2/2] PCI: quirks: Drop unassignable 32 GiB BAR 4 on
 Tenstorrent Blackhole
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-blackhole_quirk-v1-2-fc004672cdbd@oss.tenstorrent.com>
References: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
In-Reply-To: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 joelsmith@tenstorrent.com, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

Tenstorrent Blackhole cards expose a 32 GiB BAR 4 that is unused by most
software talking to the card. This BAR cannot be assigned on hosts whose
PCI aperture is smaller than 32 GiB (e.g some ARM/RISC-V systems). This
failure also results in BAR 0 (256 MiB) and 2 (2 MiB) being unassigned
because bridge windows are sized as the sum of all enabled child BARs.
This makes the card completely unusable on such systems.

    spacemit-k1-pcie 80000000.pcie: PCI host bridge to bus 0000:00
    pci_bus 0000:00: root bus resource [bus 00-ff]
    pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x10000-0x10ffff])
    pci_bus 0000:00: root bus resource [mem 0x1100110000-0x117fffffff] (bus address [0x00110000-0x7fffffff])
    pci_bus 0000:00: root bus resource [mem 0x1800000000-0x18ffffffff pref]

    <snip>

    pci 0000:01:00.0: [1e52:b140] type 00 class 0x120000 PCIe Endpoint
    pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x1fffffff 64bit pref]
    pci 0000:01:00.0: BAR 2 [mem 0x1120000000-0x11200fffff 64bit pref]
    pci 0000:01:00.0: BAR 4 [mem 0xfffffff800000000-0xffffffffffffffff 64bit pref]

    <snip>

    pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
    pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
    pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
    pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
    pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: releasing
    pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: releasing
    pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
    pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
    pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
    pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
    pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
    pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
    pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign
    pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
    pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
    pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
    pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign

Add a header fixup that walks the root-bus apertures and drops BAR 4
when it is larger than every root-bus aperture. Resource assignment
skips resources with zero flags (pdev_resource_assignable()), so the
bridge window then sizes to BARs 0/2 and succeeds. This was tested on a
Spacemit-K3 RISC-V board that has only 4GiB of BAR space. tt-smi and
tt-bh-linux are able to run on the card.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..df54e379c116b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6415,3 +6415,35 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Drop unused 32 GiB BAR 4 on Tenstorrent Blackhole cards so the card is
+ * usable on systems with smaller host bridge apertures.
+ */
+static void quirk_tenstorrent_blackhole_bar4(struct pci_dev *pdev)
+{
+	struct resource *res = &pdev->resource[4];
+	struct pci_bus *bus = pdev->bus;
+	struct resource *win;
+
+	if (!(res->flags & IORESOURCE_MEM))
+		return;
+
+	/* Find the root bus; its resource list holds the host apertures */
+	while (bus->parent)
+		bus = bus->parent;
+
+	pci_bus_for_each_resource(bus, win) {
+		if (!win || !(win->flags & IORESOURCE_MEM))
+			continue;
+		if (resource_size(res) <= resource_size(win))
+			return;
+	}
+
+	pci_info(pdev, "BAR 4 %pR larger than every host bridge aperture, dropping it\n",
+		 res);
+	res->start = 0;
+	res->end = 0;
+	res->flags = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TENSTORRENT, 0xb140, quirk_tenstorrent_blackhole_bar4);

-- 
2.43.0

