Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D63BAD98
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232860; cv=none; b=UEKKh/f6Q13oJ4DqrErHxuK3Vc7w/g/xTJe5MLCvKAbr9vVos5L4ebPxLhAzuAMsPKsMYCkYiGBvXYlmz2di+aB9xgdc6wKgqiiUXrWrOAoheVjFb70d+cW6cmYTEecLaQXdCDsv9Wx/t+7VDrpRy7ZCUzi81G/NWnJFwmxTu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232860; c=relaxed/simple;
	bh=fCZai0Br+UV9JtDbXVN+nJASmxIaMenuxY5Mhb3FJSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2FhAQ8uOeA3wtQaSBC9dUgNT+pV3GQDQhvTobND/TQ1FqJHoX2iJueBLo2XcVqgjgar62CPxq7qhEwIFNiMOe+r3VHKsT7Nc/RzesF23M/9zl2ZPg9a4kw1VxLDVgJyXT0NsXHIURxhDuiWLmd5QOzp44ImU3z8MKySL4HBXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cOmD61+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkorusCn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cOmD61+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkorusCn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9NiRR614124
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	or2aWxGkNMHGpvSv6Gz69lZrZZtJUX0pU0QL6U2L0WQ=; b=cOmD61+YGR8Nmkhy
	3gqXhNVJKdElLtLiGdZOUDayYRU1UPZRaD62K1oHns6x7ursX+5+icVC69GIhgwS
	2MXT20y+KGMAf/HflVZusLoeGd61Y/hA1yKBlALUDQ7xJJWm6S4UE7nmkCl9Z3Bw
	k9ivVfVxRgiqxtadsSNI+vi2Nwj8HyJxT8kooNGEFq+kJ1U08SYe10rUiWUrLjRY
	QkmDH9St54EGhUElyZuiydZhttYSNgly6ZERoj3gnWGKUgl+MCGJ5mNfyU5nEcKJ
	U5pcvN91YBo9j50J4J1lbmu6J74mlTwIwSqU/ePYW1VfjPAcDXSa0ks6ZjQGfMZy
	5gslqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf1wgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae59e057f1so108444945ad.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773232858; x=1773837658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or2aWxGkNMHGpvSv6Gz69lZrZZtJUX0pU0QL6U2L0WQ=;
        b=HkorusCnyfhICJQNTaKT2RUU7RHVHJ3rM1mlNZArNdTWmxc+uMZXpgju6D8p8i2dW0
         u4+AqBqIEEEcuHRxQY5ruf5LjbYd3BZ37bSpB/Cn8bdXMjjj5t76hdUNC1Rv41CwHiak
         f6DMzhdl4Mjbt6RSIcZxpnItynCnDYUy2UosB1k2vt2NHmyvL9fJvA++OA/I03chVkwq
         4l9f9Y42+nhOS9orJ4RUAcw4UCBVaI39VCx6m7lG+Mbupnu0KuEi3OlAG2WVW/oDBknP
         gtlPxUUTvShA2e4MSVSQJaiw9hpLUhs4hFL4tvZsBK6MtjOQGj+pXJuFY88NraNT15uC
         21LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232858; x=1773837658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=or2aWxGkNMHGpvSv6Gz69lZrZZtJUX0pU0QL6U2L0WQ=;
        b=dfmorV7U7s1nFrZsDLcxJZ5dAfYJGG9kJrPuSrj+1HuYXgGWRJwy3nTGO+5G62VQdN
         Yk3ZU76Q7XZHmhwT4W+DYXnVYdHBrt8KRG+a6m/thKhwhFa0RXJABvVsbtySbTLOvjri
         j45JDlzponJEyWNWzBl9WMZElTas1NC452oohpqBcVAiNYZUZjnhhYtd1RZaORP7velZ
         MTz6jAkE6ebKIhG1G86pXuUGrj4cm/VN4L5RPjyua/6PK6wCyEariMqOtWbmmiZvkP47
         vTiaWQd0KxtPxCTcLf0DwuyzJIpfTjlEWqvrRXOgtK+A0qafMVRJ7vAvhkjWJP9wKDvj
         ZeaA==
X-Gm-Message-State: AOJu0YwSucqouv2FE7atnxD8yP2ll4KQKQ/JXOejeb9H1ywA2BEYuwY1
	zxgxqh6W3wJcIxrBiw/bAm3Bg7nE4tP90vm7kLcxZ1Q0ok5UITcrKMqha9ZXzzQpTkEqyf7ZDKh
	XvtkMCa/0Zdm6uvszAYaOt68whoRJbkDtxKGm9jaFG21bta45Qrtr55SjrZyvHWE=
