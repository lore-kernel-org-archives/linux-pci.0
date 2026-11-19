Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093051;
	b=RMk3b2xmrNmvaoZgT3+XxRymeTRi7F+EueHksvDvMlaMr8L/QEVhsSZTWuJQHl0NRPFN
	 xkOdYXIa//GSt3ARzBGu6gj5wT8KKHKNjblTDdp7V13G66Se08oN+HbwryxdxbsIGMiWT
	 1yLD3+qRSqKFYTHLYTH4rKJ60IYtxvz3iGxpBuL+6VXN4YGmBNRk/uw7Nw37W7U9/cnBl
	 E5dNb7AsE7b0GGrd0CYKIJitfwXB9anLgy9F0yDc7B1kAvkuyjsyDtx8MN1fYiJaUf5rn
	 36+nN5HOKYnynmXcmgFWe65ZBgtpfxthX3vwkE1L9rctb4r32TpkTyx8Scc5AuGWJVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093051;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4tTgIxDS6XJO6n2Okvt3qag/PelJr+pY0yiNiIOw5fs=;
	b=ky15J9MK1Xl5CET7Mslr3dHlat2tzg6LYSiQffcpe6Dzmw2+JjQjwQFiVXmid90l7BOw
	 M38AYJLCAsD6ExSvRBblgERaBO/47MOQ1k0rERpdhMXzwqq1Kp5t+WtZc+kCbiuZ8qSxI
	 C4IOWTiDp6t2BaPlASiCkBtCOb0MZYbiqSkGIGM0paD2bDOHbQKzZetYNQ6kLD8eQ3Nog
	 QSGZHWOq5TDrMAtw3QwIIWWBmmTsZLvRO4pZu0B0Dlj+2im07SFOEO1ma7TdYSbshpUf3
	 GwU3lHoCSR4qrtd2LvKRc8Bz3W5WfRb9BPYDz9l9p1ylW31K69Dee+8kmpiF7DAtLNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyyxNgcB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="SsW7L/84";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910560A262F
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E910560A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyyxNgcB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SsW7L/84
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBk7U3705783
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4tTgIxDS6XJO6n2Okvt3qag/PelJr+pY0yiNiIOw5fs=; b=lyyxNgcBYDgj9KbE
	qmrx/XYf+tSkmtbyWk2R5fDOlviDxyoc05zZdzmgl3+DWButP928RJE5AItYT+cM
	s4cFX+ar6EkcxU4ajGkcXdbQvBRETTlCVv4XAmwU+YJ+HzYAo4lwDU5vRQ89MbjI
	yeoGY6hxQEuvqD8yUAbiXCUyFjftFeqAf1uFcbzKRKuSjcMCX+zFhp/9lKM7SRE+
	MvKbDyg9JLhmzg8mxzSHa8BEt9XWZyYOMVh16bIgqr6dWiRaVtLqh5X1gB0izFfA
	TnCxesXlUN18Ppwqq8CQDl38cf6LEFvMhAmwXPcwZHuXFE6xnDkCc+gF9y7oCxFY
	O5ZfCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x708w4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3837afac185so4027750eec.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795093048; x=1795697848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tTgIxDS6XJO6n2Okvt3qag/PelJr+pY0yiNiIOw5fs=;
        b=SsW7L/84sm2BM4ICdF1DjSa7a7uf9RKxGdXUpLW+sdTbSvIvsjULxMKnoQIAFDAR2z
         mdt/5b72yCIBbvmlsLJgNdNR42dNMmtCxzwtYtDqAv4V4lnO5Hhy53W8xmhSaif6tA2Z
         qLLlp6NveeM408CUsKENyc3doZ6MVkfSI8FddQqQ+r7sWedMH4wlNSYlGyDAQ4AGTs3C
         RGeJoGTrK2GWoBLp/HPgmZ/yEiuSQGj0s9jaYnWszElLoi8AmSubBfZqlUUUh6deX17m
         lrEyczMZE0aOZuiDRaA8YdNkKgWwBtdFlPFDhQqs52bJ5712vYPYuC0EUNPY4pw01k6x
         bhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093048; x=1795697848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tTgIxDS6XJO6n2Okvt3qag/PelJr+pY0yiNiIOw5fs=;
        b=sKWTUan2HmLj+YittpxP1/fjjv/+WDINdasD1gEGY9YcUO4veLD2FbP+HmR1xKZ36y
         iVKpZT5xkUIDj4+enuEdzX/9LufDxIC45sfDh+6IMpqabI2Gc39WMulrilwCnm/yXMOO
         Y6Slo589CS6zbiGdO2TryBjEnknYKzpjZQr5uU6kv9hgh6MHIVCWh5ZEa5+SpdRyP2eA
         jsAR0hgoiSRCD2mL+pIW3N3PXHZZEQHpSieuTxVXQWWosja8drenjWaINQNj1YIf9mxT
         xgBujT3zSImkBpoyF7lnNCnvQgvbD+VIlARJm5q/sQMLtjAne+1dBWQhF4fBw9tQ3H/8
         wS7w==
