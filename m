Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45738374196;
	Fri, 20 Mar 2026 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047286; cv=none; b=ooelPMSdIivi7VFci/Fci+MgETkeybctO1VaP25Dig2/LRZEIOLZACNW2MTYB368EbEGnXL/f4ui5PDv/vLDNdAXrHIIbnoZuKEqN/9hMOUV9+vJfvvrD71aWjt9usVrRvthU7b2GK+n5qSkHJguJBRq3y01kG4deIzk0ovomFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047286; c=relaxed/simple;
	bh=QmJaBBqEI/ws3NCw6GsBHeDkkWX91BDQIZPgv6eHKqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLmmu4A8LyglACL9dHLRbrEsIVv9vBTUvs4JsltsTOcq7bdPmUiyYn3HqCfLv9impnlNbSUepQD1+XgR4TQjj+RJmWpS7x41j5a6Vq9atSjm4xMQf6QxbxjATb042d71syRcB1fTCsenb/UYFyzQxN4r13+5WD0A0yO+teHLxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A55K8PHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A55K8PHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF7DC4CEF7;
	Fri, 20 Mar 2026 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774047286;
	bh=QmJaBBqEI/ws3NCw6GsBHeDkkWX91BDQIZPgv6eHKqM=;
	h=From:To:Cc:Subject:Date:From;
	b=A55K8PHHzpPPkvUQpl9BXLTMpAbi+5zXaFlFU9lz4wC1lw3bsVdsYgxKLj2TKRRFC
	 kW1STELQwxfwlZWDNMuoPjJQKqxinWWTG5k6XZVZ6i9dQlSK8dwInynU1dczdTLG9f
	 zzrzOQapthdG67jFnt1ricW8ihLm/13aQcaYceiXR00PBTqCN8UAWjPU6uc8d/r+9O
	 EfEeDlyjuD9Uxnq4RC1Za5nJNeCTiYo365jtnozsBGdJfP1o0zIIfcHKsgg2y7cUFa
	 wxeShwjlHVJpJjNR0IgHVAIFJ7hZLT6E7KW59INzaW4X9YhpiePvllz3/uawwCeZj9
	 Zv4Sf9qwx8v7g==
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
Subject: [PATCH v2 0/5] PCI: tegra: Add Tegra264 support
Date: Fri, 20 Mar 2026 23:54:32 +0100
Message-ID: <20260320225443.2571920-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Hi,

this series adds support for the PCIe controllers found on the Tegra264
SoC. There are six instances, one of which is for internal purposes only
and the other five are general purpose.

The first two patches in the series add the BPMP support needed to power
up/down the PCI link. Patch 3 contains the device tree bindings for the
PCIe controller and patch 4 adds the driver. Finally, patch 5 adds DT
nodes for the controllers found on the Tegra264 SoC.

Regarding merging these patches, I think ideally I'd pick up the PCI
driver patch into the Tegra tree because there is a build dependency on
patches 1 and 2. Furthermore, patch 1 depends on another patch that's
already in the Tegra tree, and there will be conflicts if it is merged
in another tree. Alternatively I can provide a stable branch with
patches 1 and 2 for the PCI maintainers to pull in.

Let me know how you'd like to handle this.

Changes in v2:
- fix an issue with sanity-checking disabled BARs
- address review comments

Thanks,
Thierry


Thierry Reding (5):
  soc/tegra: Update BPMP ABI header
  firmware: tegra: bpmp: Add tegra_bpmp_get_with_id() function
  dt-bindings: pci: Document the NVIDIA Tegra264 PCIe controller
  PCI: tegra: Add Tegra264 support
  arm64: tegra: Add PCI controllers on Tegra264

 .../bindings/pci/nvidia,tegra264-pcie.yaml    |  149 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  248 +-
 drivers/firmware/tegra/bpmp.c                 |   34 +
 drivers/pci/controller/Kconfig                |   10 +-
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-tegra264.c        |  527 ++
 include/soc/tegra/bpmp-abi.h                  | 4565 +++++++++++++----
 include/soc/tegra/bpmp.h                      |    1 +
 8 files changed, 4613 insertions(+), 922 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-tegra264.c

-- 
2.52.0

