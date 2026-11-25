Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581459;
	b=ENqp3LfCyenD2XsTewQbR8XqzvXciiuZL3LihVzVGN784tBI9kaOoNS5NKuBS2DGWnwm
	 bMquNVApDNBw5/0vn8JfChDPxLrVy6ZtP9eE2Hg4Dc8yih3KQEQR/ATiebIVrSTDXjyHx
	 yZZdwjMetY5xYXhM2RLVBfkjw65tdDz6fVNtrVXZisYR35zZxJ/2Da/4A4dBMuGOLXF+X
	 ExJb6iaW4Yxg1YzeCA5CRGooMOzJENurlYN0Br0N27u4s2285dwlKRv8i7PF18+4f24bz
	 v11y+l4JmpnEmrRnqAGY56lGsTrOkjavLwrZ9jx3ROBJE87W501uuIY1qLPzBVj52lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
	b=hAAloDvZeReFnpRrXksF87qb7pt7C3BosjGg1mmXx3B/bDl8SNbvPvmXXscK0vpA1oUY
	 7X0IQijbuNE4PPBsuFznBDYa7MOfAj96Vpd75WGmv9EPj3fHz+aHFtTXaSBn21Q3C0+9V
	 fBmgNVPk0f6roodq5yCR07C8P7zgwKAyo+AgwOpRbwS947k60yg3IxVPyBZs+FNzLiWN7
	 QnjZ4+sUQxLWutkatO0MlFlEsrotQ1lbhMtKGL3xsd93mG/mM2wXcpL68dlHiZVZ2bs4O
	 dnstp5bhjAYfJzuGDhWhDyoxpFLULj89Gj4vMJtCcIM/7sMTPUtorii1nDFdl+LUzkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvonKtza;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD6606A333
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53BD6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvonKtza
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so2485497b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581459; x=1796186259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
        b=pvonKtzaM5Wyk4CZmuG+bv1luP4hRBIDQlwZ3sKoJ36e/Bw3Y4pRek8KjQ7VDVbOo7
         fZgx1adpdLIdwu9BI4YXoD96CZ2EPF9WIVytdfCMZr4pBIS5N0UjXJ4WzZ8iaVc4bUYr
         Rg7BbMaiaQz2/7Y2q1E4ywyZYY/NCR1VDPe+98ERZ2tVtDV3IXkNWj2XEZAaH8u/pVuQ
         0O4Zm9DQCMMjbkvdSz0unPleqkuBZdvObOkeckPbpazhirEi6Uxidtszq1puuOqiejDH
         a8tu6JrDzUXppBdFxHJH68yoMHym6z+0S1tLAu0YzEfJ6hAp6icPFSiWAMMwOqtvfFva
         uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581459; x=1796186259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0LC0sUIzj6iLFfqcqtwKGB2+VgW9jHKFGlHAfP+Aeo=;
        b=me5NEGGIPIPmzs/Eu9Ttwfij2grnBTquCKY5tqbki65Cu5YcvD9N/EHzv7U11tkdE+
         rYP6cip01LwhcKxaS5dU4lgF6jV5jm7kTUw6PTbz9IIxjD84DNRUK9+o4LzhAaH6RDZS
         hmfm4LVOhJDWIMf9JqvnCWEiJGKX28Jpd54FyK+O7yRne4FwvtF5WuOTnlHEKMO11cvF
         phXYZ4e3Olk4K5btSKzNkYsio7zevoCXdAee9IpPrnMTdKKMbYuhA/81ONJyTXTkIbXd
         kXBpPBBx/ld4apqoz2qRFDZ2GPvF7L/XEQ47xqPU6YfpWDVWlvQpGTgSlCOocnanBTDy
         QkCw==
X-Forwarded-Encrypted: i=1; AL+hErHOYNg2WPKX4HjbCzDxj17SpwyHjTzOKNKd3+NEZb6xIjW0aX9yLyWS7PX4728RoCXAXQ+nD4boNkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9smJ+q+Kviy90e3+ACdtYK+aH5Td3I27NHFlCbSX0xBOt5v6XM
	eK0MYbpWPw0QBa1afw47mefxTCjbZWpmoC+QIqcWMzyH6D95ISBRhUgX
