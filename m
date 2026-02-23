Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C435DD1C
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845657; cv=none; b=UsjUmIzeabPJHai8xANfSs/ozAiXNdAjy4pfwCS5z0nRnCzLTh5FzN3XtwtofoMEvcndRvL4GqYv+3RPD6+27LwpfRs61xAsArBzcNxO8jZLae1dxaCrFpfOpaw6D6ivs/cxmMJm3fNbtwpF3LmIn5J9NXsNoeXWqmAAv6kX38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845657; c=relaxed/simple;
	bh=USOtUqoO0pBSXaqNzhOk6NTS6nVdSU0vA+aMkk6Ry0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PK7R8CNSUjV95zMDBnsoBQ25KL9PC8LaqDpROpbGUE11aD2PUjXIL2OmM6uuv68RhHP2Vdx9JF4MZRxwLYmo2gZD45yTdE9QNS7Hzle19WdWExeW5LdS3rY8uRognk1mDWdVlNNN26TvM46FZj9M4tKZREhyaPhVRW9hg+3irvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QaYVxQCE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hv32Uw1l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QaYVxQCE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hv32Uw1l"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAWDCc3732694
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zii6CigRbD5HDl5umrJGDYGIgq6jxY4yjDjqN07MxHc=; b=QaYVxQCE97aD5NgI
	oiJstlNa0F3GT7XjJpJeMvCg/hdJ5lWwt6JXm28paTe82cawR6y8u0r/n1x+z30L
	ZqSIJJDaJnpB9LS1UHGOYq8cM20mMLmlW6NO80/ixC0rBG03U/RvF2K4zUH6Rjgq
	MMELVzdDD2Hdw5UEI9a1BXbnktDFcNV7g3QgwrqjUVWuCmXPNRMEvO4s+NlpZpuF
	eiYALPG+oYvL4Tpa91Xv6u5vBbf1dwXR+7jr4DcS1BmemmaipKiavtpxAJiIX/xg
	ZFruflaLuShRLNssywJ9iLCwRQKJkC/ehBLi8RHFN+SqXINS6mGRbKcfybljNtTU
	Wv+RXQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn7t84m6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8243a06b397so1919071b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771845655; x=1772450455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zii6CigRbD5HDl5umrJGDYGIgq6jxY4yjDjqN07MxHc=;
        b=Hv32Uw1l7UyFOC1WW+ZNIPag/BZbGxn8/8SW5YuOfaarx0QhPH8ZY4mEayPqYKfnQB
         Zv0ngFB9gj3ff7J4Kgh+sKwOGLnTLtpraVZKvWO6G0SR6sSiLUUWckLDlYhPCYJiixBH
         ebwaTfubS2zH01MWKI3IPbCrA8LAUyCG8+ATlWZKaLxdJ6I0N9aE7bINtZWK7BlrjjE/
         MQrNahdQ85jeRTC6dObN5VNLxWOTVXmLXB17uQIQdg3oiTikZarWTYaRIRbyZ1VkBqM8
         1cJV/nGeO7PVtBB2C6id+aoPnNrr1k4AKAsmTW6z7RzuDgfVss2jkVdUzg8tKjE5atdv
         u/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845655; x=1772450455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zii6CigRbD5HDl5umrJGDYGIgq6jxY4yjDjqN07MxHc=;
        b=BIV/R0RNUIGFm0ZHcCOx+rRY8q0l33KqJuPGruKayiC1io7W3EQy6fGN+e3y3S1pmB
         FgMhw9xjNHY3iifTOixDRLq/s3O4BwMhDjLN8lvY3OajsLAdb54meGyJBn0onqr3DkoD
         8VyHjcXYfA7EGLQ3X9A8XqmI3tchlUTtsK4ml3gSsxUD8owdz06ayfh5Br+J5+zHC2if
         /19tbJz48D1cxi3cqJaSDOpcIolkfnr1Zeb13RRdtwl1MZxfNRtLxoFevgCd8G1NZMFW
         m4XoQoQm1Vm1Lr/E+v50oa52UyOUboEOaXlqz4ZcYtlZoMYje+4NzdbL2G+PJf0E8sV+
         rk8A==
X-Gm-Message-State: AOJu0YyWB/wAFYt6LRhIciWvm5LYhe7M9Jkj+ap0ZVRxvt/1c7OL4ZBb
	oVNZNnpsKy8d66JCzuyEb4gDC4Z/T5T139UGV6qz336UV5EMy8phgcfrr+IBAotruxHMJyYyGQI
	pD9QkdgQQfETvxINniPYcIUsCAl8VXTSCHEDbV4VAN5u6vczgEm9rDnaEYwGwqkLNwpLCMfY=
