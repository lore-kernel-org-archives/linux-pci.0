Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCED4C8FF3
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043088; cv=none; b=GOELW6QvLrd5zrxt8pDT4B9toCQ+Xskkcsv5tzsAJOvuesr0mgdEd7hyKvO0cWRRaidaz9MrnkFGZrANKD11sNxeRI0lUMBqMNTCTkDygmY36xyAsItVEqzG/r3EWi7YvzvtyqmdnrYvQqC+EOf2JGcgQVSKmd0iIddD/a478QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043088; c=relaxed/simple;
	bh=WDPDBEfJZfG7WijWA3DbGunhgE7M1XEqMwSx3UeUJPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2TOhb0zNtuFHrd97T8D2weYhuJXhjn75iLRRsDuk5aZyQ8etPduIU8uH0l+vTia7dyHIyTPtdBbwu3YHN7SyZiTWieLrfeYIJixHZsiJOLVcSWw92Ix8m+xA7vHlJPzwlO+w2vkfw260HQiXGSM2OomPU0qcsSyTvfidVrWsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsAbp9pm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsAbp9pm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2743921a91.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043084; x=1786647884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6F8YP/xVBxKFWuUg04Icqu+xUIgUSNqbk7COy2s6svU=;
        b=GsAbp9pmY+QwR/FM4olYxsTDgZw1sWwSqBms8PCaA0+RojdRnGDcpLrLJBdk1OyPCw
         362sapWzXWwQqkgc+CJsR/IpW/G3k861nMj68oKnhYf3TtxPEwCxF3f82YCm2gAXSTII
         rwq40OhD97ONw9z5v+06ouokx1EqGvnnkW/NoDeu5L3Rj8m5hpYfbG5MRhovwQ60HLSe
         VGkHdYkMLt4Jgyyk2qIibsKVY5QCuJQU6k/LaQC2zWqjqh5GUU5CSNUWmVsbPiIg9Qfy
         I0k0NHOIq7C0RGq4XvpI2gletN6+Z+zBa3RFys/czctjIzPa1SS978dS9N0Qg6YeEb6D
         tl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043084; x=1786647884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6F8YP/xVBxKFWuUg04Icqu+xUIgUSNqbk7COy2s6svU=;
        b=NgCII6nWZrxaeuoaf0QiPD/qdnpwRT7lWi8ETiVHe2AhULrnaEN4+l2TphfHSKP0dr
         nptEFCwNqtR41Qmh+DbqBeDgBpEwgY7m76U1BMLHbeOLZGVsPdENVZp2pg16ZfSCo64+
         UYV/lEnp8QKl1mjorvJCX0F8KJyTe9Pib21YGSCfF1TWf0ydW3Dr0MsOdrQqg173wsz4
         nYopoihEi+G6PGu2YZqH6lH2FXxts75Hxu9kxAzylMWKluMOJUKJMyXrdf4YiyRYqIpt
         sIlC3XFF0/vAGOGBJDBAuaKv4rpN32h2TrZD4zX45xzEcpQxXndwEDIyA9C0t6NkY4o/
         uKkg==
X-Forwarded-Encrypted: i=1; AHgh+RoPUmpZuOcCB6V1CaPs7fkzj6l0tzuvRqxTFWkz1+YBNT1fE7lKjWTUt6viP7ktxygNVbX+6dOf/18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX15wFTI/JsISVsHwilRtV7GokzbxfjkkwxhkgCp9ddl161sMe
	APRQywAuhHfrD1Dr57OKIT5hywiVnbSzkzq8i/ROvhBj0a3G9sEcLM0n
X-Gm-Gg: AR+sD120h1yVZwHZfX+Ru06pCDE8gHJjSinMPcziROQBcJbjme/M0YLJGEyuyacq7Gw
	xW0w2Q0CFbCzK4PDrVaETPISi4+YmxuPSMkJzZOdkyvgyilGPI0qkjiRaHhQJG3EoQNJoR6t6Mr
	mkDywLCpo3tODL6cYZH2On1eHrQHVBZQuVgLjyMixD5GHj0DHmcCDjvBOQpfxPlNqspuOHVe5v3
	xTOFkdhYf/bNtaXX8TtpTJhSoHp8Z5izcfBCkp0EymDP9C5+HdlywRgcIidDV2/L7Hu+HM2sOsZ
	buiTbod/r702MsLLAOUwPh4eUN+nJfY9EwlnKvsCLMOLY/PiNnuNRSZUGDe0ntOAzINv5jKDcUz
	2qXA+p6ruF0b0FcVBU1/wlM64//NPO2j2I06yXkJhBxeeZ0gtPFnLPyhtwCwOdf4vWi0JLphtvX
	bYewl1/V6CsJQxvYGN8bztxcbO50tIvqHXr7l9AnZzeCwCeB5gX28aolclMxybtxvHgG26njaMz
	xEqYD21MgqN7d7euAl9L9hsw/JoyQC0EGtFj//VjQ==
X-Received: by 2002:a17:90b:578e:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-3903c5ebc8cmr17965586a91.16.1786043083775;
        Thu, 06 Aug 2026 12:04:43 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141009ab943sm666233c88.7.2026.08.06.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:04:42 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: quirks: Disable native PCIe hotplug on MSI Claw A8 root bridge
Date: Thu,  6 Aug 2026 12:04:39 -0700
Message-ID: <20260806190439.12022-1-derekjohn.clark@gmail.com>
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
native_pcie_hotplug on the host bridge, scoped by DMI board name
and this root port's bus/device/function, so the port driver never
registers a native hotplug service against it. As native_pcie_hotplug
is a struct pci_host_bridge field shared by every port under this root's
domain I also verified this to be the only slot under this root bridge
reporting HotPlug+.

SD card insertion is handled entirely by rtsx_pci's own card-detect logic,
so is unaffected by this quirk.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6501c949c5b7..8218f423fd2a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6420,3 +6420,29 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * The MSI Claw A8 firmware advertises native PCIe hotplug support for
+ * this root bridge, but native hotplug handling causes resume failures.
+ * Prevent the PCIe port driver from claiming native hotplug ownership.
+ */
+static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge;
+
+	if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
+		return;
+
+	if (pdev->bus->number != 0 ||
+	    PCI_SLOT(pdev->devfn) != 2 ||
+	    PCI_FUNC(pdev->devfn) != 2)
+		return;
+
+	bridge = pci_find_host_bridge(pdev->bus);
+	if (!bridge)
+		return;
+	dev_info(&pdev->dev, "disabling native PCIe hotplug\n");
+	bridge->native_pcie_hotplug = false;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
+			 quirk_claw_a8_no_native_hotplug);
-- 
2.55.0

