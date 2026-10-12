Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F4348C7C
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798516; cv=none; b=HoVFFdirAoRWMVXeaDwGtS3vsikIjj16ifPcu3eG89zTyCrnFn+rgJ78oEQ7H7/SW4M7UcRZwwYqqWqGPQ/Pr7R1LfFpntQ11+lO0QEiIc9xdoBe/q5Ru5lLqvP7UE4RU3bSy7p0ENwKYvmrlvT68Gfs71M1kaqjqlBQWXZLPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798516; c=relaxed/simple;
	bh=Xwo1yCAMK5tqAeCHkGuwh4MMuZ0ul0FuqvfPBWClix4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBMXHTyILVZ9841koT9Lr6WSbXxR0tg6CqpbQynxXFMJobQ7rt4JP4G3XioRInJ6WyHvR8iRiI366oLzZ0XKm6MlMTvIyvAfs09kdK7E6ATtYNzsf2Iqifn86sw/j1f3RPoJdZg4FplDswBLOzYJq5neubqqByHQueMLNejF3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TORYaqkV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TORYaqkV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so1446931a91.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791798515; x=1792403315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AE3qN2Gya+sk1Ul6ZbTJH8NleA3l4oK8s0FP1HbUA3M=;
        b=TORYaqkVFtclOWs603SYkBWWxbqnriwpP+x52DkpssGyR5Unfd/daaOYmfUzIzbDe2
         UROnVRll3Vn0U/sZ51Qosr5Wl92DBaiYgY1lOmzexCtjjlOWEJ06/EJa+ud1VWNel3X9
         um22y+RmZykC3PnCNi6rRrMRLBojjLpNcz4x7nPtfPaCrLmHTxEACWD9mtBLZyaorTwh
         SG95Igkt9EIDDU9dSLWqQ8vmfGdYYuJx/6yzyMyCWBxDzZnL8f7Jll1Dn9fB9U9/XhP4
         KVgfb8YVgCfQ5TUYyALGeysPFYWpscTiow9rK/nM6Q4Vig4GBg2bEMhgquvgmF6Bvw9f
         Ev0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798515; x=1792403315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AE3qN2Gya+sk1Ul6ZbTJH8NleA3l4oK8s0FP1HbUA3M=;
        b=2vFv8p88lfJYwWXe7zvAZHfcsLBg7JBSH9CLjEmNKBYwMIewwQcs2wi8ZseLslVfsS
         kXn2ezmo47EL0DAAl+Yx/qt4q19jK2mg9+5qLMy+HNrCBnr9+4Hy27iyLEEnTv1O8pzv
         hxV0BNs+HwkfAXl2S84jB+8MekS1s9uWh+3k6E1dQqXlVQ+VjVxXQ/8dg8jeoG2ncyLl
         nDSUxlJ45COrdNq1tLveNR9Stk6/PORDfPJb/JQz+/rZGgjEp2lhm43J3UKjUR7psE2x
         kk4tJ5VkLyN9tuGc76JOZogRTHvCJpFUGafjZ7Oweywwf2grZ4kskSalf54N5g9rJx2c
         R02g==
X-Forwarded-Encrypted: i=1; AKwUvBzG5suWTecSpEDYBDnVMF+mPcnw6Ii3yY5HVO8YO4n4y2cOwFIi1qnXopdwnQTiuUGLk0u1L6d4hHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBN/PsWmSa1Gu7VnDX0HWb7o1MFYGdTprd2duKtrUSB94aK1QL
	DJMtIF60FgvVnpO7tuh+lxdhPK3nAFk9+XLYqbHKwWN5u/QJXYX1xLHyG2OVuA==
X-Gm-Gg: AYBFou3ialjUu43b8ha1S1By56OFMkEwv+WRQkItogxrfiPodNBqE1u2KaFFe837fpn
	cwDLY9PoPEggv8rvwUDoAEIb/hNZVREf3OR7WKHchk8feDJtZX/mK5E+KHhmmJc7t3eua6IWVgM
	rjIptvd5aeWj1BBI7StIdRZ+pnfvtEEDkMWRr2ln9+y0E6kXJsrYTO1h6e0om8Ak1bwUzdAbLFG
	Zpdfgj4pH8Xv8rEuqWPg1cEcKfynceytmvAGP+GEjBWykS5FFOgUe1yUS2s2363STEwF/cv6Dpa
	MUjIbMCmYrLPCgPj6pRTG/xSD2QuzGM3Beax0ed6d9h/Vd5WGb3DN2sR5fF9oprI5nUKTVXwY40
	9vtGhIhBvqPRcVaseNP4ZEoCCPQW3qeApSLqt3X1cSu4UXx0FlxJcLR+OOVZ92v8myHnyFERHKq
	8NKjQIlt8VB9SWz0ZbFxUG+ZVsCoKnI4HFGpn5ys1OYPqLzDSNrjEiJRbl0mlCYUcgovohcJ6Ty
	ToKDo/brMNo0BPGAYckQAFKVrEKrD+54HqdN9i2JrTLYaPUbka9t2tES34wuF2sykbUXA+1fo+G
	iAZecbI0xwMqVg==
X-Received: by 2002:a17:90b:58cb:b0:3ac:e6a:1b2b with SMTP id 98e67ed59e1d1-3ac0e6a4ed3mr1023251a91.0.1791798515002;
        Mon, 12 Oct 2026 02:48:35 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm16189628a91.4.2026.10.12.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:48:34 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 1/2] PCI: tegra194: Use dev_err_probe() for PERST# GPIO
Date: Mon, 12 Oct 2026 16:48:14 +0700
Message-ID: <20261012094815.28160-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() when getting the PERST# GPIO to simplify error
handling and properly handle -EPROBE_DEFER.

Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Follow the subject line capitalization style.
 - Use "PERST#" in the subject, commit log, and dmesg text to match
   spec usage.

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63a0f56cad8e..2f8e828c4d9a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1200,18 +1200,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 
 	/* Endpoint mode specific DT entries */
 	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
-	if (IS_ERR(pcie->pex_rst_gpiod)) {
-		int err = PTR_ERR(pcie->pex_rst_gpiod);
-		const char *level = KERN_ERR;
-
-		if (err == -EPROBE_DEFER)
-			level = KERN_DEBUG;
-
-		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get PERST GPIO: %d\n"),
-			   err);
-		return err;
-	}
+	if (IS_ERR(pcie->pex_rst_gpiod))
+		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_rst_gpiod),
+				     "Failed to get PERST# GPIO\n");
 
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
 							     "nvidia,refclk-select",
-- 
2.43.0