X-Gm-Gg: ATEYQzwv5wd0nUzp5jwIHJjwuBbzAnaVklcHO4OevqSp+Inj+Fx++rKDLRpo0YQu4F3
	d9Npsy1ze5i8x/MTtve1LYDPhmegzNQeJqxwjYFbP22j7/95BqTAuh7dy+galsx4wyPWGDCHGyZ
	tmBSpwh6elYSCbqU24zYnDhwfm+SJ0saeUUXgjizG1ooK/FaJg8vxuLwCb1agkAc/H9pqiYrIgD
	kj8Yn8ROsll8Ce4LxoI7oJYTqzN9cTq0xDVO2siyfshZkDYsAXuymVePKq+iX5/DmA6JHP9vgHi
	NAI4DNR3mrF6ASP44Qjev8BcBoo5gg6l8LHspL/RbnrERdFAT2gE9/2mpAY3+dVvfigy1EuIpvd
	SaDyFKxo/exb7t0nlqBoM9sZSP4MDuLZuGTXgpXkbtLAJvLhU89KfKCju
X-Received: by 2002:a17:902:f70a:b0:2ae:a577:55b4 with SMTP id d9443c01a7336-2aeae8dd2b2mr24993675ad.40.1773232858029;
        Wed, 11 Mar 2026 05:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:f70a:b0:2ae:a577:55b4 with SMTP id d9443c01a7336-2aeae8dd2b2mr24993425ad.40.1773232857570;
        Wed, 11 Mar 2026 05:40:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2466a7sm23304385ad.20.2026.03.11.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:40:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 18:10:40 +0530
Subject: [PATCH v3 3/3] PCI: qcom: Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-t_power_on_fux-v3-3-9b1f1d09c6f3@oss.qualcomm.com>
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
In-Reply-To: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773232841; l=2432;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=fCZai0Br+UV9JtDbXVN+nJASmxIaMenuxY5Mhb3FJSY=;
 b=Q4gJKXQ9XWkdvcloTyy0OjYGuDQaSF43IWeaLQVPmMM1GCZviMKmSu7O8NOFAscE78vI2fQM/
 hdaFH1/lNCIBaw+ez88sFt9ZfeVhrD16b2XYpbl5LlpIudxmRYbrE3I
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: LJ4xGpNqCSH0eOXhWIK61GwhMAwaZ3rD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwNyBTYWx0ZWRfXwCAaFOrZd4go
 VHnKQLn57ITkUxSluV+6MZJEh4KvesEODDh7Xgc7fjE16DinZ61HwFd1WyxTb/llZ7zBYuAfS8M
 aRKiWNCMEqhUUIMFH0mYAMblSJyaheBuqaAY7B4yz1/1Olip0e97AyK4jsq5ALEaaZKEAqH0zjH
 wBMDbKmxIlaU1SLGhpdROoiWTMwj9L49z2W85TlWmB5+C8G0jiWqTGpK0ZcgTVtk0aCW/wtNm1Q
 rcNNZMIytqvOAF2/w/Zrb17Kph4JduupkJmARuPrQc7vaj/1CzZpA+ky6QZDMOPD23Z4rFASzPz
 kF+BNeznHSYZZ38oql2OFFnS8bLEfSyak+JbiECcWM42FGwFj1kYCP5MEfo8BcEX7AlnlC0Z/ve
 2MJ9aJNIiaRlRtEy8GM1FI2Cc7MJEKw4sb0ulHreBD19FXKVcK6Nq/igjyK1IjEJJ11rsezQqYi
 FvxsEXL6G4HxeemKQWw==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b162da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wXczfBY3881IDOTkNB0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: LJ4xGpNqCSH0eOXhWIK61GwhMAwaZ3rD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110107

Some platforms have incorrect T_POWER_ON value programmed in hardware.
Generally these will be corrected by bootloaders, but not all targets
support bootloaders to program correct values due to that
LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
can result in improper L1.2 exit behavior and if AER happens to be
supported and enabled, the error may be *reported* via AER.

Parse "t-power-on-us" property from each root port node and program them
as part of host initialization using dw_pcie_program_t_power_on() before
link training.

This property in added to the dtschema here[1].

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..63d5628e988d3c07f42099c0d86e6b80fd54ce32 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -269,6 +269,7 @@ struct qcom_pcie_perst {
 struct qcom_pcie_port {
 	struct list_head list;
 	struct phy *phy;
+	u32 l1ss_t_power_on;
 	struct list_head perst;
 };
 
@@ -1283,6 +1284,14 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	list_for_each_entry(port, &pcie->ports, list)
+		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1317,6 +1326,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
 	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
+	qcom_pcie_configure_ports(pcie);
+
 	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1759,6 +1770,8 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
+	of_property_read_u32(node, "t-power-on-us", &port->l1ss_t_power_on);
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);

-- 
2.34.1

