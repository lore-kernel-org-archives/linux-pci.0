Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5973988FB
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307234; cv=none; b=XDdVzqtDSPnEcJu6GL/grQ0uEqgLjoXbOlyrBnNTnsU5NpAw68hjVBZpsX+hrNUVuQgL/V2Xg4+TL8/mxUiuxA/a8lUqPKW9LiqHBvjGBZXS+mUBy9K/dDzn9zkTRhKW9oH2aPCeLh8Y6CIZxp/3PF0sx+hnD1AelIftebcLzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307234; c=relaxed/simple;
	bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epT0bgPwBJbKnqRttPfzqCbqZJw5UYPGMzVzjmBY5a35ixeTVb0ehhplAQJMIm3MeknHx59xVH7coIwH2NsJ+QaKpjlmhwyv2jWKrYO7MQGJe6+t/bwOQQFbsa3fkgG6vzZ9pylgyKv4wSEu31ADSI9w4CEmblQ88sMC5grg21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4Lwew6B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePt4/70q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Lwew6B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePt4/70q"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fXxk4065646
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=; b=L4Lwew6BYmpAZpET
	uHq4mtGVCxQZUNjMnxV3CC4hzBtfhrmfd7igLZjjj0sidERPJ898KZaVPkAeu83f
	OxAZw/BKROk7Sj2YkW8Jts6KslZOTurqlZWSA5vqYrWjKkHS6SnXTzHYevzAMu3R
	qnNl3BS9aO79MHakyoXmfhz9hQtdwiCvldtNOZU1TB2z3tjofliUELawBCusx/bR
	n0ZjRKAVHXg06cWceKTJozqjeWY3AZLdJSqbYysjsxRKlBmj0udfC2JospiXICUM
	6PGjTCT50C5qGrghFHU4NyDkbarxyb76y8JFl+H4isQvysTcN1hUmb0nyvXpfQov
	D9IzSQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6swr9f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:47:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51736a08ce6so39046801cf.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307222; x=1780912022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=ePt4/70qEtUbzziph4ordQaO8Cr0dcXiB0CGxKBuAup4Tc7Sw/v+RQZ9Q/eir8Hr2I
         RrZYZx1xkNvDLjQ8QDVg5CTRc7WESceukMHy0f4r3F2TPmgmq+2QN3kMZPbLWdOD3Cf/
         3HylN5wJnNYlBAUNnSaKeqFGn8KVLJ5hJe/jrcdcTk3geI1WWkyYQhB/GzKwRA9Xe5D1
         fo4yNRjxc/CAB/UQ/VUw0l+tJeKXqvvDndpGCYM7iLrgJFARTv4aw97IXfwrhO0/2fUQ
         sPmKR7cGkIsDZA71hDxs92Y5tXOIryD3KXaga4WmOatKcG7wq5f8SuzjqlKWqm6tm4sJ
         bcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307222; x=1780912022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=MZH/gBa51TLOYIxjxZm+ikApKb16bfuJ96fEf1xkSGrl8On6HiATCwlFKxwTRzRcNe
         SdUTEINfeDrzB40u3KrbFEK90kqtiSMIFKHXzTxJ7FwGft8yxlFMHNi6mscog+2OxTN4
         Y6Ksct/0mEEJNyWrRoFDfKxPBgjaB9eM0KR4pTaYQNfY0dYtfCYFtRol0PV+S8ZlJI8X
         9qUip16PgDWHTMtoOFYhha+/v+v3244J833wIjE0CLbeOStgwTRMsJ0T52pi7IZOqfI4
         4B0jbaL7LVt4jXP3WJR1zypcndHyC2/3ZXnIC7srWvixwBnLlWCv9DI77ubJq9of5dUB
         8K1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+jn2l7zVmwmRbnGMFMo7HjGPnqm2Ec5Glp7wgT2sMiRayLqmgxlRWu7MpD1xTotCQpFZRfVJPVMHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/BI/DKeku3ZvX4lVggBtMBvB7dZkiVXb6XYb/WrBiCYClZK/
	g85q65sVdQUlgah6GaaIdk+JiDdsln2IHNWl9IYqZUK6OXOzZqgQXC9yPyiJcd5HB00SPl/0z74
	V4VqBS/1BG2797DSqzEtL61N5ZlgJXo+tBKF1QidiIu8QLfh4MXmYTNd+Itd6gmo=
