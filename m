Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A032224AF1;
	Fri, 28 Aug 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908682; cv=none; b=Jgkkw1lMw8q/VXu4t4ngyzip2hg/Rv/GIBEIGiALFlfaozm/38TzISDgYTKnRkoGHdiH2a+ZE6iLdSdpomTq2qn165WwhEw77UIPSPXi8yhb2wDAiRi1baZlX4x4W9cReNByfFASNGjr7Pz3cqx45keI4/ueekskP9bH66jgh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908682; c=relaxed/simple;
	bh=VoGo//QekcH5Wag6hG6dIxgIBuSWA00nRhbmMIj2mlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7rFLPxVxQdi+cP3n8cgEM+T30jT/QlslDX2y0IUEQV1oHdfEyAxC080qUqogtvfEEt9UqCVxyyeWows3spfRSCOYAd/O4bzlW/GCQeaU/WuSzUWMtn+2O3ZeEzDDhT4SBcRYi4ome//yqvhg87fr7WAa0XC0Gpav2LzOc2LQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAAHED49UpFqikR1Bg--.12222S2;
	Fri, 28 Aug 2026 17:17:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Thierry Reding <thierry.reding@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: Unwind partial PHY power-on failures
Date: Fri, 28 Aug 2026 17:17:47 +0800
Message-ID: <20260828091747.7976-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHED49UpFqikR1Bg--.12222S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW7Kr13Jw1kJw4xGr43trb_yoW8GFWUpa
	yDta4kt3WkJa1akF43tF15ua4Y9anIkrW7J3ZIkw42vFsxWrWDGr1UtF9Yqa45Crs7t3yU
	tF1YyF1UJr43WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The Tegra PCIe PHY setup has two nested acquisition loops.  Failure in a
per-port loop leaves earlier PHYs in that port powered, while failure in
the outer loop leaves all earlier ports powered.

Unwind the successfully powered PHYs in reverse order at both levels
before returning the original error.

The issue was identified via static analysis and manually reviewed.

Fixes: 6fe7c187e026 ("PCI: tegra: Support per-lane PHYs")

Assisted-by: LLM
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/pci/controller/pci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 59b56446c507..443fa33b7f0e 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1002,6 +1002,8 @@ static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 		err = phy_power_on(port->phys[i]);
 		if (err < 0) {
 			dev_err(dev, "failed to power on PHY#%u: %d\n", i, err);
+			while (i--)
+				phy_power_off(port->phys[i]);
 			return err;
 		}
 	}
@@ -1051,6 +1053,8 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 			dev_err(dev,
 				"failed to power on PCIe port %u PHY: %d\n",
 				port->index, err);
+			list_for_each_entry_continue_reverse(port, &pcie->ports, list)
+				tegra_pcie_port_phy_power_off(port);
 			return err;
 		}
 	}
-- 
2.43.0

