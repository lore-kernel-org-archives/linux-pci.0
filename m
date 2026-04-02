Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0836607D;
	Thu,  2 Apr 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140075; cv=none; b=kwPFuWlM5R2j/Z/g4dzsb17fHCXxg56wC31W/CM+DzB6OsMjNeZQpsrCoWMajLhVCRx9zDlmSLsdLZ2vDuuyVtKKT8bL85H8NPwni92DtlrryS5rO3QASQ3CZE5Icy69wVNRp+8ZUQjtDVioV16smJieH2HqPe2g/2Uol5cggHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140075; c=relaxed/simple;
	bh=Zer/BJD+qJqeBtob+isjMLL/b+ilLo5Tgi4DcTu1vu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sizwYMmg6l3nWhh35si0w8ZqAuraI+jGqwSL1icuu5Lw0XYFaKNm5IyQSUCPu72bxBKYm4dtRHkc87d/iPCNrAAEYk4kPCTonV8wSLMU6X1TrQT704eAx9qZOESpQ1ckIICZtfFr4CyZCeMFpTISQ+fCEPaCfXNLhm/OvlZDCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4b7ctXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4b7ctXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDECC116C6;
	Thu,  2 Apr 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140074;
	bh=Zer/BJD+qJqeBtob+isjMLL/b+ilLo5Tgi4DcTu1vu0=;
	h=From:Subject:Date:To:Cc:From;
	b=S4b7ctXJxnf+ZsiRGJaBCXbBWCNAusE0H5aSNAbYVB8YMWhXLLscg3uvZrwL0kI3z
	 YeA4WglrmVRjUrvU1/0/MkuWlJTJGZcSUEC/9FzD9TvG6pFw0e6I+5z6Ue2Xd6Fswy
	 vmTLrhmV94Wtssm7kOk7QBONGTtExTu0JeIp4Sf+njAuyzu8aht14JPKUOD9ID7Hps
	 9ojezoGOoICwjAaE51P6XYk73bYF62yhRpGA8pouvb6i+ASx7sBnpnl9VwODsOIPKh
	 zBdUVcYk/cEtVYhDs3vrpeg8esHZH/IGEqZR2WKxjaX/ZpIK84qr9M2VUm1uHgK7nc
	 PN0tV1nss3W3A==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v4 0/4] PCI: tegra: Add Tegra264 support
Date: Thu, 02 Apr 2026 16:27:34 +0200
Message-Id: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr2K6tk1n2oK48h7GBcIIowbIFInGc
 HeLblzpZvJ/8t+bp4okTFFtV08lNHHkvkvFr1eqasuuIc116gotZtZb1CM1UmLm9VAxaXK2PBK
 6urS5SswgdOL727c/fHq8Hc9UjYtkWbQcx14e74cTLLuP20EBmQWwBiHl4DXosWUSeRihmrtmd
 yHp6Gp6adTinvCLTheD985gyKFA+59233QGLmxCMJgXAXzxm57n+QVw0+cMOAEAAA==
X-Change-ID: 20260402-tegra264-pcie-e30abe23da07
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2819; i=treding@nvidia.com;
 h=from:subject:message-id; bh=Zer/BJD+qJqeBtob+isjMLL/b+ilLo5Tgi4DcTu1vu0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBpznzn8GyWDCsk1KnLx87ijwIsQ/CXd+W6jaRvz
 pYORK2DmqCJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCac585wAKCRDdI6zXfz6z
 oWqnEACMzABpCGQB5QXhKC4LEdSLeJcPJRNZXPlzNzEEQPiyHCdNBOi0FeNAEDqd5smgl4E6vtj
 Gio5rrUK6cCmPlAfN50Ne6AhAqGjuxzhgXPrGnkAXswhUIPs9sf/UrDP0ze2nNrd1/kYFvAe/Av
 NoIvra40dSEw4p6F1wucit7xC3ICCtLl7PWs4R8+CLM/mVRV3XR5G4gj9e4Hj8uzMJMCfN56EFc
 qgDj2OT37ewuSItdcySi0LpPydLhYd5+pWrFCvfL0xldAoTkt6kpvMQrlr8Z8tMufYVT8ZN8bLj
 e/9xk326peBDniUdJ0qm1FT2q+/MW2mVrOeZzJJC9Gu7cA4oBbpElmxE/9h+W3Doe/bl6GSs3fb
 M0dNca/uFpnXptbS6p2JIhbjwH2JcJcPoBwUZSKx5OvsNLNBdJCegmZcvlhBfixTM5AmbbSVkZ6
 UaUjYO0w17ZUanXoNjGsIhKN0FEzjSjgGxa+SncXAlIv1LOuZwXXYbE8+iOuHxkmcs/FKZT6kZ8
 DDCFhevxHUGMtnsleZTQi5BtoIsgZFYL1CqtrkSRujlwGhlBzUO6/CT65ZluAp6ZtKD1RZ779d5
 6JT0LnQgP21WPDPZuBbHe1FiDAB79fSenKiLeX/vhBENsVDvXTio1Q7/WR10QyKEObu9i1KSIwX
 z4qZRDuviV3Yf1g==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

Hi,

this series adds support for the PCIe controllers found on the Tegra264
SoC. There are six instances, one of which is for internal purposes only
and the other five are general purpose.

The first two patches in the series add the BPMP support needed to power
up/down the PCI link. Patch 3 contains the device tree bindings for the
PCIe controller. Before adding the driver in patch 5, patch 4 introduces
some new common wait times for PCIe and unifies the way that drivers use
them. Finally, patch 6 adds DT nodes for the controllers found on the
Tegra264 SoC.

Note that this cannot be applied for v7.1-rc1 because there's a build
dependency that's going through the Tegra tree. If you'd like to merge
this, please let me know and I can provide a branch with the
dependencies resolved.

Changes in v4:
- strip out dependencies that are going in through the ARM SoC tree
- revert bindings to oneOf construct so that we don't produce new DTC
  warnings
- Link to v3: https://patch.msgid.link/20260326135855.2795149-1-thierry.reding@kernel.org

Changes in v3:
- integrate PCI standard wait times patch into the series to maintain
  bisectability
- fix review comments from Mikko
- Link to v2: https://patch.msgid.link/20260320225443.2571920-1-thierry.reding@kernel.org

Changes in v2:
- fix an issue with sanity-checking disabled BARs
- address review comments
- Link to v1: https://patch.msgid.link/20260319160110.2131954-1-thierry.reding@kernel.org

Thanks,
Thierry

---
Thierry Reding (4):
      dt-bindings: pci: Document the NVIDIA Tegra264 PCIe controller
      PCI: Use standard wait times for PCIe link monitoring
      PCI: tegra: Add Tegra264 support
      arm64: tegra: Add PCI controllers on Tegra264

 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 174 +++++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           | 248 ++++++++--
 drivers/pci/controller/Kconfig                     |  10 +-
 drivers/pci/controller/Makefile                    |   1 +
 .../controller/cadence/pcie-cadence-host-common.c  |   6 +-
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |   5 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |   4 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   5 -
 drivers/pci/controller/pci-aardvark.c              |   7 +-
 drivers/pci/controller/pcie-tegra264.c             | 527 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   9 +-
 drivers/pci/pci.h                                  |   2 +
 13 files changed, 946 insertions(+), 61 deletions(-)
---
base-commit: bfbb8533d7293235b71e4096cc0bc9a5c0c20b20
change-id: 20260402-tegra264-pcie-e30abe23da07

Best regards,
--  
Thierry Reding <treding@nvidia.com>

