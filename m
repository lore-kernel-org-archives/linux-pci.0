Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E43D6CCC
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837918; cv=none; b=SYpsYk0+XHzaksUsZWZmne4cvua0rdeIWISLOO40BtlYIAPrZ2nw8L+HSGSnI0t/gaH1+qFzEyjTaaISJOwtFdhXQENwZBB8C6hL54hyulRepblPqHVR0S3AoyQ9dJWSqdwt7IE3TUCmZacTJSWhn4Ic7T6rWOGoezJVNuu4d6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837918; c=relaxed/simple;
	bh=y/c7YJ4/WBiR1is5iKdiPia7zTBbuMjAOEBqoP1c5EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAEWgJeQH7uhg+gNdinCIEmUZAIc9fWLR3m83rXD/aFX3bFJ/sjrZRT8A2Yx2QwXsGGNNGoL8f96ChxoHDLlM5XBceF+MNaJVb5l7FqDJgNhXh0B1MZdBMvLEXbBWuMZVv5aXIZJaO8UkRNDKm2bcLFzOqtmGmVNQTppkEFXeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sao63iwt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sao63iwt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853aec185aso56284705e9.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837910; x=1774442710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDiUi7ubyDY0I4Yajxf6etnCfMlRy3CfGIC+JcvXXq4=;
        b=Sao63iwtxySUSSAqYPpzMPdvzcv7LJhtzFPRHP80vfcnrlJXGGkfWn7BVSEtusJQGc
         JlPGFG4OKIFZmwu69JqMKepSovqKH6MYeq/xak0JWaa9LiCv41PRKzcKo0gcGDOtEzPu
         zS4bt2LZi5E5CbB/BMFQjPTiyHdbK3+W1aS8O7NRxX9jsam6HyK0cZRjEuCFSLTlCAcj
         iisSOtaF9dXZ7vcoEuXg/e/0nuoiyXmaMJDAEz44mbuzALCzQdEyGBGwQcVwSvymb/Ky
         vobmI+RvgfynqjnED0sns7y/GZixSLqi8PWq7JfavetGe/gU8hv1hs6sHsecsbMT4L6i
         8I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837910; x=1774442710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDiUi7ubyDY0I4Yajxf6etnCfMlRy3CfGIC+JcvXXq4=;
        b=qUf/iJeRQzAMvfO1my7Xdq/IW8tRVdi5CeNZu0TSJqV1Nv2JhNX3iimcHaD0Sn7bAz
         AqRqtR2qxP0jG8LnP2+FeSoipOkLRIdkgQcS3n25nfdpucsy799hq2bUGL+qIipGY+zF
         zr8iG9l8Fb0KGeEQe4xMSUrKSIcCCGW59XnCQR4X5exa5ixMkQe2RWacBI/+JnmCv7jv
         +qjCaC4+uEs4wKkEfNmdgLUxt92RCkbHDats8m/eEbODFGD7FujP8btQSqMJRdKlCGho
         q9tFiLEkTaSAxh5FBHpILRhfQ56ZFBsVxclUTd8BQpDuwPFIq3vppJnHExfAA1Rv12ff
         A1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXthQIRHryVjieVcgq8QiYsHi+bTJPwXc/vucznvNU+rt823+EMvOgcdfA4LtLWwdW6I7RvxLRTEeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYfS+DZpQmSvB+75ywcVHBIl8mz2NsFJpJhUw7BuOoQtaLU9a
	/hJWo3Uk+oL9B3U4xOlbT5laFy9EknEY9SNCyx/924okws48Sf9t0VA6
X-Gm-Gg: ATEYQzw1kds1vUxNRkyr+IV0q9z0FoOxMyfj/cg0o0EgmK4dfmAGThbbGJhA3x6wDHi
	7N5dCfeLhHl7rsX1zMEXuhNioxBXjsjggDUvHU3jNUxi+UWAd45RplGGOZY55nLg7ckaaEsbIU3
	xdoLJSEn371ePgXKaX1UOajYgUnzuvTwFGTr0KmAsTBlDW6YfnTLIvHUWgfrqcbBs/TQFM7m11u
	dFlTdR0yaw/Q1pt0gOcR3h3s7CuG9yOAm00u7Scg+KhlCn609laWnw612pxpLKYoc0oilHB3R1R
	5vMk+CABuoYA64LP9qF86H2ZIwaWb3nGRvAtgR+bmNHwHbzUMRcUT2DN4YLdfveanIgfIBCf3hO
	X34/SG/9qaqjwRjBfO7XiEZEIjXrk6WX8yk5c8DFg0ouvW+nt+pX65wan7tmRsrN/2zg8G2GnQD
	yF0fUSzKPeGGOCRy460pIskkaBKE+98s1//fJ3Zx/GvHZwCIHZhRNPy3s7wbA9Km4FVys8gBKTZ
	PGNTwC/2LrHguIsMpuNxTSdOY3YAJGFVGBNeh0pfIuloDY=
X-Received: by 2002:a05:600c:1f95:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-486f441fc07mr51141725e9.6.1773837910464;
        Wed, 18 Mar 2026 05:45:10 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:09 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/5] PCI: rzg3s-host: Use shared reset controls for power domain resets
Date: Wed, 18 Mar 2026 12:44:48 +0000
Message-ID: <20260318124450.163471-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use shared reset controls for PCIe power resets to prepare for RZ/V2H(P)
support, where multiple PCIe channels share the same reset line.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index bfc210e696ed..c61e011f8302 100644
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
2.53.0

