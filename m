Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D83ACEE2
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146015; cv=none; b=rn8JTr+JmgmPzmqfwq4gu+1SFfDgHIgRFNGC4l7pdCFCYMQlIfHu2HM0IH3A+cGj4mmE/RvRHGaZm3yvYkUHBL51d1KE8vHvKNURUqRzS7qdfgLj4wYVLl3IcqKQ7TQXBq0MkduH2uYjuQRvanzn303LEHHsmJbrl/4G5+ygU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146015; c=relaxed/simple;
	bh=aXPhBARn3a/5Ioy0IlYZvcrmKeEeSgZakrcsFrOkcBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTkYiPnMCkMzetfq9VppJTTTogYFW6I0WzETdfKboupbu/xuhuXeFleSLY+5+nwq3vrXvyg2Z+EW+DrSXsqRxgIbEhVyaggGRWsdx5+qBIMKRPYmdElBpTEOhwvVI4hztcsk/Umgn49CJI1gqaGdye+7qfmnOvYyC0sMdUihsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdaZdzlK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Aa4AKdse; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdaZdzlK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aa4AKdse"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0a4a3600651
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Whq1lvHGKENYAxLuORynt92vSwisujF7CNlKCmDhdoo=; b=JdaZdzlKmRVUxQc8
	oDoG2hB6bAgifxfZdD7ZWfa3Pz97kRCLmhgy4VFqOV36nXQBkmGY2hGsOlimrdrP
	m0T5p+n/OoHlLtggrIa6T/TRBDRuOvOAcp7qud580ZmlXlqBwoHyjrh6Xex2LexF
	tW7ykD3VXXP83p9rpzVsg2k1Zw7gtmPZLibteXFY6gSqcipk+BcD7YWeM7GzhLnF
	PFFlDRvzKpKdAwfdvlWc1Y8r14FS811dBnj9Rv9EdLCSJJqLpafPgR4kuo/dTBb4
	RafqeUWOHUKDvUXsz529nRRY4SxOnCWbgR+jq2/DrXwz4x8oLOtgnqK7iyeLPKmW
	AWFY/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm3dcy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so1599950a91.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787146007; x=1787750807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Whq1lvHGKENYAxLuORynt92vSwisujF7CNlKCmDhdoo=;
        b=Aa4AKdseelSj7YfgM8+ylUdXhPdC2Po4Blju4dPFI3a5soUJLoZLYVL7DXz7JAQ4pG
         NkdtKBXgJfPEhealUxaofg6XMez4D0Onk7lATeBKxWcRmhS/7UF7I4kWXx2KlCfz83Nu
         mOgwB9HhHL+CVo+HvJqwy0zd1FFJyu5mUgzuBT3wtSYlqLMNCQHKBWI4Tt8ypqvvCg+t
         OlouO5tdIf1pJXSTypiMnJiijcmjLnGupsRKCNrLw5h/xMbmCAY4UVToDOB+6IoO4eCB
         iqq3ZG389GDCjTpwrU4K1Tetx5ZcVatGBKn2eejNlgif7dYQig4ZK8BzgLfPp+bLngcb
         wu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787146007; x=1787750807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Whq1lvHGKENYAxLuORynt92vSwisujF7CNlKCmDhdoo=;
        b=kZCVUyUDriJa2X0Hcfbcn6XILHHx6raP3ttaImJWjWvlFKj+sZHw4AEellkZRwQP4S
         bAHrr2cE8H5lEbG2eGTsFMH6DWMKxORUEH43VKBrWKYupNpeTqlqf3xAa5L1ePyu+mlS
         FSinHuNuHQumUb7OdKme8YTBIywnyx5+eVvXKpTbgGk37EdSmfswcNu2Q2mCBzZsOSLX
         FxEElxiGQ8eo4ic0ScsXTPUT6HFhqlhVd44MSF/L8mxRc5p1Z70JhYjUQTys/XrIa0Rw
         991aR/vrklotwVPY9hjbWGYFLnEbyfxlQy3mhJH8UcuQPiuWCuDpqBkKu6OMrzYsISMG
         HXwQ==
X-Gm-Message-State: AFuF++lKin9eIhEkJ2DyXH0YuYAJ98K4uDp8PvHr7bVgXVpPlFo57soA
	EulMKKqp67Dk/nqnVylHorRiU9cBwb06TqU5cGrM3DIHKkGkIyHJmEDFEB0fJFJUgwZR6lMAX2A
	Q5eAjHqvn4YuKlIiZHsu15T6ZRNEGXcd/N/wdudAmSph+7gcXJuHh0EwxL9M3O1k=
