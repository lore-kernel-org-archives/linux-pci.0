Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093041;
	b=NHcOpacE6xMBo5crM5oOFGfR6h48AykIVUJwVr7ATunLujfXFBIaQdBlbU2vGj4mjqEj
	 nCmcpf8GV7qGzaU0WllFx96wBLHdbjKjUyrSkMAT5T5AY6SPaVbAGhD+01Fo4Hq7D5WCB
	 YhBgUPuBuvWpTLaevI/sz5NhIIX4iSsMF5k7gJ8w9sX69fxvyQeByq6XU1aTQp4Ga9dMq
	 8TU9h3fDeZ+fDIjwflH8m33s+Q7gfdHGfXeJ5PgoCpzXc/XX7TeI6ZYdnhzpn9j+ycBTQ
	 MgmXTDnEdkXpwT1e41v6UrB/sYd3t0RBIdjV3PEjucdygrrbkB2hYTyWjMiy4TfQSNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n73s+n9tfBa64kKz4IR2P3d+HMWTF0LpyiaFuREY8Ks=;
	b=YXvnT8q1GM+OlJKSizZRhOVc1XxqnqtVbG+udrngvWxFMezgvjQwt81phuZiUtPxuHYy
	 9/M/HfjSxK7Ze7aQbxav0fcxvakThftHdsVMVZUavivleVJDDVcSG9Nv4bIu+hhUsDPP3
	 wSM/pxEAsezS/UL400ovHmKMMBUBkWDfpx+tjLcsLXvDgR702nsYfDjt6e0ISoQ+9SbsP
	 4GWxil0SoySoPOMSv52eoXUSwhAk4gBi2k/vP8y/dewbp+IsoslW+JEwhgBudjoK/RbfO
	 Z3ARRNOICEvjNhJGbR1nu5NzPY8SBlWfYCzDaN+Bq7KCq/4VWxefDx88h5HKg+KeEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPzVhK4s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M7tU1Krh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BB60A2601
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612BB60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPzVhK4s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M7tU1Krh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBkU9k085308
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n73s+n9tfBa64kKz4IR2P3d+HMWTF0LpyiaFuREY8Ks=; b=QPzVhK4sbVQcLPUE
	32RtmqlU8nVDXu+uYigZZvfaeNKAIpYjWD7lk5NyjgX5ToXGBTtASXZENzk3l8Ft
	4LgrDNmbiA06ID0d2q5zwSohQFRTcENsgZdNX+QsiIKsU4J0YlgEHW3NQguTBmJy
	aThoRzQyqOz8Ag1+5NX9CtmNA8gY+7rLGvcpzlpbp58C4U4ZCqs90fYqY6XxekwU
	XJmBXovuDdYz/r32SgpyeacGYUxaQE0Rw9U+USX+rce1/1z1VVG6YjdQHzpaBOPX
	BeaMVtCztQVnLxqEJYNuRVAWtrz/H66RnJALRsnAnVHcuJl0xFDvdX04EIzKvcPJ
	ALaX+w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1vv2sauh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383f2d05c73so3079668eec.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795093038; x=1795697838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n73s+n9tfBa64kKz4IR2P3d+HMWTF0LpyiaFuREY8Ks=;
        b=M7tU1Krh3JILBxw6WZ2iZHiAUS5ntlI64V2+iBx+Sw24mtI/h/M3gxPoUVQpMHXk3U
         4Xj3GzO+/sM5CgBfm5z5OpDT8m4wTR8TSLU/w/phXL9/sp1f+kpSWnewxZAQgpVIONso
         edWC/kLOeVZxQBaD8Xr5j9QBeK41tgYLurplMvez0UeTNzZO0sEiC/kMkESg1bFLIqf2
         ti+Nvpu7ivjlpTffS9mtQvDWHwAi+LNbLhilS0sOLnQ0VnzeOjo8SKerOqYn1fmVQlL9
         BXGaVExOvSNSMbwefBdy12BIcmqaXosCjBhRTXgLu9LfZXjXhheNSQpRFzNNxGCUb4cu
         yy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093038; x=1795697838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n73s+n9tfBa64kKz4IR2P3d+HMWTF0LpyiaFuREY8Ks=;
        b=XttEY2YAHg/pBWBC6S291Em07Oyr3FrdxF994xAKnMMBbF9+wW7ekBfXrZeoDxwG+S
         yQIwpyhNFDrAhxSXIqbBikVCpVbhJz1XyUD+QeJIapLTyEtFvSMZMtzAzPw6KPjpMM5R
         if/m2WMcz0RhNYNq0Md2xi4a4kimeFQ676amVlJnd5s3rZH4Hu/LVQj8WRDsd7ub4tAC
         jnlEnN6wDQPa01y/Bf6aukOXgWZsZmYLyzdmX+CFboCRUXroH3/H9jrbWxTD3NsWnKx0
         ZrriA/M+Oe7NKZAZKDHi2d51+82LaRHyXUe4lXBtb3MvLUOFEaftcyCyTVjIpTfxQCXN
         6oIw==
