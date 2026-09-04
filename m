Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324448C8A5
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536553; cv=none; b=hXDu5j1fZHDtCftNZakeY1JgoeZq6Z4iGubKgXMUkDMR1zp+kTLYWo0kUe5Hg7mvYxKKnxULbwmE65Uw+ZIVCqa+HyK9biL0nDWptp+E6t6DUGpgseJRGAUIJCl7yn7x5i2Se606d38QJU6Zk5pmbzfBOsfxHhYTmWIwFCmrX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536553; c=relaxed/simple;
	bh=OAyBvAGn77FVJ1TEIXYkJmoJP05YhYEzxSuqREVqRmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGVeRq+mBwEsG0/UJSubwTmSMMaYJUL1pWTenLTMj6RKiy6juytu+t1RG6vNAWBC513pruYzMiolBgYCUNI0UVBbPXHcMmY7geHl0rKLhzXTjlUx60GFGlF2LB93FRineWTZXaE9mhKvcg9LU6kIODfhaZF7YvB/jErh4W/49Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGBeXoFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R+l6nJ0w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGBeXoFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R+l6nJ0w"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dh7EZ3891047
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=; b=iGBeXoFAs1uNGu2s
	+Pc6BIlzA8meYia0mNjGynetdm2Cg/bNmAvjt1IWU4SLOw/6ifb65VazWT3UPRNT
	eUo9SOuuAsvxCXaVJMnFGFT7DaajvVSk26ezHGFQVJa0uqjH2jT6ZyVQ1KLNAgvu
	b/EOZdr2jC1OFSGDQdTHHliLXv/29B+MgJrYbKnnQcKIEjrbCCqzHEzFpo4e3J5e
	pDfGiVZqNuGFMf5tXcjeyHBGHB7lnTeLGHcSUS+i0V241D1MEHff038ovdOKk4FN
	5kZOtk9Qu9ti1nkZiYrrUPxy//waHoPfT2B8tts2TbgUtdvFawNgk4xYQxwg2UB/
	wEUTSw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp7839dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97cb18cfa04so881353241.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536544; x=1789141344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=;
        b=R+l6nJ0wjzcybw7ETQay/f2YHnCmDQox7JRoghaIYOHXNGoiKzY8X1vWcm1+xkSrgM
         iWZKGDf8+MtNI5vLTT/om3IPdzhE3NTnkiyB0Dv0mggXZcGtHcKZuSaIa864mqKjMnuY
         bl+nj6yLEGd/JF/0dtezE0jXl8gv1BN5yw9c6Jrh7ZH12CruUQTI1u07WGBQ9Gg4NRy2
         9Zj/oFwJL/h3jns1DzMoGwyZyWIFu6WUDKyFYABerqk4ubxt2CrL1vKwlpvtdZeprBSi
         izlnQRBkGlI1xa5e4jb6KERRc5ObUFiXFy9SzV8zsbyoUjeJmmqi/TImExsnzpdCzAky
         f+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536544; x=1789141344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=;
        b=Uiu5GKkNlJrFs4JSy7p3/OeH0HnKWpx5Dtqdl6jlJB1BzZoxG/PdNrQbG+pX3ppTRs
         z+lsQeRTTLD4KZfPNKqZanzy/0PT/DYUkg7DryquLKICc9XaYQzn+P1APwwMGznE1gWu
         BYgHhd3c5+BngQPLQbab19T1YEAUSlp6jXCADwWoRF11KAoOtdlrLEm/4PQ8gFTJPv/k
         MiA4nfC1lEKGP6RkmA3MVADwRmDjeCS2H7MNHPAvGylakuA/2/cCXX2rBuiP75EZKliK
         eCpDE7lqk4goIBeGYJJCXXt9YgGKFsIMIx7OqHch2i4jYwJlLH2xs5D5/gTrK99QyKFi
         QHlA==
