Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EF4E50B5;
	Wed, 30 Sep 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779860; cv=none; b=SI3ahqzVjX8v12p5CSy2OtGXG9GPlGEJv3HuJuakL2P8cKhMsXJ9MJf+gObs7WsCovIwZOluvDjf3MTFYs8DCsj63CLnUdR5oblDfucbNBUuGdFKsq3smsdHdowuGwDSH5w5Mj6dvbVG43vyN9m8XQJYqJcDPLQW24hW1K/90as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779860; c=relaxed/simple;
	bh=BCQEhMxc3THDAhwCFlhAfbew/cs4Pi8oaTza++3BWS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sisQJwF6n0H4wekgZGzzJVbxmexaqBgm1rIApeoleot211knOmMzXzshGwAjFSkhWx93taqAotwSCRDGyNeBwmN4qDDUBgCO5Ve49R6BxMFxtcREzDh53YHDaNyKuvkOHVAT/DW1MrQj43+ulPjefowQiSa3mXuujIHNP9RYkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF03NQee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF03NQee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D76D1F0089B;
	Wed, 30 Sep 2026 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779845;
	bh=TSwgvDJ8bCkdzK3KRzsQi4XHuw+AgxkAx3ktEHZzz7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UF03NQeeQFakrobM0QKdTXcDNv/0m37rMtVFftS14c7N/Iz9vdXCdLy3k1wzBufA/
	 4cwrlObdOz/8fAOCtop9P+R1hPV5Krr0NmQqrZtbReTPhGNQeXHV2hLRpZ9osCgT21
	 WfNDEAWsfA/nGinp0bmHQ7TZldMoAoj1b/xOT6u2Ziode0StIC5SbFj7Pd5tqzPglD
	 2//t26pkX5Pi8BZtjWwmNAviV1bR8bAQmKOwytLtKgj3tj/OD6ioRtBLw/ZM/LaPBe
	 dbKg+AnOGhBTmFWoMifEeLSKpS1gAiN6iIiD/c9ZBhW81s56nMGc/gvzJtRgc/AOBx
	 /9I6LCo0E/FVw==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yue Wang <yue.wang@Amlogic.com>,
	Hans Zhang <18255117159@163.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jon Mason <jdmason@kudzu.us>
Cc: Keith Busch <kbusch@kernel.org>,
	mx2pg@pm.me,
	dlemoal@kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Frank Li <Frank.Li@nxp.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [RFC PATCH 2/4] PCI: Match the hierarchy's MPS to a device's MPSS as necessary
Date: Wed, 30 Sep 2026 16:50:19 +0200
Message-ID: <20260930145017.1356088-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930145017.1356088-6-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641; i=cassel@kernel.org; h=from:subject; bh=BT88USuGeykL9B1sorUB9b03FNnb7Rs3jMpDLquVOTo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLL2Kq66Uhy8PPC02t7wDNP/+w0sozSl5rziN/lYU6n+Y a2upMy2jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkWSfD/5xLLDPfl0bL7rwR f/BnPOdDnhbh9Wz8VVuXX97o+tHLy4iR4X3kRDelhOb7+85veLHOQKWmvyJn0uabbAUchs9XWjG sYAcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Hans Zhang <18255117159@163.com>

