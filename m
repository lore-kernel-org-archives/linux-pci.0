Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C73F6C30
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724323; cv=none; b=DIJoLtTd8ffVmefPv8xneOn/bU0QmJ0/0SJqgVkYCHrYadt8moGsS0YQdeFIo5+5VZxFXsLps18hdShNlzil3YIG58ZcLtqOYrDVf5tumK0QP/5QOgU7gxphRhIvWI6iGytwcHjkzz1GJwSGf84tUeQnq2e5L4qIcjfgZPVHEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724323; c=relaxed/simple;
	bh=474PNOoqPhwnp7znKFV3q01C3kbdlREQRa+VBgB/Bek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJQQbQPGa5sZnI2tPhXkiCHMLrOjd0Z85NJYURiGZGvnXvW77Z+E5WDBlfDhcw0iWGS8sSnv+Rn62Ws9mJBsDBZcnkipP20BxhKDVf1SdcSF4pJ0/v9EFkUJFFCla7vDUwfOJfmSeqlBxK0UHQqCyXQOX6hyJ2yvYSQh103FKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6sHJGB8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R/0in3jC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6sHJGB8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/0in3jC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xt61716921
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6
	rD+/ffos=; b=D6sHJGB813uSl9CLhi/yRKnBCJ+DYXAcQEBe0N6oIS9QRnLpBnp
	YOCpPP7YYNT0R2qIB4MaQJ0I52WuREjaFHrYbPQG4J2LTCFFNLGs0SmPwjjRlKBg
	0hZBZ5ZaGzSEF3CS/bpPx0cm2YCBgQQV3YFqbCB3w+Hcvt+uD7VNB6oKwI40M2st
	JOX3/1glVS2+RjHdWv7QsUVCAPMxk6zOa4Vb2W1slUcPk73nZEhl7pHcmJktPF/F
	Q6YndOPdpVxoY8BJcwUzFpsQxruac1LikHVi2XFMKoJEv0105sjotnrHlzUbi880
	vopIlSIf3JBvbt/IWAoOSch4HcvBkYLj0ZA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg42gmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:38:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91258c6ee64so4539066d6.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789724320; x=1790329120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6rD+/ffos=;
        b=R/0in3jCA3YQwybD0zw5HrXM3U09wxTjqVSdh12tj9DwahlOxM0Q1C3iBtIcQWjMBO
         87iqiEF5QZgKdQ9ltW3jJiXZq/2sgwfQuw4WsJcaGfnoVBNU4OCyoGckANmTlYQ8jlGV
         W2G8QS7gFIF67+6x0VOfPhumMzx+lIMRe7b3OBEcLUnVP4m8nYFTwhXD6ltOo0jHAfiY
         mxTXi5D5Gwhw11qwahGrQmhHqJ4saZAHWn2ydAyLmPpahd508jJPnqPEiQLV/4qnvr7a
         6TRflmQAk+JdBzXVjN/XyC6cuId7UgxYHaRQX71p4ioJ6RDrgItAbikpi9hgz1Tv7dLa
         YH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724320; x=1790329120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6rD+/ffos=;
        b=cYr4yBCtp4cIlspN9LarR6+1F6Yk2WLnqhM33USNbLCDbHmGHvxbepSeBa+VJoCTaQ
         KpSI3ps7FNBDl4+CYyb+vnbsjq7o5yImeVJCAW0ynLZYHsqa/JK9pQf1hVryZhkdY4BB
         QrayuSzYp8HoKwj8SUo/k3f3Ul4r7MaI30Cc1mywZijswDSBgEVMBF58k7KIy9n3sFuU
         8GIQQXbb1KC3C1JkSYIGWC3k3QEkmLIyAluVKbY9lO3mcG87BU53ot3It4v2MQKPayEc
         eArfHo9lvhs39jIVtm+xvWL7XsZJJG+GCnmLoJZYHMmkmuraUY1vPIxsuP1jxVT4aCU2
         fmIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJiIFUA0/+dsvTRagctIMISSy9AkN6rDW8a9GdzUZRAgbCs+2d3rrurkIgOOsL4KQIo/GN0j/MOdw=@vger.kernel.org
