Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF239098E
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901974; cv=none; b=R9TpSMTnXFW/C1ZYPkt/WPqMcwHAPV6H2S34Y8B7DvLvroM7jVQsPHkdmMUfANu4A6xvcovXVF8hqAzBxEgwP3e5Es/Hg0YosUT5ZSl6q2ACLaK9Jcgy90wGN96Yr/QEYg9ZIeOdDPndLvCCALMyKyO2qg2Bj/FPm7eo5wCa0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901974; c=relaxed/simple;
	bh=Itx6KvM9p25Ke8x91M9Gz0gLSN7XGE+rPcHJSWGUNo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCqCWZbqc5PB46Z90RgeGfr4aqZKYX5xTHbvffMp+suvTUvCGYmo37+fOeT1El0KSQQ55J7CXydD9kqx8NkFClhr0sib+l7axSgYa4A8xw35SacTp9x6/ThHnc2w5mgiqxiSy1n2PWBYt43k5OIOlLbU0soIJJdFITt2D2rhFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jRqNMoHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtZUWA+9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRqNMoHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtZUWA+9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PkH02733104
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 06:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IatakC3wGB9ng7DsDoD4sHfhEEYjsCIhCpSWGUq81CY=; b=jRqNMoHA6tID5OPq
	XwcfKTt+eYYsdaLZ7tp4seY/d4bD1A/NUeOco5Ne80FtQV8IvXLJEbvFh99RO3vl
	7BOUBol4OmlK85r3/z9DVG+ysPxJf7uDkKB6pl1yr0jPJaGJjTfTVuJcDR0GXFVd
	/pPNDA8gGX07RpPfIm7Hmiw3ZIT72D3LbAUfczHlFWdpCWVZQYJo0K3mrYyjKL7P
	XcorehwzMoEk8WE19jGnSNyr04anRg7EWSw6NDWp5fHGTxpYzNAm+6VfxUaOKykO
	Maj1ctAYpBAg9/POSgHfQiMF7BAt04XRyfp4OU8XYS88OtWLwhFzUH1/fEYXOjMG
	aq0diw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf6gdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 06:59:32 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5af6d1a2c32so1162651e0c.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901971; x=1781506771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IatakC3wGB9ng7DsDoD4sHfhEEYjsCIhCpSWGUq81CY=;
        b=jtZUWA+92vj4999SF0CY8GlyCFxFs2kzR+iIpJzHmBVe3NHFITOkaDvEsZqOBje3Ej
         Eu54HNHpJM8yIQkbL726s5HqWIAUcBpaayTZnWq1tV8Ky38DrthxgRdz1LV9mAsLpWXO
         VZyIFWW4y/fKqh02ZlpV3IrdR25wioYHJ4NTfTUK4nZcm0n3MMpDkcCEaHl9Ngql4eHe
         jhrTDb6dp+126q/aalkyURYsso7/eJYNAGhQVjX3NKEZaeVDVXNpPZhxRrSPVe+hOLJO
         rFZ5bhkmsMvVhoM8B6DGzkLkAZ6c4D1qHDFarXb8nQD5lNLbhVMWdsLgFFxPdLhSte8G
         CSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901971; x=1781506771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IatakC3wGB9ng7DsDoD4sHfhEEYjsCIhCpSWGUq81CY=;
        b=olWaRsXy4XVsI4l4/53UvnGIxotJlWN48oepgZyHev84ndV/06Sd1NUMMkl0VKVnGD
         A1YK+4PbzNOZi1+IGE72FIFv9nwvG97U/u/iO+NPeB2Gyp6FaA+Bj4XH51PnL8IJJOqO
         SYt7aaJZl4iUWAXD54oxILVSh10u9A2zhNWu3Oy+LPdZL6lklf46xN0Wr6ERdZjBL6+A
         6gkvVylNMjsuFJT5ebufDXbQlV5bXc3ZU4C/p0JTdkzg0G3Jmh9uz4OlGgT7hYCUKyb8
         LpfPTa5/iYL2rg2KalF0agq32I+ZHnKOhXOPnhd9z3tRqtHgOHLuPmei8yjJ0r3y7cWD
         jZSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8992AK6w+axBt4GthqC2SKMasNTdlbkBQ27eis0HTCE/P+ZBLdnrjt+Z1enhUDTESmJnhYzB9atKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeedSrPgbKj1igfKIPq03ry7WA2hRt23uI2On2cZP1Wc6gSjc0
	dfg/vr6Iq6oBLtqgqRg0/PE635HQdYI0CPRgqfm8h6gwlh6Itlki1+FnoJIfrxBF5fo9gukLMsw
	E9n99vCzYf2SvtQzTIWl4jXG0e5Exzczf5FwGv5s42jQ4quLgssmHuydfHMjY95A=
