Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9830ACF0;
	Thu, 26 Mar 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533544; cv=none; b=MpI/pbFHLJWe9nFU670kFzdTL0MD+UykZsL9v/gMN+vz9G1BV5TJmLtnC/1EN2vYZiKS+MEJKSwXXDuRW02wUKOnXHr5AQlv/lO05hk3cB7nYcISBSWFeY60VTcqgoCJ8jJPZ/tR91hNLen32XzF4FMGn2+9CvJ02i2HVlTJrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533544; c=relaxed/simple;
	bh=azslhyOrRd4bBRAEsZsm65h7MhY1jg32xe+pOuDKiN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYymo3grpSAanz3/E85UdpqwwQo4eUzxDCTricpZJiheREWdUMpeVkiEgp7Myr4fIjyhX7w12dhxjHdREZrfWTRcGKHUQYQrZ7uh3ywNIE3jMwD/ssmPkSw4ndascynwkOGbdc7ez0aJZc50MAv/62oif4YNEqi/aGzWwQSMbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzhyPDIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzhyPDIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8104C2BCB3;
	Thu, 26 Mar 2026 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533544;
	bh=azslhyOrRd4bBRAEsZsm65h7MhY1jg32xe+pOuDKiN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzhyPDIp/Ve4n/to/4nW3dhmMc74IYTJEetDluA9PfmTeASJDZf1rKXxNnfJDHPxk
	 B04yMNF6Yuz2yZLEnJAlvsU7diet60vje00zN+jV1KojFjTMprX22nL69g8GzD5IPZ
	 FcVRRfvZrZUH4lbJTuSCTdBJ5If0S5WWNAi1huaw16dWKb3EWZgiANeXCryWKhrTQt
	 G0JKLNZnD0jg/jJJMblzZyEIccvuV2S7/LeLdT/SC8ydCT47fUCZm7xV3kWpGx7dhl
	 zWe/ezpMVzHxSScGgXYT0hCDcxzWfG5buMY4WbP15x0M/Ou9IR5jA6w8QkRC8Ohh8j
	 2zgaQlTg34+1g==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 2/6] firmware: tegra: bpmp: Add tegra_bpmp_get_with_id() function
Date: Thu, 26 Mar 2026 14:58:49 +0100
Message-ID: <20260326135855.2795149-3-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326135855.2795149-1-thierry.reding@kernel.org>
References: <20260326135855.2795149-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Some device tree bindings need to specify a parameter along with a BPMP
phandle reference to designate the ID associated with a given controller
that needs to interoperate with BPMP. Typically this is specified as an
extra cell in the nvidia,bpmp property, so add a helper to parse this ID
while resolving the phandle reference.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add stub for !BPMP configurations

 drivers/firmware/tegra/bpmp.c | 34 ++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index e74bba7ccc44..753472b53bd8 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -32,6 +32,40 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
 	return bpmp->soc->ops;
 }
 
+struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned int *id)
+{
+	struct platform_device *pdev;
+	struct of_phandle_args args;
+	struct tegra_bpmp *bpmp;
+	int err;
+
+	err = __of_parse_phandle_with_args(dev->of_node, "nvidia,bpmp", NULL,
+					   1, 0, &args);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdev = of_find_device_by_node(args.np);
+	if (!pdev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto put;
+	}
+
+	bpmp = platform_get_drvdata(pdev);
+	if (!bpmp) {
+		bpmp = ERR_PTR(-EPROBE_DEFER);
+		put_device(&pdev->dev);
+		goto put;
+	}
+
+	if (id)
+		*id = args.args[0];
+
+put:
+	of_node_put(args.np);
+	return bpmp;
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_get_with_id);
+
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	struct platform_device *pdev;
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index f5e4ac5b8cce..822851ef4bf8 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -127,6 +127,7 @@ struct tegra_bpmp_message {
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
+struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned int *id);
 void tegra_bpmp_put(struct tegra_bpmp *bpmp);
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg);
@@ -145,6 +146,13 @@ static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev,
+							unsigned int *id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void tegra_bpmp_put(struct tegra_bpmp *bpmp)
 {
 }
-- 
2.52.0