X-Gm-Gg: AR+sD12rLlbGNXd5404BqMd35L9r8+H+X83kg0SiNVOdfgkrpYBK+tXD4vkpuvQpFfP
	mNph+H5hNnh0G8huSY/hdGvZvUVUbCh0cTYrmU+LfCeL8oqxtlFoiK7Zb2RNPf149Up0EJbaMR7
	DaE/cGOHL9iraxkii+kxm7Vq5zfOGG+sNT/oQgxnpwc27qgDwIAnEqEWzZ7V6qiaq+MHFEp0+T5
	l1fJUv7TM4RyaZQ0Hf+zgk3oa3EzvtH9I+i5WnPYUqH3M0Uc+V23s+602eZuQHJdw+t+T4HR824
	xGAvppJZg/dS7YO4IgxZvYgVMiw+yLDZzykF1ewHneoyD6IAqDg3c7ftXvRezv37CWPmmvuqS+y
	0am7depMSGbnaoz7vsW5ufxSAkRmuGbh2ryg=
X-Received: by 2002:a17:90b:544f:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3958108a4b0mr8964626a91.11.1787146007291;
        Wed, 19 Aug 2026 06:26:47 -0700 (PDT)
X-Received: by 2002:a17:90b:544f:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3958108a4b0mr8964492a91.11.1787146006768;
        Wed, 19 Aug 2026 06:26:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c2a92406sm6126465eec.11.2026.08.19.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:26:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:55:56 +0530
Subject: [PATCH v5 5/6] wifi: ath11k: Add support for MHI bandwidth scaling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-bwscale-v5-5-6dea79786b37@oss.qualcomm.com>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
In-Reply-To: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787145973; l=3078;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Wrtck8GXON4XPaYha2Uzh6nxCEmpOddneb93cQLxgLo=;
 b=cSBT2URPwVrqsDuy5hGWyBdZp1hI/lSkcFAI5vkjPChdqQ+eyTWSwxSKthBc4kuovh0RtguJ0
 tsFFUp5Qw5zDY6l0/yEEIi3zTQhV/bG++sSU3KrykPB1Nj4wLSR66MY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: CDabQHhHPc_mv0R0ggX7sEQ0HdOUOVSE
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85af18 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=262QNBeyodYRG1lUGOYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CDabQHhHPc_mv0R0ggX7sEQ0HdOUOVSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfXyLq9p+HltHMW
 gFZul1MziasCMAttZgjtF2Ey7KO/gNP6G0sE5/6U5dGZp/8CsO6r/JiuYAvl+mOFt9hVXTzbEdZ
 6+fHQPzpUO/eqjvYmxPvXysGtl7kEISJayUhofuBX8appAzXzNCQzX2kgm/W8YDutYzg3Qknias
 hUH3a2WKN30gwA+dMXvCGDkoQG/4Yh0/KF9chtR5YTCyGJ0cZaCvjRWMvFEz4KNGwMSaEn4wni7
 5Nly4y4I2ATki+qpIgolxm61otXHvm1ko8fE+daew8kSMfgYH5gFDOjQ3OkEo8gI+u9LdG+kkYw
 CYYOESk5tiedhDYJLjYrMMvxXuOS1MnkE76IYsfnHvk0MB7kx6+/IOVlh6MYW2f3HQPHdSfGMN2
 JHQtovTzLdjn8uRjvxcXlmcsglFBhxQ/mB7/kE8R3dUgaGjq7tZR3StJu5bnhhK1xf9jUMyrK0c
 eMlpb30lqKCYmNi6uFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX/mUqvMOdz3dp
 tUW15bwsS+FekhxqlxdxinaWRrhqI0DpbN2/Nb/hELdxRDja8IqktYToh0QC6pGrBDYAGHjVzZK
 DUpnVS6wUC9e5JkapngvBPvnH2HYHq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190104

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

Add support for MHI bandwidth scaling, which will reduce power consumption
if WLAN operates with lower bandwidth. This feature is only enabled for
QCA6390.

Bandwidth scaling is initiated by the endpoint firmware based upon the
bandwidth requirements, if there is high bandwidth data endpoint requests
for higher data rates or if there is less bandwidth they request for lower
data rates to reduce power. Endpoint initiates this through MHI protocol.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a6c9ff112c68..9bff4c4bca3b 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -20,6 +20,7 @@
 #define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
 #define MHI_CB_INVALID	0xff
+#define MHI_BW_SCALE_CHAN_DB 126
 
 static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
@@ -71,6 +72,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
 		.client_managed = false,
 		.offload_channel = false,
 	},
+	{
+		.num_elements = 8,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.data_type = MHI_ER_BW_SCALE,
+		.priority = 2,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
 };
 
 static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
@@ -311,6 +323,30 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 	writel(val, addr);
 }
 
+static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
+					   enum mhi_er_data_type type)
+{
+	if (type == MHI_ER_BW_SCALE)
+		return MHI_BW_SCALE_CHAN_DB;
+
+	return -EOPNOTSUPP;
+}
+
+static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
+				  struct mhi_link_info *link_info)
+{
+	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
+	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+	struct pci_dev *pdev;
+
+	pdev = pci_upstream_bridge(pci_dev);
+	if (!pdev)
+		return -ENODEV;
+
+	return pcie_set_target_speed(pdev, speed, true);
+}
+
 static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
 {
 	struct device_node *np;
@@ -387,6 +423,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
+	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
+	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
 
 	switch (ab->hw_rev) {
 	case ATH11K_HW_QCN9074_HW10:

-- 
2.34.1

