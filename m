Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931093;
	b=u3DcgM3rOLEOJ6huwDVP5Zt6iGVE5rzck1Np82P1oPGZSLPTU3w48WUiaehGcO+z+BTO
	 qhggmry5K6iAFbkhtBBTlY8JscRODMijey0zw3DZgSGIa691k1Nh8/8rkzB4m+S3eQKh4
	 IiaZFROXAURfSHX+x62qtJP14OpSLyGNydOMTBSjdFgYLAEG7FOLThN4tA0csmXPgqdFN
	 /8bazAWAuTe9u31eokQMstu0DYrdR4YuMAxObOslwfWsk0KUn+Yv1b07xV5y8nR/ls/VV
	 45nonmn8PmLVecBAvXz/OERF3OfkbyTLO2BCoXhspxyNBPqYndjsJPfhLVRpn2BN2iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931093;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=AbuVg4vN10ZA2hcaRa+VCPVPKcQZSgmZ/Iv8DAJnQGg=;
	b=urIxl/fymVo8YrDXXCvlRnMxW+n/fxK3P2PaiMXsclbPvXGmuZRqThyuFE1JwzluDUFC
	 CnMtnSsAjtNi+Hn0j2NA9x1orHCZ6/lWn9KaOx9OJmfnDEgFo7n1vHlo8r/wtX+pMGtrA
	 eE1p0YlHm37NZp/Lh95eEijv4rnL7bJYGEqehywEmdNyhGIby64HZbsb38eLIQZs19Ki0
	 hKZRX+l8dSO5gkKRrX7XVhwTZGzrXmXRqKROnOzVZg0vE9bkjAwhSVw+c235srzcr7c5W
	 M1sri1Tiia0umwx+StN7LqZF7D2Tec4Dvglt2fcfDNF0CohTWjgF5B3hB+wh6zbLg+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Kf0pnMM7;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821C606A328;
	Fri,  6 Nov 2026 02:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1821C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Kf0pnMM7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793931060;
	bh=AbuVg4vN10ZA2hcaRa+VCPVPKcQZSgmZ/Iv8DAJnQGg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=Kf0pnMM7yw1bDZSio6QOf0LdL7sW1Autj2vxxYUIyHV9ybxrZyQhJHMgNuy63CWLE
	 0wics4rfGxM0jD4m8ClBkStwaoqH7kaLqU17b7csSrA+M5n72n3zLYc97R453bLGrH
	 XPt3HpoZPbjJzEO1HDtJdI08kz+vfHSHvBf+dh9g=
X-QQ-mid: zesmtpsz3t1793931058t953477e7
X-QQ-Originating-IP: BbYzGvXJbyXNANJbyxX8YavOnC2uj3ZadAP1LufNDGI=
Received: from [10.0.50.11] ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 10:10:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12396898183467200051
EX-QQ-RecipientCnt: 15
From: Encrow Thorne <encrow.thorne@linux.spacemit.com>
Date: Fri, 06 Nov 2026 10:13:53 +0800
Subject: [PATCH v2] PCI: spacemit: Ignore PERST# input in RC mode on K1
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
Message-Id: <20261106-spacemit-k1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAOA37WoC/22NzQ6CMBCEX4Xs2SXtKgQ8+R6GQylb2Sg/aZFgC
 O9uJeHm8ZvMfLNCYC8c4Jqs4HmWIEMfgU4J2Nb0D0ZpIgMpylVJGsNoLHcy4VPjaIXRyYKU5c6
 ZojkX1ECcjp5jvGvvVeRWwjT4z/4y6196CC//hbNGjUpRnVldm9LZ20v695Ie5dQOHVTbtn0Bn
 Sv+S8EAAAA=
X-Change-ID: 20260921-spacemit-k1-pcie-fix-256ffa8d382d
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Bruno Banelli <bbanelli@gmail.com>, Ali Tariq <alitariq45892@gmail.com>, 
 Encrow Thorne <encrow.thorne@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793931244; l=2232;
 i=encrow.thorne@linux.spacemit.com; s=20260922; h=from:subject:message-id;
 bh=7T2alXfTc2E2Sig8ddTkVljE6R+muw/GFLNKQx4Ilng=;
 b=7Ca91mnujtzIqog/FDsDTW3KYGl2aSZeVwmkYHx8AmdCachE0LwPezwTcEMXQBrHZI7J2aSBy
 yJwHpwhXnr/CAllIgl1MQmsGO5dujjO4KQjBYUjq0Na91h6EFnLv+E2
