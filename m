Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA38477982;
	Wed,  6 May 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074936; cv=none; b=lbRVdZlXW0SBVV9a2BwMlw010Q2VuLF0EFPFYAA9ltH/czI9gGV0VB9+sIDLEqX6G0CUKhFCi5lDD/rHIHEqIAuGzGXjoJj3Jng1Kcok8MC/Z79dN55kb0Dz030wdLEEYDIZwwGSaOCBdzdtBhdqVWI3vqWllDoAMoESX+NLhSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074936; c=relaxed/simple;
	bh=mBnLUZMGhM091DpLc/U5zErdLqXnLgpupJv9YgGKdUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5mweAk4rf/aVlV5H7mi+yNIDPbZhZjveOn5jcxQ48GzD/fP6PfY+D99FAhE/bR4lSg7h3yPv1dVMmh5VblOiGqymjYhOOOnLj6G07HNXAjcvMJRp3aFCZ+lRIq9Di8GvYIYpUfdrwitf6euP5nhoyVCyON+O/BtG7oBKcZgx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THtIptsl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THtIptsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516DEC2BCC9;
	Wed,  6 May 2026 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074936;
	bh=mBnLUZMGhM091DpLc/U5zErdLqXnLgpupJv9YgGKdUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THtIptsl/EzTcknji8Sr7FZocfL59iionTpaj9jsaQAsNkW59Js6CON4LILpwJmR0
	 oLdboQHRAfNjp4OPCsxOQv02ppiDM9CLZ0xqHMTvJdOzdMqTSvgPx19bWd8M6sKJaz
	 90b3OmrPxHplmwJT2afntzUpR9iNzmuZ6SEIGKAzoRhl2MRyXCRtwnw9b/mAg+0/0c
	 TlKdskWrN6+E3o1LcsPisph5lJhM2D0PlACMZ1tte43bSRB88PdcpgF29UUQoZgpBp
	 Nu9exKX7YtAifz5j97TwBGMd18glKob487U6z17EieQIbvmv0/22ekvFpGej+dOOxr
	 0XBfEHreJ8JQQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 06 May 2026 15:41:52 +0200
Subject: [PATCH 1/9] ata: ahci_tegra: Explicitly specify PMC instance to
 use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-pmc-v1-1-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
In-Reply-To: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=treding@nvidia.com;
 h=from:subject:message-id; bh=CzZgWVZZSZZ3cjegVsK5oiOvQGLlRFg7d8ikashi5Ls=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBp+0UvwgGq03mhNWzC/Ms1bLh5lNTjVlpCh+IHt
 YPQUMgqVaiJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCaftFLwAKCRDdI6zXfz6z
 obDtD/9X/qtjzKNCvjJ1NN5bLe5DDKPANAIxNXbNDKMmYnrdRH3rAzFrl5eNg4E7GB72CADzGvi
 e9x77y2TmP/+jeZjbQ0KXZtseKmDMBqqYwMUvbd8KVFp0AXCMklVBdpfGZB3iCPw0qK2UlqmaUn
 Fud3PfVmxypldtelOZHVw/YH6r2ZfNvHnGE03XUclDfu1MkoVpdjPM+b/1MTBWmmsik/R+RB4GB
 Iw6TLbbUQwHrJwAF/rCNJxacbnXgKhdhhGB+jmOKJIWQe9VNO+MMw6hezHyGYCjFTD685fzqFm+
 SzzjV3gQ29jU4kYDqJlx/9+g/WbOuYHK3Wa1YbWeUzI5HKx+lbJRe0Oj6H94PXOsmHGIz0JD28n
 cHl7bHrZlAKQOoIvo8Q88SYHg8VmPrS6vj+ZjJrlOZYcKw7M0s6tx4BIP5NQ4jJAfMUoTnR3ngV
 t1uAci/JktTzGCsn91tQBxMfZbHUhU9yd1tekKDx8KEpGvD6jlfr3+rtW5iJpm/1Jgbe8N/P0b2
 dEgKpALYXVeMYixFdtlpU/D/8TAn5SG4PEd3IwTqAcOVhdOBfQCBy8615wrwgPDQcC+FT3H+2hI
 VAm8EFtN1iorZQelz0wvngIceHQqiwtYvc/6Q/zaIEFnhQLn6SzoUf9ZkY58QVWvkWdJJIkigGE
 b8rYJVlg885kbyg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Currently the kernel relies on a global variable to reference the PMC
context. Use an explicit lookup for the PMC and pass that to the public
PMC APIs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 44584eed6374..554f05e09f98 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -175,6 +175,7 @@ struct tegra_ahci_priv {
 	struct reset_control	   *sata_cold_rst;
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
+	struct tegra_pmc	   *pmc;
 	struct regulator_bulk_data *supplies;
 	const struct tegra_ahci_soc *soc;
 };
@@ -246,9 +247,10 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 		return ret;
 
 	if (!tegra->pdev->dev.pm_domain) {
-		ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
-							tegra->sata_clk,
-							tegra->sata_rst);
+		ret = tegra_pmc_powergate_sequence_power_up(tegra->pmc,
+							    TEGRA_POWERGATE_SATA,
+							    tegra->sata_clk,
+							    tegra->sata_rst);
 		if (ret)
 			goto disable_regulators;
 	}
@@ -269,7 +271,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	clk_disable_unprepare(tegra->sata_clk);
 
 	if (!tegra->pdev->dev.pm_domain)
-		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+		tegra_pmc_powergate_power_off(tegra->pmc, TEGRA_POWERGATE_SATA);
 
 disable_regulators:
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
@@ -289,7 +291,7 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 
 	clk_disable_unprepare(tegra->sata_clk);
 	if (!tegra->pdev->dev.pm_domain)
-		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+		tegra_pmc_powergate_power_off(tegra->pmc, TEGRA_POWERGATE_SATA);
 
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 }
@@ -571,6 +573,11 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->sata_clk);
 	}
 
+	tegra->pmc = devm_tegra_pmc_get(&pdev->dev);
+	if (IS_ERR(tegra->pmc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->pmc),
+				     "failed to get PMC\n");
+
 	tegra->supplies = devm_kcalloc(&pdev->dev,
 				       tegra->soc->num_supplies,
 				       sizeof(*tegra->supplies), GFP_KERNEL);

-- 
2.52.0

