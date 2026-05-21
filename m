Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0B3DA5A8
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368238; cv=none; b=NIt+QNb8DgKZpl5HBYzuF2WWyxAPyiVeq/eVvDYjo53rnXnfQoLmku7CRLA8R6NTbRQExwM8TAMp6tfG+iBumbHvOgnNAeQBFo0TjDxwTbf42z+fphQ1bmQV8jGszvexBufTnh5Gy9LfIBuQ6yqKVbvHBlIwyEFwQTq6jZgkDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368238; c=relaxed/simple;
	bh=3+5T4Qn4tm+vkgG27Np4c/MlLk3lVda8ilgq3YiaXT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KN9tH7xrYdYCiNSuOD1jTvxVpgBjgq0cLikWJSeUh35wQm0HwkK/+9ORj6wJ10b8ipq3Lecnd1I+xYIvZfcWSHlsH9g9fxbVMj9RApNtJQPfQoNH96xTNZ4rLDUkwjLMx1PnZLaqNnJfKVSTG3T8vrGlZLpddky+jeb7hp5hUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2AOAR9a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3tSfkFP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2AOAR9a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3tSfkFP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99nd93118535
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vomIflt1wBG93ej2ALoqD+yPyz13mCFS7oAgFK8rkBc=; b=k2AOAR9aiIov6Tn1
	20C5o+2oPbbl++DKVtBEnYhQIANntx4M+F0010GNxztWGtV3ne4uvoz6lbOlZCC5
	UXEsDvdPX+whUTAjO+T1yqyaWtFQZBjNTqRjoVIZ5RxXMhulXKgdqNPhHpmIZkNk
	PDiKB/c1vD7kTljqwoWDURS+Dq/SoG5Ml8Ne50g8b6azEqmy0uPxnoO7d0QUD4zA
	wn1FPlpMC1Om33ZsO5I4JBCsB/GrlIFwsebIH92pGvnhea7Di1Tj1TtzxX9IdSKu
	zKNN4FzT6gsxWg+7B7uyqKlYw++Br7xyDO9nK/q/Y6kAtKHaNadZJbgQjbtNrtBI
	InNT1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962ga7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso9639198a12.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368234; x=1779973034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vomIflt1wBG93ej2ALoqD+yPyz13mCFS7oAgFK8rkBc=;
        b=g3tSfkFP0+U6DLIPHnBfuUci+J2KdAarZM59igY0AeJpcpOme9IRiztbm1qgdsNCtd
         DS+FvSkXH7SWQdl47P8X/NZ+PbQYm8e3DcuOO5dQtbO5f4U+AriFshHgduEJtaZ5CbOi
         epQk6VRG0rvclx6dU2POcEIEJv0WLFcsVVgYL8HUs+uv4YIRldJEtexCrpsXDJDAaBzr
         TYe+sTUTcto00KLp89Tr20fdq0kpcSLhaXNZTmJFaPfo06j4X7KvNud0HW4ivFIBsRl0
         H+KWxVf3/4s2ni98slb02ZsYL4sNwP1ECl5QCD+OMQqnKBJocNFnPgE5y3XniB5rG1DX
         zsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368234; x=1779973034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vomIflt1wBG93ej2ALoqD+yPyz13mCFS7oAgFK8rkBc=;
        b=TpLYNRdmm6kBh9T2ngYmgVf4QNOVaGUwjEjEuVvhERlh30T8GFBxSQoUx7nCuWNrBM
         tnvJIK15V28nm7DasrvB4OMIU1CphHldGK/v6ehZwv7dc1nXST0C/Ynr6P/Q0okSlBTQ
         zDzN2mG5MNKr6DU34aa+gNR1UtqyjWGI3PLfRiOisGp8QUEGEFWoKBiIidILgj6pfYbG
         ntwSWI78rU9D7ZqUSzPZcuiv5oz9mhRQs7Nv7aTFrg2oqhDab0996FAchtHYgCO55/LR
         QMdsN4V9adG/8zLqRT4ph64c4vheOTmQEb1vbyOfhAwXxG7UJ32dFfeJUHkdVQ/4S4yH
         wyjg==
