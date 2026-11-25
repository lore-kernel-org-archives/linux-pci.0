Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580137;
	b=EErnpcpQX8REqp63W0SUV/8VfRvFgfv1neWpKYJWe4m2/W6+UyWFQ5CGyrYZRenpSkz5
	 wcDldPITBMnEU3WdX63fcgiLiqRXyEc8IemMKHLEXO9bCKHcEedokSR+mDksx6YeBSzZW
	 3k2aSw2JGDPbzJsSrpNFWFhu0wWpAZkifcZArJ+u4K+xY1BT17aQC/bnfH8zA898ZCX9w
	 2RgxdpNIic5ovDxL000kzHyTjGTNY2+yYMo+SdiQL7DjwjrK1jABGvj9is/X4PdvGtz+O
	 M2tH5ZENZSrYjmOMRFn9q/+OT2oB0Lp8FEdW878mneE9oG942x6a2z+WyNne+LuClHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D/X9ZyEdnOXOVxwhtJ+XxsYI1vONhPEcHfkavK3jVzU=;
	b=n187yxVLeRGnWFzh5CEwFw81NAiScliaJtQ6nABbUAYn3Xbspc5m2xe2DEy2b2+a0JVx
	 QJB4F0mxqw+9j4SampHmnRV4CW8xM6CEVh9p1ZRQpr3YC8AQagNajGsbbX0c14WVc1NIg
	 3nrCAaWaAdguztyOK9qpybqBdsmkBO7aLYjXw+jYEY7a7FpBZBy+1+cth1dgONUQOU2f7
	 dTOqB5XqmhTZA5H1DcZUarS7DZymM67fnAL1lNMLb8hnEbOuhBYGHp4N8AcybLRIN0tvy
	 46Ao8kSCHTQHMYwO3+WX2cdiytpb6ypvBhVnE1GCNdJFge1f86J4ClbThSlisL+nmdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOehhLV5;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B7606A329
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7B7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOehhLV5
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f0464dd6b6so31714475ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580136; x=1796184936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/X9ZyEdnOXOVxwhtJ+XxsYI1vONhPEcHfkavK3jVzU=;
        b=MOehhLV56Waaq2mRUpUZJGwEY9shCuv67QPGJ8YarlLXY0W4iNb5HkkEPmmMB9iKUl
         v0vXxQBxg2tRd4+wkkh6REu80iLhv8x4vkQ3PMFfCBQ5ba24hUx5b95rsqT/o9glAT+P
         ZsJ8EO0sUD5uJ/G7VsFp+gEPQUBcoRlo72hmj3N8J9yF0xeS3t93kkwlOtOupuJKpT1w
         sBlvylZ2xkJfMIfCSGlIxjCKhsjdV4cQvkVc6MxVYwkXJgwVv5mBcYLnB6jVpEBb0s2m
         75TU7qrBQMzniA6WXqmB0JaRxKipz2R5U12Ju3TNaAxRwzAAtAH8/OK8eRsjD0f3NWLw
         jYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580136; x=1796184936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/X9ZyEdnOXOVxwhtJ+XxsYI1vONhPEcHfkavK3jVzU=;
        b=mUtoZRNfmX2M1OkEGNa1vGlB4s06ZxZopqzV84s6LxrYyY8omiYVsdcZtuozg4OtML
         Yfh/QlE1PyV1QrjrU2Q8B7pBPyQCJTXd6kWsinLffBwnRge0yTsBax+FJNkOKDaCItmC
         OFC9MytMh8RKipSFvGfJ82RuSJpxnszyEp1wH5fVfQRy4zNR5SddRjkkk7yaS1gQsEOt
         cmDlmqVbl74kcsg4xn8HQeq4NKsu+ONE3b/Vmfz/aUD2FqiHEa5Twh5nXWPw6U0Qca39
         VIQfrPx1Nh9wI3oaT1XEMyyXfiDpew3TDwo2nJspryVoQ542sfsjS9Ou2AYKQBhrganN
         tScQ==
X-Gm-Message-State: APuU4Z8BmNtFtB5+vvHd0HlIuZ2FajG1fpRUqa3p5EDclIMuilmxPYyJ
	kHX2a50KLM2kA9b8t3ASBMSs5Wbvc+KLdqyUJFNEu7gsQBeAoe+ZHpv3
