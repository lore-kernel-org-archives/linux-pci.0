Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3703E3179;
	Thu, 19 Mar 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936086; cv=none; b=bZFapSpSRlGayiWJnZ0gtQvClwxEMOBz6wuAeCwt8uIldzX3HfHPr1ntAcjCFSSFxLJn7SKWEOqLOWeurvtrWeGuq6NCUJX5AoJZo8sr3c3MRzXjl4H8GOApS38hbtiYDECZvwnWBFhdPvdrwGQSJ4PElt/G8+yOZOYxceqnqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936086; c=relaxed/simple;
	bh=MPtyut21H+++lysPLECI3MDbrZFZ8ba/5IamNcCxk8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvRoHhUVKQy37V+UqPukaxFDvVWzpgJFUpqD3/Biykp5PGSYe6727cEpZvD375Yd3xRoB8UjGMmjFWG278z0/z8i+LEvMEf3DLILKLRmHadxutuNVZFWd27ik9Ig5a32X1xBGZxSuwSm35yvp0x0ZcpGrxKyYjjspUURpBEa1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im07sUR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im07sUR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC7C2BCAF;
	Thu, 19 Mar 2026 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936085;
	bh=MPtyut21H+++lysPLECI3MDbrZFZ8ba/5IamNcCxk8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=im07sUR9r4koq1ZN+Mne6Y0NHksY6SQkdKnLZkb2/ImMzAntrzXvq8G0foyJvz1Up
	 IUicbVwRynfnphLVUCimK3JBb1o84327pOH+Iuwt4tsqFEZ0Yqj+G/pIHgmcfMjj4T
	 lDCACPscnYDSgiY3SOBInR5m7GMA4cuvXgJ39fykWWlr48mwzdKvqf9mhugEGIiDGb
	 GvwFf+ToblJhwKS+S10wJaqjErxqu5REdqLGeNb2Pz8D18Xf2/sQgrO0OnFGM19A/8
	 ZXFLVakU6+uiPJbhd2Q5cK3oTsF8ciqpZ2OpNjO0ePQzYVEM7YbChAX3TNtLuJYcJd
	 fdGqx+35dFEkA==
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
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 2/5] firmware: tegra: bpmp: Add tegra_bpmp_get_with_id() function
Date: Thu, 19 Mar 2026 17:01:06 +0100
Message-ID: <20260319160110.2131954-3-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319160110.2131954-1-thierry.reding@kernel.org>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
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

