Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE963B4EBC
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910237; cv=none; b=BtS3HllDLoekg5h1KubLSIVsUnDg4MLNiWMlAS46PY8LG1BAm+1/PcteYTKiXSoCDC+0KuavzERtKob1PFaZKzaDO+FDUPM2XulKZJY5uH3PndkJ+Y37hGLr2EmOaBIvbFssvXWIhBXXaFqnupxh6tKf9lImPryVAJ9ByguipgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910237; c=relaxed/simple;
	bh=VC+OAXuz8EAO0x2CZC4Csp47ug8+MAbajNt/UTVkJS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ie0cgxvAw9u2qrXCwgtz2jR40GOX0+FN+cYHScRX4hF7Z3YrSLCODB4weF7Cm410UQPyitBidvjiEalKE+gi06CJvQI2GNpLfmlMBVNAqZEGzNZG7uvxDrHR69Pc4ko+s945+8ExRSNROyWtvro6idc49lwl2AOsHzmT+05JyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nm/j/93t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BF2cIrQi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nm/j/93t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BF2cIrQi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OnoX2802065
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 09:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cGbKRVpcAfB
	zmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=; b=Nm/j/93tcKam1NhBCXoXtouwDoM
	1BONcnKJBWdwlNCe/bE47ja/gwnAnxPISiWHM3uRRhJrIdqyYvMWCkFuV9hpAA7x
	vV7YnI2mK7MPzoYT4mLWz6H3GSts4Bpbh/Tg3GT5nmgzqMk+I1x0T+cnqcL6sfA8
	7yqrGFE9TZrwxBJ2EFdaUqRAUnCmq4NLCke8ZGOlR6bQ6xGYXUpo+GuWt5KRkw2l
	pWUJ341K4cVDecusc6ON/3zAL3b9Bx1Jdqtv79ZKkZg/99jqWUz7i6GRnMBEEAHJ
	5yHxFo3fDS73a/ICUryzG5cjLfuC2tLpt07xnoXESF5X39KO60kI2PLgEpg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3qegk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 09:17:15 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-13825f68028so51665c88.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910234; x=1781515034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGbKRVpcAfBzmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=;
        b=BF2cIrQiuqKKMM2PijhlhbGH98wITK/xAxWdU0nidWTq4dICHLys0xLMpzineqbv1m
         aa41ol4l6IGfAs9Q1VkhLkG6tU8DWyPKeWb4rYOVESwBBZOwXfgKvKFFE+jZ1tRFqy/9
         6dY+ajBm+vu7hWLidxPOTKT1HNLqjvGtnfYfg0YqqGRS3ZNpz9GDnlvZg0qD50R38WpN
         NaOw9jJIyj2TvuQRoFE2uALHnt0qeFZjeohcwfwRIZALTRWzEPoREZJPYF5Aj9WPTL2z
         oqlq1TQq4rqV6zBy57Jy5oXT47F5dAJ0xiOiKtX838cxBWOHjkbyBiESwaJpg6vmnL/Y
         +HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910234; x=1781515034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGbKRVpcAfBzmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=;
        b=EtErtEZd82Mh1aG3dgmigVBnPcP1M8QOS4TEQxErIguB6hJEEGjNITbgWClhGXJ/e/
         osrjVGb2dw7SrghJiRqBQZBG/7OQaMcqb42L8PwFY2O1wsvcMip7MlqA4naTc3IPPzvT
         Amn1s1bL+MO8RlD22DjZAZm140NhxgEJUHkt6qu8p5gT1sXv6AZR5T/U+JMPcOzYq7TY
         dOT6LFBt4hGj2oT6FIjy0ytt/jRAil23A5f931SQ+D7iVF96xAcUdWTZXHos4fnk+9Jm
         dqaCtrrHFmDE9SEfG7FHbZK3iVZns8CPIHr7sWgwZfN8K9oX3uCJKYdQhe9EgMMwjIIU
         S1Ig==
