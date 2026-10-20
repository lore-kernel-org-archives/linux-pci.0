Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=218.76.62.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463882;
	b=PtrSRnkFlfF0xypBoYlGqOZn4Iwrz+yiovitm4tTkONiagotufPll2ZpsedYWr/8ree1
	 QltrBgDC1JJ7qsXdeqSdH0P8vIc2iHEb+bVxef3Pi6FXS49CaeOixLudVn5+2JwVRDJG5
	 LAqhLNkCcO0a3N5i02VDesM8X4mhJniMsVyuEHkfWrUZuJ4n+U9bid1/Yr9pjbeyUYAVi
	 tWJnFwp/xFH9zjFwe4HAQXunzdrg1FlctyJE9wdp1yQ3UQ67TsCxZk/77kr/7T4+Airxy
	 QR3zLAo6DCJGmec62Wo1Nc6aSCifgPnMkSAZjQJuVJV7Bl0DIaEVYwGFhCazgvL1hqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463882;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=VK9g7vRPPBC9tHhJzOVeroCsAXFqKlIYl/3Cax3+FZg=;
	b=XleSAWPRBfSoj4pMlphR+RCS8CQCHvcneFi9dTocHFDXzruqOs6Es0K2UJ1cC5ohuVny
	 Cd380t3rzads7zww3y6azkSo1tEVZGwyO18dzRlscwo4k6EPEZkslqlP+qicM+3GL0EBx
	 Y4SOCAGQbuyycWTWqUhDRcmTfJmqt4bu/n0n6iT6iQyf2c/6ryTOG+FUtQuFzdeEbd4W9
	 WVTvA0OwoQCQ4lk+suEkPpKAkcIC3erIRD7FLMG4nvDDDv+OHS1vMiUiRG/hoCjf8pdnf
	 +UAM2DZmBH5I6q46dELgQa4AlML24NPdCbWQ5nvu3c9o1MkjGKfJRpNYm/WdekphkRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ultrarisc.com;
	spf=pass smtp.mailfrom=ultrarisc.com;
	dkim=pass header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=UD0Q+gcb;
	arc=none smtp.remote-ip=218.76.62.146
Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CBF606A319;
	Tue, 20 Oct 2026 02:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CBF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=UD0Q+gcb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	To:Cc; bh=VK9g7vRPPBC9tHhJzOVeroCsAXFqKlIYl/3Cax3+FZg=; b=UD0Q+g
	cb6t2tDWGjfStIfbW1RXHyDGGM1NzcRsEb5dl6NXhd3CGiR20/fQMfYecwFwqKtT
	kKLEYiRSxlCZi7B1n3+55VweiP2yjpmaFhEE0Sip49Ma6uDwXbVtbWk7Q57r0Tz/
	xdbWUP07KAueeWo8pOSzD3ndzBA3GItI1GOP4=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf709ZqunoCAA--.1134S2;
	Tue, 20 Oct 2026 10:37:49 +0800 (CST)
From: Xincheng Ji <jixincheng@ultrarisc.com>
Date: Tue, 20 Oct 2026 10:37:35 +0800
Subject: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
X-B4-Tracking: v=1; b=H4sIAO7T1moC/02NwQ6CMBBEf4Xs2TVtDdh68j8MB1oWWaNAWkAN4
 d9tMSYe32TmzQKBPFOAU7aAp5kD910EtcvAtVV3JeQ6MiihCilkjvUTB8fY8Audplw2+mBJKIi
 DwVOMN9ml/HKY7I3cmAyp0XIYe//e3maZej+x+RfPEgUae9SFaIw01pyn++grz8HtXf+Acl3XD
 4Vb+S66AAAA
X-Change-ID: 20261015-dw-pci-fix-c8e51f83be02
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792463868; l=4234;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=Q9+BbDS9yoQuyZhe7cObUA+8q6N/qC+6CswqkBQwSRw=;
 b=NiwEdG9VnycmQ0G7JUSJURSWYgrpsPOVgeEf4VWKfdtTytEsMJ7nZVuI25yzhErBX/mRNixnF
 H2xoHUWik1oCAiNEZYVh0+K25pRzQychPNyxiNHT+uM8D/H0TaStaCX
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwDHQAf709ZqunoCAA--.1134S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1rAFWfKFy7WFWrtrWkWFg_yoWrCrWUpa
	9xKFWxAFW8JF4YvFsFy3WkZa4Yy3ZrAFWDKFsI9a4xuF13ua4jqryrKFyftasxGr4rZr15
	Kw4Yq3s7Ga1rJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAIcxvE14x267AKxVWUJVWUGwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-s
	yl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUbgAzUUUUU
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAFDmrVviwAAQASs0

No outbound iATU translation is required when the parent-bus address
matches the PCI address. This is a DesignWare controller property, not
an UltraRISC-specific behavior.

Compare the addresses directly and skip MEM outbound iATU setup when
they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
use outbound iATU windows.

Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU setup")
Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000")
Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
---
This series follows up on the recently applied MEM outbound iATU support.

The DesignWare outbound no-match path does not translate addresses. Skip
MEM outbound iATU programming whenever atu.parent_bus_addr matches
atu.pci_addr, rather than relying on a driver-specific flag. CFG and I/O
accesses, as well as non-identity-mapped MEM ranges, continue to use
outbound iATU windows.

The UltraRISC DP1000 driver has removed the now-unneeded 
bypass_ob_mem_iatu, and the general DesignWare PCIe host 
code has also dropped bypass_ob_mem_iatu, directly comparing 
the parent bus and PCI addresses before setting up the MEM 
outbound iATU window
---
Changes in v2:
- Merge patch1 and patch2, because they depend on each other
- Link to v1: https://patch.msgid.link/20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 17 +++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 drivers/pci/controller/dwc/pcie-ultrarisc.c       |  6 ------
 3 files changed, 5 insertions(+), 19 deletions(-)

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
diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 523f454c6c52..a0d328c0c09b 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
-	/*
-	 * DP1000 routes MEM transactions without outbound iATU windows, which
-	 * avoids the 16-window/4GB-per-window aperture limit.
-	 */
-	pp->bypass_ob_mem_iatu = true;
-
 	platform_set_drvdata(pdev, ultra);
 
 	ret = ultrarisc_pcie_init_clks(ultra);

---
base-commit: 0a2602de077462d3111eb9fd3da5b12a57fc6c93
change-id: 20261015-dw-pci-fix-c8e51f83be02

Best regards,
--  
Xincheng Ji <jixincheng@ultrarisc.com>

