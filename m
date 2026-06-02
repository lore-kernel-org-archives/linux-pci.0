Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066663DC862;
	Tue,  2 Jun 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400035; cv=none; b=hojwwaiBUz1iBPqBbDq+0vqVovodvThpor0INgLjZAyDgMILtf9xFVu/SJ3ot/PptCuvqUKco83pAOW7NhVopHwdPofPzHOcP13gPCB/W27zOW0+vlYPHb2Mt72QXF9UsRS8vuyDRfA6TkvdqP7SLEWznFQM/e4Jw96jPyEn27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400035; c=relaxed/simple;
	bh=KMH2/ojjq+sbTJGjYAXNbmCc7sW0lbLCjB6n1xLpikE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DlgJsaaxW6m5KrEoKzYGJNejlZ7KAGqg/NnzNmwVMykhQgFe7plLcSpp94xyK/AoTCq166nNjbHHR/RkiuiluvpOcQPxZHBDYMny1RMRPI5QYVMVYrq3hp4lisG/74HWkZhplkpNZKVRzdIx3jCdhjPm8ka1+wZsH6GiZeeG2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owAzFEni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owAzFEni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AEE1F00893;
	Tue,  2 Jun 2026 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780400029;
	bh=MZzE5gk2ciiNwh8D62gBS31R5AnJefl9q3snq9zcyYo=;
	h=From:Subject:Date:To:Cc;
	b=owAzFEnicFWBRgJqHkdTWoN1icFPa/bZmfdiwBaDNWDZDMZI5N+GBn1e78fRmTyQk
	 44eI/v7RkdhhnNQ4To/qj/XdfCZmUYBsoyV9C7UFjJb1rBYKL2aLMz83C5WMkKyzzZ
	 fPSMVtKW7sDZviz6tFtcSFp41QfC0oBBUZdJUatZsDwNe8cvpIBv1w8cYxEWET7G2G
	 PTnTZGcT8MLnfmOCVzZKBfgaQiqYtXNbPj/WZ1X1mdFomwUnRjw7/LSyxxME6ob7GN
	 aBN6/rDXrMh7FDipwiUPz3Nn5AbJZ2iNsq+tabYLvekHHHBsvZ+5aTXtb8Oggb++gi
	 5K4yu2v18oWgQ==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v6 0/4] PCI: tegra: Add Tegra264 support
Date: Tue, 02 Jun 2026 13:33:22 +0200
Message-Id: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQTU7DMBAF4KtUXmPLM/6LWfUeiIWTDOkATSonR
 FRV7o7TLFpg0c3IT5rvjeSLGCkzjeJ5dxGZZh556EvwTzvRHFLfkeS2ZIEavbYa5URdTuitPDV
 MkoxONaFpkw6imFOmN/6+9r28bnn8qt+pmdaSdePA4zTk8/XgDOve1m0ggtcAWiGUt7MS5HRgy
 vmsMrXcd/sPyj19qiF3Yu2e8U6Xic5ao9AFiKgfa3OvPRhXOacwRAc2Ptb2pv//ymyllgiEBDF
 Wgap9P3PLSTXDcePuxh36v9wVXtlUgaljiG34xZdl+QHEd7pFtgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3197; i=treding@nvidia.com;
 h=from:subject:message-id; bh=KMH2/ojjq+sbTJGjYAXNbmCc7sW0lbLCjB6n1xLpikE=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqHr+aOvgqGQG0k6eSTa7z3hs4cYHPs5PzvpZKD
 LCemG2aNq6JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCah6/mgAKCRDdI6zXfz6z
 oRV8D/9QlFkG5wdTVG2PVMh5At6JOV6geS7SFf/6N1DV9ISijGAhn5MGG1biY2iYtsynJXvZebc
 9q+xRz4qNII+4Me+sR26s6QsAnP7uN+uafxngtmk/a0hjSL2FT9RJZIMdz323IJe9yf8RHUO36v
 LUNBjmBmHWENiC+/fPq8tFNWgWe0zE3sSqUi1SZP0CUeUrvPErSebaVZl7HyOW234CPG4QmWlya
 iSYCXJbwIqkwSdy8iKIof0hVOIAw2Td8mPG4V+8399GV/yknzhCI8IyacLzojoSIDFrVsX85q8p
 vnorZ69nsDQ6wxLjmeYzPu7CfwwxGUtodwxXDfUG/WboYAUjiQuaLaWngjYSN6SaLE8jFf9D+Fx
 KknKOwcvhFequcX1e9a4Jtx7ElPnCKXP0hAwQP1VPk1gXVYPPcLh999pdLrVJXIGdQX59zIHOmP
 R8h+gRwuJuDQGHi8LG78kHNsbhYARRfQr9UtyAxQM5mCrVDK8JwDdGSU57lBqZY9BS1zxH2xaan
 Phv5YPVu9wz+rwo3nihBnUPKpl9/kABlqkcRQQxeYSnkPMabuJ2riMn8MCMuR5SBOQLP6X5/8Ib
 WxCJLMmK+Cl39iYjiloRa09T/rArjOo+THqrslYwZXT0tRwxLCu6RdWS6lTvp0SSoZjDWzfOfWj
 gENYK4HUDB8AWeA==
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

Changes in v6:
- address review comments from Sashiko
- rebase onto v7.1-rc1, adjust DT bindings patch accordingly
- Link to v5: https://patch.msgid.link/20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com

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

 .../bindings/pci/nvidia,tegra264-pcie.yaml         |  79 ++-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  48 +-
 drivers/pci/controller/Kconfig                     |   9 +-
 drivers/pci/controller/Makefile                    |   1 +
 .../controller/cadence/pcie-cadence-host-common.c  |   6 +-
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |   5 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |   4 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   5 -
 drivers/pci/controller/pci-aardvark.c              |   7 +-
 drivers/pci/controller/pcie-tegra264.c             | 556 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   9 +-
 12 files changed, 655 insertions(+), 83 deletions(-)
---
base-commit: 9153998d6bc78594c0c853e0eea84db778855a47
change-id: 20260402-tegra264-pcie-e30abe23da07

Best regards,
--  
Thierry Reding <treding@nvidia.com>

