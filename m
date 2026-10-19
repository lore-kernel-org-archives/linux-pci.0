Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500C4AD7E3
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401951; cv=none; b=KLVMkb2AAdKxsuPu3ZXThGuzcW1G2fzWpBP7+F1xPHNRN/mzlClUR+pEIqaZQYgiVTslvOnFujn8zDsMg2EdKaNtmR4XCdAT9Ch8ga8HoUpv8ZC+kYzSrjvHXd+K9Uf4/KXZsH+M4CUYenfwbdIh7bQAXuDV4ZU7xZYsxJfS9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401951; c=relaxed/simple;
	bh=xu9UkqrTenBHBotGjSYb2DNRMD1vbtCWxZ556RehpDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAw20J/7WGMwMYiMqe9LidZBe1bTmYGQkGUEf3ZOJq/X1Q8cntY2lJBSWyfVWleySEOp/8AgqL18HA7mrKBZhIoWrAO9728td11uWW9fBRE4cDSeqaTHQg7ouERn+07ziuuqbQXt707F/q2ZA3Zn6/x0bgnE44/8L61hSrYuIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=panm/GZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gRsA4Ekx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="panm/GZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gRsA4Ekx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P2O6724559
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blzspiWyOtJxzBS01q7zxMZsMueapA6Q28dKLw57dFI=; b=panm/GZdbtT6x+Qi
	0ORvhI6YQoIyiuFMc8jSiphQvHTV7s7VxWMfsERz2Ru68MCpv9EZG+AAQSpSTlN0
	twDyZtGH5ADlx04kB6yHqRqS76wZ2OayJMVSGFDyuEUEw+Yfq8DvhQfDWIvxJRh/
	Of32Z3oDyPrioZ4U0lMCvTywmPkd76MdpD1M/nmuh6xFq0lPIVsSRtvksf8ya7MX
	VZr1vGjoQUNZ74Okh7eAUxg6mVFEWYpotk1ZIKL8k0Cx+LGDRN/YI2ez9yGRMv6b
	k6tesKnDDA3XQXXgeENVyFC7D7ZO8SHaDvsDzwTB4BZVptwmK4QEnqnguoNy4+bs
	so5RFg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gbrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3580c07911eso5798215eec.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401949; x=1793006749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blzspiWyOtJxzBS01q7zxMZsMueapA6Q28dKLw57dFI=;
        b=gRsA4EkxJSj+NUA9AdF3e6j6eEK7RukKyU6eZ5byJ43t+ndQ7peDDU6qnO3J2AqZ5b
         hhPYvGJOVD3A1FlBVurGlSIswOifKBlzZ7vOhrgLxJJnR8v10Jljd0n1yeyCGrUQEGNX
         to2k/n5ygGbborgjO0mQnsPSw+X4s7mM9WskGX0iHzgRVG0LfJvvBr/LluA3fAvnPgh/
         KewN5k6iY33FtK//5g7pOeYc/FArHE2WcusWCkhr/fRfLRHlair5ASXWqBgvmINllDn9
         1FA8BYhOXK1YHHfVthvIaHMZGBepX131eTPAoLd4ejGi71yfj+boZvkrJ7dzEzCqA9+K
         TDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401949; x=1793006749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blzspiWyOtJxzBS01q7zxMZsMueapA6Q28dKLw57dFI=;
        b=HYPrULmUABvd3P0Mj9Cg72CamKxxDA6MWZScrq4OEk/zShkqqB3YFhTCTEqMHeTrx3
         FFJRmWTpIQgKEz9abe3nAThDc/nWnF2FQNhZ5XSSbYNOlX4r1ikaBCkqkrDK9/Ad2E71
         pUjRDPG29BBa0aX9HQalZcra1Vb+2Dy50X3Qj8pukoAmHErl/bSvLUk0XwnP9UskcsuO
         y5e8mZZrG2AFh7wx2Qvc4FWlSZoRXrGcQro6RQhS8vJNLcJkB9IHDYbFwx66BWIQiiX4
         QQYjSqtKKdy+2qFIEqK0HoiBuDtBRbTIQGcuM4Rcv+unrUejDMCM0tMrnU4CnxdI21jm
         WJTA==
X-Forwarded-Encrypted: i=1; AKwUvBz/omhUQFrCLBOfpsYOcBJJrfE1b+jvze8UoIrPbSjqaXxO1reDuKMX4jJbCQVLtguz1LpvjeCdn9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdnEiLn4SHmOABQXku0MhZFWwWc6Z6xvpvY6a5D326hui5HMf/
	02IHZkbsSxuDF0GdQqIp6vVTv8u/Y2dtTrmHLRv0ljhaqmAMwL9NyI+lLU5+7FETOsYiJDoaZfw
	wsLZ9pxUhRoMx1qFkocgCRAt4+lMzLCf704bZgNQAJS9+nDPSYUuAfjuhynIXEPc=