X-Gm-Message-State: APuU4Z9r2Yk321DfZhEiIGsvVTcHQjot6/nYGDrqk0/JH1p6qsFz+fDl
	6sKKSUtRvzbREvoxqvOV7S6gZfovoYWLzOTXyOBhdMZqr1yn50MX8Mgfv2gU9Kb7Gwefj9PP0uY
	T4kZlmLelPYXXgUYyULfehgqBf/Bwsqq76a0Ix1HNw0zAhKoCnpd0rYO/zbtmjtc=
X-Gm-Gg: AZFdTZfGITqgJg2QTgWjqJ6hnChAVPn8X/5l98jNIbnB7QK0HuCQgK7Cc1Z1CARoqdu
	Lnw3O5OswMJq9ELhL/hA7hjFg4J38KpjqlCeJSaG4ltxkXFlJg+zxyN1zvs/ATTOng4SYtwMOzo
	xFaDeAbDpOyIk+8yvk/+FmJGO41knsKdAOH7JotWaa40E30wQ14lMwwoSQgXxOm9ymBJIk/f4ca
	x/bNV+7EQyenwouZjVuwM5J58sAyYTLuqscuUYnmBxbFi0hF0zuzQclO4zPNvx6tCMu86oqnnI2
	GysbuhlHwi90StN07u56oddoREYluEXzmXW3Z2B6Mt6sN0j1ZWCinKnpDrwuYMYXR94ujklQ3jG
	SpmQgAqLMFlgvUKr9RrKoP6BFl/qUhKTvm64zW+OMfr0wNm8bijLTS0CYK57Jyd/wdl9Aza/LY+
	QhdE3Hqjf5
X-Received: by 2002:a05:7300:cd90:b0:381:1eb7:938e with SMTP id 5a478bee46e88-3827da107a8mr7828303eec.4.1795093037423;
        Thu, 19 Nov 2026 04:57:17 -0800 (PST)
X-Received: by 2002:a05:7300:cd90:b0:381:1eb7:938e with SMTP id 5a478bee46e88-3827da107a8mr7828247eec.4.1795093036606;
        Thu, 19 Nov 2026 04:57:16 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm18529369eec.28.2026.11.19.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:57:16 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:26:36 +0530
Subject: [PATCH v6 4/7] bus: mhi: host: Add support for Bandwidth scale
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
Message-Id: <20261119-bwscale-v6-4-9a9a715fcb46@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795093007; l=17488;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=lxEKVsG+leXrvDqVRiQ1HI5Z4Cz/mPHGdPLxGIXIusQ=;
 b=l7SF8CEX2qc0o4ia6fwuJ7jAMImZJKHTOZgazP/lfcrodwemkNNnNEuKAe4cNMYK9VmrMpIia
 Fpu43DRIHg4Btd9w3M9LVxT90WFuXPyEiJpX62fZDa65Q96Tmkj8WFl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: sZ_O4VlpXTwhN0O60zkJ_RGttONiB3yc
X-Proofpoint-ORIG-GUID: sZ_O4VlpXTwhN0O60zkJ_RGttONiB3yc
X-Authority-Analysis: v=2.4 cv=ZZWIpcVA c=1 sm=1 tr=0 ts=6afef22e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1cv9sBuMcNe9vbkH22sA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfXwinV851qWjyk
 SF+7FLQ20VYHya3XEunOZL/3MRBS0pibyOjJb7dlTT+7KHQpGEOuf8t4/tONBfK4zlQ/ZbWHE6A
 8Yi0fOxB3GgE05Jfu7Q+IAfaPIhpJQI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX3RJbZJk/3Pit
 tnOGx2MXtuAOPaPZdA4CW19WHwZTK12nVgod5yUKjMpX1/LS0tgG3GreeaBri/XiFbTjEWUJ2uT
 TeF1EGlKZp5h853leD8KN1guRucmT7NWlteFyalTKOHyhzspeLh2tBt30IgDOaMMayEW6DXBB2v
 ww4tfAsFH5tuVJpdNy3ZTRDxe+J0ouHkneV7wM+PXk2Vj1qypMYaI1W7/tKIVKbLtUeWgx7i/c/
 fBvvodVkY4zbhR/93yFBHQxp9D5aIvCu2fKCBwFQ2eNdwsMH48GsEZ09dhNHA7ELBkIR7qb13pr
 hmL3TBLOOENwRGQsEXvoQnOrQH/wET+KCRTiE884kgWs1W64KljljwWPciszW0uO8UNu3a1QUfi
 hvteQTGca7wXZQBABuYJ+OL3c9211IE2xktQ7vPSql7IYjvcuZ6iar8hYLrK11yc9G5p0iF38aG
 YmUoT2X/Htcqz6EsLvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190051

