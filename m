Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602C34A786
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234082; cv=none; b=sy4RLu91PJEDE8suP2w0aHH4FeUyt22im91eZjBZwS9BJPxUwvXMvCwdWY/bqQqIF0egMHylXWONuM/7LvDiQIfzYaX0cF2thUGSGNMCzPS1JuhIRV4qZ9QCnJCK/UtyLeV4dMQ/iMscZVInLxJDgy510bg9mG4NfjueSpNFo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234082; c=relaxed/simple;
	bh=HjEDykLJX6Jt9S9QvlQhNfndBFcUdtpN/AUoX4hVNMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L+sL7hcDtdWWGdNE2j4wa60Mnu4ncsfwQeuQW4Q5Xdecli26Es42n4RTOx5URoFkcsfPIG0nEehh1TBbvBA9OOKDT9HGDJt+gqHzW7hDdXG4lwRbQ1GR6YC4Xm2Q5KW/vp0QRPM8XzZwDn2qCNYd1tZEGUQB18bEPSZeNz3DyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDEzoqEs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b5V15Z/5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDEzoqEs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b5V15Z/5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6487vhB52384116
	for <linux-pci@vger.kernel.org>; Fri, 8 May 2026 09:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TiJIdCtRF8sPp8DTAw7sCi
	AkaeIBCqQtT+HrST28lLw=; b=fDEzoqEspPuMo/PcO1ct4OOEGOYWxy1fjn1bWl
	qlbZAimEryrvD+q78Jg6VwIKVC4UivO6jaEKCZyTFm/17Fg5hQyA1s8ayDNhIDg8
	Ik+6RBDkvF4FCMPV/J6A8ripnyRS4NATE+usCZJTRYRotcsxnBwJWNVw+VJDvr1S
	YQvmKiS4P+TLI8oU5LsMZsBDHupzDsGsBikXPcZSxdEO1psLHRxMhsLZ9vhnkVFq
	7ifcINVUPVOPeSgkTq+iopX9RhPS9XYZp9oPiOIi9mabNDIwUPcjo695TEr/Yg8R
	9LcXV4wPzLxydZCg4o98NQqpwIync/4NTNuhBPN47/ZTAJ6w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0wwukgwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 09:54:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ee34588671so2589093eec.0
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778234079; x=1778838879; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiJIdCtRF8sPp8DTAw7sCiAkaeIBCqQtT+HrST28lLw=;
        b=b5V15Z/5ALzZPOxTtundHgtxB0t8P0PU6ChTAQi8CiTjt47gA9fdhMK964tYzsOEos
         fYlU1/foOEcMfc1SMdiRgeDEBeaWdLpe2gES9DYWZIJFq3URN1+TrbaI9zdKCBMyP5c7
         vKj46rnlxr/yhVG/zMCaX0oqXcDKNrvOQo+Jif66USDqX7NYg7j7YBZn6MtQdiW+RtHj
         Eo2I3DQ8GPdzV5F6xohE6NulHtryErKeEatP/9Y3Hvd6ebEL/PSdpXDzNu0oGsC/CQVi
         2uHM0tTqEk9uCV3cu2aQNjYfhhTRrN/Y/MkzVsKr5q+sl+ez8Nl6aOpEO3WnAlJzoX7y
         sWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234079; x=1778838879;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiJIdCtRF8sPp8DTAw7sCiAkaeIBCqQtT+HrST28lLw=;
        b=ZPN6Kadsq8T2nGPNTGN77thtafiU0Vvt5eYsru49oNeW7LNDnyFNpIHgVR1kfQ5taC
         TN2sq6PenDMheksD70Sm330R4scUdSFmBF0n93NYWmlse178ehDNSqcLkG9Z92WP7dtm
         tNM825E1xelXR1d4DENCnpRIC+uiLdGHk/+HOCZQVGX4TT8xGlJeEwdJcEfCJVEuM+Ks
         kAsbxwPzhWN14vnZbY23w1EpMWmk9mizNNkov3+9SkhvdxxK2kzGlgTb51/XtVRN/uht
         HijBcspwm9Gy4ORU6xa/CYFLhuk3GSaM9AxYrBEu+YwoxyofXUEbulZuNxl9BDquMOJm
         BAQg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xj4GEABKGGKVc4CcjKPFihZF9BFHKcZIUdXk1eFK4prSGadVgN13Mdbzg6CpNXVOCB04QgJzuEbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVT7qEgz3+4KVejVRYXdA/DJ2jrL926ngEiEK+dd8Isw7j/tsS
	siDqBCzBbOxPtxeByNmRYkH2MRqZnq9aVN/Yr1tzT1eAqBM7jkUrR/FAu1xEz0tmbcPI761YAlD
	MMb/lZx3o1wh8oHYS8PhrQHLONTQaihbTpS+6Y1erelVXmYH7yNVCzBUFUkt6DOXNvQQNSHnQlA
	==