X-Gm-Gg: Acq92OF59VkKm2Yq9wi0uMSbSbr1T8G1e1yLbRrYlJ3aKA6exSyqUAaO0sykhJH/Z+m
	roo4F589xIokRXPavaQv+kYleTqziy/GrEL4pzUj3ROy+ng0//927PNRQPEjjA4Z1IgNQYbh1ZT
	uHMR4hVF4N28W/KtFKDXEc2l0/F/ukcX8vRxQBHoJBdT+ykQGckQKIFqq+Dtda/i8Eh7ALyaMBg
	vFcRvG0YCLhhSHXD4G2kZZRjF3u4bNJrMnFm82TLjv1eBNihNsiEaI/r7YlcKBPX9/uW6ucKkDp
	xPeAQkHm4rL4Y9dByiz6A70UFNsUVMFSzCl6T3uz1Jfamcp0+VHrpgGEYkp9fnu4vHnHxnhnK9C
	q4y4Y0kUvfZcOqKmovEsY+iD7dZfceL7jAP3mt+MsSP6s+bvGxyDgqqHG37l3WNnPiBC4SnHYAC
	0w4idVMycIuRmmvCHtD0uZTp06piYqLlk9yDIrNPti4ZRGzA==
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691791cf.28.1780307221800;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691441cf.28.1780307221405;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:52 +0300
Subject: [PATCH 4/7] dt-bindings: bluetooth: qcom,wcn6855-bt: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-4-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKFzA2GWzfnPbRBNnS53Q+2DwhhafI85JAG
 lkifT4EHP6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1TRLCACzFCWDg8vta0kl/Q/xGa4mRMzH/xV5T9QwD5QgcFB6m/mbqBfpwArl2qrB7+QImIHy6ky
 RJo19vvWTsrpy/+sirk4YeZAQUWPh8VcZDHbHc8Pb5eps096styxqBgKh7bLK4YqBw17Tb26H9A
 XP9BNsdX91u6ESQLUeMCDyrtrzNRZqu9EvZ4w3jaYtrn/egKh8Kqe1NcaJUgWwsXxKZlWuCV46A
 K5OOz2knudfmQxcsf94iP4X21eov3JvZadH1H/Sq190qQO/nxHoxk9XIn+VPnVEBM8AExGcP5LH
 c7Jp1/RdMTRgcnzWPbINBFsPk6VDwXdh+4KRhhs10LRk+rhh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d5516 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CPtQq55eJxPKLu9fJ8AA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: WYjZtTblUFIJTQjHs1jyPj6UaRWdYvF0
X-Proofpoint-ORIG-GUID: WYjZtTblUFIJTQjHs1jyPj6UaRWdYvF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX4OKv5eIq7XW7
 LmBFIS5U70VWFMJBQynQ5y7zkStpknssoyqZIkOhtSOXk7+Ig9wTl/ds5GDi8Vl9w7UkCOs7HOS
 XyRHfP6W1dbEFyibgQJD91ebE6m9dEuvr10605UPuBCKelyFSHL1bh5G/Wk9ZsrjVaJSBRoJB2N
 8Bkz6ovRAmdCc7ZJMQTQ9HiIvbEe7mksPGoEBnZCsKZ0jlfkM27V8XK2SHf4s2dpE7CSpEOhu6T
 yUgH1FXWr8M/TUH/OGvYwVhW/kQyVBcZMzZkUyNnUxynOHDVxUqGULrEbkSG2aXqC4Dr9SUA6po
 4dtgLjvU4ZzdHbx/SjLtfvS9ahitTZ+eOAGQMw+VE8xn1iWqDC8N9q7jZ67tIeDgByEbot8T8Tx
 dieodWzLYEae6v5iwGX/ENUaRf7LjP3Hi5RFvGl08m8s5nILNzjSdkWKXOevNtkiJjQpt5SEFOR
 HfEK03K6Z+4JFOMwoDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
index 0beda26ae8bb..ec766f40a042 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -13,8 +13,12 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,wcn6855-bt
+    oneOf:
+      - items:
+          - const: qcom,wcn6851-bt
+          - const: qcom,wcn6855-bt
+      - enum:
+          - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1

-- 
2.47.3

