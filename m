Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C1302767;
	Wed, 25 Feb 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009816; cv=none; b=TzCryOD5Zm4gljt/PdukNOzoLAMn4e9vMe+YsjSsv/EG65kV9hAOMs1W3YVPKIjx/sDWg6G2Q7kz3WWEsR5xl60Qw9R72dSQV0trg3L+EMdZOw2o8AQYg4PxvrBA60NQuq8dMbVQxwFJYl0W0n0wjVvGtfHDGZUCi62ThlBMHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009816; c=relaxed/simple;
	bh=wlQ5GQhbYOAzh/KowiyGqkjmHLg6XfjR5AQ4NZXO49Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D12j3mnUBiz9VMk2EAQrEN5KB6xTqQf2wYM8aJvrVMlnlSQ9H6t9iF4lZ3u+0d08x1PHB2HdjK0830/Put2CnS2uicK9qr/HGbz0sZKOCGd2RSJQkm/f9oFH9qOHjrajoyxR4KwHTC84LlRgrTbzwx8j7DqhI4K9c22EM6+evsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 61P8tAPa077808;
	Wed, 25 Feb 2026 16:55:10 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Feb
 2026 16:55:10 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <Ghennadi.Procopciuc@nxp.com>,
        <quic_wenbyao@quicinc.com>, <qiang.yu@oss.qualcomm.com>,
        <vincent.guittot@linaro.org>, <vidyas@nvidia.com>,
        <elder@riscstar.com>, <s-vadapalli@ti.com>,
        <ciprianmarian.costea@nxp.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v11 0/4] Add support for Andes Qilai SoC PCIe controller
Date: Wed, 25 Feb 2026 16:55:00 +0800
Message-ID: <20260225085504.3757601-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 61P8tAPa077808

From: Randolph Lin <randolph@andestech.com>

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
Changes in v11:
- Make minor adjustments based on the reviewer's suggestions.
- Use FIELD_GET() to check the link status.
- Use dw_pcie_readl_dbi() when reading from the DBI region.
- Enable runtime PM to participate in the PM hierarchy.
- Add dma-coherent to the DT bindings and DTS.
- Fix the interrupt-map-mask value in the DT bindings example.
- Modify the maximum ranges size to support multiple iATU regions
  in the DT bindings and DTS.

Changes in v10:
- Use "qilai" instead of "andes" as the tag

Changes in v9:
- Drop the patch that adjusts the number of OB/IB windows.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v8:
- Fix the compile error reported by the kernel test robot.

Changes in v7:
- Remove unnecessary nodes and property in DTS bindings

Changes in v6:
- Fix typo in the logic for adjusting the number of OB/IB windows

Changes in v5:
- Add support to adjust the number of OB/IB windows in the glue driver.
- Fix the number of OB windows in the Qilai PCIe driver.
- Remove meaningless properties from the device tree.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v4:
- Add .post_init callback for enabling IOCP cache.  
- Sort by vender name in Kconfig 
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v3:
- Remove outbound ATU address range validation callback and logic.
- Add logic to skip failed outbound iATU configuration and continue.
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v2:
- Remove the patch that adds the dma-ranges property to the SoC node.
- Add dma-ranges to the PCIe parent node bus node.
- Refactor and rename outbound ATU address range validation callback and logic.
- Use parent_bus_offset instead of cpu_addr_fixup().
- Using PROBE_DEFAULT_STRATEGY as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Randolph Lin (4):
  dt-bindings: PCI: Add Andes QiLai PCIe support
  riscv: dts: qilai: Add PCIe node into the QiLai SoC
  PCI: qilai: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    |  89 ++++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          | 109 ++++++++++
 drivers/pci/controller/dwc/Kconfig            |  13 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 199 ++++++++++++++++++
 6 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1

