Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD53812E3
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347963; cv=none; b=aqPFyeJFwJhLR6K+6nYZF6jisDX2UFuChNwInIV0sM2OHgFVET6U2ssPI7PJ8jZaSLMCfjZo111li7FEVFYV0/IHdI+xiBhSb2ectvcWve/nbNq1w8rUZJrbNMVI+Cu68aiGxCpHw3g6B/yIhjjUBjS+A9QRAJhLro1xHGRG9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347963; c=relaxed/simple;
	bh=3NyQcX6UtkQinDdPKnEDpzF+Nwl4fBqZnu+f+acQlPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCajfb5ZI8+j7NwTwlTbI6JwN2rSrvQWsoC6UcOEaOjSUsl8IHx0BGV6uFxuNcoIJunH6TNcpUQg0rDZpveMityiAI/3CkjMu0J5VFBRXHp1IWW9V+5CECscCHSVorn+0PRXR6bDsIQh6vlu8wF19cyW8SVuSNIU/aqeSNMVpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYw1drq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIIJVXTX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYw1drq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIIJVXTX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6IdJE3680289
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ec
	b5GJgO9w=; b=jYw1drq37Aa8pNMI4dzSEE8mYokUb9i9XcsW2AJywqngw/X5t+x
	9WAYNSboIZS+bK+L/ylJKwL64H3eyAD6fxq3oVp+LO8gmXKHSxc/pau1Y8ZDwMgE
	HYKoGf6BZS5jvRSiaK2SqYPdCseTZvDCn0T59kUVlneBMv69O5vqdcRamNTxylH8
	7WeVdAHeEMQvqbnkdjrHNdyQA/D0QU2SuOs2r1EQp/JSCgI+Ur+m8zZT5unkp7rA
	P0HR/Ouu3U06sA2IthWJhcueLlvlmXEFZhvQIYmRqRMBtIH+cjp2bAtldXnt0SKV
	hnT1B2lfEEMshOXrX8sx9wCyeYNABKxgdhg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j3nq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:19:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd00a65673so43002855ad.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779347961; x=1779952761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ecb5GJgO9w=;
        b=EIIJVXTXQsot58o68W9dQeO2/j9JBjY7scZAULu/WUh5aqGuXqTQWwO4hhcQ6kWXee
         lqmknoku/rr2xOE52dhciqJ1PNdVm29dw5u2xh3Yoo9d5Au5q662bwDEB+LD0b7wPjfL
         I+tPcXCJSXb6L6KW6DSgqZqHbSPoQv2TwfHvm4Jv3tEW/7WYzNfQpssgoZa1YTK9qOql
         VdbY7jgGYudyEaU1EXTEcBddXNTRw8dd80ARQCuTsaMVB5TGyGTXvatrfYrxi++8X1o8
         KYSkEzEuOW3DB/hXZ+KNrpYDR03xwxrLCpcVc7rl8L9TVrbiliW89WYSmTNg135j+xPE
         PFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347961; x=1779952761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN956VWUpzaipasyvgQamUM/S2X7TTAO6ecb5GJgO9w=;
        b=NuCyJEM+1V2A1DJ6A2TL7jtSQqpEYo+i0NyH7EXwOotnebYP1jXXXCHkO+ZrCYPJ3K
         lQERinxB2y9nesnKYg/nvsiGk9V2FxroIDvdwf/wTvtKDu0UIe0u8SBd7CVH02SRTRRD
         b05aqWePvwipnl91dkc2rdsVLaUQXsHGbVRxmnQdUqoM8d85zTa7oCi6NAVcZ+0MO/rd
         NWynO2tQZTHi5oo+5NGB5t8MeS7F6Hit7ZJQZ2dLU2Z36yq4xbPluwcs1nOG57yf6dPG
         9P45e8aU5WqeVVYnPsM9Me0iCq5DfBGT2I2NEano6/53H/BwWV27PVpYAih5sjlELHED
         EdEg==
X-Forwarded-Encrypted: i=1; AFNElJ9nF95CYEbitYL45F1XqeqJvinwxGzh1LnpZ5P+R7sIYUlzyijpFyC89aa+yghf4fsVEgPPAYCLa9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaf26vzXVO5RrIm/a+/M/uWEDHCEOTv2ULybSmEU36wD7Vvi3o
	UoV7nhpGQoUWcNia8H8r/rlTbmG5FgrbytbJe7penv/gC4hbmoPSxK+pag6/Tl71fQWRaszCBpJ
	/AJWTkKvkejwmV2d4yL3IMnJlWyg5Zhse1aCdLkS47VAwAJLSv6LWjyVqWwc2Mnk=