X-Forwarded-Encrypted: i=1; AFNElJ/D8CMAS6P4hYgKT5dIxkutJzevD9Rm1aO3IwOfmfyGGGZo3gvuW0g1m4RclK+lPqhUDRjpLydtQRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQmlG5pak/Hh0bQPd1xI/rFVH6ZtfV2hibXVrDbeE0HdBrwbp
	RpnXFm/0/YGbvfCcYtUTBFhjtypCe3Hfwt3D1oh2Noq6FTKhhZEbTmtz+jYbs9Xevv+J2eDBzsR
	qOX5RQprHJFj+jHO7Cf/9i+Ff6OpZ06c5yCHxlA8uOMpirlHfRCbhnl8As3QfvVQ=
X-Gm-Gg: Acq92OGCTSlsY4GPsjJd9JOoDUBsPx0+RII17fjNxLn4+26gL3QG2uql1Pc3Vol65wI
	8eZACyBzBknyuxFbXtxe1qL6K5ZgG5MbU11kN7cjEeUTAW02/m+dUqhY1t/5dO8LgxA0Qxi52QB
	4WlC724HYj9o0L71xN88R7evuYt6JNwvALW2eOed8IutxFYu7KpZYS95yJA9u7izSzeK0Vi3gUl
	IHzq4Md5Dvz9TXrmvzx71uwwcSEVJTay7aGm5NW3HvPRmhASFjj2PpeGq3yy9OurPpnT+NXiewb
	OV/rOS/rjoRso5gNG5VYZuTkDYeJSbIuB5MxhieDtOqQJe9MF1/+SdGnZZj1RXL++bvIP5Ds44K
	gg0xTh21HYwn7ds/mZbZa1WBeyI+be5NCu3qSRM5VEQkI8+qOfht856GyM9VOirE/VzwCcpBKH+
	QuRZuUPHg=
X-Received: by 2002:a05:7022:fa05:b0:137:d966:d890 with SMTP id a92af1059eb24-138067af64amr3099087c88.7.1780910234055;
        Mon, 08 Jun 2026 02:17:14 -0700 (PDT)
X-Received: by 2002:a05:7022:fa05:b0:137:d966:d890 with SMTP id a92af1059eb24-138067af64amr3099082c88.7.1780910233547;
        Mon, 08 Jun 2026 02:17:13 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm12178656c88.14.2026.06.08.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:17:13 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
Date: Mon,  8 Jun 2026 14:47:01 +0530
Message-Id: <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NSBTYWx0ZWRfX2g0gWXUstUBW
 rriivYQJ7B4VRFT7cXZatRDwhTsilTY+7WI54vw/bktN8Pqh55z5VgdGTRWjRip2T91uxiVQYZC
 yBsLdiuBhT4IDegrJExmWMlTwxEMz4MfNQzI6ZJQzUrhlURyVQWUaeDR/KW8Zqs/mtkVFyocT6d
 UbBBI083Kgva0xauGF6D767jwYQuJ/gFpl4osyjXwriR8ycPetKNM9kHsRNB2XAOV7o2iSzZuu0
 xcN7HDghxVpEfVL427MhFPZFK5jvp34Mytd5RDswGX9jTIHiSVMnW/LqddAcsl89hOce/VuS6we
 dhDsfzaJM3tXI2x5ZZNvOhpDPv7826B0eQatdbKfKWlApy0FL+gRAf39LPlmOmVYhAqVRRH7qEb
 5C5o26OQfRPMHNGT/TlOycH92wn+nIunirZh9kqDKPoQ4csbMpPj9ZiP8tfMREWjy1Mso9XAFj9
 yIQxpSnW34ike06cmhg==
X-Proofpoint-ORIG-GUID: 84qL34fEGlWFtHRIhoUPNF_IF890wFw5
X-Proofpoint-GUID: 84qL34fEGlWFtHRIhoUPNF_IF890wFw5
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a26889b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ohc_vuBGHJ6k7NFuzkMA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080085

WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
(WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index efeb25ba9c79..b3af14464314 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