X-Gm-Gg: AZFdTZdWoDbjusD6Tdh2FGGLcGzGBvkaFwwG3OsWrFRL2lJndvKTpD3Ei+EbYRJoVY8
	I2SlVwc1++6JI8FpmeDl9Sh/nezFSQAk/jHDsJFEttrqe+pqFwGjyoTPrfks+mmATXUcXfaxCOo
	J2CUhzQJrCGLROqky6uS0r+aSmA+jKHcAvT99vp5CRJDlrrpU8WpXyr3yaZxNekCSGvP6suA6ed
	YWPr/syw2zfIQd1LFKPK5roHrzffHoQ8pDjASsA1mbVQ0DNcK840y72przb6jzHe2sl+muMy1lt
	Zv6KpFnUdZ+mv52aRufRe3lIOVVoVrQHagrGwwxIMgkIK+HE1LmUsMVMYnk8z8cUkHieS7MMquk
	W4SwOFDVRe6/djrRXmOecgMmZmFH+uVIZ28AzdTQzfTbkOMTr/GY44bh5GbGkoZ7fSqOz1lcUYY
	rgrYn0RYd9bN8WslSa4VEeqxTmxtVUI6LL0ZXzcOn1uVzSZ6mWtzZm4NN4oqddHcAELEWXKmjJu
	1daQLQmqRZozfm5X8QDJQVcBEwNBqAVb1M1jZf/okFetevg/nLHsRHKeIh6PR4sU5mXlKyGMgFL
	N6/zzjVwcYsvgsKueZu6jcESuR/Z
X-Received: by 2002:a17:902:e80b:b0:2eb:1dd7:3aa4 with SMTP id d9443c01a7336-2f03f181759mr177341625ad.34.1795580136016;
        Tue, 24 Nov 2026 20:15:36 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f8aca00sm68640555ad.38.2026.11.24.20.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:35 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v8 1/6] PCI: spacemit-k1: Add device data support
Date: Wed, 25 Nov 2026 12:15:15 +0800
Message-ID: <20261125041523.242588-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
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

To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
data to handle the K1 specific logic and make room for the incoming
logic for K3.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 92a71ea90ac3..658ad2fa87b2 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -48,8 +48,17 @@
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
 
+struct k1_pcie;
+
+struct k1_pcie_device_data {
+	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ops *ops;
+	int (*parse_port)(struct k1_pcie *k1);
+};
+
 struct k1_pcie {
 	struct dw_pcie pci;
+	const struct k1_pcie_device_data *data;
 	struct phy *phy;
 	void __iomem *link;
 	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
@@ -277,14 +286,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 
 static int k1_pcie_probe(struct platform_device *pdev)
 {
+	const struct k1_pcie_device_data *data;
 	struct device *dev = &pdev->dev;
 	struct k1_pcie *k1;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODATA;
+
 	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
 	if (!k1)
 		return -ENOMEM;
 
+	k1->data = data;
+
 	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
 						       SYSCON_APMU, 1,
 						       &k1->pmu_off);
@@ -298,11 +314,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
 				     "failed to map \"link\" registers\n");
 
 	k1->pci.dev = dev;
-	k1->pci.ops = &k1_pcie_ops;
+	k1->pci.ops = data->ops;
 	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
 	dw_pcie_cap_set(&k1->pci, REQ_RES);
 
-	k1->pci.pp.ops = &k1_pcie_host_ops;
+	k1->pci.pp.ops = data->host_ops;
 
 	/* Hold the PHY in reset until we start the link */
 	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
@@ -319,7 +335,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k1);
 
-	ret = k1_pcie_parse_port(k1);
+	ret = data->parse_port(k1);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse root port\n");
 
@@ -337,8 +353,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
 	dw_pcie_host_deinit(&k1->pci.pp);
 }
 
+static const struct k1_pcie_device_data k1_pcie_device_data = {
+	.host_ops	= &k1_pcie_host_ops,
+	.ops		= &k1_pcie_ops,
+	.parse_port	= k1_pcie_parse_port,
+};
+
 static const struct of_device_id k1_pcie_of_match_table[] = {
-	{ .compatible = "spacemit,k1-pcie", },
+	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, k1_pcie_of_match_table);
-- 
2.56.1

