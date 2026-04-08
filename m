Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688333D8918;
	Wed,  8 Apr 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671070; cv=pass; b=H+HJ9048JI5/tHx6KJaS3W910QtygSQu8afeVadj9zF+m3imOmf4pkM02dma4u8xk0rZkFzNkJ062ERPwlIx8jRd6FfAweYPfDtfK0GzDcRRoDD8K4c5go0T/HMxi1B2Zi5ndtPOP5ICIfEfKQ5u9ozxAbWUzUFQY6OuHAoYAdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671070; c=relaxed/simple;
	bh=40Swb9hDDPRZ1WxKQ3Q1OfIJx4PN2zac84FzG+15J30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/MQvg1qmygi1xE4Lzz1U7pAT/Rp2+T2aTOlAJqXIBY58ATEEL9rOaCSuQselITQyb7s0zcs/UMQBB6w0K8ckqXdzsHpEEgHrWO7z1nMLWDe7aF+KYVAXFzPb6FoOocn+v3noIrzhVwyOBDJ6alhAvils3m4oJWwRqu9Fi02w1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=l3XNOglI; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="l3XNOglI"
ARC-Seal: i=1; a=rsa-sha256; t=1775671047; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hMWTn1vIgHtcYyHEYu2t7qhR2GJU65MlI2IN+3dS4WzM85pwR+crkJpvK0U3c/JAx8xwqD2+MVIx/fJZG3BDUe0m74BjO+JYuMG3wgjLZlTFYrNoIAfVUT0n/sa4HUnbrCG8HcTwou4CDnkjOb87hG0hIZsg4oTmVa9+Lxx6FZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775671047; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=COxeKDaX+XgKV90LR9TylYsK00hAyP3GSYBqn/E/Jzc=; 
	b=TdG9+eQmuLpFuksJOJeg1MT6rtxjeXh8VfDcDwD8iqfqzkA1BLJ9pmVFbx0V283fqz3f4GpyQ9dhOCiHMVil+LbbYgXwbbry38lGbeq+FI7dG51KS7vOzoNikGDwPL1Z1HKiHw4vBQZU04+cFQKNQfVioFsLsA9ki+rVt5QJlE0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775671047;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=COxeKDaX+XgKV90LR9TylYsK00hAyP3GSYBqn/E/Jzc=;
	b=l3XNOglIfOzSCm5bFTlmolTMycT7nLvoW4Ifh0HfS6RKlUrmL90i1Aib5ziIRhmA
	ajnJ+qTvunHg/PvWssGonXnikoBh3zehXEIEdXU3i6bw5dPXEz+KNBUBVjTT5OKWHJN
	W3XSY6EW85RlIa8YWR+RBpBRRRH83laFF3YfdnI1ktAW4Pg2Tt0oWHK/L9FRE9v0ESJ
	A+/eR8JFhccUfTgZRiAG2S11DCWkQmY1qUCLBX+jFxDsaGM8xm9YUsvBbZAD9wBX9v7
	AFC2/yY5rTKL5tyDwI20Hchqiqc3DpUP8CDWuVqK2xY5RYOJDVYUMhJlV89fBJBx8pm
	rBNOp56jEA==
Received: by mx.zohomail.com with SMTPS id 1775671044929313.9143064676292;
	Wed, 8 Apr 2026 10:57:24 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 09 Apr 2026 01:56:58 +0800
Subject: [PATCH 2/2] PCI: loongson: Do not ignore downstream devices on
 external bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ls7a-bridge-fixes-v1-2-3650fedf1afc@rong.moe>
References: <20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe>
In-Reply-To: <20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "Lain \"Fearyncess\" Yang" <i@lain.vg>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-7777e
X-ZohoMailClient: External

Loongson PCI host controllers have a hardware quirk that requires
software to ignore downstream devices with device number > 0 on the
internal bridges. The current implementation applies the workaround to
all non-root buses, which breaks external bridges (e.g., PCIe switches)
with multiple downstream devices.

Fix it by only applying the workaround to internal bridges.

Tested on Loongson-LS3A4000-7A1000-NUC-SE, using AMD Promontory 21
chipset add-in card [1].

  $ lspci -tnnnvvv
  -[0000:00]-+-00.0  Loongson Technology LLC 7A1000 Chipset Hyper Transport Bridge Controller [0014:7a00]
             +-00.1  Loongson Technology LLC 7A2000 Chipset Hyper Transport Bridge Controller [0014:7a10]
             +-03.0  Loongson Technology LLC 2K1000/2000 / 7A1000 Chipset Gigabit Ethernet Controller [0014:7a03]
             +-04.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-04.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-05.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-05.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-06.0  Loongson Technology LLC 7A1000 Chipset Vivante GC1000 GPU [0014:7a15]
             +-06.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset Display Controller [0014:7a06]
             +-07.0  Loongson Technology LLC 2K1000/2000/3000 / 3B6000M / 7A1000/2000 Chipset HD Audio Controller [0014:7a07]
             +-08.0  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.2  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-09.0-[01]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter [17cb:1103]
             +-0a.0-[02]----00.0  Etron Technology, Inc. EJ188/EJ198 USB 3.0 Host Controller [1b6f:7052]
             +-0f.0-[03-08]----00.0-[04-08]--+-00.0-[05]----00.0  Shenzhen Longsys Electronics Co., Ltd. FORESEE XP1000 / Lexar Professional CFexpress Type B Gold series, NM620 PCIe NVME SSD (DRAM-less) [1d97:5216]
             |                               +-08.0-[06]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe SSD Controller MAP1202 (DRAM-less) [1e4b:1202]
             |                               +-0c.0-[07]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller [1022:43f7]
             |                               \-0d.0-[08]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6]
             \-16.0  Loongson Technology LLC 7A1000 Chipset SPI Controller [0014:7a0b]

Fixes: 2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
Link: https://oshwhub.com/wesd/b650 [1]
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Co-developed-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/pci/controller/pci-loongson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 8b1a3a03dc51..de5e809a537d 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -231,11 +231,11 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	/*
-	 * Do not read more than one device on the bus other than
-	 * the host bus.
+	 * Do not read more than one device on the internal bridges.
 	 */
 	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
-		if (!pci_is_root_bus(bus) && (device > 0))
+		if (!pci_is_root_bus(bus) && (device > 0) &&
+		    pci_match_id(loongson_internal_bridge_devids, bus->self))
 			return NULL;
 	}
 

-- 
2.53.0