X-Gm-Message-State: AFuF++m75u6XtaJKKaFkmKWxVaHNjMHUdudfo3v6wEW+IBmzQGztIaOy
	FQjHf67940bHIUbMIXgjkJvvvb/ob1Hp04FvdE2ZWUwylxJ8StbRaGHxalw0bkjWCCtyVFWf/Xa
	v+WII88QOUCsxZVMP52H65XS7499C/jVkJGVLjaDEflQmkjKJqLOjfOskjGBGr9w=
X-Gm-Gg: AYBFou3dFTwW3LPgbyYvQhPS2s3hKrqJIwEWmqeZfijbMu2um0v815q5q7hRP/sbfwg
	LjU/mcXXcnJ79JKBV5En87iIboPvA6+/SAB4Qv61T3d9DVPnlX1ITRVw1U4WKaKElswdUwnXdVJ
	TRMBImnhYsc69rcGYjaJVAQse1v34dtfMr06aENrrzlrTfsMIfvtxD4+cRST2LRfFNmWev+hR2K
	QihskFRdUCkBhZHLYhq8BMvwcbQjBjKYvYRv8xUd0l0/uFTXF2nVt1zbngMxDmZhFd0mynxp80l
	0tLw1UpcNB8bBoMDAfeAdKuAC0INf3RNgWSnrcdNXar49lM1dVuLzOYtt6ocdLqbQRutWHtgv3Y
	lnNvLgVAbhVBxXtUP+VwlCq3DcVR84QlDs748B38HrSOR6bnAWqOSv975eYK1SHLnnXcoKTBwBP
	aT4Me5M8TWeYxhm2Qe2qWXLIJOgSWYEV42CnFZTrQHWefpRNBwBJo=
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id ada2fe7eead31-78a4a9c40c1mr2809075137.10.1788536544037;
        Fri, 04 Sep 2026 08:42:24 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id ada2fe7eead31-78a4a9c40c1mr2809050137.10.1788536543607;
        Fri, 04 Sep 2026 08:42:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:17 +0200
Subject: [PATCH v6 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-2-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX33b/V8MPngW7
 W5jFw7hcAHqjZXrhDs6oP7jmVZ5UXmirQXWscoCxR6Ddv39wlMq9XPKJv5l1J7r1omg23mPHr74
 msuKPOHKXDkzraZaZlFuVeZtZTfOpr0=
X-Proofpoint-ORIG-GUID: EYozSWg4bGTUjODLF0lp8dm5AKb6On2j
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9ae6e0 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: EYozSWg4bGTUjODLF0lp8dm5AKb6On2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX0Bf5P80f0tYX
 OgGvROyaFyaiC+niIJh39SuEn1Sa3rRQYwPhQqMhFC8GKNYARirBfOeSEIYhs75MabtIP10lUCm
 gxNHYlEhHbA+ONiXIXwaB9aWXf5yiz0ZlJNdKxKBvevgLBO2BWyWBHhMiaeaT0AZVMZl+tKrZf9
 yHbmRFvBnXEnViGXHK+Z8vgvHaLT6TGnoG8RgGCIWJdrkAzXk+y1nXUsKSnpitBZ1OJRZ3FBzty
 oICt9Ds28YHlwXF7AUUZcqkJaxsZlH3OLX4hr+IBrF0VXR0etI5Z0tlCwYZRtwT/5TfQJwHOExM
 pB22R+bzivGdcahjhudNusEymJYLgUE9pqvLlpriNRYb9WTzzeo4pFoMpJJYqkbSXFR/BoihRWO
 A7itXQmJ2+HXBYTmKs3Yxekpia9L4LYgyDkAHIXjkxIxziPA2BcDeOSXl2V/6r1pGUIPmDGr0t8
 t2oLGgJuNQHVCUwCZbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

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
index c8ea5507bdc2c83f214e3154b5ad6d05f418a1d4..f7a20138cb742e8f6ea51d565aa8da8751f21f37 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2396,7 +2396,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2504,7 +2504,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2542,7 +2542,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2560,7 +2560,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

