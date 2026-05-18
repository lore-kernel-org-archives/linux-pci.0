Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB963F99FB
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119624; cv=none; b=OJNRFYm1pGT6OeulqbHqgTHl570dsoKv2Bcf3tsqvy83iJA8a3fuETaxfF9s2N5znBoIiI6vAthHXBYmoD0kUp9bWOot7z3PYAjdBbzY9KR8OX10UK+A4UOJIAdeoDdGcKSAcFUdyG672jJCOmS5jvLPFWTZpQ4bwn94XBR6Igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119624; c=relaxed/simple;
	bh=BDBX1xjAJ0LRJ669WLtKgmM/iN83kf6G8Zqu5Nhk7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0DkEGh0SGBT0Igt12AW5EkvLXXc/3RexC2Cl9Usbid2TFqEbLDElztuFDRLwcmPzJvUOwzwS3fCa5BJ+PtxYTP+RFB8mEi9Rdb57UZSUG+vEI9JAa5PL277ru99DB6ktw+ZzF44DI92VFxJkFdsqJIRAdPQ9AJm+oHM33RNUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3WvuLxM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3WvuLxM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so27639235e9.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779119614; x=1779724414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uJv70dl9pxlSstZxADnST4TafBrOMHuR9XAmS5GRB8=;
        b=s3WvuLxMILjGpxqPsyRzJJCKHk5YO06+QBENgSlg/1Q3LN3C1x74AY3G+hDh37LauM
         mm4KyZEr75ILS1pFCg8y8ATZ4ITyzv3RpPbjb+k7H0B4gKN2n1XRgBoAicICrd78trJj
         K3JK5zXZ/DIF5ySFUnIsAhXjCdecWOUhza9krnBh+yHNe5zHRqsmpxjFx1vAs8EGW5Jj
         DGm57LeXs13qwifSwwAeZhxJE2Gy3Dn4fBpxxdxCckLMyzuLch6WmpFRm6+oWdrla0As
         tzT93l1LNgj+g1Z0153IYuDl/2r5vRZIKarwwVereKH3l+LLRw8vMRrrXhpkn3Cc4YJu
         RBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119614; x=1779724414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uJv70dl9pxlSstZxADnST4TafBrOMHuR9XAmS5GRB8=;
        b=Dyf0UaTIX+0FwRRNKWQAXGROjh6iFmyoE/lapE+B1b0GKtKEOAQpmuBEEkN5opVR7s
         eYj/BpyydXw6Fx4cIqJ0OCNDV7MOZ4zD+m49WAGnGo06fmIjNO98IMUHBXMv6IRsiVep
         Bmy56w+dmBkIAHRkfWg1jsE2yMMAcunoj/rtDsqZLOBx28ytMN9YQ/yl6925spgtYsI/
         /pNQHdT/DDuePC6ueMqEmsCyEwq2z7FlJT+jNuqeDgVJhZBjC+5Vn5NboKEdDlyKNuBe
         t74Q/4E7KXzU84kH0WeuqMXodzwhEDQFSapRgk5wocHyqPT2ZgqhU1SBsjsKqzJmwYBp
         MdCQ==
X-Gm-Message-State: AOJu0YyN266njxAXmUnLdDXlNkQzlnNKGqNu58L8PSr9AV/f4H2WmGdo
	+VemKRHjcqqGQyvkdLvPblDId5EB47qro6yQDvBfvqCdg4BTOvQ2OsgB
X-Gm-Gg: Acq92OGAXPRWyycV1ue3Kvp1kh9ui/CkwjaJMaCacfWJ1uoJJFPoR4Sk/r0g6w+YkSm
	gFGvvYjq/rfSMFHt4VoSXde7fOYwPRSCKn+DTjci7zkIFcvJn5o6R/pu8eaj+aO2CCatqj6tRJJ
	Utk7W2SMWxduNrRdWeh9dD87MpzfBJTRc/hrLcvx7wrLAEq8N9gTmUFDO2cKajwUVL3C6evudAm
	+dXtyNIFmr5koplFYGSOW6udXawwB9RkTBYpCNS+7C7VDY25xyS7RGOy2h4XeNsd1Cjxzo1FOCt
	4A30R+44ZxFewnZen9heln5sUk0+NSV5JtIe49IIZueeZStYL2mbmg9ihlDHXKfkZ5SmljOBzoD
	r4JaW3+Fp5LEGQVLBtv3aL/NoSgyd1Ws9H+/iNTug5/zQo3hipHwjWxfAq2NtYIrPVHIQUZgs3k
	SQsNHxnTG0hV/5pOX0UViq3DrsfV4xrrxwIThKCUjnasWuDUzErH4JPru2gA12AQ8IT33JyM7Kx
	izBNQAV8GFyiiYIXrBaw8EIjqG3bCLyczJa3sb79TraXF7R
X-Received: by 2002:a05:600c:698d:b0:48f:e230:2a1c with SMTP id 5b1f17b1804b1-48fe6631158mr251523225e9.31.1779119613752;
        Mon, 18 May 2026 08:53:33 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:2409:d26f:6d8b:b2cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm450054575e9.1.2026.05.18.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:53:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
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
Subject: [PATCH v2 2/4] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Mon, 18 May 2026 16:53:22 +0100
Message-ID: <20260518155324.168948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