As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
power consumption. MHI bandwidth scaling is advertised by devices that
contain the bandwidth scaling capability registers. If enabled, the device
aggregates bandwidth requirements and sends them to the host through
dedicated mhi event ring. After the host performs the bandwidth switch,
it sends an acknowledgment by ringing a doorbell.

if the host supports bandwidth scaling events, then it must set
BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
doorbell that will be used by the host to communicate the bandwidth
scaling status and BW_CFG.ER_INDEX to the index for the event ring
to which the device should send bandwidth scaling request in the
bandwidth scaling capability register.

As part of mmio init check if the bw scale capability is present or not,
if present advertise host supports bw scale by setting all the required
fields.

MHI layer will only forward the bw scaling request to the controller
driver since MHI doesn't have any idea about transport layer used by
the controller, it is responsibility of the controller driver to do actual
bw scaling and then pass status to the MHI. MHI will response back to the
device based up on the status of the bw scale received.

Add a new get_misc_doorbell() to get doorbell for misc capabilities to
use the doorbell with mhi events like MHI BW scale etc.

Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
which will called by the mhi controller driver can sleep.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h        |  13 +++++
 drivers/bus/mhi/host/init.c     |  90 +++++++++++++++++++++++++++++--
 drivers/bus/mhi/host/internal.h |   7 ++-
 drivers/bus/mhi/host/main.c     | 114 +++++++++++++++++++++++++++++++++++++++-
 drivers/bus/mhi/host/pm.c       |  10 +++-
 drivers/bus/mhi/host/trace.h    |   7 +++
 include/linux/mhi.h             |  11 ++++
 7 files changed, 245 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index 4c316f3d5a68..1091ba6c4dd2 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -215,6 +215,19 @@
 #define MHI_CAP_ID_MAX_TRB_LEN		0x5
 #define MHI_CAP_ID_MAX			0x6
 
+/* MHI Bandwidth scaling offsets */
+#define MHI_BW_SCALE_CFG_OFFSET		0x4
+#define MHI_BW_SCALE_CAP_ID		(3)
+#define MHI_BW_SCALE_DB_CHAN_ID		GENMASK(31, 25)
+#define MHI_BW_SCALE_ENABLED		BIT(24)
+#define MHI_BW_SCALE_ER_INDEX		GENMASK(23, 19)
+
+#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
+
+#define MHI_BW_SCALE_RESULT(status, seq)	(FIELD_PREP(GENMASK(11, 8), status) | \
+						FIELD_PREP(GENMASK(7, 0), seq))
+#define MHI_BW_SCALE_NACK			0xf
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7ca2fe48c9ac..3e1b61b828a7 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -497,9 +497,67 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability)
 	return 0;
 }
 
+static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
+			    enum mhi_er_data_type type)
+{
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+	int i;
+
+	/* Find event ring for requested type */
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->data_type == type)
+			return mhi_event->er_index;
+	}
+
+	return -ENOENT;
+}
+
+static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl, u32 chdb_offset)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_event *mhi_event;
+	u32 bw_cfg_offset, val;
+	int er_index, i, bw_scale_db = 0;
+
+	if (!mhi_cntrl->bw_scale)
+		return 0;
+
+	bw_cfg_offset = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID);
+	if (!bw_cfg_offset)
+		return 0;
+
+	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
+	if (er_index < 0)
+		return er_index;
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->data_type == MHI_ER_BW_SCALE) {
+			bw_scale_db = mhi_event->doorbell;
+			break;
+		}
+	}
+
+	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
+
+	/* Advertise host support */
+	val = FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
+			 FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
+			 MHI_BW_SCALE_ENABLED;
+
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
+
+	mhi_cntrl->bw_scale_db = mhi_cntrl->regs + chdb_offset + (8 * bw_scale_db);
+
+	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
+		er_index);
+
+	return 0;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
-	u32 val;
+	u32 val, chdb_offset;
 	int i, ret;
 	struct mhi_chan *mhi_chan;
 	struct mhi_event *mhi_event;
@@ -581,6 +639,8 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -ERANGE;
 	}
 