X-Forwarded-Encrypted: i=1; AFNElJ/axHNmajmmVx/Dol4vuDUzLBM2Tx3AEaShW9b8E6xCSzOMAEGg9YXOJz5Rb4iQl3boCxtD7HamUHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBclVFFB6shjP7wFSDIt27NNa4ubZkywEx5H911JzskNPA7l+9
	fZAukH+q/fx6tdqKXqYYvwDf0R+C/ODBSGNuBfjnAJP6zw8ZlIp8MhRZa/1AW6OXWkQ+6UrVsyo
	qoyEAHyuldqmXJxxM8chbb9dBy5W7G2OL57mfVhWkgnYSpK5pJ7T7GQaa+xeJ7ts=
X-Gm-Gg: Acq92OHnQWrrjrbeSeCl7SZjalzqK/TM9w3Dw+ooZCAph4ao09pYB4ri22A9JQAco8a
	5MKn5ZLMCftKbhAArp2+hWPkBl8hs0X/3rzkAQ5wlz3DDG1RNqkm8yBWXDlC/lHK2xaL5ysi50Z
	c6zPoJda3nntH8tujRG7ZrZZN9YF8Pi9LoHjFqlRHm5MD5vX5Px9O+KkMWAB4iaq9mAcX5qemcw
	sJ4VyQce/RWkPYuTvRqoMDC6wPwxjHhz+DhbfluaCqeEdKViBBbYMnHz+izHNHTY/CVXSWEsEoS
	ilwUlUZl7Pp9DXJFna5dM+bZ6r+cnh4tV+aEYAs31dk3pCVMLioY5U0HyExMJKzZDgAdrxEnuyy
	9iHYPFAbLrP1YT0R+0uNSlbSLL/Bk7ta8hELMEf35/mLGAQn7MMiR0rrS
X-Received: by 2002:a05:6a21:6d83:b0:3aa:c9d8:d795 with SMTP id adf61e73a8af0-3b308555272mr3380173637.10.1779368233987;
        Thu, 21 May 2026 05:57:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d83:b0:3aa:c9d8:d795 with SMTP id adf61e73a8af0-3b308555272mr3380129637.10.1779368233408;
        Thu, 21 May 2026 05:57:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85198f508bsm357984a12.20.2026.05.21.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:57:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:26:35 +0530
Subject: [PATCH v2 3/4] PCI: qcom: Add link retention support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-link_retain-v2-3-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
In-Reply-To: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779368212; l=5792;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=3+5T4Qn4tm+vkgG27Np4c/MlLk3lVda8ilgq3YiaXT0=;
 b=3taxAhZvMHj6pmSnpng1cabvfhu1DN5TaebBCIxL9G67b0eO3II2ZzCt1hbB8rPsKQH/Xqv5J
 v0ME8HLCAcJCIWHybvoY2p6aRktajyUrl6JsQrI113udMooaQL1R0V+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: MKMBED6MhQS4LQtRVG6dRf9knfKHEKqS
X-Proofpoint-GUID: MKMBED6MhQS4LQtRVG6dRf9knfKHEKqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMCBTYWx0ZWRfXwccf/rraQeQW
 spOxuWhDRvh3DQJQW+EVcu7DMyunWGD4fMEwwli5kAL9Ax/EVjHfmIeDOMPeVeK9BImdmx2YJ7Q
 IpGmZj+Q8KRRizRglXsAJkeYrVKRueIvY30z5blK/Cspx9utHHVk2ROF8jS8p/nA4B11mp4A1UU
 /vZryMMx16php7FX99JfTRzBluGbVFcTz+JU0Sr5iKTuH5wipzo6l8xzlnkmOXbDua0l3BQ4IDZ
 yhj5ccJe9hXQXBMmqwBzeZzGKQS7U0bDXr8MrL1oNC0mQmnWvSDNmK//eB56QwxitFqxAiTFakf
 X7f11HWqcldstPt/r2avrZAqBhoWb+AWbnKboykz0MHJwVuOcjG7KO65J2N+MWh44zNIZzZLoCh
 8lDDCoOsuklvr5UseouvH5jKss/v86TNk2BDsv8dTgCXQGUAqiRF+YZkk25OxlA+PA2aGURBlq+
 Lzz7GvF85XXDcvQqdzw==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f012b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210130

