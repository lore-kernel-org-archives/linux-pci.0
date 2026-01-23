Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287A35DCEA;
	Fri, 23 Jan 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160795; cv=none; b=m+BODxjT5isU8cb0CaxEbfEW0ietC3H+VWtBtrrilNHuulfjQ36st8TueWAA9oqTW9Z/A0d2vjKGZFV9287qlcxCBW+S0VJyv9l6EvQOe/ZiHBQSvR18WwxILn0x0Xq1EpHx1eVvR6JitwPKXocghK6tI/ZOOqtKswvw0gln85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160795; c=relaxed/simple;
	bh=26/yJNz4YSnbicTXM0RZydtgr9bCYQuI7RPh0S62vDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkjEbxU9C5FJvO2FtItXJ5+SgMuR/5qNGNT+5H7c5KAAvN4yc+yudTiBh3byB2iJifkbu+HO9d7xjclHSwDPGb+VSLbg5Fr0XiSS+cfd3TyI0rnbBwgP4cCPDnHbg3qQMxR0s5he6Bt+JkABJLDx28SJPTT1Y+sHoqbecB+UG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q45KAZsZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q45KAZsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C5C19422;
	Fri, 23 Jan 2026 09:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160794;
	bh=26/yJNz4YSnbicTXM0RZydtgr9bCYQuI7RPh0S62vDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q45KAZsZqDKAaVhCyz2G8XMzV2DFeoVx9nlTuIqbo5aNQZ1d6+2SEVDhcdoGkn2Qy
	 lKPcqPsR5xerl4kxf7lIoyApgd3XAV3rMyTjNjk9u5JOjE/wNi3y99PDtp7pO/4A3b
	 G4efoseWH3QJ3Hw66cyuSIC809M9bLz77ByHwixT0yMAnMWJ2mEPERAscO8VmkkiTK
	 nEyeOX58iMXQRBsfZGHOVlD5gFbIjvpiF9VbbXW8aH75hzkzghfdw7MCfCQidYjVyZ
	 okKehnnXasZVcLXJSi/A/HuqxcNujASf9Fnjr0Yo4WbNNMjjbnslVHlHdUPaaIly5/
	 2LHfuQdLhpVbA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <zhanghuabing@ecosda.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: dwc: Fix msg_atu_index assignment
Date: Fri, 23 Jan 2026 10:32:10 +0100
Message-ID: <20260123093208.593506-7-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123093208.593506-6-cassel@kernel.org>
References: <20260123093208.593506-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=cassel@kernel.org; h=from:subject; bh=26/yJNz4YSnbicTXM0RZydtgr9bCYQuI7RPh0S62vDw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLHeS36gva8meabU6deqlrX/INdUHV+wW7pbKCWjcx6 VWlLrLoKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwETExRn+p0xg/PlphV7F9K8p MY/UFLb2lRlIH3rZLeLQ0NeraPCqj5Fh5ZT/+a9UOeTz1PLudb6JWr+k4MOlo/Lc/5xObp70Zd0 lDgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When dw_pcie_iatu_setup() configures outbound address translation
for both type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index
to use is incremented before calling dw_pcie_prog_outbound_atu().

However, for msg_atu_index the index is not incremented before use,
causing the iATU index to be the same as the last configured iATU
index, which means that it will incorrectly use the same iATU index
that is already in use, breaking outbound address translation.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b3d6a474fd16..ae5f2d8a3857 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,7 +982,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->msg_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
-- 
2.52.0

