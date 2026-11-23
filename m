Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442178;
	b=rf3Pfvty67WKuAhNZJbJGVZVBbOEowYdz6NTzd8HyIdfEgDoXETzYb7lEV+IUa6oI2b1
	 4qUVGOSQpLxgZANiTJ0kpB9bwPM1E9GLHGWSY6P4s2LBatJtpDQ5lTVu/yjXDJ2WdpUSG
	 FsAlMhrtoifnnv8UVHr3Nzk1daPzmbhxCdjV+YGXU63fT/gKRujxUGNpAbxu+ddwrOOS1
	 wlOd0s5bjnoIR1hRKbTh/FoEgSGHTKzBJgZlidtw88U9QVP6MMNxqnE/ZtHT0WVXINZam
	 sOy8jgDy/L/rECB/EzsSGDSU9/IOffFhRDSTP2i5Edt5JJ/saPv5x1Q/Bc7uEZIkbGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442178;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
	b=Iq6cBFnypQEhWuDeZCYdZ83tGhRhguPCMmXwM0gX7KIY5IDW33fWrrQjp5vFn661WZU1
	 FNIRRr8uqh5uIUp5sZt3J256fD1M7TomMMrPLxbEhC5/o5FKL3Ka5xY7e/dYpq2M7VXkR
	 QgQu9nKBKCvKRwAowtrbMNjdVGS1axmSBpyRONNlWw0r80AfaidtIfsFd7Gnl5ZyqNM0G
	 JoRuzoxA5ZFvP0/CoWl2uVgnJYcClxlz2dgR4j5XHtB3rHIE8Vcpz7N1W9B4vBEU/zqkr
	 hNDgYJhu6gsHo5SN0gM22LgM7s0xPYfi2tgihdjdwGdFwgsqdzu1B6JAtjt5V6GoHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EC60A2600
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025EC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL0tf3072380
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=; b=YWRyANkgd+upY9eN
	x8GYfyuWfYQNwlVOeyYaisbNxgEm7+4kDzlWs3+ljIdpEXcfNpfQGVAL3nDVaE7E
	DqlNrig6WW7QYXvCxB7uJqS2lvq9+CMiLP60JvassDtV0jcivDxciNgZqqJSletX
	Fi6rmOErx3+nMHPdHtvG2IWQJWWkY+AEvqprPOeAPe4t+xgQRwOHJG02H61ujdLg
	csPhpP69yqRQRlbIaiGlPGqS2AA4mxAWW5Cbxy1YIuMO9ACDFYP9L6hVeTibn53l
	YdIffD6gaJ09cVfAU5zNevjBRbNSdXkSp9EsKj09ZbMINMbhhxmeN3Y1Q78p/tX/
	xc/tsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7s9rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9495dd0f07eso627735185a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442176; x=1796046976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=InFUBf6trzgIwBCnPI5YKA1Rv1Yi19wUes4p2rqeSsdb8KXhQc06JbHCDHDRwWu74B
         ZgBHg57GfioDTCiI+BxJQJ0cQxmDsghjK6KxtuPUQCSR3PiCc3lN8lv6JAbp3H5gBRTM
         g1cpvuLD4E4vPDxhbPpeshsFnbilA68N66mJn3SpjaqzSP9LdVFtlzi9OBoiGpR3CqVb
         JvkZAv8q1GZntudzAsyiC6/IiXWsnNA4XHkujJwYjkWnMFsPSdchvGhWRKoxXep01wEx
         rPLVSr4UONQL1sR6+yuYvZu+sn7wb9DoWrrErf7KKb7cs6gEtg5DS2TVVIKee/HxmDat
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442176; x=1796046976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=jDFy924Zp19+fNagW2yacyDvECLdmfl5DxpZzWDLkHByL1nOnRUn2uR96RNWK+iXu9
         a5pSySC0KOgnAaRBACTf3tFOElKSnNYVXtlRlFL01aWJjJPJEV8aaVeNV38fQbdJMrKd
         bnBxfiQuc089H7CEJW+Gh3XLXWFdyt931rkXSOAo2DW70BA4lCs59nljPtlZqTiOwyXh
         ulr4FS1BDJtUqCInnY9e4+PG309n0Jb+Y4Yo09VRV0nUw/9lqdwOemjojrW5hLy9Ndg0
         McgCZocMpy9uhmZ0pz+R8LxmDNmL6qTMvf8MuPBUaheOBS2683y2CLPP360Pnofmr0WS
         SwHA==
