Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE939526F
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901978; cv=none; b=KHtK9Rx+SQIMQ4xfxcBF1nBABroQXsjuIZ4fS3ILeH56tHZKe17WPx2NKr3cTVufv2iHSp59Y8edoVIjOLHhJ4wuB1KDtEjaJ6ubTRsG9yTmqASMjhNukD4U1tfRytg/cjfFkz/Is4S3Ty+jQK1/XJ8xiM387Ncxjm87DpEH6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901978; c=relaxed/simple;
	bh=N4lXB4opQ7qAKuk8u1f2aSIoAAZnDbqfns47nokZNK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVIss/afzOrV56Jkr23xusgR2q3i0fhjsY8cgyLOOH44zqbvjgIUm58UWTKh8oEDD+WgC50Cw5x8dw5zXm5YYD7loln6pJRX/M5yXrKFJwpb9mCd6pggKrC/gPrTRbShFQhPR45HwXqxFk4e0VaDSB1V7kz2ozMikwcg5IQzQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXPSHrH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7QrK/Fz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXPSHrH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7QrK/Fz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OuNH2832996
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 06:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AedYKycSBAq/raV/KihAPiAmgc3F5eLdRbQLIE6J3R4=; b=hXPSHrH+fhqGRdUP
	q9eHLRWIYHtW6GtbyWMT9hijFc/5KdWgWVN0gomJyJnd8hpMMi59Wha1fmZVst+l
	ETaihHFgl5zaZnM060ze255aWH0hIWC3hLm/vDayGKn1vwuIHuQOswHe+HixmC58
	A/KDzOJRT53cHnrI9j5DGRbY++HcOD9SU4wgrmS57INynG6nyRxZmlrxfl0q1vCr
	zkyh7FhV8cvqsk1ZiZrOFXqToVtL0do9+9cIxKTxOxVhI1hBOnJV+GFVjB1Gjuql
	gIc/gMnk/PEDO9G1z9PoHLF/8UINs1S2dpYV9SjayXbqTktOiPxc601wKbI0PHo1
	T1B+7A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmreeaa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 06:59:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7002d6c3426so3375182137.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901975; x=1781506775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AedYKycSBAq/raV/KihAPiAmgc3F5eLdRbQLIE6J3R4=;
        b=I7QrK/FzW56s0UWnx7eI+0pCmrJ9u92svD9TW/NNUMxMf5Py3998RahGYHPpCMx/uj
         u1PwHSmh3YFAS7lqaFmt0qVG8ii/csDbo0sQQXO8r0qFx0YnJbrWhEd+giOYuqYwo+Jx
         AVadIP5v0Eb/Gz3UbRGxft/8qJWa/psBPd0kvIEGY41E+93KbdG4VSbruaPX1bwJyNjZ
         +0wkCOEoJivzdLk8dr+u5Q+Hzb30yZ1ROlW7KG2WNW4liFlV2I5x33DuzIqGVp5S98Vg
         3KBgTD4mTrTtWrZme1myjlWJ18FAjA5rrsCdkEqYn64SPagwBSIebWdUW9kZgrC0irkU
         3L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901975; x=1781506775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AedYKycSBAq/raV/KihAPiAmgc3F5eLdRbQLIE6J3R4=;
        b=CnWhd4noExnROEBQfD3CgRcnb/1uWgLKaqKsXu2934jvoG87RbS+u6zVthlyx93o9e
         tPmBk8V8Mjv0T/UE3P1G+A56LT50zf/59kOB62q8lORuv8sZHOLS2CjWVwBTFRcDn1Z8
         SsKk8VAeqot0KeETbw//ymttHwG1TlEoTGcV8iduJG/X6mwh33bmNUX2rIG7p2oSxtU0
         5vhYUFNTQGsFqrgrCLM0aQGebB1oiURtkhESLvaxBpgYMFItaU29mt1I6xYYVF5ZzQVQ
         w5FXG6u9zNB4eEu49RF5q2cKJby0wQDx21jINOfMxlBmBWQPpDN/HuYQOZyl+4jrkRgF
         rPQg==
X-Forwarded-Encrypted: i=1; AFNElJ/rjoNEpsQSH5qworGA4N/cImsaT9/ne0RBQGaHm3ueDmwOtVl2nmSiiB5vKrDt1Xnlh6ROg3IDRc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDe6RYMSTGJTEa6LM1/lojNrPIiWlv2GJK0QbJGxyED2H4sWhg
	tcn5q3oAEdIUTN9EYjPkZw4njmwD/Eru1T0IHlCWnrHdQNxT3qn6CAsKFjES/ueZb3ZnJP3BKAq
	6i2RMjvmHs5W01jDzF39tb7rlCv0FDUigwknEuwyb3luhZhfQCHO5z0u9BQDh4wY=
