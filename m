Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B6433025;
	Thu, 16 Jul 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221658; cv=none; b=jUENbbjPuMKOy8TT+L32pZCdHcI+fd6TvYpEs2yln/QprApm8WemqAviEP2yJv5zNSn5OwhNQEBkuU+QIgBkQdDgrzdPd2Uh4GDpGsyTClXuH2U/oMEgu9UYCpzX9UhJ+YNG6vyLutspJJ9RWpKqMTxkxg7m00Fn0E1i57lQWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221658; c=relaxed/simple;
	bh=MKLOjubL6nDaFDSV3NchtODcXNby/V7rdDE6XtMCiYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PLns8mF5O1z8WNcZK70sUo8lmunWm1/WVS9fpVZM9SDkIVl+Mygqw+kUA2UFxgVBg3z994+1bpGNtW5nXsSXlCd4jw3/B5KXBGfTO75BdCi73sAPBwUGOpB2IZ+f8WHByhqzbvb9k6EWyi5q9GaifNSHD6ysB1ImPDtwvpikIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZHNQmaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZHNQmaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39AF1F000E9;
	Thu, 16 Jul 2026 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221651;
	bh=19O6VUT4dIdHRfQhthVazuY+ztgGA71mvvyc749iEmM=;
	h=From:Subject:Date:To:Cc;
	b=jZHNQmaQWZslgs34iA+FheFGclWMOPjgOMMWMpJHCu13n83SHxXyCf/XBnDRNwmXi
	 9I9UaQICeaL/AQNv09NJVZ4To9XSnd2Y2E4RuYa9T1Eeh2e5h+T8QJzl2rOiwL5Xm8
	 LJVuUiv9p47KrWGOnCZraxPx96gcNVyOP89t4eQXesCL6HZTJ4FOZl5rmaOVePswKn
	 b7ZaycNJtqlhU9PJfRjOOasjoPU+OcySthwXNyk1VuaF7AxR6G3goc9qRhDh5Z41r0
	 Vc73OowM/tQm3O3J7CMjxk/oMbINjlrK9vpqLC5k3Xnh2Mzbzo03Ok+Iz3/bYaruYg
	 HFRP7fQnZno4w==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v8 0/6] PCI: tegra: Add Tegra264 support
Date: Thu, 16 Jul 2026 19:07:11 +0200
Message-Id: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XSzY7CIBAH8FcxnJeGb4on32Oz2dB2Wlm1rUC7G
 uO7L20PuvbghTCE33+SgRsK4B0EtN3ckIfRBde1qcg/Nqjc27YB7KpUI0aYIoIwHKHxlimB+9I
 BBk5sAYxXlmiUTO+hdpc57/NrqcNQ/EAZp5Dpxt6F2Pnr3HCk070lm1NDFaGUZIymvRSY4rh34
 P0181C5ttkdwLdwzDrfoCl7ZE86rUwKwTMmNTWMvNf8WSvKZS5lxrSRVJj3Wjz0eiqjwAQzCgy
 oMbmGfNeOrnI2K7vTwuWDS6ZeuUw8FzanvDDaVHrF1YOrdXeVOFRFWVttdV7DiusnTvUr1xO3o
 C0YJRQz//h9eVQP5yH9lbi8NDpBCHb+K9vNHKuJxr/2AM6fv8PQ952PeKQszbUQQvJaFmVp9K4
 LITsP9piiT3N+Si9sADwduLjdtHCJeEmkInW//wFPjHltsQIAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=treding@nvidia.com;
 h=from:subject:message-id; bh=MKLOjubL6nDaFDSV3NchtODcXNby/V7rdDE6XtMCiYk=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqWQ/QeOxEroN7gWqauk4euVDQFWMe4DqDpU8XV
 OB/eFdiIxqJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCalkP0AAKCRDdI6zXfz6z
 oVskEACQaUuNw/atvcSi5GvU7Y3Ryjzgr2itAl2Npf3mk71EszQeGf2+y5wcVhGjUmUHIad/L4n
 ciXQLONSFEVFnMkaNQHGjfuXK3zIGlAEhCml1KJjjVteM5aWorMs6U1L4T8eVOY07Z7a4HnV1fi
 oKYo61+wIbFiYCAFqvC5TvLJTPpKO/Px0ON18Bprwnes+G8ZtTIavNR29Fkb73QfDaJl0R8ETjX
 XvZPcmp/yTOB12zJvxpe4PuKqh6fep1oTMxJ01Hy7gRRNicv/aE4cJySZnkvIzgG28xNf70QQnH
 FbGra7/2cr3SOqhVl4IPUFe4i9jHhB1ll+nYYBMQKDXeYhsBJoN5wuM0x3FhxYORqf+0tF6rlMW
 icig74kksobonR7W/W4mxxRmYZWUGDji34B1zWM1HSVw2Ts6VU6O+xk3nJ5ctFtSOfr8cuyk8Cl
 PPi8ZdAbvbdVKZd7S12DnDfNWU7Ov8sgScsfTS9RTRUZBIoFDlzgSR/rTzpjPQjBvDePxQLOUGR
 jV/DC71WU3DyC4YXVVlBcZiQj0DW6wvQODUyG0I2hQ3SfVRmGVcY0YPbievn3Vh58eFtTGRJpTA
 Eh3sKTnjnBkfUCRZNDQ9EMSC+/LqKBFFj7wPaui1LEyg7b6GGF0fMz4D/O0ZfnCbpiMEkvLEfNn
 zAKu7nt7VuXMBsw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

