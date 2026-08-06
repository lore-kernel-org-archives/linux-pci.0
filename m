Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599222C11CF
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052893; cv=none; b=CzSIhxjp6o41ue5f1DT9dbrMyA1P1zxxSqaHU4XbyrA7J/Fv8dr6JwWCJx82eqO6pOMLKyxUie6q5t5LotCxxlgJiutZwbekmQUeYjl+w4JnBXkgEAnjNkFh2J9Z2acCcKvCRN1nb8Ywc9vkJfIDCu63ozV1LkCAJqgyIPJ/mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052893; c=relaxed/simple;
	bh=rxX9sb8omrOuRjWHKox05kj5+f6wT4kFFGbiQIYgHms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCHt8Q+cLAS1CvuGMN0Cw7PHMa3hMvCzYVkMscBokoR2D82aRwhoqJOmvM7Yo8RuFwN7fEIfKsRvvXOdl/gMkGRaAtFvbnSnpuft3nO5AG4jtKb+dKFej6K1zMD7o/FOJ2cNPzpmrdnC/mxPeIh4CTrFQC8j2vpdLmkukK2wrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ued47D8O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ued47D8O"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486672f03cso3353677b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052891; x=1786657691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnzWeudK78ev0HxgMilTAa80DeSiwwfaiQpToKncCPM=;
        b=Ued47D8Oho8s8H390Fh9nikBFQeIVcMqYuqXXWOd8/aKGoFL1RehC6H+V62ERFG6Jr
         n39aT71Aj8D5No1YNIglQdNQ/tKVincxZisHyM/jF5/ZiUod8Smk61h5rnHI5hsV4eAh
         RBPYUPDuFMZEmFY9C8kfm1HjahB0MX+mVu5zqeD4pFtqaluKuSb01hb/6yrOM3N6CG6R
         lDS211oWLgrXlyQBEqSY0+8DF8cmIV9uaHCyqxafBrW+NoOUh6fq89L015iY4cXBU/cx
         xut4lagH1fj0VxKoxxFNN9H2XHCdAzbPm5cA/5bZo+j4NoTc7ZFx1pCcv8JxR+2YEpi5
         Gobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052891; x=1786657691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnzWeudK78ev0HxgMilTAa80DeSiwwfaiQpToKncCPM=;
        b=hWjSezQoncbHLV+PouX99cQAX9Qbp0p2AekV7FhWu+ezEJ2lrgMVWBB/ngktF6yS0d
         C+RluvJvd8X8MQeVRP0+houbkPa8lYCx7HmE0bdkOG7Ei4Zh3kqHl+wAheCSb2MB5MAi
         p5WwIacnp8F8/mnkUDjPV3Qpui2ozUObbtGv1KDiM2blNlApHG9j9S+WUe2BnLyZcVr6
         9VbLZZyD3e4pqAkNKZe1AlRxyNxZ0IjDJ3SLmkLRPZCCwf/3zXj4G9lPmDUuZHNPmqi+
         9TJdEKYRR8HKnoxshu1bZPbYZAEq9J0Q+jpVNOJn6HpyK7b/V+MuUqZ7O3+8oXWdxVQQ
         jAsA==
X-Forwarded-Encrypted: i=1; AHgh+RqrEdDcSo0uDm0QiphVSYbWcsh6VLu6IIJ2+G88tyUii0Xqg64yY95Tmo1FrXneOHyWkTQRqgLZNWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkNLsnKWDcN2tYgS7AyiEBqvwwp/9GPwtDzdbWL71vbLXtw+H
	kNIjeyV4To9f9+xaIf+swDhSNrFEdz3/H4AuXaVdBp2GljsnSE5RNaBY
