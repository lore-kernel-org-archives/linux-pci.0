Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468E36167E
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037692; cv=none; b=CC+IkVnLgVUNO7IXmlpej6QuoVTBdkZ43JWqbvLlgPrS0EFNqrGuFUvyow86+PXzdwFMx6+wc8bN32FL3zQwDY04LH3EZDs3ydB3yY0TS6IyBmhTd1yTW79zjtHaHINEgyS4FKoIQ5QbAGTIyHSrL1Zj4sQammdxc7hv87cuzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037692; c=relaxed/simple;
	bh=zt9DR77wzlilHy+G4PnOiXCK9LPBeXZsCAt1vj+ySS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnXQ5a40HkU1eFd1wLQheqVowC2i+3u2MV5UqYtH6JQgVJXCfLJn04YiqFZOKfSJAT6EZE1fCahnP7hIYV27piXpnAxR8nHscir0GRRa5haXjmemnTrNR7RhWKBGZjQ+dEvcv7OZofPfo7of04YVc3svwfbI0X4+BwNbPcNP0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aU4scHM6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU4scHM6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so47200995e9.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 05:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770037689; x=1770642489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=us8rkbaDqiFPo9bSgIdnDClrOWuVChIefeA+LRaKMx4=;
        b=aU4scHM6YzD9HFDtv35PVHrZ0aKJKjmQVgd3n5rn3AOxSmD1b9+8zWdiiAYoI52+um
         KaZtLfQdZLzhv3ZJ65BP/2dQBWE9mSssjvVJWQO8x1KgpvdbJqCK72h4bHMTjcFbdNAk
         dAM5izxsbb5+HUTXh1GGk5WcgZxrELLHlb2lIYs2sVb4IskTjujAEplOrVug9QYRfX04
         BLWQdLDpA2yc5i0KXVf8yUK648wF00Awm7WW+h/jc8uxSX+/2XDwSZ1rWD50fnl2ZfqZ
         BtObyE4OvgTybxEmc2zLEWrjr3ZC8wvHWd0J53cZLK04s0JE4UJhRoAEl3tarkCCeVgk
         0wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037689; x=1770642489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us8rkbaDqiFPo9bSgIdnDClrOWuVChIefeA+LRaKMx4=;
        b=iwSGQSqojchyfkbKSIvrk/JcKJ5ndjfenfEyPiuu8lfLgvcggo0hasIttxTUBU+1nk
         FS8Z9C5CVbuzCo8BkGQOTy/zAq0IFFfQ0aKManF8/0ExskxdtiL3Ey7yErgnCE6Xdet/
         Vbu/d57F+lZb+d+X8LJOTr1KMS9Z3iCvVp2vD1GigOMs5xlwDPtAIlxopcIphOPeDmaW
         MHikJ8ZoNCgdWMQbhY1+X6gvkSkp/VZ3XL+36FSnOdUnf/k9HWCPYdCgjqAKVuCyNPq5
         3AxV3NBgHRLB4+fRnIzDa3px1hdZehX1MErtlqAMUs0U3ojDa1Szl4QsScCu+zfz5b8i
         qOXg==
X-Forwarded-Encrypted: i=1; AJvYcCWB553GcUNHCMUOYPpVEniQYoxqmWyRB3k2m6AF80XKL0wC7/Qkrp3q1iMe5/EKiIg39Amr80WrX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigYBM7kAgdxiY8HZ/dzNPDdcJCJS2s2Vd68Lt+500ValQPFLa
	nNZV0icLhU3TmZDToOHlOtjX/W/RfA5s3h6Gq07YsCUVvAKGub7hTdeThF9iIj+ezwgXV74sZ3S
	2ii2q
X-Gm-Gg: AZuq6aKMZpJ6gp01z+VSVOymqhgL2gQKMzy/MzMWG/ouob2igrY8zab8SOn38U6teCm
	rEaCHyLoKwK9YxKnWKNy+ee8896bdXapzfV5El9SGURdsDVp2hNrviv0ogp1xQPNQe7a1bRxrvc
	fEIZAsXQkdzd8TVq46RJjinRUPQ0ZxppQblQRuufBz4U41Qa24CsldPsKQk8gQUysl3/+hczCeR
	T31PQKMq8VZreGEySHfbyelaGuMeRy0oC+Abmy51wDasmxJ8Tv6nrqO4W5V2dyAFXcOFmjH7c38
	pGc8Q7KO7pk5bfP84ugDiBm3fODHdsJNmU7uGQiwwZl3b/On+BsCVZ7Uy+QJAB/D717qXgxL3dc
	ozTtDdGYFp50jendM/ZFobAulRxjl+dTmngXdyhBm38kndqdcwbiRebHO7ncwM9WjEpseHJ32az
	7dy7Ygcis495d6dmYR/UOUkFLaXH+BnQ==
X-Received: by 2002:a05:600c:310f:b0:480:3a72:5238 with SMTP id 5b1f17b1804b1-482db49243dmr160135245e9.30.1770037688901;
        Mon, 02 Feb 2026 05:08:08 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:fad5:23a2:cd9e:d80e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066aaf235sm438299775e9.0.2026.02.02.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:08:08 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PCI: s32g: Fix ports parsing
Date: Mon,  2 Feb 2026 14:07:56 +0100
Message-ID: <20260202130756.1421488-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No error return is missing after the loop resulting in removing the
ports from the list.

Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/pci/controller/dwc/pcie-nxp-s32g.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index 47745749f75c..767f5a622441 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -285,6 +285,8 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
 			goto err_port;
 	}
 
+	return 0;
+
 err_port:
 	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
 		list_del(&port->list);
-- 
2.43.0