X-Gm-Message-State: APuU4Z+p0ddnDn3VxiCdrKcKFQNBJc+V3Ny1taFVHeiE65d2gzaZgJbs
	s2WctHJcQnk8E/3CnTs0Nt+T7JAhrvSjOtvPK/OKsCxD4WGktNyPkUP3o5GeG+Vg3WEIDGJUaY7
	NDqrAtSQcrag/f0ru+NLE7nZh/T0qz3GsZVt7MzdyVGmY9jOimJahp+4O+HN9I/s=
X-Gm-Gg: AZFdTZe8CPnAYhwH2vipwlb/+YEkesJjzS5tashjYL96PPfOSPwNo+04PLxtrtKlS/0
	AhZACXxUiMh6UORG1RyDS0UTRNhgDOvibiovFgUK8gQJkl9R5b5+Y1KNc/88tCXf6upWOMA73DI
	HBG3VbYaxwtLsu6UtQbpS/fHt/PtftUZXQq1lJO8gJNLYldOcbco3xy4AtWdjKPfRYYDpzDUASA
	5CHvA+hFsiH7Y8bRC9IwwbwE2gaR6wU+WundCe0gstzA5bzTkJqqxRRGmnxQOtwoHk1EaiffFTw
	MdcyF4IBxLDZW5iQQnuJGnkCRw96Pxc+qE06HkpMOnUhwe6sobPoVXVjalWNBM3n5lbbUms/fjA
	k21l/KuWyr71fKWdjSQpPiwgtQkLsySaHDaGR3k4GFhvRCmFWTP63NkKGr2XdbKBCZE3rzWTv7/
	5lbNw4xy1s
X-Received: by 2002:a05:7301:6f8a:b0:381:7ee:d351 with SMTP id 5a478bee46e88-38280c30d3amr6041418eec.15.1795093048277;
        Thu, 19 Nov 2026 04:57:28 -0800 (PST)
X-Received: by 2002:a05:7301:6f8a:b0:381:7ee:d351 with SMTP id 5a478bee46e88-38280c30d3amr6041394eec.15.1795093047773;
        Thu, 19 Nov 2026 04:57:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm18529369eec.28.2026.11.19.04.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:57:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:26:38 +0530