X-Gm-Gg: AR+sD12A4u9WdzVGaZkd/UhAfejCsFfvTnfTqQt9AQ1l4V16BuR/3+slVC2nUBtgH7q
	HB+SIghvyBadlG6hjfD1vgbRD5Q9yEPKXaS72lqIYgQRg2tuE6QUovAUyEPkMuuBQJ3tfKuf3An
	7leD7FwQvcxk/NrgAvKP70tOH8t1pqisa1pSXqSlNSHDUf64KN+VTnI48Exx1T3GpFMNXG3fRQu
	Ciwf0NY3eHlljtuqrWEOhli3LthQMJbAqUIdUXFqU5Z78Km3uajlba4lTlWZgPai+2brrJQ6tzq
	gikZUwiD3JGBDUBjxj1iz9c8scREPb7vRXnhHCZSP8pEVyHxh7iCEtUyXiMx74/TIMLVeqOkxjz
	3MxG/Pj13VM0lYhSjd2RtAEJWMcojVyC2558O66msnN0G4nnwnE7LjUDzn+vRWGY+eM7uKjkYRZ
	q+9txKPA6Br6F6rN8qjvYoBmD/GeL8yD/qRRFV897T/qeoj/dyf8sCe0fV75GRt3dJ5d5/ZYFXM
	acvwgPoLpz/B4poBtPfbLh8wzsOgzh4xN0HuGHTAg==
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:983d:e9b4 with SMTP id adf61e73a8af0-3cb8603af0dmr21269181637.33.1786052891546;
        Thu, 06 Aug 2026 14:48:11 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bca4647dsm498839eec.18.2026.08.06.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:48:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw A8 root bridge
Date: Thu,  6 Aug 2026 21:48:08 +0000
Message-ID: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSI Claw A8 (MS-1T8K) hard-locks on resume from s2idle whenever an
SD/MMC card is present in the onboard Realtek RTS525A card reader
(10ec:525a), which sits behind root port 0000:00:02.2. The reader's
PCIe endpoint is fixed/soldered and not user-hotpluggable.

Firmware advertises this root port as PCIe hotplug-capable, and _OSC
grants the OS native hotplug control. When native hotplug is OS-owned,
resuming from s2idle races the port's hotplug/PME resume handling
against the RTS525A's own resume sequence when a card is present,
hard-locking the system.

Two kernel command line parameters were confirmed to prevent the hang:
pcie_aspm=off and pcie_ports=compat. Both stop the OS from running
its own hotplug/PME resume path against this port. The former does
so by dropping _OSC negotiation during boot, skipping the path that
enables PCIeHotPlug. The latter prevents the PME service resume
handling by aborting registration of the ports native services. Testing
different kernel boot commands, including pciehp=off and pcie_pme=off
did not resolve the issue. AER, DPC, SHPC, and LTR flags were not tested
because the hardware reports that the platform doesn't support those
features.

This quirk implements as narrow a fix as possible, clearing
is_hotplug_bridge and is_pciehp on the root bridge, scoped by DMI board
name and this root port's bus/device/function, so the port driver never
registers a native hotplug service against it.

SD card insertion is handled entirely by rtsx_pci's own card-detect logic,
so is unaffected by this quirk.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v2:
  - Switch to pci_info vice dev_info.
  - use is_hotplug_bridge and is_pciehp on the root port instead of
    native_pcie_hotplug on the root bridge.
v1: https://lore.kernel.org/linux-pci/20260806190439.12022-1-derekjohn.clark@gmail.com/
---
 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6501c949c5b7..62480fe10bcd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6420,3 +6420,26 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * The MSI Claw A8 firmware advertises native PCIe hotplug support for
+ * this root port, but native hotplug handling causes resume failures.
+ * Prevent the PCIe port driver from claiming native hotplug ownership
+ * of this port.
+ */
+static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
+{
+	if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
+		return;
+
+	if (pdev->bus->number != 0 ||
+	    PCI_SLOT(pdev->devfn) != 2 ||
+	    PCI_FUNC(pdev->devfn) != 2)
+		return;
+
+	pci_info(pdev, "disabling native PCIe hotplug\n");
+	pdev->is_hotplug_bridge = 0;
+	pdev->is_pciehp = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
+			 quirk_claw_a8_no_native_hotplug);
-- 
2.55.0

