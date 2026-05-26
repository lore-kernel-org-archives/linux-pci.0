Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564235C1AD;
	Tue, 26 May 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785607; cv=none; b=oai0lD+15uCSgMffoIuup+uJPwWUVERauw5UCP0bJ6QgzlG08ACgpaCZekHYgzttCNAS5T2pckpk1hJ7+qettx7iE5j8lnsQpnnENm6Hrle12cJj3CHMGn6q8cUhZrWiD3Cf9ZPpn9HIVlSSVoCVWJJJenrlBCAkdJZtLB5JuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785607; c=relaxed/simple;
	bh=wJLfF2BZVe+uXfktz9Da0Q6EG/mzRSCgVR+2/5DdZo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nNi6P5srrYpBcq/vBj4LeBKuQkxF22HNfhrFEuf/DfUb+mpb7uLGWfC7Tcs/y7/ige7je1JD/zMT1v9kMuwAKsisdbPV8d5oBEdcDWC2ASnfc44oUqMXm0O2CAeM5SjxX146CGc+JMFYDZawAyRSmmkesM3N4rmiRyLbPZy3XI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc+qJLV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc+qJLV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293951F000E9;
	Tue, 26 May 2026 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785606;
	bh=l7VErk4ZLg+3sShapVbVsbipSoUmWfTkdEOMvIvFw88=;
	h=From:Subject:Date:To:Cc;
	b=Qc+qJLV4TQnlbrXiSVrsaWs9YQ6i9pOr4RvMYLRM9ECCYB5xtGFh1DRF0Bvp7j7XE
	 KmKrSkclv3jx5q53le12XFJEhdNY6bYMARgbgOmsV4uajKpFraXFqK1eI6giTNSk0q
	 KP5zLJHRdTa6wdF/KATud1w3ywizhGBYA86otZClQxF3AuANIPK68vLYrVhtpNou9I
	 NCUt5MgNqajJW27dRJPssJBiFI2frAnk3H6lVKcPuVtNWESUjINZpbhKHK8ZHN+g8c
	 fp824153oEh7r2dywAKxoatPm6L5QfkU8fsywpEIDhwBLQtc9ezVZKf4lAsBj6qEyK
	 AAAJv1U8M/FVQ==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v5 0/4] PCI: tegra: Add Tegra264 support
Date: Tue, 26 May 2026 10:53:09 +0200
Message-Id: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQwW7DIAyGX6XiPBA2kISd+h5TDzTxEm8rqSBDq
 6q8+0h7WKUderH8S//3WfJVZEpMWbzuriJR4cxzrMG97EQ/hTiS5KFmgRobbTXKhcYUsLHy3DN
 JMjocCc0QdCsqc070zj8339vhnvP38YP6ZZNsjYnzMqfL7WCBrXd3G/DQaACtEOrurAS5TEwpX
 VSigeO4/6QU6UvNaRSbu+ADXSc6a41C14JH/Zw2j3QDxnXOKWy9A+uf0/aP/v+VYqWWCIQE3nc
 tdftYeOCg+vkkDuu6/gIoNvEwdwEAAA==
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
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=treding@nvidia.com;
 h=from:subject:message-id; bh=wJLfF2BZVe+uXfktz9Da0Q6EG/mzRSCgVR+2/5DdZo8=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqFV+DGK/1Dej/huYhz95sX4UhRpjd24UsF9ExP
 7grwHuRsCyJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCahVfgwAKCRDdI6zXfz6z
 ocHBD/4odEjmVuVeubUzJUhPR2J9AzYRayD+8uc0uqyxofWuu7adt17WH1rssHDf1NDlCp1sKiV
 RSDepxfB3NJiJuc//ArZHMWq/JlgHTx5gmyYZaKbgehEWfr/QXldeg49kF/oEekm6X6StEWK5n5
 SKPKQ/uSfOzCWS1c2G1pQkw4a4gIpIKLaTon+/ElDb5ynibUjvkHvYBc/F/W0pPlIBcmYVXxyiZ
 TrmXCVL18QNvf4FWVfORTryW/pL0//gE8u32Axz2OSEU61h6EsPS+BzYC65Tn+ggflnr5jAF1AL
 4vhk2Zf06dJJEHEHr6J29hIcFWiu3cb9yj5XKCc6TnxmG6fRYxT6AWmIVcyHtVRZzAsAiOTLfEk
 qUduT8LY8StYKTVNNigpuuo58+wu6z3pP2Opcq+KbKjO9LpkEFdATT/DEowxHaM6guBKB5lMmO0
 vG8uq2bCxfyeaTKeQDbfcYZiP4PN5FVzYOT+MHZtIwOPyOk+hh/yZgvKloyv4aCheydsBjvmmQs
 Ejt2PVm9jJXA+QsoJxQt2qk4qltWUwlhSZZukZStSZrohKgWL5Sl/LDAswvqbkYNN8gL/7dKkfP
 CipATu3+T+MdxH32cgz6eQYepNvtOCfVdwd7R95Y+5niIHcK/BnSmHolJHjvOiZINrjGmfl8KGc
 HzT9mHAmNMA6qFg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

Hi,

this series adds support for the PCIe controllers found on the Tegra264
SoC. There are six instances, one of which is for internal purposes only
and the other five are general purpose.

The first patch tweaks the DT bindings slightly to avoid new DT compiler
warnings that slipped through because they are now disabled by default
(-Wno-unit_address_vs_reg).

Before adding the driver in patch 3, patch 2 introduces some new common
wait times for PCIe and unifies the way that drivers use them. Finally,
patch 4 reorders the reg and reg-names property entries to match the
bindings changes from patch 1.

All of the prerequisites were merged in v7.1-rc1, so this can be applied
to the PCI tree directly. Optionally I can also pick up patch 4 into the
Tegra tree, but there should be no conflicts, so feel free to pick this
up with the rest.

Thanks,
Thierry

Changes in v5:
- address review comments for the PCI driver patch
- Link to v4: https://patch.msgid.link/20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com

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
      dt-bindings: pci: Strictly distinguish C0 from C1-C5
      PCI: Use standard wait times for PCIe link monitoring
      PCI: tegra: Add Tegra264 support
      arm64: tegra: Reorder reg and reg-names to match bindings

 .../bindings/pci/nvidia,tegra264-pcie.yaml         |  75 ++-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  48 +-
 drivers/pci/controller/Kconfig                     |   9 +-
 drivers/pci/controller/Makefile                    |   1 +
 .../controller/cadence/pcie-cadence-host-common.c  |   6 +-
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |   5 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |   4 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   5 -
 drivers/pci/controller/pci-aardvark.c              |   7 +-
 drivers/pci/controller/pcie-tegra264.c             | 544 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   9 +-
 drivers/pci/pci.h                                  |   2 +
 13 files changed, 641 insertions(+), 83 deletions(-)
---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260402-tegra264-pcie-e30abe23da07

Best regards,
--  
Thierry Reding <treding@nvidia.com>

