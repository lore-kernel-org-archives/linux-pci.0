Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8D27EFE3
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754414; cv=none; b=DxwXsPk+u3ucOdMNva+1qWh3W+vnFzET6C9TlmiRSYiVLijUS1kgtCrbXstgmSaITc8XHIFCuqoroLZeO/6tNX3SvxQIq54YibdNcQjw9v4IE3MAWktbeY2+yLY3PICpd+FRvfLZjhBVNIlrzdIhWtL2sTIN4j6MlIeR7MuuYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754414; c=relaxed/simple;
	bh=OrdLwue7fdAbDzltDnJtmbESjqt0Rj2YqfvXS7hTKOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHbb+S3TqC0BJlK92r/3+PZpBrb6rV4xRc7LLuJ9Gfot2NKQPQnqbN0gG4ujXH72rd41ewvKLg7CM14T7DVX5glzqfWlUNWZ7JGoMcS40XgdsJURDwJmILWtGYMsSytTSmj4wxPNNz+pLjrZkEoA0ErhnbleLLKdQ+c5AOeJzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoLU4hwr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khDqLmL5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoLU4hwr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khDqLmL5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8emYC2315776
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdt
	G0dTVDoQ=; b=UoLU4hwrC5dC6619mdj2VnbVuT7Aekrcbig4KOnX60dCk5TZGoQ
	ML/pSlTBEj6WjZtUqe3RQQcM8nXBfu60SE5I6aZkNxpMQ+cda0SQBu/hW95PSfaI
	7EEaAkBUB/5KDpZpg+OshLNtLJblnjg7CAlfckG16eTH5tLxcOFdt2KE2OPE8lCh
	Ep6DOa8Z2wWqcaOQiiIt9EmYvUWjHxKF8UEm21fzjiBouEMbN+QsuYo4eWpzOyO6
	UlXQlcjA6l7zQ3DZSvCWVCodKT3a1IyeLXH6IbHSOj5l5bJJROzTJkvpUrVtxVnC
	raCXSEH3TJOHlhQArtY7SvI7CNdh6kpd80Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf2c1yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5092135f2e9so328172771cf.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754411; x=1774359211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=khDqLmL5qqbCnTzGzlTB5ndzrc2Jah1Wnf0FA4cMsJchSk5GTQ6YWL/yLq3NWm7Ock
         qhJpiU4thQ2pudc3TjLwOAyfnseDbRuiTrAzIeM5Z4juDU8K/MdZ3s07Mc/3f8XODq0I
         q6W9oetbHjusz1A8WnHmyuB9brM/Uh7tI+kQ667Pb+cVNEUNNLl8rR0uS7tCOQJ1Zpo1
         J4vW+sCChg0x35uDBrTRWyel1viBlXpbYgCh9dTbST9r+37VZ0QSGwjofS4vdpalDalc
         q7LiKAOZoOnfT8LzQyR7mVEiL/6fejzYTeiTu8cDwW5U+ImS0A2tG/Zq4ncB1HNI7UZU
         Sxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754411; x=1774359211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=jylGlK6qrqsyyImfon7wLyd9CgUHLcpFCqQZis4B99J4QUHv8QFD1NrLL6DWOlDtIT
         mRgI+b/z+3hv0aXgVLnUizMBrgVFlgZivZQTA9ZW0FfNNFE9VcJvkOkLNHf9Cal1SAtI
         iPIPXcqEiJskVJGrdDU/R4BJcKowmvugMByImN3E6qg+EcyHuw85gLHt9/x7e+7d1ztB
         wLUm4ZxE2SS23v6ID0JZH7G9AMzCb2aKSKnTFRjX0CuTX/YE/1ib6SQWOkXvLev47qXQ
         DfGQH77PaO9InYtYDzpQM/xPpJy+t8TyO/VNc8fxZ5MryoxHtKeV5uJUu1O7Q1i8DXBH
         fPmA==
X-Forwarded-Encrypted: i=1; AJvYcCWEu3qv+uw4k9IAVzaTKuShSsMF3Hop1Jz04MdYpiYZMSVcC7yOfy3/rQpcNB+kA6QOuSaXUGCdbCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDppsLmfh3H5C3muv2YsflGyNjzjePdRHJRTfP2w+SXCnlrYU
	AYIC7XkBOmURNtO41WDBoytGK6qG//mZ29B4TZSTr22NPfpXhh3y7uDs9CBkLa8tmk8fo5rUPLT
	16kTIElq8znGcp09ffo9vspUWDv5PiN3dmv2zurc2GCLxvsafxSobj4FZfqbAsO4=