X-Gm-Gg: AZuq6aJwZAgcsrQnCPi6RGno5rV/eQNDH6gWqr2BPzQxmddXc96y+FetOx4DtCW2YGa
	CiVyS5ZNQrVbeg49me7NwhBL4ImG4WP8zkFQqahpIrzX9wXq1wx0D6kNK/+T6MYDlDepyPckyF6
	CiH1AbwRuu37vqGlR34goBpTPxLOmo3CRVC5Wv3QxM3Rr1D/m1sOnBMc9aEtc0YIiO5sUnuh/xV
	ZlpVFbATnWd3GogIr6WPm1rpq4D8W6i954Lnzmp1le01Q+FduUWscfawapUvrSXWZeBOEpwSy2b
	H9GFp1xqwyNBwDjMwFjkgXHnghsiOsBRMWWXpcCwxnEXv9VBtKnfmmjY+riDzjt4VDdrzWCv6yn
	skfp4aLa5j5Kk9sI3VT4hNlNcQru4FGNwjgiP7JBBuDoyffvdmaKg4JH2
X-Received: by 2002:a05:6a00:148b:b0:824:cc05:ce88 with SMTP id d2e1a72fcca58-826da9f164amr7590952b3a.30.1771845654613;
        Mon, 23 Feb 2026 03:20:54 -0800 (PST)
X-Received: by 2002:a05:6a00:148b:b0:824:cc05:ce88 with SMTP id d2e1a72fcca58-826da9f164amr7590923b3a.30.1771845654131;
        Mon, 23 Feb 2026 03:20:54 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd899386sm6744057b3a.43.2026.02.23.03.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:20:53 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:43:32 +0530
Subject: [PATCH v2 3/3] PCI: qcom: Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-t_power_on_fux-v2-3-20c921262709@oss.qualcomm.com>
References: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
In-Reply-To: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845636; l=2371;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=USOtUqoO0pBSXaqNzhOk6NTS6nVdSU0vA+aMkk6Ry0A=;
 b=3Jc7Bc5o1Onuvgwj6TkaG0/UEWyM+HUbCbIX6omxJKs6M7Zhr1gmGVFlKmgLpXr4r1aW9ZX1o
 KMQRvDJdxN3B/S/Potiib7P2t+yWhIDRucfMU6ST59uzRoLDfsElsQy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=c5OmgB9l c=1 sm=1 tr=0 ts=699c3817 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wXczfBY3881IDOTkNB0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: TwCVpcAwUINuZELC4dA4Avmua9keUUOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX5owIKPeXap91
 yP+ASJEGL4aYAq1zzNeYkuz+Zh/ohn3FBwkXh732tAZ/GhG6fCQJG4v9g/bJYLOyVsj+gX9VAGY
 O+jiUiQ7zM+iPl24dJ0goOv81y0e456SB2H1KgPXGjh9Y3V8C+lO1kb4nPmvHlsDzmFmPqCZEUW
 Tjy/CP1AKU5kw6SATAWBe+iLhXs8G3Oj41B1MCLs8Rb7i1BHK/Y1t0lxRbHuGCQCfGSokV2Zl8C
 8xwksLKb6fRUT3ou/e3Noh35XxURveZ4QRxjVacLTsbNaOPq+a6qDPrmDVAJliPPkT3cJakSx9Z
 yd2PvhdWMUF0Rkc/zlQvrIB8ylTvjz0d54aYEtaNn2WDDAVC4hM/XVywuk345wQi+x6q1fGCfPR
 xXdO0Whv45vLq6gTEo7xQvX4SrEF2wczUDujsiAYpdGsWMi9SuUby5md8CxDpaIZKF1aRp3lRrx
 UlNR2m7pae1JaXrF3lA==
X-Proofpoint-ORIG-GUID: TwCVpcAwUINuZELC4dA4Avmua9keUUOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230097

Some platforms have incorrect T_POWER_ON value programmed in hardware.
Generally these will be corrected by bootloaders, but not all targets
support bootloaders to program correct values due to that
LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
can result in improper L1.2 exit behavior and can trigger AER's.

Parse "t-power-on-us" property from each root port node and program them
as part of host initialization using dw_pcie_program_t_power_on() before
link training.

This property in added to the dtschema here[1].

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..489ed64c1df0fa3ed9f6b0d4c3e0bb65cfc3308e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -269,6 +269,7 @@ struct qcom_pcie_perst {
 struct qcom_pcie_port {
 	struct list_head list;
 	struct phy *phy;
+	u32 t_power_on;
 	struct list_head perst;
 };
 
@@ -1283,6 +1284,16 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_configure_ports(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	list_for_each_entry(port, &pcie->ports, list)
+		dw_pcie_program_t_power_on(pcie->pci, port->t_power_on);
+
+	return 0;
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1317,6 +1328,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
 	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
+	qcom_pcie_configure_ports(pcie);
+
 	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1759,6 +1772,8 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
+	of_property_read_u32(node, "t-power-on-us", &port->t_power_on);
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);

-- 
2.34.1

