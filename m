Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B12D0603
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382848; cv=none; b=h4+KQw0s3U2loU0Yk6LkTK8i9XtbOJHL0s9sWG1CesJ77D82mHD34XAB/y+JHbIKwexwT2+9S+zmtsz2MDWQfMpkIB03AmVkiOHj6JSCQ/a/MtQ26r20/nQFzL4E10tgEuwhhE0KwkKw09uGz+1pPnvcKUZoqI82AY2zdmwiBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382848; c=relaxed/simple;
	bh=OrdLwue7fdAbDzltDnJtmbESjqt0Rj2YqfvXS7hTKOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5UmikDobWT/gKRHKUkADh7OXQVcftBWOXFu8pPsDVIPnmoZ1FSTyqDnUkCXc5ZT6NUC5/PERZjCahYcsDHZm/RhL5aGPObMODL4eVizYa5IUHJjuwl1FMkXe0hkcdUhrLZ4vOPS9jFn+b+UFLaWg0qjshKYXkMgMLKmuNE9Pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUDoZkf7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFLzW8Nx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUDoZkf7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BFLzW8Nx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA2v3Q985077
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdt
	G0dTVDoQ=; b=UUDoZkf7dkIKv5QtAyw6m3D0a3PfhX6iQdd0EyETB9cOLgS5yiF
	dZ3QgJZxFuCVU1ayF3845veEbnhEeoqeiw76GTmS/Irl4Q5jkJzfxm4U+2QxNzE0
	OCHvsfzt+iLA4WLqSX4pbq4wpPO5NtDiAIISCGRYC40RevxG0/IHdb2+yCPH7IBr
	313g37l5FjFFnC+dbHHRPQEDF2NcNu4AjQPYR0SAjI1CyWcu5MyaXDrAPJh3BF7s
	cRF7cw9IfXTqAcMudHARUMmnofMUNRVaLwJPk+TwQRltZt+zYbVXEdbEc+EHi9xY
	HlTRiakwMnxtYT5iaN+qEwGaxmlNACkAJcg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2rsn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-61010bc9c12so5022649137.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777382845; x=1777987645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=BFLzW8NxYsl1K/H33B8R7ROPblPFiLpbWxoCsKWAt/UcQikir6VanEdw1Aqrz6XUjT
         iwyokIBMUY1dbFhF3mUr29gOpysiMo0uzX5jtjqARXKz5ZZXUuP4DvxUUeYbHqsp/I6y
         1e3vJxAI+7ypOwJ1iKApp7yHHoIKr2tFFc1yI+NHArkty0Quz9ElcBrFELMT6eX9S695
         zRwJVycZvYmkhbFipXYsXhfVSdFmSp+uzmGi+jUISfbml0W35HtObVjpGSeks9lZM/k8
         NSNIF7jVDldxIyfS647wgDHSLzR0MzdfmonWE9uXxCb8ljWD/tOQoR6rdJh2QyZG2Bl7
         5qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382845; x=1777987645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=FYRrErkCtnywBKXpzXP0YlP41eYRaTGnvFxqWzeQAh1aSUuSvdk4DO1CVUWquzQUm2
         24iM+BPCjlpHdCV9d/KsKR6gpRdKilTefd5CvsWx+MPAYMnn36kv8og8oAWrWLgw0mGf
         4fvZ1JazqOrgNL8glEdIwIVYRKbXf74RKOl1lxyq7VcUKHuQC42bCjLDlQ4kRjqsxOR0
         z0XpBnZc/Tdy/TRysB0f//tmr0MXB7fuWpNttbdMtW4r+Jw0j7UJhEGcUX9DWmRkHF56
         zCz1qvSCQdMkWtVr0jQPEXV+4dkRGst6wS9dOcEmH9MNXz/jUSgoiXYrWruBoziy6PC/
         8uKA==
X-Forwarded-Encrypted: i=1; AFNElJ++Xk0wD+f3b2iTmSmNB0SY9QvN/Ab/xcHkJSvkeBs8RWWa/zeOCNjM8z+ZLBL6giMfGt/LciHJ0+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcunqJdHJYBqWo4MHUiv1+pc4QPEbB2PHXquUBaariqQqS1s43
	QaB0u4Q/dJGrv7whhyCkAC9SaBIe7jMTTx1tZRnamhMhFvqsixFd8mZnabiDxaPFRRF2s8t1Ye5
	6wcf44AVwa6P4RZE0vSeL9ghSUC9LIOArCPlpb9aU9yVKqDlX3eWB+DS/Z7ZrTvvYRZiqF/o=