X-Gm-Message-State: APuU4Z/z8HxjIwQlzc/sYIROba899wou8sW8QCPv3xHD9bYQ8jSEdeJz
	7q130LOhyczD6fvfjNJNT9q+zCgBNVTDec7g8UbQfyBAfnf/daSbaeWEBW0lUZjYYlPAyDR+1Zr
	8KUef31eIW3H1U54FCJAgcU7KP22fpMWEuRCRe+4tCzqe+B2EhIb3SLQux8lBHVY=
X-Gm-Gg: AZFdTZedIsSPjdD3J9va7ooTtEdes0PJ/5zhq2a3ZScLZ54oBPw0jfiAIcvszQ4hsHY
	ARTUjRGOF7uRgouUizcCobhf8RK6XQDdg3l13f0LDdZZ1Z40kSTiKn94y9VzzGUDW8gAJ4zRJkd
	CeERQ5r1f0pO7ZeQX2phH6tghn9qDvYqtKH2zCsXHT+iZCbWIx1njWY7Je/Ghoic1i7f+4apqlR
	A9gKXM2BSJ63c7XagQUQSz/1BVMtRmpYf9jqIvBMjWTO54jgBvmnxtB4jr1oFlIBEtU5LR4JhdY
	Fk1Ods095loyhXXdTV+FcyxVozO1bVLG17BMSHfo4mS8iOf/iB09vYoDlRLNVePNqZC9bgagWFi
	n+DAVPgrlGPoV73ui/F8VtxITy6H9iTTtefjyiNinVcxZ5mSB8/DndCwZ+RrK6tygNd6/IB+QbG
	R+YvHAy6a+HsVkNNGnAevP9VKrAp7PSYUkqGnfchdnVrP0taBSwWcZhdqlxRQh0kU83InHD7lIB
	7m2XUP5Ro8RDJg56CxE+gbmiwo3
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951681385a.35.1795442176200;
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951672085a.35.1795442175472;
        Mon, 23 Nov 2026 05:56:15 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:14 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:09 +0100
Subject: [PATCH v9 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
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
Message-Id: <20261123-monza-wireless-v9-2-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b044600 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=I95fhSNaEobLycDSJJAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX4jQH4kOeDsvX
 WasNuwomc1mmlF++d9XNwFuvtHgWUetGAs6tXR1KHDsDTMead2Mgq8J5OKZkURZxui6PWUkkbJQ
 4PbQ7qqf6myTWcbaDneNSHFdBXYaeNeydWoFhTYU8ifyy+9UeWSiN4sMYTyz2LZtsF5SrOKJfpu
 DVmmTMKS/QjhOJevvlLAjikxgSm/SfUpynH23byb/UnPb9LcDXeKupmj7fTxZe4eeG/vxln8W4b
 416U3e8UhgQHPwdRyhpI5zNMsGOIVsvIGb0tcCoZcYiqf96XV8qGmlNvsvUAmjKgCdc+zvnDtZ+
 fmBX62Ln3DalFujx+6JJtHUhPdu914yyQ+aAOXUVRve+Hlsy1+sMrNLifaDZAEOmn8Z8kLFogEX
 GSwf0NswLl/BlIK2Z8/BiEy6J5CPsy0+KZerYwxJcHooCcEYtytngNq+YE5w2bltXnFCY6AyFmc
 rGUCzsAv1JFY3N9DWkg==
X-Proofpoint-GUID: yvIm3KRTR0FUR9a8Zjmane9a8VGJieYm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXxerVq9MQ7qx1
 SXDLHPuUJSQLIXdz1/n3UbS/7nVgxmgBpj3yYsLGIcIJsMvxa4bDPgcSInGsRcaPnzQWTrVSEa1
 v3aDzUqM4rWjuGb9QjUXm2tHeq9E3fE=
X-Proofpoint-ORIG-GUID: yvIm3KRTR0FUR9a8Zjmane9a8VGJieYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230055

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c4e42c9542adaddee17e256eb017902ef565025f..5544dff9d10b5064797d41294b126fbc229a8dd5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2584,7 +2584,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2623,7 +2623,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2641,7 +2641,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

