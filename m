Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D12364E81;
	Fri, 20 Mar 2026 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047292; cv=none; b=PNCT02Mt/3In9iHkxB9HaI7+uLO2acvR/k6oADtSnAT4aWuj7ebIcP1CXrEDdHu7sYfhMWdqmXUqDCaJL1Gt3hi2432iyG7gJjJTFzi6wXKus2AA5tyhL19FzbtoMVmPrgbjuPoeCCzdB0jSrUI1k14RgXfbV4UiJyCGLSyQ2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047292; c=relaxed/simple;
	bh=MPtyut21H+++lysPLECI3MDbrZFZ8ba/5IamNcCxk8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyRxVdMPrZXJxacvBZCYUlRRO/V/HbaIqubgBCIPOOsSCl8lx9dp/MapD5VbcjyRciR8ya+h10t2cnsnuoeG3pa3c4unlWvdapGDMOnlCnpapo/bChNyeSfT3AM6CYGtsqUp2WBf9IdxYL4KP+DVdCgot/OhGjF+DJ+8vczrqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWxCB+Vp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWxCB+Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E722C4CEF7;
	Fri, 20 Mar 2026 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774047291;
	bh=MPtyut21H+++lysPLECI3MDbrZFZ8ba/5IamNcCxk8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWxCB+VpbNvbG2vvffmTzNiyxxz2kzSn459eCDqM38A29AXqmMtjFdImEwZyiGMyb
	 EUH0otcqDL6TVZVh9hvo2qudq2CCSqw4iJUq2NqhG8MqXml42vYFaiXdKEAXJMAC2b
	 MZnBmhm3tSez8gnMPBwaQk88jxqAX7JAtjIyj6yztgmUhvBbrOC+qg0Dl1BUOMhAcd
	 iEqnwPOK62RMZTqe3eCgqeFE34nWGnB95RH5SmHsGUvqepmWsPu7gXEe+x33je5OSs
	 9RTiO4soLkyrcnXiqoH/XJn/rWsFaW61as4HUhN/WaY31tPbZqJUr4qoAfJpr0QIOR
	 ZbZlbuxqK9ppg==
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
Subject: [PATCH v2 2/5] firmware: tegra: bpmp: Add tegra_bpmp_get_with_id() function
Date: Fri, 20 Mar 2026 23:54:34 +0100
Message-ID: <20260320225443.2571920-3-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320225443.2571920-1-thierry.reding@kernel.org>
References: <20260320225443.2571920-1-thierry.reding@kernel.org>
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
 drivers/firmware/tegra/bpmp.c | 34 ++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  1 +
 2 files changed, 35 insertions(+)

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
index f5e4ac5b8cce..424188c100d9 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -127,6 +127,7 @@ struct tegra_bpmp_message {
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
+struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned int *id);
 void tegra_bpmp_put(struct tegra_bpmp *bpmp);
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg);
-- 
2.52.0