Subject: [PATCH v6 6/7] wifi: ath12k: Add support for MHI bandwidth scaling
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-bwscale-v6-6-9a9a715fcb46@oss.qualcomm.com>
References: <20261119-bwscale-v6-0-9a9a715fcb46@oss.qualcomm.com>
In-Reply-To: <20261119-bwscale-v6-0-9a9a715fcb46@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795093007; l=3223;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yAllDll9YCBe68xUUxCszpos4lvTFYNXK5z/BwyDl/c=;
 b=+k1xuH+OKoHdW1RPtGLjE1H45txjZLkvtl/v7yQ80cCbYV1mjZYC938l9WQ1zSE8XTI68IedX
 Cs+qfOOnDbNCo9/sL+ruhb2wxcVo6/Bui29ICuhdCaqKSD6tDrSweoj
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: qwD9UzayNY-v0V4f39IUcgfJjWWjhotv
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6afef239 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eVNgtL86jhWfyD6ZVDoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX4Pt7ANONOODF
 LkbdvcaVhNXZIxNvKckGpOWtRjh0XVDL7fgxprZY9mOVMV8ak6+TPQylXq+UwotgpG9ak3rcGpi
 h8shilpbdWG5PxXmzOu/ACC1/Nk6tmA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX/37a1+b2gkHE
 d/z/H6HiPOYseLM4KVIN9qcV2S4jXnEJFH7oz/mFqRjXn91rFdTVoiFX8eHYB+6mkmni+29ldYE
 6Q+uyj9m8plMzWEGAHsZ969oOegRNbALjNHJQQZOJRg2VjJeInDIRzzMownJas682pPA5wm2eQS
 T/OousvjmunXsmgpWTe8PRAo86wTb5XZE2cPJtBuYPZtcAwMr7Um2OCLY8Y4RWE/CVyXkYdaS2E
 hJaYlG4IfVtJVoyNmZYyuwfOca/YBJFiiG0f8tUD0YyNUUD838zKcXT/57xg0b8DhOIcwvkE96q
 ms5NrgKX5XUmfFZtdPPJq4X4fKdR5AhjGY2CREcxIP7hMy+A17jbDOOJqt7YMcatlm5oYO+9DOM
 80FWGgRnN756AG/XuFbggR2bUQjqcqcsknu7hZlzt2F8rcPLrmKS/++d7rdxqXFbdedQaYtttF8
 e1kKqHFgygbV0iORt8A==
X-Proofpoint-GUID: qwD9UzayNY-v0V4f39IUcgfJjWWjhotv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190051

Add support for MHI bandwidth scaling, which reduces power consumption
if WLAN operates with lower bandwidth. This is only enabled for WCN7850.

Bandwidth scaling is initiated by the endpoint firmware based upon the
bandwidth requirements: with high bandwidth data the endpoint requests
higher data rates, and with less bandwidth it requests lower data rates
to reduce power. The endpoint initiates this through the MHI protocol.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c       | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/mhi.h       |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c | 12 ++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index ee87f00bc5de..16d3f299c47b 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -184,6 +184,21 @@ static void ath12k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 	writel(val, addr);
 }
 
+static int ath12k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
+				  struct mhi_link_info *link_info)
+{
+	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
+	struct ath12k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
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
 int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 {
 	struct ath12k_base *ab = ab_pci->ab;
@@ -261,6 +276,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->status_cb = ath12k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath12k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath12k_mhi_op_write_reg;
+	mhi_ctrl->bw_scale = ath12k_mhi_op_bw_scale;
 
 	ret = mhi_register_controller(mhi_ctrl, ab->hw_params->mhi_config);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
index 367432676385..7187394458c1 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.h
+++ b/drivers/net/wireless/ath/ath12k/mhi.h
@@ -17,6 +17,8 @@
 #define MHICTRL					0x38
 #define MHICTRL_RESET_MASK			0x2
 
+#define MHI_BW_SCALE_CHAN_DB			126
+
 enum ath12k_mhi_state {
 	ATH12K_MHI_INIT,
 	ATH12K_MHI_DEINIT,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/mhi.c b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
index 988affafcfd1..c482f0e04742 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
@@ -120,6 +120,18 @@ static struct mhi_event_config ath12k_wifi7_mhi_events_wcn7850[] = {
 		.client_managed = false,
 		.offload_channel = false,
 	},
+	{
+		.num_elements = 8,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.data_type = MHI_ER_BW_SCALE,
+		.doorbell = MHI_BW_SCALE_CHAN_DB,
+		.priority = 2,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
 };
 
 const struct mhi_controller_config ath12k_wifi7_mhi_config_wcn7850 = {

-- 
2.34.1

