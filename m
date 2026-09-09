Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FD550DCB
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956693; cv=none; b=KcEewH/qus6mu/MgS41sia4hhx12gfQUMgk+SlDFOrABzBzW+mr5HaSNpOA8LMpXnkr32XNAKO8qbvkJBAGs53xmjAKeM0ayqWQiOtFVZFvnNvTLdxpdkNfKrjfWKxB2bzjZ27LE5bIf15MIM9LP2EG8HEx9HUL2RpRaMX7qH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956693; c=relaxed/simple;
	bh=Q1bgAN9nlbCB/Ai0JWq2rOD7P4Zydq1395QADVMDquM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEg4drbtv2CsT4sEuWlgc/UQ5R4TzKtHJYr/d+EMVBpiEBSrd4W+3L4q57PD3LsAmQLbFejbIwnGSJh0yVxqL+vFf2hIjttekGhF4s1HAR+rRAOj9PBAl4xol2ORvO6yU8L4vZw6MmVTkoluHJ1zvCzre2zVn25NEYhJsRU1QNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9o5Nmr1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QhW+SNHE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9o5Nmr1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QhW+SNHE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU3511810065
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3RTr8hgVt/wHL1o1+VAPRppq9VVHXaQ5GvXArkG/BdQ=; b=f9o5Nmr1JaZj+UpB
	xCMUO+wIwlMr15MNWJzcDBC6NzQiXVEoYlXrNIrx8EbKfxB8u6cLivMGPN9tZsu7
	8Qpd4nKZdR2sCPXR9iKvVytUlDHwRf2tk7fBKtkii/G0SBRI2sGGtET3Hcu/EFws
	1dUT99j/JVFwxSDmzgmttirD4BT0CjeiznCc7X3QHuctMQTcqeOC5Di3oOamYW2g
	TUq+yx2li9wCghpYXPqWUxk2lk5WS/8GtCNw0pMDNUpy/dp3N7sS6HjMuRCZhVce
	/OhWgNe6ajDsCzmtgIcK3P8qfUzutks3ICQ3vtFBt/OMpuXc4SO38AdpIBCvQj2f
	solj0w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj0m0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:24:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39af92138f9so9034622a91.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788956689; x=1789561489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RTr8hgVt/wHL1o1+VAPRppq9VVHXaQ5GvXArkG/BdQ=;
        b=QhW+SNHEg8FHC5lzXpYg0UBq22b4zYYtnfz0iDmvtHavBVzhFMvkPHAA9e8jC9EAJi
         mlO/u2T+J84PW3KyLuASS2Tt+i4YtsOcAJ7YsVevnBvyUnGj+vTVLuUl7jWNvQFQYSg7
         jL9HsJ94LoXXjKLVs/UydLdfzVxx2lUpz9yX4Bx1RSU6+cLVbzGoWdFMkFeUVlgIAdz+
         LtaPRI9hohikf95iT1q1pfKCelVTd0pupuUrzLUyFEEgvYg/j2lm2XqZK99AmW+L9FNZ
         EjDjA1kIlNdLIFcepfUrFaU5A3YEbaHr0n8gRrXfq0kW5b12ds8JJLghB62IY8zc5OM7
         J1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956689; x=1789561489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RTr8hgVt/wHL1o1+VAPRppq9VVHXaQ5GvXArkG/BdQ=;
        b=DZoldl/t96OD1b5wKPoRQetFUctk/G8Q6iekqNG1L19IlQpgo4UaL041b/VlCNzfqz
         kAyMwfrDpT8c5VDwKWhy+7HLAt288W1A8i0+aokN3y9G4PkYjgJLeD7HehCYuDk7GjLx
         vU/HQzNCasti9kUoZXBKbJ9WRUIIMvenPsEFS13JDckCyV7y06itcdui9hCfxM2x3cQ6
         3VcjXZ12fk6uCn01D99jg6HFLNadwZWoEcu6e5mm5DuIQo88F1MPfT0cp5mC6iNQEJ1t
         kuN/dN5cMIDEtq/EF5jyd/kwkbrvQKzcOzxSKtmCrRF2grWEoEU+wAv00l5eqHbKubKu
         tZXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzv7XCnlWpnCtmS/UAwBygimgU4++Ccy+m1qflyrAjyFY7vef40OeAB+/QyHa8vwkecJjOK21hWfIA=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Q4YRR8OQ1UKhPF+KCbAb5DRGh00nMjmIg+CAS+vFD4/+POL8
	UPvt46hv7A4LeqKxBlqWvzZmesUDGt224Y2qdYNUYs3XQ1kgjGZRWl32+KjfHNSGfeJkysHFrrP
	TOApD+elbrETTHj80YRWeNK7vNHRA4AH3L/8/lXnEaY25aL47gsoFMQfze6+0hQA=
