Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301703C062C
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154628; cv=none; b=A9ypYJUSbP8ZxP/xXuog8+TXSrSLZuMJlYpDsiTpvKmfOF+vES6c/FK6x5Wt85/vYpwj3lPPb+YTTEkswDSfUWhJH7FPZVvswCVlig4CiH/R6dasE1x2lWYaAaw9gecBqYFhTJSBXwEGQGy12ffzFEIm55pcEQ4eMKAnBU0Hqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154628; c=relaxed/simple;
	bh=hR7PWAXiXwEEwFIet49TpDy0cQALd3XIah84ihqGwyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHUr0F3NacgX+5Xw1Wq1KGmJPowcxbK2vd61Wa3extY8Xv/sPEVvLyA7YWUJTJ7R0P+5oVOim8RTbzi6AdOa6rsL+s+QECeMdpEvRCMhQGbmsV4GAHVZrEvNVqvT+UgTdPZs9lKrydWMPj+MPEy1NHknzsZRChi+vb3JYOU++tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMOVTl/s; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMOVTl/s"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47640541585so2948505f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154624; x=1784759424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4ripfAJqWHIXdYXUM5+uu7AjPtdQOgQwww925KypIE=;
        b=hMOVTl/s1GCb1jmAoqpSGG1IP95cd2y4F+1Srj+2Zz57cayLKBmMkL3y/VbvuT/yGQ
         9vd3E4YqOyVw/ZRkTG7tefZWlAFzG5H+wRkdl0amvJPrD+YWTpcK9CZr42ERipetzVgO
         YXAQMdo1H2nTIRDu11xSL60ynNmKla3ss11Kz+9Vmv4iszaYqeaRysJHN15s/iwDccYl
         ts8g/WaIPHfu4SGY6fueTLRybmzrwrscGy4rSgMREO59TI3LSe01Tvmb5DASpOPUJmWE
         olCohkhTDVHwnQDLHCHpDpQuFZn9T7xQbkboP925/ZxfQ9yJ+GFo7AloRaa5mhbVIOYM
         UPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154624; x=1784759424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4ripfAJqWHIXdYXUM5+uu7AjPtdQOgQwww925KypIE=;
        b=rwdw/GQoxmVP3hbZnVuI7Uhvzut4FQD7HSyOdqlw+S8v0PyJhH4gCn8loTTV3CWkDH
         Z1i2kufeqKRxsO18wLV2nZddDg8JiFCMOBR4ZGnYVBntXv0h/YmB7qiXA16HvEnBG5U5
         GyM3jKmlPkQBmXr7Y5o2ioqrr0QLIHtt+jHqoHaqtmheIPdfdUzADCCtMaKI2S5aiXJ4
         RLhtzy1PFASP9cxes70UNHtHWTm4ZCHfuvahO6BWcOLybDgVsBA3yTP8yaI0UZNv6FAA
         y06rhInsyvpslw71Ucx/MTg+6Zo/4pXfj9hhowRC71avyfJLo553J/nbzNydG61O8+ss
         UkmA==
X-Gm-Message-State: AOJu0YyVKeNwNYUqhXYUIZucUkzU5ovLPwVArMe1KV7Oti/K/K+0YH1s
	xv5vpGC5Vfyqf6CnG5ClhupNj7sqlquNWKeCWgUdVF/OB0pwhf4UKElk
X-Gm-Gg: AfdE7cmc2cHe4uCQBkJJn3EfP86r17c5qJchrJC3hvghnsXSbRR/7dLYsmLUYIofw9u
	QBC0mT0Ca5Ms1vYHIoA3litstd5tGAc1aW3RDTkGGpffohpdkCcWt0jQPRQQEF3NjrdiI3ISGkJ
	4iSjQb5HP/tEDUlLdKT61RRKSlUuoaKLrLBupBZDHQmfpTYfo7zgPUwXSLwhxYB27UWryinfxNJ
	/qarrUX847SHd0IqXH1lPEClx10yHxMpuj8JOtPI4KBHk7sFyhM1+pQo2uAtaXUidv4RoYFWYE8
	L2rrlEL3HOlLw73VTeUNWynJRSgpbJEkUgUUjP3J6H4FfMGBmlRogAyB1yr1DJ+qg1W99ASvjb7
	wXsjzbsGj6PKyrekLON8xA7xBp7wCblguGbHx4Wj7RYvnvqJMO4rcu06NcUtJ49ecWK4IB8ZFEj
	NUp5Dn4UpMT/TAIUOAT7/ewLvJt+C2q2MpdpD3DEZ17zefoPbmBcJyJ0Qf5Ap0IW70P1Vkeqjg0
	arb6mFmbB5+N3N6YKnD80rwuT8=
X-Received: by 2002:a7b:c38b:0:b0:493:c4e1:40a6 with SMTP id 5b1f17b1804b1-4953c28b6bdmr37737615e9.32.1784154624276;
        Wed, 15 Jul 2026 15:30:24 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm14791025e9.15.2026.07.15.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:30:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure
Date: Wed, 15 Jul 2026 23:30:17 +0100
Message-ID: <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzg3s_pcie_host_init_port() enables the PCIe reference clock using
clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
example because pci_host_probe() returns an error, the probe error path
only releases the clock handle with clk_put().

Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
probe cleanup path before releasing the clock, ensuring the reference
clock is properly disabled on probe failure.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a1a78bdb7af1..01488660ab08 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1897,6 +1897,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 host_probe_teardown:
+	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
 	host->data->config_deinit(host);
 rpm_put:
-- 
2.54.0