Hi,

this series adds support for the PCIe controllers found on the Tegra264
SoC. There are six instances, one of which is for internal purposes only
and the other five are general purpose.

The first patch tweaks the DT bindings slightly to avoid new DT compiler
warnings that slipped through because they are now disabled by default
(-Wno-unit_address_vs_reg). The second patch references PCIe root port
bindings from the controller bindings, which will allow using the
standard WAKE# handling, among other things.

Before adding the driver in patch 4, patch 3 introduces some new common
wait times for PCIe and unifies the way that drivers use them. Finally,
patch 5 reorders the reg and reg-names property entries to match the
bindings changes from patch 1 and patch 6 

There's a new dependency on the PCIe WAKE# interrupt support from
Krishna here:

    https://lore.kernel.org/all/20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com/

Since it is only a runtime dependency, the series can be applied
independently, though.

I can pick up patches 5 and 6 into the Tegra tree, but there should be
no conflicts, so they should be fine to go in with the rest of the
patches. Either way works fine for me.

Thanks,
Thierry

Changes in v8:
- track hotplug support separately from link up state for clarity
- remove unneeded controller deinitialization, done by firmware
- fail probe if the link is down and not hotplug-capable
- select pinctrl sleep state on suspend for symmetry
- switch to PCIe root port bindings (new patches)
- add Reviewed-by and Acked-by tags
- add err_ prefix to goto labels
- use generic WAKE# IRQ support
- Link to v7: https://patch.msgid.link/20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com

Changes in v7:
- fix build dependency on PCI_ECAM
- remove pre-silicon support code
- Link to v6: https://patch.msgid.link/20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com

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
Thierry Reding (6):
      dt-bindings: pci: tegra264: Strictly distinguish C0 from C1-C5
      dt-bindings: pci: tegra264: Switch to PCIe root port bindings
      PCI: Use standard wait times for PCIe link monitoring
      PCI: tegra: Add Tegra264 support
      arm64: tegra: Reorder reg and reg-names to match bindings
      arm64: tegra: Add PCIe root ports on Tegra264

 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 109 +++--
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           | 114 +++--
 drivers/pci/controller/Kconfig                     |  10 +-
 drivers/pci/controller/Makefile                    |   1 +
 .../controller/cadence/pcie-cadence-host-common.c  |   6 +-
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |   5 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |   4 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   5 -
 drivers/pci/controller/pci-aardvark.c              |   7 +-
 drivers/pci/controller/pcie-tegra264.c             | 485 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   9 +-
 12 files changed, 670 insertions(+), 94 deletions(-)
---
base-commit: 8306754e0e226390edafb50b0f2c85f7e703077d
change-id: 20260402-tegra264-pcie-e30abe23da07
prerequisite-message-id: 20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com
prerequisite-patch-id: 0f984d1bf11850bb8f833a26f6945ecf18a9a816

Best regards,
--  
Thierry Reding <treding@nvidia.com>

