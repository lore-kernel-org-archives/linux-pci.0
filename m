Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996193F412D
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651458; cv=none; b=ZSRU0dh3fKnIh7xXy3PPFNBYBt6GqfCHEZ+dvOCjzLYfOPY7tas3OaAqbMnHAoqHNl9ofQRc4ivP5Lj8NJ7mMqZLgg+PqfyWTuXs6ck/jgyK5rXh1QdKubWgd5kHdeF+K6x/LrM95F6YcM638CyQL8laHnOOp6+bqktIv7VlblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651458; c=relaxed/simple;
	bh=L4KcC/D8JNR68JbmIZsy7FDJIPX4XPqpuzQaMbjaS8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCuNC4jcVuBG0CnBduNV7n4SXi+rUFLKkuQmOpFhhNDJjWG+5Q5zH46CmKBlcHW++8OishSemYtBzm3298XsF/4j+vD3N2OMmcADjminh9iqFdyRCVBwyOpQkenNAC1cVjWjVeuYJ1OvNWx6xNg4chLV4AGOhdcD+FfqumehXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiaytjNX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiaytjNX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c197eaaab00so755042366b.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651455; x=1788256255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeaVy2u4NwAxOvzDo2/ZVVxI3i4d6+VqvUeN33Hsu74=;
        b=GiaytjNX/52UUZUm8PWir3Ok+HZnoluwW+H9154fomdJupmrizn+06jbiK97e6RNpS
         iTdseqp0li/99br6etMcJw/iWnr+Wl8yWLPsUMMPXH8STl/8FFp+skMUnWAUioQAtSmT
         c+nDfLWtUoMjUFYfb+vphiiEV5eq5vhYuOqCQPFP/1ZIPoYHhSRoxe1Y14EOngKed0a+
         A35MlBQnKCPhQ/PIvOtWC/SZ//FVSXi7D3c/VS7FOKKNZsMhfcYPkCEn0AGdKdp4MTkl
         VLa1MAkJ5vzTPYev9nyah1aewzy3+E0FBpolY3zXTjlFjMPJXuYgJv0GiBeG2j1jEYEu
         NBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651455; x=1788256255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IeaVy2u4NwAxOvzDo2/ZVVxI3i4d6+VqvUeN33Hsu74=;
        b=Q2ZdK5alACNPyUBchE5CC69LTJpprs/Ji7qaS7/9W4UEn0MznQfaqWXOeFaKYySDXJ
         ww0k0NIec2YdPvYOqcvYi0RZGAu9YXy74Oo17DdhHXpWoBN/jhlfYgHyuWTLp2aw7Znx
         IjD/6+jOXroA1f/owYZD8t1rx1X/SNLTUQM+Krd1pNPt+cn6/tqlcPqEgbHKp79QDXCA
         IE76tl7w1VTcUMcnlC3ZdQTx8qzE+F3C7m5DKHoNUEJN6QjHGe2K+t1lz6HrnTX1Jzpy
         kozEvlZA8KWJ604RtEIeMBKbLeLVlQ1KI9a3bz4yCPNHS137317WsbhPssfS8/LezP34
         P3WQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDraoeZ5AtPgjgQlxjYmRT9+1nenIsp5RGoQfTWE64rJ2x1jG6+FuGo3Or/g9wc7tyFbDguHZg6qs=@vger.kernel.org
X-Gm-Message-State: AFuF++m/rVbr4UURcscNhhJH91edp/fwcxYBOSxOcvS6FZ40kvWNghWf
	USNJq+Hs/BhJln9A5ZuZFL7K3GVvXlb70/iqWyE7Nx8tcb88VVHYRXwY
X-Gm-Gg: AR+sD13rhMo+Ee9P5Kjq30Cri2+XDYfmUACBq6bZWMd9ZMXy+Vj5wqPW67rqrbMo+uQ
	QjalS9xzhwL0mh7Zp0H23/qRu27/rMihP1CYc2dF3qdiUvshonpCMP0h/SlmiMDmXTfkvTNNEBE
	plFhIx5LroBhovTTDn0fBc1NWGEYTQZeYmj8VmbZ+d1AkU+DNRhP5TwMNSdren3wJPZRYaRZWGH
	ip98gVJimmBDhe4zzqvlAY23HD+/wSwBxESwQRkNyizhvw7XCRIBesV6TqilJ25KJW32UKlTyot
	ZAvwnF/q+nhCcX0U2+Ha+dE0XeI47CoBl6Ky66lgoXxpxo3TQ3ofS4QUuKx98bJn+xQvzhT6Po5
	24Dp092XrHSxQwzo6gOAmBuOVgEV+IFxgZimxejgQOh81rYwbWRBPvfY4JAIoA4DRG4vi5fOnuD
	pjoEpTO2IJHWfl8vqjDCAEH+nqqkztG7Ya+NwmH50RXvP7CeHVio3HTgu5THnRhItiUxnclJb8X
	BOCn5BSSfQmCoLpsv32jhhd
X-Received: by 2002:a17:907:e1c1:20b0:c25:437:3dcf with SMTP id a640c23a62f3a-c2504373f29mr20567466b.21.1787651454490;
        Tue, 25 Aug 2026 02:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1749320666b.23.2026.08.25.02.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:50:54 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 3/4] PCI: rzg3s-host: Add support for RZ/G3L SoC
Date: Tue, 25 Aug 2026 10:50:42 +0100
Message-ID: <20260825095047.9971-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825095047.9971-1-biju.das.jz@bp.renesas.com>
References: <20260825095047.9971-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add SoC-specific data for the RZ/G3L (R9A08G046) PCIe controller and
register its "renesas,r9a08g046-pcie" compatible string. RZ/G3L reuses
the RZ/G3E config init/deinit callbacks and power resets, with its own
L1-allow syscon offset and mask.

Also increase the timeout in rzg3s_pcie_set_max_link_speed() to fix
the "Failed to set max link speed" message seen on RZ/G3L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b3531468ef38..3dffb85c6a47 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1165,7 +1165,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 				 FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp) == ltssm_state_l0,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
-				 PCIE_LINK_WAIT_MAX_RETRIES);
+				 PCIE_LINK_WAIT_MAX_RETRIES * 10);
 	if (ret)
 		return ret;
 
@@ -2467,6 +2467,25 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	},
 };
 
+static const struct rzg3s_pcie_soc_data rzg3l_soc_data = {
+	.power_resets = rzg3e_soc_power_resets,
+	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers = 1,
+	.config_pre_init = rzg3e_pcie_config_pre_init,
+	.config_post_init = rzg3e_pcie_config_post_init,
+	.config_deinit = rzg3e_pcie_config_deinit,
+	.sysc_info = {
+		[RZG3S_PCIE_CONTROLLER_ID_0] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] = {
+					.offset = 0x3a0,
+					.mask = BIT(8),
+				},
+			},
+		},
+	},
+};
+
 static const struct rzg3s_pcie_soc_data rzv2h_soc_data = {
 	.power_resets = rzg3e_soc_power_resets,
 	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
@@ -2516,6 +2535,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
 		.compatible = "renesas,r9a08g045-pcie",
 		.data = &rzg3s_soc_data,
 	},
+	{
+		.compatible = "renesas,r9a08g046-pcie",
+		.data = &rzg3l_soc_data,
+	},
 	{
 		.compatible = "renesas,r9a09g047-pcie",
 		.data = &rzg3e_soc_data,
-- 
2.43.0