Some platforms keep the PCIe link active across bootloader and kernel
handoff. Reinitializing the controller and toggling PERST# in such cases is
unnecessary when the driver does not need to retrain the link.

Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to indicate when
link retention is supported. During initialization, check the LTSSM state;
if the link is already in L0 or L1 idle and LTSSM is enabled, set
link_retain and skip controller reset, PERST# toggling, and other post-
init steps.

If the current link speed or lane width does not satisfy the constraints
specified by max-link-speed or num-lanes in the device tree, fall back to
normal initialization and retrain the link instead of retaining it.

Configure the DBI and ATU base addresses in the retention path, since the
bootloader may use different base addresses than those provided by the
device tree.

Also fix the -EPROBE_DEFER error handling path to return 0 instead of
propagating the error, avoiding unnecessary cleanup when probe deferral is
requested.

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 62 +++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3e69ef60165b..be6c4abf31e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -450,6 +450,7 @@ struct dw_pcie_rp {
 	bool			ecam_enabled;
 	bool			native_ecam;
 	bool                    skip_l23_ready;
+	bool			link_retain;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index bfe873cbf44f..b061eaa227b3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -253,12 +253,14 @@ struct qcom_pcie_ops {
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
   * @firmware_managed: Set if the Root Complex is firmware managed
+  * @link_retain: Set if controller supports retaining link from bootloader
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool link_retain;
 };
 
 struct qcom_pcie_perst {
@@ -960,6 +962,42 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+/*
+ * Determine whether the link established by the bootloader can be reused.
+ *
+ * Reuse the existing link only if its current speed and lane count match
+ * the max-link-speed and num-lanes specified in Device Tree; otherwise,
+ * retrain the link.
+ */
+static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
+{
+	u32 cap, speed, val, ltssm, width;
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	ltssm = val & 0x1f;
+	if ((val & LTSSM_EN) &&
+	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
+		qcom_pcie_configure_dbi_atu_base(pcie);
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
+		width = dw_pcie_link_get_max_link_width(pci);
+
+		if (pci->max_link_speed > 0 && speed > pci->max_link_speed)
+			return false;
+
+		if (pci->num_lanes > 0 && width > pci->num_lanes)
+			return false;
+
+		return true;
+	}
+
+	return false;
+}
+
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -978,6 +1016,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		goto err_disable_regulators;
 
+	if (pcie->cfg->link_retain) {
+		pci->pp.link_retain = qcom_pcie_check_link_retain(pcie);
+		if (pci->pp.link_retain) {
+			dev_info(dev, "Retaining PCIe link\n");
+			return 0;
+		}
+	}
+
 	ret = reset_control_assert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset assert failed (%d)\n", ret);
@@ -1038,6 +1084,9 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
 
+	if (pcie->pci->pp.link_retain)
+		return 0;
+
 	if (pcie_cfg->override_no_snoop)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
@@ -1294,12 +1343,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_pcie_perst_assert(pcie);
-
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
 		return ret;
 
+	if (!pp->link_retain)
+		qcom_pcie_perst_assert(pcie);
+
 	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;
@@ -1322,7 +1372,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
 	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
-	qcom_pcie_perst_deassert(pcie);
+	if (!pp->link_retain)
+		qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
@@ -1337,8 +1388,9 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_pwrctrl_power_off:
 	pci_pwrctrl_power_off_devices(pci->dev);
 err_pwrctrl_destroy:
-	if (ret != -EPROBE_DEFER)
-		pci_pwrctrl_destroy_devices(pci->dev);
+	if (pp->link_retain && ret == -EPROBE_DEFER)
+		return 0;
+	pci_pwrctrl_destroy_devices(pci->dev);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:

-- 
2.34.1