X-Gm-Message-State: AFuF++mcavr8uFGgv5olJWl8jrZmw//1CBUllCBDJdt+MMvxAaOf7OpR
	dGFWgWd1T2+CywpQQvBcJickK+MlWqYs95FqapCk3B/eA0OSzQ0bc0Vt5Dkx7P4D87vruRvyxkm
	WM74AAPac4BsT73xexMzFHvKKkYZQhxkngunai03V1Tmgzdby0vvVZnEhod/+HT799+irwrA=
X-Gm-Gg: AYBFou1Pqe6ypUwpQf1xQ05Xkp0zUo3S2iwWEgGxr8CmRabI691QGTt+rrPRoWvSyso
	MQBriUnbIzMOK8YPg9QLfe7Fvy158FldaFyT4rIPQiVbf+YZPxra/eDT1ob4vqEIh7Q6wVXPm2Z
	3VJiSf8R5+VXq4UwNBsNIvPVHKnCY6BXafVHof5XYc9zZ1rL+ZKRii+/2AgM2fOML5rpCy1fujs
	7iTzqWm60TZR6bWS4NVg0gCyiZAUHxlyX0EqVagGU8OdnBVpsHfS4iNBj3f37mkT8gQuZFc/Cq9
	DUozrvd1alo9vdC1Gg6+Np+sC+QnNWwD9Ur1UmLk+7xExwJfjf8p9adlvROQ5bsGlPXhAmHZ2R0
	nDPFW1SVbgbU3Q04D0ljJ8ppsqViAep6V6CQr/aJOWRy3TWlBgc/N6qS74hxJKAcm8M3SOxS45Q
	RM6/4zF2MYvVQ=
X-Received: by 2002:a05:620a:4547:b0:939:fe07:a13a with SMTP id af79cd13be357-93bc6241149mr910464485a.6.1789724320401;
        Fri, 18 Sep 2026 02:38:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:939:fe07:a13a with SMTP id af79cd13be357-93bc6241149mr910462685a.6.1789724320042;
        Fri, 18 Sep 2026 02:38:40 -0700 (PDT)
Received: from t14s (2001-1c00-0c32-7800-07d4-cca3-ec08-7ac7.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:7d4:cca3:ec08:7ac7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a06sm37315566b.53.2026.09.18.02.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:38:39 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
Date: Fri, 18 Sep 2026 11:38:38 +0200
Message-ID: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a_i9Bb_IE4hpqWgIrPCzW-10bxXoxSEX
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aad06a1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=ohc_vuBGHJ6k7NFuzkMA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: a_i9Bb_IE4hpqWgIrPCzW-10bxXoxSEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX1JS+sPPQtTb/
 mKDj5HLXHYPQ2pD7rWWu5WTSxqAwGzfDB6xbXTcrzKrTj2IwdEQEGO9qD9Aawftp5wRyraJVnPw
 xNvDSFYFD9zVGOQVTMdID2+zq6BysDhoMWLA8xQI5ebgTYMVSrRGiK1LHpHBGjMEI1S9EcQoZ2b
 A7DX6/j/Yax4YZTvT12kpDpqki3uShHh9h6nFDUi5Jo5/yX97TX2JqyaCO+pklg+FO5iqChsM8k
 i//8dWgrVBf5KUyONExGRY6DBKTlcFZSP31R83DbN3SibGbHVCM/yD8V8hFGhwi23jCRQRLPwMB
 0ORcck1sARwI055ivzjkLz9Zo483uk8kdFoCKKG82WTw+PnJIUJAhjh4Y81ZxQ+UcujVqjBj+Ju
 EUUfXGGst+rqpfhq2Z+QpHO4Ho/cvgQeazQOik7YoXraKWYp6jpyxHmp1vCCTupszvsh9KicqXz
 OUUZlP/OOyMW3m+2klw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX/H3TYwlUjctl
 cItPp8kHkLXrnA+pAWv1jrqsHIaGMH+RCAEPcgZ68ZBMjVCP3VbX35sb0/7leijWuRhE+xzlWYA
 Aq87eFeLxVxj2gQSphUGwXfyfdi9hqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180132

Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851
UART BT variants by subdevice ID") has caused the serdev for the WCN7850 on
the Lenovo ThinkPad T14s gen6 WCN7850 no longer getting created.

Add a new match using the PCI subdev ids from the T14s gen6 to fix this.

Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 471ffe914a4e..0b72e3a6992b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -197,6 +197,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.55.0

