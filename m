Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF34511E96
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784635; cv=none; b=EC4Q+6Wrt5F7HgPtG0QuvbkBdF/65Sdu39IRJO9XGvcrvCYr3ZMfnI8Xp6xdh3MxVj2Efdm7FXPA/KiHz0nUAAeoPWK3b+PRyzpv+rePdOtIUC6fu7/7SDQ4YIXGIkXhkaMUZvm9N+ym7tTS3CLDXYTZFXItpcprDGOknEc+B3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784635; c=relaxed/simple;
	bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UeeOPEXlCtokGzUIVERhfm8g4Vhuh/mzBgkdzzsfOhq5m8K6Ws190esdeR0ywu/zX0nTmLstk1xlr64nTLnCG9e5L+b1o4a+2ph6CPp0FS38ynvIVL0LaBDVuNGs8lWK1Yk7NIlpAgXDiB9Gv25jqS8yjTTYpNw4ycu2DZZmG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=4Tr84zAw; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="4Tr84zAw"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b03eb33b2so273491f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784630; x=1791389430; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=4Tr84zAwa6h5SeATB+ALrZ3fb0crj5UiCozOL3C+eDJww9RtL/ctjfD8jj42GxMrOG
         zH9iVOs5Lu1qpnQ1iuELXe2+Kddf6cqfmNRd5ikIDKQ4v8pG5RdQxf2njrKoU4147td8
         6Ya7EsicWeK94Hwl1rPiwbrEEZhwc6OrpemjIdEtDxnA4vtysGnAJ+GR0zXG95jWoAgX
         luji/UR6bqGAz2YRkBkVdGelQfqtRF4NmqzQwKpxyl2sa+3I9OboOEgoHVFm/NDJnuz4
         5Bv45JEiEKXBQgQunw160B/keisyog8PJ5WIZSMmLU1Jf5nobSdFUPCDrfkr7dxOmr4l
         gcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784630; x=1791389430;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=zzZoo5aez1KeshDKkpGnH8H2o1QBGdSq5Vho2CF3YwcdTTDTfmspsPH374KtuxpAg2
         LA+McVnvgvIcsezDnbZh0bmEaaI7sUBOT8kI21rgsCRU3EP+gQ4kfjf5GBCBygP2UpJu
         mIJETBqSmKfTVp5J/8aF4LVfzseB7H8qGinPsAxMbnYQo2bhJylPHU+yOEOuACWssfxC
         cFPPNEKG+v5DdPlNUPOGfZHww+/BD5blz8mFn5fJqm3kz5qpxunkkNRKf5iKY74hTdET
         LK74F1GbhzU7t13toYHntfE/l5GRR7Gmc2P5+q5Cb4/kTps7rUdUY2SCLs2WISbx0hQD
         RjDg==
X-Forwarded-Encrypted: i=1; AKwUvBzo69KgZYrvK9WdPgkeFTBPPsASFu1Hv/6DDHmRdlyMbe4JdtIbLjBNnSPFAg/U+IgwzlBR/y1Tx5o=@vger.kernel.org
X-Gm-Message-State: AFuF++mqVrrIHfZWRJH4m6nTz77xTtlEta5m9looEHyv5/emu8TYDyZM
	SgHQu/DES0EVE3Uz+KMJVFqztd3CyQAaThxKXGnhNnCP4HXz2/nQFgdR3wCuFNxqGBg=
X-Gm-Gg: AYBFou2xXNscOcfGDOeQajqZ54+UAjP/cxxAAYrZAtYpN+q3ueGxWGR0IHjMFFjixJ9
	LVlLcUTa72aa9GEJZ1e850ifwHQpA9DNjN3r1I8z4XA9FEAJJ1+aMSd+wNzESzCHkDGgs7HNwrA
	BD0hRCt2SunSYTeMA8lwcIyDNUAXBkPrxQjv/FXubVoC21Ry1Zl23QH99RuUph6INiYam1+iG+s
	KxUcNrf+2DePbUkSSoa8c8Ink4IEAcbFEgoFw0hYe5/UMuSUZF9ANP7V/lDF1LSyfy9hy0qL5o/
	RD+q4fHMi960LHvNTdXq8Y6U78HJcbxyjFXapZYba6ppfiJ/vqaed5zoa9d86VnLJdUVRElhWgu
	nTiAIqGnnwVHKkkd5GmEWLLOJf29IpN0iBEZPvro9hPAQ0Xs8XMnOjZ/znFtPqwy4Duj56+AaiH
	VenODzUn/lgJhgk6i4T/hfDOiJOo/DiTY2N94riHocuvk3+pyXXxFZBcLwRQIhXyaQqdlpQG1Mf
	UdamgjjS+6ux1At
X-Received: by 2002:a05:600c:b96:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a01eb03db2mr2531975e9.8.1790784629228;
        Wed, 30 Sep 2026 09:10:29 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01ccfeb2csm8578785e9.1.2026.09.30.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:10:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:10:21 +0400
Subject: [PATCH] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAxF0a1UHmMpJFL5bAUxaMILGEQIdvlIV
 fdOgOEZ3DuRQQVG224ixVNMbqVhuegonYZyBMuhmbzzvdsEx1fP9aWGO1+yArxaxxRTiH12nlp
 VFVnev+Nu/7c94hlp/G5onj/Po62mcwAAAA==
X-Change-ID: 20260930-m2-pwrseq-kfree-78bcbc3b6f02
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNSlqmC63gKM342H5FBf1K5b9/14q/L30SmvPV5mLx
 +peLtwa1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUW6Yx/OGbvfh7wv3ErCPSh5aznk61dOVxXpyvGOo1wbYgaCZz1xtGhvbSqfX
 HP5bEWFvJiB0W/+LM36DpptTqEXgkz0s30m0rDwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
pwrseq-pcie-m2.c never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Split out from [1] for easier application per Mark's feedback

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 91916768e922..0febe4b3d980 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -613,6 +613,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 err_free_regulators:
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 
 	return ret;
 }
@@ -626,6 +627,7 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260930-m2-pwrseq-kfree-78bcbc3b6f02

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

