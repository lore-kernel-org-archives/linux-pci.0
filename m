Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801370;
	b=VpxdvSWvrJ8OtZt5qAPon4WK7m/HRzXeacniVZIgB5CSlyt+wGaWgpEMFa6H0uRmjKeX
	 4MJWx0wmkXv6/SlOihqcYXDGglteNuPUDhYs7yMLnBsyhOuv9qZbNQ4QXD0/Gjvv3LR2e
	 0DDM4SHQPSqPQR3+Ox1ITxFB7wwxhrYw91FhNOUy7nMQ93jqcjCO4+Kel8/gC+feTs575
	 DrHID1DRqvGHBMyNtdWI30xYy+yGwNy62ucc2dcRPvvNFwvPcYsoaRmui5u8fiEyJIrcN
	 +eyKh01QpqKwbuwcPG/A41UvxS2ZVZlkRvBkarnqUhnHaLWjEibEioRl/Vc77NWawnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=feOTu3Fjg6/kqLdoArqxeRe79rB82tCPqWr5RYI27tE=;
	b=F4BfChgfCaejFnPUB6RwEnjuMTWxNPIY7AjR3S3pL5ngdoNfTgQSYiN1WxqdX6t/MTgJ
	 RZZ5RHD3Urdl7oSC/4ySB7sLZBG0xicMOXxSg5fzP6I9VBDQaVBY+VjgCJ6aGZc+bPjYT
	 AaBGANmhBQQPIPAmravT/iIc+bRSNJ8Mn7eQRp4PEjRlzOexmGK6nId+Fonk5QzNsFLkx
	 v1ClweUKcDEoPU6usvqBKfrezSZh6tWCKin8EwwbP5e1bTVyfbzYoNw1edhXFlFlPPDVg
	 hohDHW/ICFFgcqym5ahSNy7UBpYly2KC29Kq0oqNJzdxuEViGIoQ0nwnIavZCHwr1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1KjPdAn;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE6606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 14:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EDE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1KjPdAn
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4ad5d6045d4so3909955e9.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 06:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801369; x=1794406169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=feOTu3Fjg6/kqLdoArqxeRe79rB82tCPqWr5RYI27tE=;
        b=s1KjPdAnYyMy1iRROee1OouXiivvuAG/RsHa1TnHBpdZEdZmryfksJthuvzAxDQapd
         djAq2y0NJizSdN2XgujDaxVXqFvrM7CRbQx7RUuDVRk7mC4Ucot611VQGMP1dfcPUUMg
         J2VrsIHUGKGcXEwqt93gH17iBZ3ZLXxsSN2x6XcCeid8StiKzVzx9W4tVUqpYac6ys5a
         Ob0fWvFb1FAPCN3C2h8T0GrnihsbXGcRV7vGBFx6qVXWXwhv9C94Oezq9OfpHAyjqOWZ
         RKAyd4q9GunzaHalSg0dPAbNu/KnrKSJHIMemt+Tema37Ytfl8sZ+26N9VFjzLzUWrPz
         ZzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801369; x=1794406169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feOTu3Fjg6/kqLdoArqxeRe79rB82tCPqWr5RYI27tE=;
        b=yhXf534yk/TY67s4A9HSHOuxc8SxaThgOilWOARIIqds6IXOJnQ0cnal83vLk1Rg3o
         VxTDcnLcT9q/YdDieXLj1aRXzBZTRnqnK8yuLS5T52SJDYLbB8hG4qed/DcWe1kaiHiL
         rTXOkS/Li348fG4/GVWoyap6fNWDBfaRLhABKbGtBeN+NlX+jiU1pnP+HlBKomsppU58
         GIL8183nuJQ0NZWahQjC5ntfAgwAaWzS0Cab+18KgCL0RBBYGXCmGpdMdby1BNp+urRA
         4IQZb+rtI6A7iGI/dQ4yDGilz5QdbMX26gaxKCyJQQZgaYMzjpd5ZyI0KmvXG1biaMbm
         Lz+A==