+	chdb_offset = val;
+
 	/* Setup wake db */
 	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
 	mhi_cntrl->wake_set = false;
@@ -634,6 +694,10 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return ret;
 	}
 
+	ret = mhi_init_bw_scale(mhi_cntrl, chdb_offset);
+	if (ret)
+		dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
+
 	return 0;
 }
 
@@ -778,6 +842,10 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		case MHI_ER_CTRL:
 			mhi_event->process_event = mhi_process_ctrl_ev_ring;
 			break;
+		case MHI_ER_BW_SCALE:
+			mhi_event->doorbell = event_cfg->doorbell;
+			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
+			break;
 		default:
 			dev_err(dev, "Event Ring type not supported\n");
 			goto error_ev_cfg;
@@ -1001,12 +1069,17 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 		mhi_event->mhi_cntrl = mhi_cntrl;
 		spin_lock_init(&mhi_event->lock);
-		if (mhi_event->data_type == MHI_ER_CTRL)
+		if (mhi_event->data_type == MHI_ER_CTRL) {
 			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
 				     (ulong)mhi_event);
-		else
+		} else if (mhi_event->data_type == MHI_ER_BW_SCALE) {
+			/* Sleeps in pcie_set_target_speed(), so no tasklet */
+			INIT_WORK(&mhi_event->work, mhi_process_ev_work);
+			mutex_init(&mhi_event->mutex);
+		} else {
 			tasklet_init(&mhi_event->task, mhi_ev_task,
 				     (ulong)mhi_event);
+		}
 	}
 
 	mhi_chan = mhi_cntrl->mhi_chan;
@@ -1094,6 +1167,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
 	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
+	struct mhi_event *mhi_event;
 	unsigned int i;
 
 	mhi_deinit_free_irq(mhi_cntrl);
@@ -1103,6 +1177,16 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_trigger_edl.attr);
 
 	destroy_workqueue(mhi_cntrl->hiprio_wq);
+
+	/* Clean up BW scale resources */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->data_type == MHI_ER_BW_SCALE) {
+			cancel_work_sync(&mhi_event->work);
+			mutex_destroy(&mhi_event->mutex);
+		}
+	}
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_event);
 
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 7b0ee5e3a12d..a3a9a7f69fa8 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -246,10 +246,13 @@ struct mhi_event {
 	u32 irq;
 	int chan; /* this event ring is dedicated to a channel (optional) */
 	u32 priority;
+	u32 doorbell;
 	enum mhi_er_data_type data_type;
 	struct mhi_ring ring;
 	struct db_cfg db_cfg;
 	struct tasklet_struct task;
+	struct work_struct work;
+	struct mutex mutex; /* serializes bw_scale event processing */
 	spinlock_t lock;
 	int (*process_event)(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
@@ -404,6 +407,8 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event, u32 event_quota);
 void mhi_uevent_notify(struct mhi_controller *mhi_cntrl, enum mhi_ee_type ee);
 
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota);
 /* ISR handlers */
 irqreturn_t mhi_irq_handler(int irq_number, void *dev);
 irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
@@ -419,5 +424,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
 			    struct mhi_buf_info *buf_info);
 void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
 			     struct mhi_buf_info *buf_info);
