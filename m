Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7349A3AA
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370189; cv=none; b=Rj8wEjijNXQTb00dSzwMPj2lECG5OUfQlW4IPILJSw/4qV8qmR02N/2glnYNE5Rv6zlR/gHTmbR+5MhfqzGCtLoxc73lfbVGb5X+Vy3eyKkvx/kWZiIf5fjK0gWDnYuu99THzX/N1Atk43YcKT85uDouS9mztzW92nW47ntG8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370189; c=relaxed/simple;
	bh=xgVe3/5ChIxKHbtLau34tuV4XNPB7x3ojPv2vZnUFME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9H5c5wo6Ziq9UsrL13PadnI4LjE9ytF63iRI0Bn4znhOl8i9YwUeHeoc0SiKg1XeUrWEldXw0CKbZzrspUtySjBGrZEhmZIkp1RW862c/XKD5x6arrVXh2X4oo1DPB9n3sFSTor+29VhfyiwhVhl/RnmoWzxx8axRWBo7Q7k+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvSmA0FR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvSmA0FR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4d455ace3so1844311a91.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2026 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791370139; x=1791974939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9e+3jmJX4LTPI4etQxzprcCTZVbd6Ws0ithfkyYyE0I=;
        b=nvSmA0FRbXqc5/oDtGDkyVQO2bdR7TsiVdpsoxGLZPTz6odvbFzPXZQzHY3Z5sn5xu
         q1zKp/Ka8B9UXy4KcDDj3itHeWCozt8Z4P+IWDl9fKNKUaDOI5qHsSncYDpNM2OEHRRA
         qngdQpPrnyDnLQhgOMwYFYm49YW4lP0EC9hVB89yf6VJIw9LBb1gRNjI8/UUe794TsOi
         AS/y/jC6jq7diW8pOOOwYry8OohSMsFTxUjxbAzipZ3zoYxg+tnbgHR3wZVN9sfsIe2V
         NAeANelQZcKSF0ha8hn+Q199eyagBKI3CtSwfpm224sMx+v0QstSB6VRI5B/IZDe9ScV
         aHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791370139; x=1791974939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9e+3jmJX4LTPI4etQxzprcCTZVbd6Ws0ithfkyYyE0I=;
        b=n38FHaVJjw8EqHTrbFr8+oOAmwPOU0vK1ZYu6yUnw2K+IpWo0LWsB64S80QmbUi6Ec
         FuBPMZLu+wWJu7sBkWK/TEKqBP6KaXEWv/+PbWVz8KqhLL0LkHMXzhtStUS79JYuRm6S
         2jGF0g08LchbcQoq8EHkvfXptznczgKFFt14AI3qCFChuQfWNKif9opbFJn5phGKZM56
         IY50DUzmakDg0qj6mdpu2X6q7qx79wab7wToT7vDnMMHdBMoWp/SpxmzB4mFwByQvhC1
         bDxc+VOGUt4Xbeqf011hUOnLU3923Y/8KnVLi2AYvfQ/HGerEtG+BfABMV4K/egiBpwY
         ciog==
X-Forwarded-Encrypted: i=1; AKwUvBz/0eK4l9+VVxY4odke1sZ68vNs4NV8IN0Mk6ySCmSZYhS5s39qMQ/d1gTZQEmUuh2cyS7gfz+Dqdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS3S1dkgeOjgG02+GtS9HyjzJc21tdRLBW1EyzO5Ls9nmwaVhZ
	cD3dozTUSCcnja9W8LoIcJ7/EVlldIKlALJjdJX1DprA8yWokDQVWkIe
X-Gm-Gg: AYBFou0gA+NC88KVjwlEuCm+X8ldqx35/Udq5ETju2gzE5UJ1G6Rv9jB+aFc7jOnakW
	vLsWhPDUsgT/nSZVPa6KMYUfUWAjcrj25fWavnWF/D3bg8edNx7NxhjncPTY7D3W7JGcFvBWInm
	qFXp5Oif/rmY+5tGubFuxlH+lLSEMeBcGX/z9LhjjQVROQLDGgRXKOQwbqZfjnyQhcVmWrVsvkn
	8w7/OIeIhMmQi2gftPFMlJNHL3uEBvyc0GshmW68WPSZuZdt//PfHEhODdZBYYMiln6hM4G2VaO
	ccPgei1T8QveONLsqpAJuIJza9rmmF3FJ6hOW7yvqx5nRvUCI5UcCWV7SZcGydoBwCHhcWaT7lO
	T2M0tEowu8luZmLBYKr8knqdn9DbtkqKoTeIgY25buBgKpMe5POvE4SDBTJb04OYJRsagBwolp0
	sM78d7TjX9fSnxubgA1aZZ1WOh+jToOIlQjteeS/BT8PY4YRMzH65W4SeO1AUmz4mgQifJO9+Gg
	ikBwa44XKUbEBjHNuQtaJ7s2GsJWS7p7PTFgotwnQiy6Xj27s3IjV0f/u460Po3e8UmXKnd9LW+
	dlwiCkE9KvA/Ew==
X-Received: by 2002:a17:90a:fc50:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3a89f649791mr1506978a91.5.1791370138770;
        Wed, 07 Oct 2026 03:48:58 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85afe9ef9sm9119961a91.12.2026.10.07.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:48:58 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
Date: Wed,  7 Oct 2026 17:48:46 +0700
Message-ID: <20261007104847.507776-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() when getting the PERST GPIO to simplify error
handling and properly handle -EPROBE_DEFER.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63a0f56cad8e..767e11216196 100644
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
+				     "Failed to get PERST GPIO\n");
 
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
 							     "nvidia,refclk-select",
-- 
2.43.0