X-Gm-Gg: AeBDievVaOxPODD3Cp4ZFnokZ+VedMtPQBzJjDqVQSURE/rcWui0EHO/anc2C5odXCB
	eX4prVc2Fm/a+C16WqH9le0/9avkpJzqWrX0yZy7zGMkByBZHp4U1cONZH2l/b2fksqIlHBPShs
	i8iA1QrzvfjxS0DMXuHMME7GQGw8DVZckdUF2Z4o+Qq4YE/Zl0Nau0ANWU2Spxv3pF7ngctQ0WY
	FLkp5DF38IP3rYVFkAWEnhm1OMi9NfDPKWG7Sn8ayA4gRQ8y9s/AXlpZSrOC485ps4Zlvq6Yp/H
	oZEC+WgbAZQCIEYCp2g+bxT/C+CEiKYguKHwQ4jCiBlCfuEBnlJZtO9DGl23Da5TPWaxn0QHUn3
	Wwef0PjACpb+PRGXDiwIcoVeEsGhMyWCebmxgot+PC/X6sAQ=
X-Received: by 2002:a05:6102:5106:b0:605:62eb:46f5 with SMTP id ada2fe7eead31-6280aab5382mr1036860137.14.1777382844391;
        Tue, 28 Apr 2026 06:27:24 -0700 (PDT)
X-Received: by 2002:a05:6102:5106:b0:605:62eb:46f5 with SMTP id ada2fe7eead31-6280aab5382mr1036708137.14.1777382838203;
        Tue, 28 Apr 2026 06:27:18 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm7232213f8f.16.2026.04.28.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:27:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [RESEND PATCH v2 1/2] PCI: mvebu: Simplify with scoped for each OF child loop
Date: Tue, 28 Apr 2026 15:27:09 +0200
Message-ID: <20260428132708.95998-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=OrdLwue7fdAbDzltDnJtmbESjqt0Rj2YqfvXS7hTKOU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp8LWsNnmMkn77MrcChhNDnE9rF/K8JQJoK2dTl
 77t/s4gkB2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafC1rAAKCRDBN2bmhouD
 121uEACaGSATosAYoW0XcVvUvvJRkqbgDwo8ccDSqB75WflJzGX+m2egSgB+n+NHXJOa3kVxaZt
 xW94i/43SUOooIvW6WdvtMa+vgbimnKN50cL357luzAn41NSH2+hsr4Su1fl8LsMFlk0um9918N
 fDlJV9F83mCdhXYQ/X5FLnMDA3pFSjeU7+0lgGWqTrkvnwLD6eBd1YJY60n2Y01GFtgg29wp5TG
 szmuXhqW25Aro0W7AQXPrmvXl2kICF5JchzZcr6+3NX0fSefvj0gOxJwcUFe6G45kO1GMy6Xf9b
 q/w/CMOVUmM1FYwXB1SGSwutHM9k1+XFCmQmBbuHMsRKwDS/oJlQvK/VjpEBvLgezCgpDWEvoA6
 v9sa9q+eW3zHojZK58MfFFFjQKThehwo0ZycAg7bjXaWOiLdLlFEoRnfCBCYTS+6H0+lGZ31IzX
 30+kGmlcKOFaDgG/vwrNb4MfaLzUd0MhSYlCmueUX1Y6INZtL9CBq9GAbX8hW0BE3OdH9kk/T/k
 VJ3J8zIlM3XaY/TxapA44rVOWl7CK0Y0pwFe36ElDrs8sSX4cDKun85nP+gfbAfwiz82BrVPDyt
 7SFTYgrKqIsZZw1dzVQo21MmDR4YpnPwicDxuN9JcLeRqHpnCDl8oZg/dTdt/WHmvZ88F/9bEN7 1HszEbX06i2mtrw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0b5be cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=r4sBWMy-QYfdzbUQJWcA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: Mwo7vfLTfzvUhAoaf0hxy0Svyv5tqf_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyNiBTYWx0ZWRfXybLrMOSo0xSb
 RhLAj73XukL4RxCQKJ+ERgD4pclMDUfETmWm0PILF+OIWLRSEP9nGARvZaZlBTq79+pzMVPhOuu
 UZCs82TxMElB8Z/Fol7j7MLdxA4D+fXOOOKsknnSHsP7XQ1WZBfvjLdMRTSBoPQnnTeJlETBKS0
 i4m0wa6J2uQlXDNZfzTENwTkye9xM1zOBWSrO5o8hMPH1/PmLYmOSRWaRi79n4gdduwpcIpsEry
 WDGGD1GB7Cq2hRsYmM62jJqh9podMeAFumjSOV/s2H618JrPAaTfFuBeO/0wcanIxevHJw2p7Cd
 mtEmmZwwKJsW6IcnNODOuFzQLhxUVyQLsUI7+tIDJvr8jo5T4nJ8itwvYmigDM0OwU3x3vfV8F5
 cKuMKvA1bY8+bKKXihhDBrtFrf+hMJYf3fpO0FbsDd98hSxnDqMbPWqF2dNcboLJqSBeEOFyEo/
 /okd9kTy7Alavodi2bw==
X-Proofpoint-GUID: Mwo7vfLTfzvUhAoaf0hxy0Svyv5tqf_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280126

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

