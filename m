Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C631E834;
	Mon, 19 Oct 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392442; cv=none; b=OMb3AMY90D33YyZcbr2QVyyt1FOpZKw7v8x/gw9hWO0S2q1M1QEPk7GTUKjGOJIfkZcHHrgHSyHYfqfaXrfjbL4rxyddym0Nun7wafmkqcW0GSdsnwIm1+VzLx/NAaQFZTmTJzK/UkBoevuEgLdANOe2uStZX3QGl6Bsam1NfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392442; c=relaxed/simple;
	bh=2ON6XJWcFGwD/Ai1naFeypxURk3BEINkOJPi72OAgg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO5lx1WB/uS2FyDs/YzpP1xD56zKmzPfldMCcm0pFDnE4K7z2W715WNdbHZmA+nLblSQQBpsf+pV4Yk7CtNIARaBYssjVVxxSTDSJd+AZFmwTppRf1MgF2n2UhP/bQszryk4FAXFnWFudaqxAAep3FiLkVYKnXtEgZWtrU1YgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=niQshLte; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="niQshLte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=gmVGK2LzVmqgmIo6Q8rziUWcnWAztje
	SyZjGcoijjuo=; b=niQshLte6p4XnqqDnvIvJDVWj8hcYKeB2wbVVEWK6thjBkD
	3k18R8jfcwBWwz8S67EE4fyhiqW1W63Bj+eSjbpWtRNKw6XwzZTTkqJNGdleDHnG
	v9I89t4Jxg9x/+jUsnWg2FE/vvuU26Z9Ojf9lhN7q9qpfMe78yLZa8pz6io4=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwC3cwXnvNVqC28CAA--.728S3;
	Mon, 19 Oct 2026 14:47:07 +0800 (CST)
From: Xincheng Ji <jixincheng@ultrarisc.com>
Date: Mon, 19 Oct 2026 14:47:02 +0800
Subject: [PATCH 1/2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-dw-pci-fix-v1-1-9b7860f919b9@ultrarisc.com>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
In-Reply-To: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Niklas Cassel <cassel@kernel.org>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Jia Wang <wangjia@ultrarisc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xincheng Ji <jixincheng@ultrarisc.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792392423; l=2482;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=2ON6XJWcFGwD/Ai1naFeypxURk3BEINkOJPi72OAgg8=;
 b=mK6M90gGMaf/MQns+IimeYzp9Wz1UfI9v+ZtZkmdXerAfOw2YOiCiihgfKH6QGDdoTvGNrpcG
 MI5oWpnzIrvB/Ty+Dl25WM/zZCEOwxcTLMBS6ipLduYdheBTobGGjZv
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwC3cwXnvNVqC28CAA--.728S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43GF4kJr17Ary5uw48Zwb_yoW5JF1Upa
	sxtFWxAF4kJF4rZFsFq3WkZ34YyasrAFWUGFZ29a4xuF13uFyjqr1rGFyftry3GrW8Zr15
	Kw4Yq34kGF4rJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2IY
	cVAFF20E14v26r106r15M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU1MKtUUUUU=
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAFDmrUbKwAHAAAso

No outbound iATU translation is required when the parent-bus address
matches the PCI address. This is a DesignWare controller property, not
an UltraRISC-specific behavior.

Compare the addresses directly and skip MEM outbound iATU setup when
they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
use outbound iATU windows.

Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU setup")
Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 17 +++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf5ca281e91b..c593a1f1c2e0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -918,19 +918,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
-		if (pp->bypass_ob_mem_iatu) {
-			/*
-			 * The no-match pass-through path preserves the correct
-			 * PCI address only for identity-mapped MEM ranges.
-			 */
-			if (atu.parent_bus_addr != atu.pci_addr) {
-				dev_err(pci->dev,
-					"Cannot bypass outbound iATU for non-identity MEM range %pr\n",
-					entry->res);
-				return -EINVAL;
-			}
+		/*
+		 * No ATU translation is required when the parent-bus address matches
+		 * the PCI address. This is a property of the DesignWare controller.
+		 */
+		if (atu.parent_bus_addr == atu.pci_addr)
 			continue;
-		}
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 799c05213ae3..128729fee607 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,7 +471,6 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
-	bool			bypass_ob_mem_iatu;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
 	/* Set if the RC loses power during suspend */

-- 
2.34.1