X-Gm-Gg: AYBFou04JiHpUIHZuhNo+a4hqDSyILOxzKtow3iLRnxLxhPD8vGl3QUh85cEW4kCGjJ
	0/EEc1yUz9EWowyEI40rPJwAAiuXVzio/Jzt68wPMBoDMUM0o5k1k3BFZiTPy/fTevXl3U8gwp3
	atmUe3Ta85RgK9SQTWgFz4bFM8VGy7ZbNEcO0LOYTNGFvKif1V6AzeehpDLut6F4kWZn4uHh0K7
	3IpLtGFjqBn5JWIaue2Kz2gzSKFWtGWR66b36HwIJK0qXbmwyli1VE3kbiAddFmnraEwDiZ7+Rb
	8gpTgF7CpLeSoGomNWQNx9Wo7bfLHwu8T4/rnvYOqjzFPQqsgwxTipebElezpfpcDHjCtDBk38R
	KcQ+WrZbZ+23fuPvFq9nVIocYflDdCzpTyZw=
X-Received: by 2002:a17:90b:2542:b0:398:9beb:a2be with SMTP id 98e67ed59e1d1-39b08969b5dmr45313495a91.32.1788956689124;
        Wed, 09 Sep 2026 05:24:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2542:b0:398:9beb:a2be with SMTP id 98e67ed59e1d1-39b08969b5dmr45313453a91.32.1788956688582;
        Wed, 09 Sep 2026 05:24:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm69372775c88.4.2026.09.09.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:24:48 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 17:54:29 +0530