X-Gm-Gg: Acq92OEdCR400x1PSdTxPSTRoYQajcRgd4gLIW5ihaekxOvr7g2GVxRdsqeYAESulof
	t7Q2SJfV9VPEOym2dnXIWTmHTlJvzeHhlY8CKnLKliCOuNUN8OlkHNrQQli6NaNKyM1Xkw/Q2QZ
	q+J7yvkyvGjK10v4glITcpmsdRS8umC5UqjSfbEf0emGzWw4huaWLg3MiXNTJiWTC08V6jG58Kx
	mUfKiXp4QJ/fZzjdRJnGcNPmzgWcoFxbk2/TqGv+lCNivVFbWICJve7fURCNcQMYaklkMe3BP8A
	jcBjN8D/YcnPG7KsVZYrp7q9P0gFkD0mFBXtuYIUJdADc0vNx2PhV+oyi1ZykK/KAxcsKyTeaeR
	lrV6mMdyojHs3K0X2o81DwIasttdM6goDb8hAGh7BxCGOIRZpY/l6a6iyBSNfaxtM7CMT47MDTD
	Ds6M4IKjQ+jy9IkMuH2H7XLSjsJUPmmWc+9+d1bzXs2Trk9A==
X-Received: by 2002:a05:6102:d8d:b0:613:e996:3014 with SMTP id ada2fe7eead31-6fefb0a7367mr7189674137.20.1780901971355;
        Sun, 07 Jun 2026 23:59:31 -0700 (PDT)
X-Received: by 2002:a05:6102:d8d:b0:613:e996:3014 with SMTP id ada2fe7eead31-6fefb0a7367mr7189651137.20.1780901970940;
        Sun, 07 Jun 2026 23:59:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:20 +0300
Subject: [PATCH v2 2/7] wifi: ath11k: enable support for WCN6851
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6271;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Itx6KvM9p25Ke8x91M9Gz0gLSN7XGE+rPcHJSWGUNo4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhKzgeew76Nc19/nB5LY0YDRfAy6SNHZpGcn
 zPMFbEFzdiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSgAKCRCLPIo+Aiko
 1ReNCACE49BFc02i9Pwu4kG4mEUyFc1wHnKlkDN80b4iJcM1VkF4SSPtHTHNpPIV2dArv3T+xTt
 Itdq64CXgIwhpW+6PsDWlCWK666Sn6lyQQB/ziWjXlYuNS/oHSfkRAGQTKsb+hvnfdqaSN5SvAt
 BVboN9QvIoOPSPka023EDB8Kx+itNOXE/h9TO8V5iADEqKMtnHD6N31Ie9b7kEV9FR87yyiEN/e
 bKPOrrXlDiNRk5FzUb+EPGyFylF3jlL0rvpLHNqrDnbA7+x5tcYrELPByAXZsS9PtsRkZ4yiywM
 fburWtNSrsqsSw/FoYCXHh0rfuRdsb4uRSRwAZMWnYEV3vOk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a266854 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1Ms6DnRdHleovX8mdIYA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: Ru0NsFY_YjfQ0hNBX9TqA4rITZUmQpNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXxuGgwep9Ifxj
 5SWgwzqLymYnxXz0bT1doaGgS/SGx9Ao+XBcGzSDxR3h3S2R26ljik2pot+bO675lErBmyUz4OT
 LIFjXB46jnRIvMI+89jtN+5k7MDhrIBagZLasP8RXlpkex2cm63tiKtfSMoaS2G8qKSm7Kspmw9
 hittgL0AQRSn49YgOod08nHcc2bRMpoOVKOPc1w0Kn8W6jJ5LByCqti5vYKkTAisnU4lXCCLzGh
 Q/bbdqd6Lt18OLqSgqGnZk0x27+GccMXMnQZK6wMPPplGyjUOZCaMd7pkk7oolD4E1nB07VcZHC
 a/rA6/2s/4xReSvi/r3UsVZmS6MNP7ffS3Dw9kByZBPGuCkSWHblSfgrWES2R9WcHzWhaGmUo1s
 sajGzfTnBeFCG0mV+Pd4aNicQgp1i+jBL2jve8bUveHegyQrEHBAhLZHeOyFv8Z78lHxFyUu5gF
 IWXRJjH8K7DPFd5rZFg==