X-Developer-Key: i=encrow.thorne@linux.spacemit.com; a=ed25519;
 pk=2pmSCQKuWBw48bo9mVmWM77uEWdezu/geF0k1YMFzN4=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mfm8HKGnOlI9/73z/3UqV3IwxbashggCw5UKvSrorhABfst2bcXFqShS
	ZlM3aPcvozGTrB9o4p3FyFUDxhbAY+y6pLT0I/qz9GFxvX6ogmxFFjGuWZ41+JDJ7pr7gNi
	PJ9aC0bsR14zaikyVo0KcU3w9wVPNT7Z4cGyzdHHteiREievSXBFF/IafE+xaWDzp86o5Fj
	Xee7nangQoJ0vinaPtf2J/dX0UAarwipqbQXTqAWrUWb1AZ0W3a+fVyDsGnZCeTS+xcA9AN
	EJcp7+9w3YGlEADrqYMed2Av2TWPDWAzrDAoyK/f5haFyApJ6reBVf379D6LnBqe+QQGtUW
	VtKLEb1syoUqxKhU4dqXjL/5v9Bjd8KqazukaItsZcRFG4jA/qJmgAD5TKBCyf5W5kdsWU4
	gQpoxkiZf5od7H0pcb0j1Ea13MPizx5EOcFBTkcsf+r/hij2ylZyUwBxBgq/xkGEHWLssXh
	eVgXJJm0aBq6hHuCNnr8S9iGP9e/rW0gYq2hU9JwYvxc31i4Qy+bV7v5kFmFpVSyy3UnGWq
	rA8NXekYvygcj+P41bspN6rzjmEuqoXBsFyg6auTT+EeonaabW58ukAp9ozVH4c8YVqwycY
	PIJi0K81HgXxJROfECndHldZ6ujSwtrO3A4fobz7RHSRQPa8kbJUGKbyfGVMmxahAQagrwq
	+hRdPzsuzVqm+HwFC2wMmY98UIZL37HkLeFQeX77hSSGpXoIc2gfP2RlEVJ3MESXRmvguTh
	DFSr9QhwbiHxFT2CW76SAo34KypwFTslQ/tUakAkNevY0FVXrQcX+CH9+0YMpLhnWXwdtqf
	4a6LU9JX5KN2Yi6mXoX0jswIcReyXrDTsDBOVTRQLdujMPgyobMZKAXKQ8GmhLFnYbmtDlC
	6C63GWgDeMR/gH0/nwPXyxvUA1/I8eAFPHJtG915obSqXx1EPrsc9LBbq/E0GHTMZ9fawSW
	aDjdB9bY0SoatCXcNr29YMzf8Y7z2U8Jbn9D/orMP0CykLVNwtbJlpbBD/LNdUdwdC2K1Lz
	iC3uorm/vYpHonWSf6H9lMR73PUPMdBQluPJIWh9viDYTfclaPXiyFOUVQH9lzjH2BNZLeF
	g6UpmI4XMS0vkspf6rvgDEW11CondrAAxAPr4ZrEc6eOUuMYt9dKVIjmlpqQ9iz4CTAG2pm
	5Q2fSu5IdtOe1hs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

In RC mode, the K1 PERST# pad input also affects the local controller.
Without PCIE_IGNORE_PERSTN set, asserting PERST# to reset the endpoint
also resets the RC, losing previously programmed register values,
including the vendor and device IDs.

Set PCIE_IGNORE_PERSTN during RC initialization to prevent this
feedback. Set it before the first DBI access, since PERST# may already
be low when initialization starts, causing the access to hang.

Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
Reported-by: Bruno Banelli <bbanelli@gmail.com>
Link: https://lore.kernel.org/all/20260825052249.66921-1-bbanelli@gmail.com/
Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>
---
Changes in v2:
- Rebase onto v7.4-rc1.
- Explain the PERST# pad input feedback into the local RC.
- Use PERST# in the subject, commit log and code comment.
- Add Fixes, Reported-by and Link tags.
- Link to v1: https://lore.kernel.org/r/20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 92a71ea90ac3..bb60a35c2885 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -47,6 +47,7 @@
 
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_IGNORE_PERSTN			BIT(2)
 
 struct k1_pcie {
 	struct dw_pcie pci;
@@ -140,6 +141,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	/*
+	 * Ignore the PERST# pad input in RC mode so asserting PERST# to
+	 * reset the endpoint does not also reset the local controller.
+	 */
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			PCIE_IGNORE_PERSTN);
+
 	/* Set the PCI vendor and device ID */
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260921-spacemit-k1-pcie-fix-256ffa8d382d

Best regards,
-- 
Encrow Thorne <encrow.thorne@linux.spacemit.com>