-
+void mhi_process_ev_work(struct work_struct *work);
 #endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 4d458396233a..d60e78a5053e 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -478,7 +478,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 		if (mhi_dev)
 			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
 	} else {
-		tasklet_schedule(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
+		else
+			tasklet_schedule(&mhi_event->task);
 	}
 
 	return IRQ_HANDLED;
@@ -1049,6 +1052,115 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	return count;
 }
 
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota)
+{
+	struct mhi_event_ctxt *er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+	u32 response = MHI_BW_SCALE_NACK;
+	struct mhi_ring_element *dev_rp;
+	struct mhi_link_info link_info;
+	bool dev_wake_held = false;
+	int ret = 0;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
+		return -EINVAL;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+	if (ev_ring->rp == dev_rp)
+		return 0;
+
+	/* If rp points to base, we need to wrap it around */
+	if (dev_rp == ev_ring->base)
+		dev_rp = ev_ring->base + ev_ring->len;
+	dev_rp--;
+
+	/* Fast forward to currently processed element and recycle er */
+	ev_ring->rp = dev_rp;
+	ev_ring->wp = dev_rp - 1;
+	if (ev_ring->wp < ev_ring->base)
+		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
+	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+
+	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
+		dev_err(dev, "Unexpected event type for BW scale event ring\n");
+		return -EINVAL;
+	}
+
+	trace_mhi_bw_scale_event(mhi_cntrl, dev_rp);
+
+	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
+	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
+	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
+
+	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
+		link_info.sequence_num,
+		link_info.target_link_speed,
+		link_info.target_link_width);
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	/* Bring host and device out of suspended states */
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret)
+		goto send_bw_scale_resp;
+
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	dev_wake_held = true;
+
+	ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
+	if (!ret)
+		response = 0;
+
+send_bw_scale_resp:
+	response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
+
+	if (ret)
+		dev_err(dev, "BW_REQ seq:%d speed:0x%x width:0x%x NACKed, err:%d\n",
+			link_info.sequence_num, link_info.target_link_speed,
+			link_info.target_link_width, ret);
+
+	write_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
+	write_unlock_bh(&mhi_cntrl->pm_lock);
+
+	if (dev_wake_held) {
+		mhi_cntrl->runtime_put(mhi_cntrl);
+		mhi_device_put(mhi_cntrl->mhi_dev);
+	}
+
+	return ret;
+}
+
+void mhi_process_ev_work(struct work_struct *work)
+{
+	struct mhi_event *mhi_event = container_of(work, struct mhi_event,
+						   work);
+
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return;
+
+	guard(mutex)(&mhi_event->mutex);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+}
+
 void mhi_ev_task(unsigned long data)
 {
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index ced83fbb1a51..a23d33a914c9 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -524,7 +524,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		if (mhi_event->offload_ev)
 			continue;
 		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
@@ -681,7 +684,10 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
index 3e0c41777429..f7cc3470bcdb 100644
--- a/drivers/bus/mhi/host/trace.h
+++ b/drivers/bus/mhi/host/trace.h
@@ -212,6 +212,13 @@ DEFINE_EVENT(mhi_process_event_ring, mhi_ctrl_event,
 	TP_ARGS(mhi_cntrl, rp)
 );
 
+DEFINE_EVENT(mhi_process_event_ring, mhi_bw_scale_event,
+
+	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_ring_element *rp),
+
+	TP_ARGS(mhi_cntrl, rp)
+);
+
 DECLARE_EVENT_CLASS(mhi_update_channel_state,
 
 	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state,
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 65e8a397cc50..d27db66e1225 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -119,10 +119,12 @@ struct image_info {
  * struct mhi_link_info - BW requirement
  * @target_link_speed: Link speed as defined by TLS bits in LinkControl reg
  * @target_link_width: Link width as defined by NLW bits in LinkStatus reg
+ * @sequence_num - used by device to track bw requests sent to host
  */
 struct mhi_link_info {
 	unsigned int target_link_speed;
 	unsigned int target_link_width;
+	int sequence_num;
 };
 
 /**
@@ -201,10 +203,12 @@ enum mhi_ch_ee_mask {
  * enum mhi_er_data_type - Event ring data types
  * @MHI_ER_DATA: Only client data over this ring
  * @MHI_ER_CTRL: MHI control data and client data
+ * @MHI_ER_BW_SCALE: MHI controller bandwidth scale functionality
  */
 enum mhi_er_data_type {
 	MHI_ER_DATA,
 	MHI_ER_CTRL,
+	MHI_ER_BW_SCALE,
 };
 
 /**
@@ -271,6 +275,7 @@ struct mhi_event_config {
 	u32 irq;
 	u32 channel;
 	u32 priority;
+	u32 doorbell;
 	enum mhi_db_brst_mode mode;
 	enum mhi_er_data_type data_type;
 	bool hardware_event;
@@ -315,6 +320,7 @@ struct mhi_controller_config {
  * @bhi: Points to base of MHI BHI register space
  * @bhie: Points to base of MHI BHIe register space
  * @wake_db: MHI WAKE doorbell register address
+ * @bw_scale_db: MHI BW_SCALE doorbell register address
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
@@ -373,6 +379,7 @@ struct mhi_controller_config {
  * @write_reg: Write a MHI register via the physical link (required)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
+ * @bw_scale: CB function for passing BW scale info (optional)
  * @buffer_len: Bounce buffer length
  * @index: Index of the MHI controller instance
  * @bounce_buf: Use of bounce buffer
@@ -395,6 +402,7 @@ struct mhi_controller {
 	void __iomem *bhi;
 	void __iomem *bhie;
 	void __iomem *wake_db;
+	void __iomem *bw_scale_db;
 
 	dma_addr_t iova_start;
 	dma_addr_t iova_stop;
@@ -459,6 +467,9 @@ struct mhi_controller {
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 
+	int (*bw_scale)(struct mhi_controller *mhi_cntrl,
+			struct mhi_link_info *link_info);
+
 	size_t buffer_len;
 	int index;
 	bool bounce_buf;

-- 
2.34.1