X-Gm-Gg: AYBFou0qrvGBBURnmmEV8gchV71skDRRZji6NC92RrCy9G2Vt3hDeqbNcUSTH8deu+Z
	zXAEl4gsGeg7BeNAcxM7r52qcsbv0Unw9bvriiNKygYvCKj0KAfIqXPrbsg/liIg/a+igW5vTA8
	oC5NwFpfK78s8PZH4seDDS3WPwfuCkxQ9SiHrMjdMMuE/dEN0Gp4ZkBzidSGW1mZtmMH6t/KSMG
	UVOlOaZJd/sNM2e2pobIOGDUurIsb+kazYM90XyesmTFf/goWM4LyedgwDv16gvgOu9pyH2tdbY
	gGI1ZFMCdD0lKPkyYIWUXGXb4ny9ll4Yy2SQYAgEuqzOo9d4nQxsJrkrQWg+sOJLBRnPfUobuYj
	K1jEtmJXSqtdO1z9/crPFduUve71YagkaOQ==
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr10057393c88.40.1792401949048;
        Mon, 19 Oct 2026 02:25:49 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr10057348c88.40.1792401948485;
        Mon, 19 Oct 2026 02:25:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm26682584c88.21.2026.10.19.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:25:48 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:55:12 +0530
Subject: [PATCH v2 4/6] PCI: qcom-ep: Set initial interconnect bandwidth
 before enabling clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-monaco_ep-v2-4-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
In-Reply-To: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792401919; l=2784;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xu9UkqrTenBHBotGjSYb2DNRMD1vbtCWxZ556RehpDM=;
 b=PJQxjMnSel094yAn0e2lWNVF+PVM4h9M+bWwd/TcwqwOIgza0IZsozs407okf5hOHc2m5QVTq
 rV8A4Jq3L9sBZ5LDiJkc5QhbetIdnX1TnEWATH7F1iFnRrSPRMs/+hw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX45NO/l0AF5vv
 3jcH3KaTjEPPpkX21muT97i9H3qSxTnWPMxp/9qfP/lO+9i9jhXWQK63zH78ib+bL2OHN9icWsk
 YJbCXnr5ILmcrsQqhiZpKfIaQh9ZJw0=
X-Proofpoint-ORIG-GUID: aFQ3ypeQBYcr1piJqfAoigvyNePBVKfM
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5e21d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXyE9+bK9UGC4+
 9B7+FCqKCZNssUzD8S/frV4fSsZBjbSiBkkHgP5oplwzy5ru07Ts/OqNdgAT+WqnLaZsJ79xPcj
 /Ma5zdPEAQnokAjmlCkBM2KwVidEne4vWDF8uF8l1Osq+016ZtSDHuZPK9EzLCmJkPEJ9OrZrPT
 fNFcjuO/K9Kfdptma43T3OyvLilO97DYL18C6nE0mBIPSQFGo6Ya+DsceoGzOpNzPhKLRuuQAwz
 dyOEWm+AicGaXxxFXCQtC0FnhfZYXIgc836jPxR31X4F5dZ075r8jo5qQReP4zQ2/m8URyVyJEJ
 nnrYzB/8b+VNLFqJQZeYEFiERXOtqo6kT6xdsCq0lhmNZPJOwU8XlR8okEkN6M5B3lsEa4hCzbn
 zb1CTaEcvz7UbtczdX3GVpuUSiVS8yw2F6eOU/CSrnTEf7qFQyWOsj57waTcrQ3QWTGI0gaGoZS
 6XukUP2ewuLCy0KfXiQ==
X-Proofpoint-GUID: aFQ3ypeQBYcr1piJqfAoigvyNePBVKfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

Some Qualcomm platforms require the interconnect bandwidth constraints
to be set before enabling the interconnect clocks, otherwise some
clocks get stuck in the off state.

Move the icc_set_bw() call before clk_bulk_prepare_enable() so the
bandwidth vote is in place first.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e6..6b5eaee84f8b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -331,9 +331,23 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	struct dw_pcie *pci = &pcie_ep->pci;
 	int ret;
 
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
+	 * for the pcie-mem path.
+	 */
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
-		return ret;
+		goto err_disable_icc;
 
 	ret = qcom_pcie_ep_core_reset(pcie_ep);
 	if (ret)
@@ -351,28 +365,14 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
-	/*
-	 * Some Qualcomm platforms require interconnect bandwidth constraints
-	 * to be set before enabling interconnect clocks.
-	 *
-	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
-	 * for the pcie-mem path.
-	 */
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-		goto err_phy_off;
-	}
-
 	return 0;
 
-err_phy_off:
-	phy_power_off(pcie_ep->phy);
 err_phy_exit:
 	phy_exit(pcie_ep->phy);
 err_disable_clk:
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+err_disable_icc:
+	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 
 	return ret;
 }
@@ -387,10 +387,10 @@ static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
 		return;
 
-	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 	phy_power_off(pcie_ep->phy);
 	phy_exit(pcie_ep->phy);
 	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 }
 
 static int qcom_pcie_perst_deassert(struct dw_pcie *pci)

-- 
2.34.1