X-Gm-Gg: Acq92OGaJJsfHkNd17M8GQhrW7w0DLuuiRmh3KQXYufIn2CISyNsxSwuO8qY3Ev40Pr
	2HdzHxhVCoeCfcGAuzMmdAiFkCsp2baxyfL/lssSNRzTkzcsR33nJ0F3c/QO3sIW5lZ6p1vBA2A
	cYjjSoqEtoopDy6LAXGDuMECctUzADXL+2KRZk1sCHHU7IjWNZnJdJ3YyhU1yEsaEs/2+/+sn8A
	UZytAuZb+4k2cbMBrN7gd0ALryuYhgxHE/x3iRH+sQQsTt5LHiEbgHWDd/Nyw6r2IENQ3qxH9yX
	NCGOqqYMQkveDeVmeh5Bv9i8F2RKxxlqnNJL/MQaZjxhSn0wBKW7/xPY6z9ahH9fPI9nKrHoOSc
	/bzwhnRRBkou+x6pHRmPeUixkKUMMogSQbuzhHD4eyI73y8Qw6lVGL4V2WA==
X-Received: by 2002:a17:903:3bd0:b0:2ba:5f24:caeb with SMTP id d9443c01a7336-2bea229bfd5mr15735455ad.19.1779347961091;
        Thu, 21 May 2026 00:19:21 -0700 (PDT)
X-Received: by 2002:a17:903:3bd0:b0:2ba:5f24:caeb with SMTP id d9443c01a7336-2bea229bfd5mr15734965ad.19.1779347960462;
        Thu, 21 May 2026 00:19:20 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:ef8d:de79:6e34:4a35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98eca29sm468475ad.41.2026.05.21.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:19:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        ryder.lee@mediatek.com, jianjun.wang@mediatek.com
Cc: bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH] PCI: mediatek: Free IRQ domains while freeing Root Ports
Date: Thu, 21 May 2026 12:49:07 +0530
Message-ID: <20260521071907.13614-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0eb1f9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0GrS9vw-3MyE2OudUf0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: XFOOWTqoB37ATG7vUJbBoxYqWcHHZDFT
X-Proofpoint-ORIG-GUID: XFOOWTqoB37ATG7vUJbBoxYqWcHHZDFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2OSBTYWx0ZWRfX/o8cnIBUerx9
 NIFHlvATzQETD0UzOV/UXp4aFPARJSH030pFz7mstHEHrCFuxmhv25q4JhlhiIIpV4ag0MLH7gN
 PkUQXbAquOVYYS1O0CHTH7rnvXmoJF7ePV1Vc16FZwG+N/DyqI4LxPjLOQ4yr5sVyzrVX1rMYlD
 B9sHJNzXa0O8TdTOb/0Lq7vLIib4bklobaWPP8Iq1NGY9tfFGd0EyEX1LabFf2ogEaLAQZLDnGA
 iuPdK3oSKDIqPfpmjET60QUlPHLFY8LNH4xsseLqOWQSwo4mlUdD9y0agv+ePk2mV8Mye8e94Ac
 bD523knPeTE+Wopydk7ypZhmCCl41dfmee7miL0TuO9FStW+I+jt/KsropClcHei05ItWrueSy8
 HWBcVo58GO6A2QZQEhXvofPCwxel3fieVmISqAUx8yM2hpLfSUY0R9oEfCvWM1JC4Jbdjf3RY/r
 NQ6za5vSnjUBu9Oj/ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210069

Currently, the driver frees the IRQ domains only during driver remove().
But when mtk_pcie_enable_port() fails for some reason, the domains are
not freed. This leads to resource leakage.

Hence, free the IRQ domains inside mtk_pcie_port_free() helper which gets
called in the error path of mtk_pcie_enable_port() and also during driver
removal.

This issue was flagged by Sashiko when reviewing the EcoNet EN7528 SoC
support series.

Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pcie-mediatek.c | 35 +++++++++++---------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c503fbd774d0..c45baf681cf5 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -250,6 +250,20 @@ static void mtk_pcie_port_free(struct mtk_pcie_port *port)
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 
+	if (port->irq) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+
 	devm_iounmap(dev, port->base);
 	list_del(&port->list);
 	devm_kfree(dev, port);
@@ -531,25 +545,6 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
-{
-	struct mtk_pcie_port *port, *tmp;
-
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
-
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
-
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
-
-		irq_dispose_mapping(port->irq);
-	}
-}
-
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -1186,8 +1181,6 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	mtk_pcie_free_resources(pcie);
 
-	mtk_pcie_irq_teardown(pcie);
-
 	mtk_pcie_put_resources(pcie);
 }
 
-- 
2.51.0

