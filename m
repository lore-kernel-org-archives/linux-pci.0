Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A8D367B89;
	Sat,  5 Sep 2026 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577049; cv=none; b=RQbPbtX5ltsTC2TG4IEULzq1oEM7H0IaclSXfftNP63jmJnV0UDxIPB/CYNW9Pl3rb9hjkHrweO+EYr8tv9erTzzRrkS8ARhe7xIBXC/GOkB9IC/ZqWRHfOKhrGKHpKFeL7ptrSkXkYPRwnwZLeQBd57IeJM11kMdTcU6dPNHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577049; c=relaxed/simple;
	bh=xvMAxdykKJMrlWh+AEoP34z6GvzFoitid+x6KM2d6X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/Om9nI5yTRzdRcgOFL2Es8R8+2WKLbgvtnp1qvwJ2FXhSSwpsSwenU3f8Cv5tRKPk9Swo05Hg7Db6T31oeFBGMSIR4EA2y3dGymZAggOk9vkhB+B6Dn7WWjP1+efD9uQn7Y/44VPPJzHGhZEw4+0oK2aFJM3KEPkclKCjj6d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=mw7sp3cq; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="mw7sp3cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=4HuF45kaCua5XxLzD235BdFaTg40woHG3w
	Kmj9GKF40=; b=mw7sp3cqNwM+0h8QMe0eVtP+AWVci1rW9Sx0as5XXoe0cpt6a3
	L+laQCJjHiZV7U5VlL94q6Ex6hDXCVF4imR7d9jZliER5Lr2L8D1mw6jTfOyDmb4
	pQ8VbJ2hsXNZRj3d3H0MsqPLfT5XGmUJCfcliqt7lmWkYrc494SowKbVs=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAcKhZtqDUQAAA--.300S4;
	Sat, 05 Sep 2026 10:57:35 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jia Wang <wangjia@ultrarisc.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>
Subject: [PATCH v2 2/2] PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000
Date: Sat,  5 Sep 2026 10:56:35 +0800
Message-Id: <20260905025635.211390-3-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHQAcKhZtqDUQAAA--.300S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18Kr1kKw1UAFy5JF48tFb_yoW8CFWkpF
	9rKw1UA3WDtFs8Ka1Iy3y8Z3WYvFsrAFWqgFnFkry7ua13u34UXryFkayYk3WDCwn5Zr1Y
	gr1YyryxJF13X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQABDGqaaqQAMAAAsC

DP1000 has 16 outbound iATU windows and each window can map up to 4GB. One
window is used for CFG accesses, one for I/O space and one for the 32-bit
MEM aperture, leaving only 13 windows for the 64-bit MEM aperture.

This limits the 64-bit MEM aperture that can be described with outbound
iATU windows. DP1000 routes MEM transactions without using outbound iATU
windows, so skip generic DWC MEM outbound iATU setup to allow a larger
64-bit MEM aperture.

DP1000 does not use ECAM for this controller. Config space accesses keep
using the normal DWC config access path and CFG outbound iATU programming.
I/O space is also unchanged and still uses an outbound iATU window. The new
flag only skips generic MEM-window programming.

The DP1000 integration has SoC wrapper address decode for the PCIe MEM
apertures described by the "ranges" property. CPU physical accesses to
those MEM apertures are routed directly as PCIe MEM transactions with the
corresponding PCIe bus address, without consuming outbound iATU windows.

Set dw_pcie_rp::bypass_ob_mem_iatu for this controller.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 51e89180490d4..0d4989a0f3afc 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -154,6 +154,12 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
+	/*
+	 * DP1000 routes MEM transactions without outbound iATU windows, which
+	 * avoids the 16-window/4GB-per-window aperture limit.
+	 */
+	pp->bypass_ob_mem_iatu = true;
+
 	platform_set_drvdata(pdev, ultra);
 
 	ret = ultrarisc_pcie_init_clks(ultra);
-- 
2.34.1