X-Forwarded-Encrypted: i=1; AKwUvBzH2CKsUuwqzgSKfjr825sq2SpEVwUPzsA8rkBjepmmKpLhgd5L6blRkEgyWtS3Kj+N7fk3vJgds7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bWZ3/M7Y+bK4YLk+l3HxLq2pHXJSXlmGNrJSZq5TzINkPdUtb
	RSydLbzLmMk404PsYFO5Rdsp5vQ6Z4N/NBNsZ0nBqOFkE9NrqKGHXolk
X-Gm-Gg: AYBFou1bpqrfOuLKZjxi5jUSgvLs6I6NLtd9FUZnzfx4xNZ5L3W5N08AAgl1+3YUvws
	ZpXiC4u0/foYzZAHqRbvlgf8HGqSuZ2JAYbxLWNkX/5OZdahgNqzFsVWKWNwC82LF2XvMjnejFi
	AXVdg5pTqjM5a59Izb8dXg+V053W5m2tYX0lwciOB4mvK2XC/4FKI9bSm7V4NPe7w4Ki13um/zc
	dxOOw0N4MxOa6v9Wibji/6hf8nXmWwpSpsl2kya4ZgcA8Zux77+V8cFmdGUhvA1S+Xj+fVLES3Q
	zll6pwbuw96ewb20DPBtIg13z/4UTCvEN4sYjSzI4tfd7ZfMTaM12W5lTEI51PSuFpNsf5Vuznj
	oIVHOaVHcZjtmDauep+O6KERRsBK5jiXrZX+OjWP8R1bZgNPXvfcs0Eu2IIJMl/qBsMwMgX+jg9
	/NLFcRGGu/fO7Bk5I3C3mwUyDfC0fCbtip4wxH/3aNP1jWm+NRpvgj5ARX8FrHyCBeq90dcwcVo
	auMfyB9Zb95mwv8VgppJZliWQaA/kFVr+ax09AkjRGSjWEEG6Uc4NQh6Nwb1kHwn+9EaAfVr7+j
	h+5azMkBirKKwgb8/lNVHXBZztjnt4ZW91E9vPnWbLjVbR8GnFBcKQ==
X-Received: by 2002:a05:600c:a107:b0:4af:e04f:cbaa with SMTP id 5b1f17b1804b1-4afe04fcd89mr177944795e9.29.1793801368473;
        Wed, 04 Nov 2026 06:09:28 -0800 (PST)
Received: from workstation.. ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b411de95b4sm40977605e9.0.2026.11.04.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:09:27 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Alex Elder <elder@riscstar.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: spacemit: Ignore PERST# bit for controllers
Date: Wed,  4 Nov 2026 19:07:45 +0500
Message-Id: <20261104140750.761330-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The k1_pcie_init() does not set PCIE_IGNORE_PERSTN bit of the
control logic register, which causes controller to reset itself once
PERST# signal is asserted even when acting as host.
On Orange Pi RV2 (SpacemiT K1), this resets the controller and wipes
the IDs. k1_pcie_deinit() leaves PERST# asserted, so when k1_pcie_init()
runs again, its first DBI access hangs the CPU.

Set PCIE_IGNORE_PERSTN bit of the control logic register of APMU
in k1_pcie_init() before enabling resources so controllers
dont end up resetting themselves when PERST# signal is asserted.

Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Hang log: https://kernelci.cloud-v.co/scheduler/job/420
Fixed Log: https://kernelci.cloud-v.co/scheduler/job/430
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 92a71ea90ac3..af6028e8825a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -47,6 +47,7 @@
 
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_IGNORE_PERSTN		BIT(2)	/* 1: ignore PERST# */
 
 struct k1_pcie {
 	struct dw_pcie pci;
@@ -131,11 +132,19 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct k1_pcie *k1 = to_k1_pcie(pci);
 	u32 reset_ctrl;
+	u32 ctrl_logic;
 	u32 val;
 	int ret;
 
 	k1_pcie_toggle_soft_reset(k1);
 
+	/*
+	 * Ignore the PERST# signal so the controller does not reset
+	 * itself when it pulls PERST# low.
+	 */
+	ctrl_logic = k1->pmu_off + PCIE_CONTROL_LOGIC;
+	regmap_set_bits(k1->pmu, ctrl_logic, PCIE_IGNORE_PERSTN);
+
 	ret = k1_pcie_enable_resources(k1);
 	if (ret)
 		return ret;
-- 
2.34.1