Subject: [PATCH v6 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-shutdown-v6-2-62b7bd123236@oss.qualcomm.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
In-Reply-To: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788956676; l=7334;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Q1bgAN9nlbCB/Ai0JWq2rOD7P4Zydq1395QADVMDquM=;
 b=wlf+LcxzvGI+mmNHXWQXvz0Di5Yi7U6OvbrXaidzC5nGGEvGnIZHnzDnW5VEAtc/bkngL/9Vt
 /b20sJyTMJFBlHrPv7gJqAF/mOLVxW1GPdcWWVcjVb81lbcmlYCw71p
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzOCBTYWx0ZWRfX6VeUvq8kCVt6
 yezqGFnPttr1eAi8+8vYZb4avzTazR4b7qfNp/RDx0GejF9yZ83YgSspmECIEpIl6+CL6fYStqe
 tSrYS5w/WPhaEg/Imt3URHYEWAopRsc=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa15012 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=65BtJ55OYu5Af-7Sg50A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 5Hxz99VX9TKTfvgndDS7LUCjvc7zaPm9
X-Proofpoint-GUID: 5Hxz99VX9TKTfvgndDS7LUCjvc7zaPm9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzOCBTYWx0ZWRfX2+/S7yYcfZaw
 /+9B2t7SEWt4rs61bl4tHjpIoKRmtdZ/0pOA21LowBO5jpZHomkIOTTNBtOL2PlBo2u6YuPyPOB
 VCslJmit6P31ic/yFDcoVTQq9lrPYXa02eLQtet5C3rByO5g4PrJd/7sp+o1qvngum8OCtRiAiv
 fgTH7N8OzZaKDbiZTXbUXlqDu5dVwwJvuN5xrYQ3Cl8o6GeP/neb4OIE2UKUptgsUjKAI0JyMks
 0RFuL/z2iFX1O6WJqEBDQcPj0ZYA8WktM19l3A8Ogz4x+7beU1MyAMPtt+c2KG6b5nTV98Ie8dP
 w6RjFNcDNUc6pf6vYOHqg4SUH2EEIvaE9gaCXy56aFeDGR6Nh6b1mrP+REtul60yyN5Q8XCA07I
 z2QHpncI38SSstlif1OFBs6D/6YKOW3oegxImLOog2c/MIu/nJmLyMA7KfkPERQAWBxE5/qOhP1
 NE9Oy0QKro4Dkn/0zWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090138

dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
to check whether every downstream endpoint can be put into D3cold before
bothering to move the link to L2. If no endpoint supports it, the
function returns early and leaves the link up.

Querying D3cold support during shutdown is actively harmful, not just
slow: pci_host_common_d3cold_possible() requires every active endpoint
to already be in PCI_D3hot, and returns false otherwise. If any endpoint
is still in D0 -- which is common, since endpoint drivers aren't
guaranteed to have suspended by the time the host's shutdown path runs
the check fails and dw_pcie_suspend_noirq() returns early without ever
moving the link to L2, leaving it up right up to the point where the
system cuts power/clocks to the controller.

Add a force parameter to dw_pcie_suspend_noirq() that callers set
explicitly to force this behavior, still call
pci_host_common_d3cold_possible() unconditionally, since it's also how
pme_capable gets set, but ignore its return value and force L2 entry
regardless when force is set.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
 drivers/pci/controller/dwc/pci-layerscape.c       | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++---
 drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
 drivers/pci/controller/dwc/pcie-eswin.c           | 2 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c        | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 2 +-
 drivers/pci/controller/dwc/pcie-stm32.c           | 2 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c       | 2 +-
 9 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4105c28d180c..63799b1c2013 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1738,7 +1738,7 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		imx_pcie_assert_perst(imx_pcie, true);
 		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	} else {
-		return dw_pcie_suspend_noirq(imx_pcie->pci);
+		return dw_pcie_suspend_noirq(imx_pcie->pci, false);
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..aca1b0acb4ed 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -382,7 +382,7 @@ static int ls_pcie_suspend_noirq(struct device *dev)
 	if (!pcie->drvdata->pm_support)
 		return 0;
 
-	return dw_pcie_suspend_noirq(pcie->pci);
+	return dw_pcie_suspend_noirq(pcie->pci, false);
 }
 
 static int ls_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d7..21830c05d147 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1222,16 +1222,17 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	return 0;
 }
 
-int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
 {
-	bool pme_capable = false;
+	bool d3cold_possible, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	d3cold_possible = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	if (!d3cold_possible && !force)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a53ac27cd244..cec1c64c3a5e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -860,7 +860,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
 
 #ifdef CONFIG_PCIE_DW_HOST
-int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
 void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
@@ -873,7 +873,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
-static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..06fc488f80c7 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -367,7 +367,7 @@ static int eswin_pcie_suspend_noirq(struct device *dev)
 {
 	struct eswin_pcie *pcie = dev_get_drvdata(dev);
 
-	return dw_pcie_suspend_noirq(&pcie->pci);
+	return dw_pcie_suspend_noirq(&pcie->pci, false);
 }
 
 static int eswin_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index 31e1169b8ab6..43174a06c60a 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -365,7 +365,7 @@ static int s32g_pcie_suspend_noirq(struct device *dev)
 	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
 	struct dw_pcie *pci = &s32g_pp->pci;
 
-	return dw_pcie_suspend_noirq(pci);
+	return dw_pcie_suspend_noirq(pci, false);
 }
 
 static int s32g_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ee63a6ec99de..2693a98d0b27 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2421,7 +2421,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	if (!pcie)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pcie->pci);
+	ret = dw_pcie_suspend_noirq(pcie->pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 349618ea5b9c..7b3a8c1b04a4 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -78,7 +78,7 @@ static int stm32_pcie_suspend_noirq(struct device *dev)
 	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
 	int ret;
 
-	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci);
+	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 51e89180490d..cb2781a1557f 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -187,7 +187,7 @@ static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 	if (pci->suspended)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pci);
+	ret = dw_pcie_suspend_noirq(pci, false);
 	if (ret)
 		return ret;
 

-- 
2.34.1