X-Gm-Gg: Acq92OE+CpiZp+OI/3scjcZ2d8cZ5ZVWFFIj5FqypQK1jDrBMWET8p4uJB0XADLcNEu
	96CHs2R2vRv4XeMcC4OSkXDIROyTe94U/Z73SYX2ea5/2VFQ2A3OHIhU5B2u+AaK++9gcelWrG7
	z7KQK0TweKF9cDZDZiSHhYuUEmG/sGo2hZG4ZgpGJ0F3CWLXBJbYVtTAV7VczEqw3G2sfLuNOCW
	XODvBhvs44VksLBf632UMak5lqBxnZvnDUpopxarAwC3bJIyM02vpfH5iTxLTeJvj3e5OEGmJFW
	HWCbMtNRTENhK9877fvzvMNHCpcLZhqhIQibe6BlYSBPz/3dXBlUtGbQLObQW8Unl5YpG5nJ825
	ZAnZFMnpeITgy+LshyMLj2YnceHnzOJYGYv1ItXQJuPDymHOU1IqV+l1cjIiDZsBN/68eX7yCkG
	4Su/6fRpjxXax8fi/Cn6jhBnS/N/YzogNF+y6ZU4MFPt0/TA==
X-Received: by 2002:a05:6102:80a0:b0:631:ec2d:12bd with SMTP id ada2fe7eead31-6fefc010482mr7047271137.5.1780901975205;
        Sun, 07 Jun 2026 23:59:35 -0700 (PDT)
X-Received: by 2002:a05:6102:80a0:b0:631:ec2d:12bd with SMTP id ada2fe7eead31-6fefc010482mr7047241137.5.1780901974810;
        Sun, 07 Jun 2026 23:59:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:22 +0300
Subject: [PATCH v2 4/7] dt-bindings: bluetooth: qcom,wcn6855-bt: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-4-efb68f1ff04c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=N4lXB4opQ7qAKuk8u1f2aSIoAAZnDbqfns47nokZNK4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhLefQFtHVh2ZE5dkKFHBcXKIIkVHYL9/M6m
 O8ttgGrP9+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSwAKCRCLPIo+Aiko
 1U4QB/9K3hMSohuH95r/Oa9z5CleEUZa9trHYMzkZSs4atX3e3oJ+ChcjsV2CqnONdGXXsumJoi
 r0dU0wohcdC9sUpfzUgOjDFrCiebbeD5sDDwz37woVSxK3w+FHzup43hPyuYbtHt5bGWSmvAV5A
 yO0N73dtOYKgobqSW2Jp6OzyCgM30hqO/5lcAhgNfQFkkzzMDa18gytiVJjFgy6/MhVDLFP1Tvi
 ZzcuGwZcXa/rf7tt/cwD/9BKHe94vCVjZXGvT2F4qSHAgtYl9n3SmCHUcsV6O9MHyvF0Yzto/+L
 wIzPN12ka8f5jj5HbdGkiHXX+SiSNQC+C+JTg8GyMJ3YsVhl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXwSgkXt3G9QF3
 85NGbYXW8TkkG8gw5DQDnInFHF5pZSAtRZai38JWSaVSoLOqOuXY0L4XeELzJCQo/L7VpItLweL
 KOII6/uN8x0jKqqexNzPZJmaCeDsiip+lw/FYj8J/0XZmw1TFTO9YR2Xih6ZtcHsWiRRmK3Y0FH
 Yx9D2GEGPBqbR48u+zn8uMiEpoyDer8INPLlHA+S2LMgxSI43MEhaYXJrLDm8tigYSup6Dk5Xvg
 obEFmI2aoo759XW+vRm43mZd0zS3HRwT+KHGqYvKIeFAWvLxUjJXIC0H1N/DaVkF/M9qDK4C6U4
 stDhGHLrYVX2mKKJHsC8JJPV+aNe8g6X02jUIECugRkaL7NLCjiGjMKRSQMVsNyPhheaiZVKQL8
 OvT26+NND+G+Y0F1HpPLHZH/+84HxmE2c39FFsZzeeSddoPtKtcQfKBcHBr5DxLBjqA3F7ZE0Wn
 x5GbOI+ADcxyWlh8Geg==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a266857 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=dvh2RpXz9-UaKh2pYLIA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: GFSl0KlzJ7KWN7BXKQDubjFTs2A9XsIn
X-Proofpoint-ORIG-GUID: GFSl0KlzJ7KWN7BXKQDubjFTs2A9XsIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