X-Gm-Gg: Acq92OHbwhuA14+pDTyzB0I7OrE0IWYL0x80o2TuxlAhsFyEcBKd2rIUYNlFMJY38Zi
	sV2KyK3JjLaiSSEyKiUKQIJGPTZyy+DZmSkv948YC2CEsdaG1cDVKe9rsXWtUMBT146g7TxFZm3
	hnb6pB2D1n4GgdKG+/5eqkuKUmQICJVGeiQopqp5cCZ7nrtklQ4PssyYrjaytBTnCh6hVPyCg2C
	Q0vViWjl/OLVGo3Cu8wUBi0mXjrWmcpFIM/+H0KvWsqO/1yoymDPeO7qpWkvogyaCz1LMfNtUs5
	t3yIJhFys91R8UP+VklvB21amHhasWM1W+pilUO9vOkn6X5qkIbBSHJ5E+Fbf71DP56jQy65kBy
	XgS9Lu0n02/0Pp4aS4VcWdrfYmWCD8XDZFrZdn1SkZdmQUXsSv1WseQolcnJoYmwCRGtr
X-Received: by 2002:a05:693c:2c93:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-2f549f7c2fcmr5978693eec.22.1778234078493;
        Fri, 08 May 2026 02:54:38 -0700 (PDT)
X-Received: by 2002:a05:693c:2c93:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-2f549f7c2fcmr5978665eec.22.1778234077926;
        Fri, 08 May 2026 02:54:37 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88924af95sm1459176eec.30.2026.05.08.02.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:54:37 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 08 May 2026 02:54:19 -0700
Subject: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMqy/WkC/yXMQQ7CIBBA0as0sy4JbVGJV2kaIjDKmFgJQ00N4
 e6iLt/i/wKMiZDh3BVI+CKm59ow9B24cFlvKMg3wyjHozxILR60m4iJs4nhbXxmYU9qsFpJPU0
 WWhcTXmn/Peflb97sHV3+jqDWD7zZ6oR1AAAA
X-Change-ID: 20260508-mix_perst_phy_dts-b741b840833b
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778234077; l=2895;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=HjEDykLJX6Jt9S9QvlQhNfndBFcUdtpN/AUoX4hVNMk=;
 b=ZFbD9kJPg9Z/CSnes5kNmNpry/Acsc17UJzeDMdNuFXVFH2WaQsdDcwVGn0FhI2+eA636JUUc
 YYYkQ6353NYALPswRbWrBfqVNamuWbGR9ni7x/DRvywQLwxq5ChO+Aw
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: PgIOkOTFUvpepAva64TZf1d_qYdwQfIw
X-Authority-Analysis: v=2.4 cv=Nd/WEWD4 c=1 sm=1 tr=0 ts=69fdb2df cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jtNwtCWPJ1kYkMuoZKUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwMSBTYWx0ZWRfX2YUCCDOywDnB
 8NcZFE1d+ENSu5XJaGmOSW2JL80ZIq6jmeK9jvbx6IzeK+7QODy/kfY6LY9f9yVwsTnna1r3RU1
 p5+wJpxVORcO4ATb1IMIo09j/EFkC+wBaDtdHOm+3/AIqlIHz6u4ZAEIBga8EVB+a2d9LhpxjID
 dez3ytwv7z20rcAdu1G3ogO6dLxLkwAQH/1RT9sX6S1Od2fgph6fahPBqMWY24JfMY0MvGj/0pL
 4n6XDvihrJeAo0LVVjkZ0HAGiOO1urZaL6e2cwLj9zVC+aBzRVHtr+qyc3OEV5vRtlebVqHg++n
 oDgy6WcLge7HNG+aknhG3IhyFtEWYkY3+0dZh2/fcrnZ3Gf35c6MmICuhUIkXgp4FrsbSPArvkp
 tY0ZighAOY/56z3LuZjQ7nEZmEDmrXoNYanrjaDDPx5JEetKkZbLoNy/+TAXa3GvRllln3vEl0r
 jWoLLavXBNCwIisRNtQ==
X-Proofpoint-GUID: PgIOkOTFUvpepAva64TZf1d_qYdwQfIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080101

The driver currently supports two PERST# and PHY DT configuration. In one
case, PHY, PERST#, are described in the RC node. In the other case, they
are described in the RP node.

A mixed setup is not supported. One common example is PHY on the RP node
while PERST# remains on the RC node. In that case the driver goes through
the RP parse path, does not find PERST# on RP, and does not report an
error because PERST# is optional. Probe can then succeed silently while
PERST# is left uncontrolled, and PCIe endpoints fails to work later. This
silent probe success makes debugging difficult.

Handle this mixed case in the RP parse path by checking whether PERST# is
present on RC and, if so, using the RC PERST# GPIO for RP ports while
keeping RP parsing for PHY. Emit a warning to indicate mixed DT content so
it can be fixed.

This keeps mixed systems functional and makes the configuration issue
visible instead of failing later at endpoint bring-up.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9fdfc88ac151..8235961d692f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -282,6 +282,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
+	struct gpio_desc *reset;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -1703,6 +1704,11 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 	struct gpio_desc *reset;
 	int ret;
 
+	if (pcie->reset) {
+		reset = pcie->reset;
+		goto skip_perst_parsing;
+	}
+
 	if (!of_find_property(np, "reset-gpios", NULL))
 		goto parse_child_node;
 
@@ -1721,6 +1727,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 		return PTR_ERR(reset);
 	}
 
+skip_perst_parsing:
 	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
 	if (!perst)
 		return -ENOMEM;
@@ -1778,6 +1785,14 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	int ret = -ENODEV;
 
+	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
+		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset))
+			return PTR_ERR(pcie->reset);
+
+		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
+	}
+
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
 			continue;

---
base-commit: 33a76fc3c3e61386524479b99f35423bd3d9a895
change-id: 20260508-mix_perst_phy_dts-b741b840833b

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