X-Gm-Gg: ATEYQzxhB8RgzgVQsVSRZFZtc40O3BJzpmMTtnIzwlYo5ys81NGXo6sx/mKtVn8h+a+
	w11wscLzZoKkbTH98pZpc90PhCJGRvymE/6D4A1DIFBaMxg2kg/CneaSdkX1/gFxgkqnN5IZEak
	L4rHl6+g+CJEtOHZeqThYPNEZMxuGTSAKEatpFQ+LZmahYL2rzFJfVaI/p3D/O1bMnaCQ3LaM39
	N+5C3LiAV4nP/fWsVm+SuRdp+vnRezMAP2ArI1ufAA8tJwAvwaH9MlDqUBIIWKe2vlmgnAwUV8i
	C2t3wY4uzjhBT/5UTafjvjT+ojwIMTuJ1JNYVpXIxqTDpQQKfHc6LNehfU+htWRs3qE4khG0q2b
	2JllkMIHh7eDGElY2byvuVmNvgJDCm9O7cTzA
X-Received: by 2002:ac8:7fcd:0:b0:4ee:1c81:b1d5 with SMTP id d75a77b69052e-50957de91c4mr213716881cf.46.1773754410644;
        Tue, 17 Mar 2026 06:33:30 -0700 (PDT)
X-Received: by 2002:ac8:7fcd:0:b0:4ee:1c81:b1d5 with SMTP id d75a77b69052e-50957de91c4mr213716261cf.46.1773754410160;
        Tue, 17 Mar 2026 06:33:30 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/4] PCI: mvebu: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:23 +0100
Message-ID: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=OrdLwue7fdAbDzltDnJtmbESjqt0Rj2YqfvXS7hTKOU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgiNnmMkn77MrcChhNDnE9rF/K8JQJoK2dTl
 77t/s4gkB2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYIgAKCRDBN2bmhouD
 1ze4D/9krAOOYWKjH9emdjBtbBAWnahk2EslM5mgi96nhIwDz8xp6zxHv92avzFmuxUITKJG2Ue
 qDQC5EHqKRvpnbsuGY4fBpC5GPhprYTau0XfSKvNFX8xuobGppZ7HolxLls9lynLQ8mY5OIgHpu
 xLEclQTekGqPrstc54kCypI+K/xi3qJ8UVJMzjKE+UpQtLKX8WG0ZIa3c1rJOnPhKegExoZTjQ0
 QtHdt7PChdWXO2442uI3j0QqptigKqDF9bajSMKKTl10vALKZ5jSMT9UTAMJmTCGbC7nPSbnzpA
 xUxWfprrx839uBEtRkNnl4jUaLq6xj6EUqBOE0CCzyz1t3kcy+lVeWVqlZQ7E+KmZZSb2+5yvNd
 6niyQTB5GzbOdROK+aI8D9lwWAmdwRFrpd0uJGb7Fc6xPm+6U/e20FCrpCUS1iS7znNo4dsJaVb
 tx4/E0fV5zc+Cy8ecJbJyGN1Go01OQneL4EUvYPeYbGUWTstF17YeOnsr2VesN125X5KQJIz06J
 JGjMAMUPlf38PF1Ib/uVplTpzUNXUipw34KU07qZNDuBZsQtmvbYaZm7D0KprE17aPlj+1jvsuG
 EfI1zmzfrUQ7/YVVpu32BPtfviMLHZIwplLc6AMHVt8S+EguiBN/qVcU7wSOd5adXkLlqLHkp0p ynjQdNzofm2jI+g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lZF9Y4EFVi6KIIVu7cplVLatNvaJF0Hz
X-Proofpoint-GUID: lZF9Y4EFVi6KIIVu7cplVLatNvaJF0Hz
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b9582b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=r4sBWMy-QYfdzbUQJWcA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX8BBFWcCQSidY
 /mU/yLHO6sbMVOkOAmMOpJ9YmR6En6awNkLFbjdmu5PnU/4JdgSfK7EfmEGHft35lJIMMUxFCus
 wbeAqcUVlIxFl7HfNiZqz5cXFxzsUFPS0jO+uXXG+SHw6lJv6hdPwy2CCER6BPLR0tyuudtDKvW
 BV4Dy9yK3Ml4vjFeKoIsK+NNQUWTkS9xD7nWezeZmUb8iIgiXjgEeiFggSL3wMLTGonejIVEFBl
 zsX7rEBc6gvcnYk+6u0OZ6iCgJeurzdxn8m11Zt9d9N8DTOdbeMyt03u3nJuU8/dyganNc1IlbA
 vOnjiz8KxLXBc3jwzsC8eBGzOSzO/4d6wq656T8OVEvPGi/LTLurUlBB3jSf7j95HH45IUmnJZ2
 gpL1tDm2tLhWBVcBVOSWVgH/udUPwf+ce83Q8m4WfUsBaqAj+2l+QaevsomB5aTNIxUnp4BlANh
 PTvKjHbFPpV5mztKJhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170119

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
None

v1:
https://lore.kernel.org/all/20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com/
---
 drivers/pci/controller/pci-mvebu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..4d3c97b62fe0 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct mvebu_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int num, i, ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
@@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
 		ret = mvebu_pcie_parse_port(pcie, port, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		} else if (ret == 0) {
+		else if (ret == 0)
 			continue;
-		}
 
 		port->dn = child;
 		i++;
@@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		int irq = port->intx_irq;
+		struct device_node *child;
 
 		child = port->dn;
 		if (!child)
-- 
2.51.0

