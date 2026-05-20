Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C990352016
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295757; cv=none; b=N8suuguJ//+idCTBRcFTtkrsQCkIimm1WMwKm6sstBsapzsClU375FkGv1xK4vKlDHQoUXn15iqk74MwuaCi0G23thCZyBjH20sIs5MXuona4GO3xaFzbXKfUwHjWcmomkKFUGFGh9B//jxxNSaL4ugqnQpuZ4bfYKnJwjjYmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295757; c=relaxed/simple;
	bh=KHCNdg8WDuW8IcELyLOslLxssl5wbWlUe6xFPFofttA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ha4veNG3wo64PSPLJ95+geol48GoHpb9hEDNznMFhgcVeeRwfJbGqnM/kpf17ebQHKXbYZg8A5EbCJ05jRkRDR7hr5RdaAGVuoB4tC11HbIu/S/8IH3KmWeAfJKTzgL730gWbLvskbnwDkS0bX/M4HDSUcg7ArKYNurD9x+KfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVk8b0L+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVk8b0L+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so41810965e9.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295753; x=1779900553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRMlPPpvWg0+TEQtNgaYgNZz3rw+h40bKIEhdoGDsxg=;
        b=YVk8b0L+rlmt6P9fuWhXkVZ7LDvpGLj3gturB7s9lnZyek0mTr+WEBQnK7AmXtmtT3
         ie0UzU5iUKazHnLpjfcFuS7/gM66R801sqqkKfqs/tGyQeDJqMCfN3d+wMVA4K4LRvuh
         4F1knett9Iw/BcbZZRsc1JfFpIhlUCvL12wS2ArEDh9kOCzkTFDV6hAj0XxKFNVVlKt9
         BjmU4AJEdVja1gNhwEf4+SkT54/6+/fuRiQLY1GCGBPZtlXN5+B3zMPSDpQOIguRK8At
         4tcjqIoKB8asUzhUkrMq9tDx8mzc0zBtzTfAVwwzHQzuMmDuyaGsZLQX5ZhZTRen7aiO
         tphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295753; x=1779900553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRMlPPpvWg0+TEQtNgaYgNZz3rw+h40bKIEhdoGDsxg=;
        b=F2c1u8o0ipsvrm/DU48z62DLi5AiEQtzUyX+n/4qkOlj39cr8BY+mP6MQVAgS8gp+p
         d4jhpiP0txR2R/Vb7vRbpRJaK741lRcq2ja/xMuqyDLV6Zq6dgHwkOAPxIb+ERaTveph
         tnqL4Jb+NzTmmKCnTu6pj/rWTW+wH8dGpQJl6pD1vqHorDUJrW34MfN9ks4uTZHgjYU/
         gqa84/ZRhjFQVmuDno2HQOAgl2S3bCEG66fp65+LU7Wsq4qzWcIOe6Johl0RrznYlEb2
         rhiilQcYwAx3BeYICi8SDPaq5r+R2Z2BAjBTWgYN/3zQalNyy/S8vkx+0vAmP+vdZ39q
         dgtQ==
X-Gm-Message-State: AOJu0Yx+wYr95O8U5W9IyIFsa0nzxUY5JmxBDCyl/+OZhR2Rym0c6l+G
	KFYASr7wqaQvEvuR9NjMYypJtGqTD7K+FTapfp5u2Yr9i29Pr57QUYPz
X-Gm-Gg: Acq92OHMrc8E47fU8ClZI0tDAEBlilvO4RNIM+fTe34PYZqq5wUVi5AV8o/rterGXhy
	Eqr45jurU3poNC2YuUl4d7qCPM40vfAswoomV7tMSjv0tbR0vZ4FZxwIqcc4BueBhIVkduMYQCh
	pTjmw9C16Sv3Kr+JiOpVq025zUKAv1ZLSQ7hMyKKx/pgV0EpYLj0RrF5qGS+JtC7iCRBhpm5+K2
	KvjwxaGubL6TbVBoPBdtET1z2iOIt6Spl/hTQ4THgYhExTX4qyknSVewvTNFGhYaj6Pj69Ju5jA
	91Kc/OT3MJcpMbfIA8L7qeB73avVqVe2YgqOL2jrAwmV/tpTuyecw5e4doUhoFRK9Q9yr2Ckj7f
	SoKZjVi1KfO9YkS76R1FS/xugG3keodwnpYNHNqgUGwAMfxaAykik4fI0OgCSi2VVHxCLPHHd/U
	fc/r8yFAOw2rESl5YRh9YCTu/o+ro6a5zSkj3XKA5vDTOup6wft7LAxU+E/Ax/u9KFkN2CRbvKZ
	8ywYOSRXV97KtPjKZOEoc4SnUb8lYLhs0vQm/PsABNP+FRiY3+ur39dxQ==
X-Received: by 2002:a05:600c:4692:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-48fe63253e0mr403611915e9.20.1779295752770;
        Wed, 20 May 2026 09:49:12 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e71dsm3110285e9.9.2026.05.20.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:49:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/4] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Wed, 20 May 2026 17:48:21 +0100
Message-ID: <20260520164823.436992-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Switch to shared reset controls for PCIe power resets to prepare for
RZ/V2H(P) support. On this platform, multiple PCIe controllers share
the same reset line, requiring shared ownership of the reset control.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change.

v1->v2:
- Updated commit message.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index d86e7516dcc2..a5192e4b58df 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 	for (i = 0; i < data->num_cfg_resets; i++)
 		host->cfg_resets[i].id = data->cfg_resets[i];
 
-	ret = devm_reset_control_bulk_get_exclusive(host->dev,
-						    data->num_power_resets,
-						    host->power_resets);
+	ret = devm_reset_control_bulk_get_shared(host->dev,
+						 data->num_power_resets,
+						 host->power_resets);
 	if (ret)
 		return ret;
 
-- 
2.54.0

