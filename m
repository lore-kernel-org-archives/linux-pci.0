Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581447;
	b=zsSjKtkTgyWcBrBgCkd8xpYANrCvDDEJCALXpv7nA/fqGCUnQl9fghrG7EyN5PS7h+yl
	 h6SraFB735xkdIViWffKS8pEXHubcn6dK7gEGtLhICmqOjgdKa5yclqjnFJGTl4tXmzMt
	 I/ZB6GluYl/iZaH0E2neMPIhXY175jY9moRmw2B1VTrg6z6Ax5KmKyv44pRvMdKIIMshG
	 wCQKcZPrMjmNOvHkugbogXS/8OM6ie5A6zDLDj58FbGrA6E52TpCne4/qeemTEzwJNUmM
	 0fDlPoy+rBvwWiX5/xMIkIMn0Po9lPVudCzlqn+eqVD8z9v2b2JqSi4X3434G1VbzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
	b=EGKCM76FlCg1A1xXyQOqIIeJyl5R1oN/ZsqlBBwqRgVDBSG1vHAxen4T5freh0dwQTvn
	 oRsDHfbdAwDcH9ARQmqUvvUSRmQWj2C7yBB4E7+8R2VCIFcplshz43794LuISQWjK9G9T
	 7Ey73JTNFoECpxqrhk4DkY5d3WIUfuM+QEAyHDOfkAI1QdFe1V33TLC1PKFVN0xbxUaR8
	 DNJ6r2Dr5wvhxo/RnD9OHZ4xxGTvtY1zXYfpBArxByWlkDpXczuPykFatbMGcLTUuNicv
	 jtOqjosxC2N+goxAU317m0GiMOpeZ7PwH0tCn5trCTuBb3LvSm/ua01XJNwxcz4Bb/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr15ZfdJ;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1117606A334
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1117606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr15ZfdJ
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2768210a91.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581446; x=1796186246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
        b=dr15ZfdJEWlFKiosbX0D7l9+7/idGVhRa4u95t0s+U28EotPIPmyI2a+lnKcCTISn3
         S83ipJQLhVZoPma58S0CxFaXppQbCjP0Df0vV2D9+SStuKA+umIhNW7QQSUz9lHe2Ljb
         jC8mQgsMmwAU2d2AxJRP/InN8vIA/0f6/ymJPD+J2WOGQbtKCNFmm5AeybuSWmkAqwtJ
         jIdyrqVbnPcE7hN5G8f+I5n0ge8+/Vx/orLpolDiqFu8ZMF8EES03C5sS6pL+Mi4eIYv
         3LE3GQ2ZuqbVwZ1kE2IaFXX67bbSv/y592kweeth4OlvGf2uRDCZKlXbvbJ/nm771M+P
         1F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581446; x=1796186246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=37Yw/Yh5Rz5Fzq741ubEI/Rr+lL1nn4+JbSz5DFAcwM=;
        b=orGGbxE3Sgw6g3JnRWJiXLLnBcqDUyDJ81cVJDPsa1sqGS8VJ0tZnwsSfWDfb52H1o
         D9f7PwZ/J8VndQLqVya6OtCU2BRuVm4PxylZ5TJwF9U8zbsRv1FEG1d7XvWugXfziesv
         hViOmNNWSiJE0J4itwmJXpNBTHww6CiN7tnMyZH1HyLDTPd/GUJ8gXr0p3S7EPkQEWkM
         ESX+oP1TzooIKkeSdoSA2TbLITaoR2zDk3r2ZlZOhHZe2f+eEABsaUjOsQOt08/tm6HM
         kCtcG6X3SbvVgmbhScCrOV9fSd39tuwozNOQkbYoHw9fG03D0aY1lCsNANWu2Beg8zRG
         YLeg==
X-Forwarded-Encrypted: i=1; AL+hErHkSr279F9nkpc3ciNOJ5PB15EIGRhKuWy5m9cHGkTIYJIPbDrLMzugn5KhbKclanXjAbd+Yx0Z8y8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Yg1j8Pf6zf8ckDbZh8iQ0ziriCVM/6rB/ss1JEHxDL1pg7p0/
	bXVvw+M883Kk3IfWD5x+HKQ7dciIVYgzc4YZrDOJWN55aAhzhxA3RJzV
X-Gm-Gg: AZFdTZeN7g6K4doao1wQ4uk+Fh9B7cILUSsogdBMEdAK3ORrIDBHdr0SXwjeUaAO5js
	2SjdTBXBDR65qJsfmYiAtDhVur5BYljOgCrpTkbDio7ybvPNQK8zvKZ25E/E00tlARiXhLS0N5z
	MpehDlXADObbzXh0fwZlb51y5uFjdlWVUXBdvyGbg8LhL1Xs4ANRhrMe1blfOoQ06yrDNFezJUz
	LHr/Waxhg6h3jbRaLPGK5/X9lKOk9kOY4pfJRF77lkovpRxXkFmonS5hPCbpVv9NYfA20sJgXkZ
	1ukgxMAeaU4hbq02F7fFdm/SCUUP5QwjiTnKLpgdmEg/11TnjYFU87/Ern/uQ4jYlAj5TzIEktl
	SCy/8AX3sy1UaFARhsIfck7gSfVffNC23Qo0dELFnyRbtc2psEVPcCrteUpXxdpXCXn1I7Unc53
	On0rmIyhAUsUyPvUwQiUNIom8tCwxqiaObljgnwbhk8KIWmncGyr8h4B6bDrYBSN8ToS/42pzBt
	D6IPfEew4ApvjLahcFgNpjJ+tWC3cc55zGYOuazW3WLTTG2LLk4uVkW8Lwyyw6HFDeg0zQVY9ZY
	6cPHQGheFx9IcnOT59Zs4JH8WGA=
X-Received: by 2002:a17:90b:4a48:b0:3b1:4018:bfdd with SMTP id 98e67ed59e1d1-3b41c7d5cc7mr13865555a91.7.1795581446160;
        Tue, 24 Nov 2026 20:37:26 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm30506154a91.8.2026.11.24.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:37:25 -0800 (PST)
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
Subject: [PATCH v5 3/8] phy: core: Make phy_put() ignore NULL and error pointers
Date: Wed, 25 Nov 2026 12:36:34 +0800
Message-ID: <20261125043639.249525-4-inochiama@gmail.com>
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

Add NULL and error pointer check to the phy_put(), so it can ignore
any bad and empty pointer, this will simplify the release handler
of the bulk data API.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/phy/phy-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index efbd7e139dce..5004d28b167a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -780,6 +780,9 @@ EXPORT_SYMBOL_GPL(of_phy_put);
  */
 void phy_put(struct device *dev, struct phy *phy)
 {
+	if (IS_ERR_OR_NULL(phy))
+		return;
+
 	device_link_remove(dev, &phy->dev);
 	of_phy_put(phy);
 }
-- 
2.56.1