X-Proofpoint-GUID: Ru0NsFY_YjfQ0hNBX9TqA4rITZUmQpNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
configuration to support hw1.1 version.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
 drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
 5 files changed, 114 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8dacc878c006..78a226ca081c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cfr_num_stream_bufs = 0,
 		.cfr_stream_buf_size = 0,
 	},
+	{
+		.name = "wcn6855 hw1.1",
+		.hw_rev = ATH11K_HW_WCN6855_HW11,
+		.fw = {
+			.dir = "WCN6855/hw1.1",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 3,
+		.bdf_addr = 0x4B0C0000,
+		.hw_ops = &wcn6855_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.internal_sleep_clock = true,
+		.regs = &wcn6855_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 2,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
+
+		.spectral = {
+			.fft_sz = 0,
+			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
+			.fragment_160mhz = false,
+		},
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
+		.supports_monitor = false,
+		.full_monitor_mode = false,
+		.supports_shadow_regs = true,
+		.idle_ps = true,
+		.supports_sta_ps = true,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
+		.cbcal_restart_fw = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 4,
+		.num_peers = 512,
+		.supports_suspend = true,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
+		.supports_regdb = true,
+		.fix_l1ss = false,
+		.credit_flow = true,
+		.hal_params = &ath11k_hw_hal_params_qca6390,
+		.supports_dynamic_smps_6ghz = false,
+		.alloc_cacheable_memory = false,
+		.supports_rssi_stats = true,
+		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
+		.dbr_debug_support = false,
+		.global_reset = true,
+		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
+		.hybrid_bus_type = false,
+		.fixed_fw_mem = false,
+		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
+
+		.sram_dump = {
+			.start = 0x01400000,
+			.end = 0x0177ffff,
+		},
+
+		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
+		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
+		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
+	},
 	{
 		.name = "wcn6855 hw2.0",
 		.hw_rev = ATH11K_HW_WCN6855_HW20,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a0d725923ef2..29727ee94bfc 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -147,6 +147,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_QCA6390_HW20,
 	ATH11K_HW_IPQ6018_HW10,
 	ATH11K_HW_QCN9074_HW10,
+	ATH11K_HW_WCN6855_HW11,
 	ATH11K_HW_WCN6855_HW20,
 	ATH11K_HW_WCN6855_HW21,
 	ATH11K_HW_WCN6750_HW10,
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a6c9ff112c68..c94546c367a7 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -393,6 +393,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		ath11k_mhi_config = &ath11k_mhi_config_qcn9074;
 		break;
 	case ATH11K_HW_QCA6390_HW20:
+	case ATH11K_HW_WCN6855_HW11:
 	case ATH11K_HW_WCN6855_HW20:
 	case ATH11K_HW_WCN6855_HW21:
 	case ATH11K_HW_QCA2066_HW21:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 35bb9e7a63a2..dc1dfd219d88 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1031,6 +1031,15 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
+		case 1:
+			switch (soc_hw_version_minor) {
+			case 0x10:
+				ab->hw_rev = ATH11K_HW_WCN6855_HW11;
+				break;
+			default:
+				goto unsupported_wcn6855_soc;
+			}
+			break;
 		case 2:
 			switch (soc_hw_version_minor) {
 			case 0x00:
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index fc6e7da05c60..0f4dc05cc5b5 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -86,6 +86,17 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_QCN9074_HW10,
 	},
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_WCN6855_HW11,
+	},
 	{
 		.total_vectors = 32,
 		.total_users = 4,

-- 
2.47.3