pci_configure_mps() enumerates top-down and programs each device's Maximum
Payload Size (MPS) to match its upstream bridge.  When a device's MPS
Supported (MPSS) is too small to match, commit 9f0e89359775 ("PCI: Match
Root Port's MPS to endpoint's MPSS as necessary") reduces the upstream
bridge instead, but only when that bridge is a Root Port.

That covers an endpoint directly below a Root Port and nothing else.  With
a Switch in between, the Switch ports have already inherited the Root
Port's larger MPS, the reduction is skipped because the upstream bridge is
a Switch Downstream Port, and pcie_set_mps() then fails with -EINVAL for
the endpoint.  The endpoint is left below a port programmed for a larger
MPS, so any larger TLP it receives is treated as Malformed.

Multi-function devices hit the same hole from the other direction:
reducing the Root Port for a function with a small MPSS leaves the sibling
functions already programmed to the larger value.

Walk the hierarchy from the Root Port down and reduce every device that is
above the new value.  Reducing only the ports between the device and the
Root Port is not sufficient, because a Switch does not split TLPs: an
already programmed sibling left at the larger MPS could emit a TLP too
large for its egress port.  As a result, a single device with a small MPSS
now lowers the MPS of every device below its Root Port.

Only do this while no device below the Root Port has been added or made
available for driver binding, i.e., during the initial scan, or when
devices are hot-added or rescanned into an empty hierarchy such as a slot
directly below the Root Port.  Such devices may have drivers bound and DMA
in flight, so their MPS can't be changed safely.  This is the same
constraint that makes PCIE_BUS_SAFE limit fabrics with hotplug bridges
below a Root Port to 128 bytes in pcie_find_smpss().  A device
added next to devices that are already in use is left at its current MPS
and pci_configure_mps() warns and suggests "pci=pcie_bus_safe", which is
what already happens below a Switch today.

This only affects PCIE_BUS_DEFAULT.  PCIE_BUS_SAFE, PCIE_BUS_PERFORMANCE
and PCIE_BUS_PEER2PEER program MPS in pcie_bus_configure_settings() and
PCIE_BUS_TUNE_OFF doesn't touch it, so all of them return before this
point.

Fixes: 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")
Signed-off-by: Hans Zhang <18255117159@163.com>
Assisted-by: LLM
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/probe.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..d8e58e5ef730 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2200,9 +2200,49 @@ int pci_setup_device(struct pci_dev *dev)
 	return 0;
 }
 
+static int pcie_reduce_mps(struct pci_dev *dev, void *data)
+{
+	int mps = *(int *)data;
+	int ret;
+
+	/* MPS is of type 'RsvdP' for VFs */
+	if (!pci_is_pcie(dev) || dev->is_virtfn)
+		return 0;
+
+	if (pcie_get_mps(dev) > mps) {
+		ret = pcie_set_mps(dev, mps);
+		if (ret)
+			pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+				 mps);
+	}
+
+	return 0;
+}
+
+static int pci_dev_check_in_use(struct pci_dev *dev, void *data)
+{
+	bool *in_use = data;
+
+	*in_use = pci_dev_is_added(dev) || !pci_dev_binding_disallowed(dev);
+	return *in_use;
+}
+
+/*
+ * Return true if any device on or below @bus has been added or made available
+ * for driver binding, i.e., may have a driver bound and DMA in flight.
+ */
+static bool pci_bus_in_use(struct pci_bus *bus)
+{
+	bool in_use = false;
+
+	pci_walk_bus(bus, pci_dev_check_in_use, &in_use);
+	return in_use;
+}
+
 static void pci_configure_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	struct pci_dev *rp;
 	int mps, mpss, p_mps, rc;
 
 	if (!pci_is_pcie(dev))
@@ -2252,10 +2292,28 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 
 	mpss = 128 << dev->pcie_mpss;
-	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
-		pcie_set_mps(bridge, mpss);
-		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
-			 mpss, p_mps, 128 << bridge->pcie_mpss);
+	rp = pcie_find_root_port(bridge);
+	if (mpss < p_mps && rp && !pci_bus_in_use(rp->subordinate)) {
+		/*
+		 * dev cannot be programmed to the MPS already in use above
+		 * it, so reduce the hierarchy to what dev supports.  A Switch
+		 * does not split TLPs, so reducing only the upstream bridge
+		 * is not enough: every port up to the Root Port has to come
+		 * down as well, and so do the devices already programmed
+		 * below that Root Port, which would otherwise be left sending
+		 * TLPs too large for their egress port.
+		 *
+		 * Only do this while no device below the Root Port has been
+		 * added or made available for driver binding, e.g., during
+		 * the initial scan or when hot-adding into a slot directly
+		 * below the Root Port.  Such devices may have drivers bound
+		 * and DMA in flight, so their MPS can't be changed safely
+		 * (see pcie_find_smpss()).
+		 */
+		pcie_reduce_mps(rp, &mpss);
+		pci_walk_bus(rp->subordinate, pcie_reduce_mps, &mpss);
+		pci_info(dev, "Max Payload Size of %s hierarchy set to %d (was %d)\n",
+			 pci_name(rp), mpss, p_mps);
 		p_mps = pcie_get_mps(bridge);
 	}
 
-- 
2.55.0