X-Gm-Gg: AZFdTZf9tkNP75tpBDvGiY2MthMsbPFj/hn21ONJPfrbGEzJXqRM0ZIq1xUz9Mlbw5B
	6BVHBd2tqswrfYaul2KIYgNDyFCnfK7XZpxA5x6gzNVQQQSboc0Jxqr0aWLMPirCfQ+3f9XBeLX
	Il3xmVTZkmqtQ8vlT/ZGMf2+u0Ezl+KaY5ER6dXZjo43xu4XNOmm3BK1ZJpFOt7b97SnoImyTgB
	HmXlkMLmjKvdht7qMT5vH28O3Rky3j8DqSHZ7jYHqBcZ9HQfPPWQtlT+93SY4u/Iumo3Ro0T3pv
	4Q2EION8pdbBUuIpZjYwLA0SdUm4Uua5cZToFnResgDNDSMKVEeO60Gh7VrL4sFZvASz3BxRZBp
	rfvdy2/l7ZqNZP7Tnjzbd6KmyW0qEhYoLAdr8mWnZy6VpJpX8HbcGat9u8cDDSe8CBrGbUgc3tN
	rrKv4G4wulzlESaYXP1LWSyCMyxxvQ5DxWJitX/I2aKDYrFmWlL6rhq8dgmQ7aTlPGqYNG/F95f
	ZV4rCi4DNm1Vhb3D3ibxZwQKqTz9ElfRy+yhUKCi+BQjtEte47U0DgAyYOFC03FhhO1tHf1aPvW
	jpXPdK3kNEwkQhCgk3XInmtRpB0=
X-Received: by 2002:a05:6a00:c311:20b0:8c8:e7ae:5ab2 with SMTP id d2e1a72fcca58-8c8e7ae5b89mr11374449b3a.53.1795581458605;
        Tue, 24 Nov 2026 20:37:38 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c86d821637sm8324761b3a.0.2026.11.24.20.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:38 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Rhys Tumelty <rhys@tumelty.co.uk>,
	Manikandan K Pillai <mpillai@cadence.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Hans Zhang <18255117159@163.com>,
	Yao Zi <me@ziyao.cc>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 7/8] PCI: cadence: Use phy bulk data api to simplifiy the logic
Date: Wed, 25 Nov 2026 12:36:38 +0800
Message-ID: <20261125043639.249525-8-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125043639.249525-1-inochiama@gmail.com>
References: <20261125043639.249525-1-inochiama@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According the document of cadence PCI controller, it use multiple
phys for multi-lane setup, so replace the loop of phy operation
with phy bulk apis.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 62 +++++--------------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 +-
 2 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 0ac980249941..8ed2a679625d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -179,39 +179,22 @@ EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
-	int i = pcie->phy_count;
-
-	while (i--) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
+	phy_bulk_power_off(pcie->phy_count, pcie->phy);
+	phy_bulk_exit(pcie->phy_count, pcie->phy);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
 
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i < pcie->phy_count; i++) {
-		ret = phy_init(pcie->phy[i]);
-		if (ret < 0)
-			goto err_phy;
+	ret = phy_bulk_init(pcie->phy_count, pcie->phy);
+	if (ret)
+		return ret;
 
-		ret = phy_power_on(pcie->phy[i]);
-		if (ret < 0) {
-			phy_exit(pcie->phy[i]);
-			goto err_phy;
-		}
-	}
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
+	ret = phy_bulk_power_on(pcie->phy_count, pcie->phy);
+	if (ret)
+		phy_bulk_exit(pcie->phy_count, pcie->phy);
 
 	return ret;
 }
@@ -221,10 +204,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 {
 	struct device_node *np = dev->of_node;
 	int phy_count;
-	struct phy **phy;
-	int i;
+	struct phy_bulk_data *phy;
 	int ret;
-	const char *name;
 
 	phy_count = of_property_count_strings(np, "phy-names");
 	if (phy_count < 1) {
@@ -233,31 +214,18 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 		return 0;
 	}
 
-	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
-	for (i = 0; i < phy_count; i++) {
-		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i])) {
-			ret = PTR_ERR(phy[i]);
-			goto err_phy;
-		}
-	}
+	phy_count = devm_phy_bulk_get_all(dev, &phy);
+	if (phy_count < 0)
+		return phy_count;
+	else if (phy_count == 0)
+		return -ENODEV;
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
-		goto err_phy;
-
-	return 0;
-
-err_phy:
-	while (--i >= 0)
-		devm_phy_put(dev, phy[i]);
+		devm_phy_bulk_put_all(dev, phy);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 4a96e1869e53..3cde29592331 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -274,7 +274,7 @@ struct cdns_pcie {
 	bool			             is_rc;
 	bool				     is_hpa;
 	int			             phy_count;
-	struct phy		             **phy;
+	struct phy_bulk_data		     *phy;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	int				     max_link_speed;
-- 
2.56.1

