Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0F3F6C2F
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706666; cv=none; b=FovOu+yjJ+KtalERI1fPjy+xaRcsn8LPORftH9xauPByeb4BN26gzBsxmXtsR5C9Rxl/aFnSoB/2Fjrz6jtgapovn17eBQ8FjJkzcfJcO5cS3QdF0Ry+DrUgQ2+L30d6L114w/oDI5OBo+qAu3E/+b0aWXksbcBww9x4CVYBv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706666; c=relaxed/simple;
	bh=A+lBLB1doShuM8W4lpJJK21Ex8TQp3+bUtgDerepGR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPOA8Xh2Iq4VfqTIdOXIbr00AKwYqMDBGH0O5ANKPU0HJHvEI8jxmDSNK2PXs3H2DNrdi9eScFZh0mNd9x2HAB45WwETF9fDgSF6KgeEw5THdg1VokSFKk12hRmn6Ul35JSE1Ntoidv21l1KhD27tPnJ9rP2o4hKJ4lA6Nye9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8PE5aO6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LVTJhFBB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8PE5aO6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVTJhFBB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEEXb82428553
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 14:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7k
	OWdfDKls=; b=j8PE5aO6wl2yqJiBQajuAnWtafX3thaW7FoowzBypEVaYRw240r
	7tTR5j9paV1EkOs5eh5HCgOMkh/ZPMUwNiLPaNXMtlPDy1qmzaYekcl+09GvLDNt
	dF1emosvVgsERw0tC4A8kQFbd9Df1vnThvNf7+FLT+8EX58hglHOh5nRYpV6TmNo
	t+0w0s8cOaiSY5kXFcV4Kg7bsF61+os+hbvdOouRmIzXs7VUnV4JVa/s1dye7vZN
	v13oc+iN4AkmxCXvpwezIO069QbNWNyaw4cZe2dkJTw5hE8tggAFRjs5XY2gP7SF
	wJ/uR6T889n7JZJFgMcG9y6v8SXjyrdS+8w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer3j79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 14:31:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bd9e93024so56442eec.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781706663; x=1782311463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7kOWdfDKls=;
        b=LVTJhFBBWHQimvAyppKNetJb6uGN3sV/t/V3ccoyTeDBc6W3MQdWZolGRTLqo9yVWJ
         esCeDcZXcqhS3bGoxJyy2IwYOirOTJM0aSx4QWLEpH2wtllGsbxiEcz/3iX+akeoHVWa
         eR8u+Ko0bBfpeXUtxsfR4vclimAPEAsYYUxAwvHEtOVxDNT6Oxmmu+gPxGFqnRqYR6Tn
         A4bXOUHBvqsHd+nATBe24Bow/r8cJPR2lSLDf+kUjrjvLSgTJcJ+U/5tGndqbsGkuq1N
         lOlyPbksDBLI7E0OLo4AahTP46sfZVcpx59lexIGW1T/edUsFTVP/P07Xv7hZtLrA/Vx
         gWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706663; x=1782311463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7kOWdfDKls=;
        b=WxfRQlXouPE9GlStTorirXJMq5pQ/ZtqWRuhyfmONJVXMGT5CowGWv+mVm7szTKVHY
         khUzR8lMiXsIO3V2a3CYOSiXBc+3q548dw0pFsjfuU28TfR+eOnLt9GaZla+0AwnNS2Z
         FP716Pr5wPlqFMCtEed0tGkCAtpDOUWv7bF4EcR99vAnC0x8eTtum9L5NR7mBOBrs24K
         K5y0soLVGP6dtuxxpmDSslShYdUw5KLRwdGyfHUegZ54Htr/Ze3PgoJBA9t3/alDoDV3
         vhpFUaHxKFhlj5pvOaVib5u2YqviL+1zQOzccJfaA42xCRoI1aaFdNZOggnXh11oJtK5
         UwNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QMH/lMXGRUOZ4YlZYSMBSpRzqZlbYdGo2rk4WpGzsIv5+2CKsfGpaBC2kNhjdY336isi2ZHcPjYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiE5ttncPIgdItUg0h+Oy2zOI55nXiYxyD+H+g4zrV6sFS3fs
	8uPzJ3Krs/Uxubr7F/4SrlGajlAgM7VM8lW8ozGRGE0Rv7U8VLByi4il7W0W9LKxxadBypsQd8U
	0OnIzAsM0gSe9QTrX1IDDTF23hPLL7VJagRkBoV9GhpdMsxPXW6Tbc0MHuUYTUpI=
X-Gm-Gg: AfdE7cnREQixM67VNCMpE3hRfAj2JOgex7OvhxXIH4PKVqhTTQteaI3m/fhml/DfHgZ
	Mb3sUkd76YUVexxe5ZWcrA5rcKR/8Dn+BGBshG5PwsB0pjSvksvc4RmfLgCRa65SQypamiRL0h0
	zYSTjhT8M0nknebLOLWlBNmZoYxBMMQgWH2w5C1fNQLjWXkp0LODJOPwbZekFXHHW8wF2iwRr5A
	B6g7g5A/Qtvm1DkPLJRbUSM6Q704ni175APL8RFWDcpq8zdWawJTJFymC++o4Zyut+58Ukq4GTi
	YcpbdLGyIcJjfJ7SVa8bhaI5gWz/od0F2yPpEoIoKX74/Q5g/ByWHnAIAhuaBD4SLiuYsAuV6fF
	OMKat0R2nL7b80oWzsm64dPKS4p21gVwGRf6kZiVIcqt70a00qRFp95JdstxbxQ==
X-Received: by 2002:a05:7301:3c0a:b0:304:5074:83b1 with SMTP id 5a478bee46e88-30bca07c512mr1043507eec.6.1781706662252;
        Wed, 17 Jun 2026 07:31:02 -0700 (PDT)
X-Received: by 2002:a05:7301:3c0a:b0:304:5074:83b1 with SMTP id 5a478bee46e88-30bca07c512mr1043476eec.6.1781706661368;
        Wed, 17 Jun 2026 07:31:01 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm22962978eec.17.2026.06.17.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:31:00 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH v2] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Wed, 17 Jun 2026 20:00:55 +0530
Message-Id: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GZTF0U4Pv_YIRqjF80l--69im9dWA0dv
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a32afa8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EF50nfIsKRdRTP-bws8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: GZTF0U4Pv_YIRqjF80l--69im9dWA0dv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzOSBTYWx0ZWRfX1GNHcIFsK19N
 hsnSezjrdfWT9Ao8PmU3Ci7VgqrFUJQNS8qwd2vkaeeIKAcn9sHRJZOuxC8HNneyKz1mYZ/SoBP
 s2xAdBWTdbuyHJPG2ZqPBnv3GgMoqEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzOSBTYWx0ZWRfXxiQIWoEJ8LnM
 Uao11FWVMae8jdBtvCC9JAa3jFylO+GUAfUvB7T/Aa3FaGhUJqQL9YR2icKolOZ21GuFQrtTDwB
 6mBbGpHpWq6fQ/qveUkIxUWHrWwkQqGx1pwhW2gdMxYzCOILr/rgNVn5F9+k5sNwzpomxRpPJ9x
 Lk66wwAIBMEtvkxnrqYO9/AJAWejwigfC2dJi44FQim+hFKOAioSqMaz5z9ghWlpSTyzmimBHkM
 IepK4ojMr0QGK3Ssd5r5DmDImIBRTMiy1AipScz1SCiTiJm3HbuCZQI0rQ90RYvUz5JT2oCunDO
 5AckT1roum3jEGGYnfB566o2LXuptw9B4zvuCRjHO9LUAjbpaFikahS3zds//hx89nLPTYXG0lN
 lR3a11EmgCMpu+oZHZFijUQsp5SR5oX6/OizqPgy5a9KW++0l0RfLOeJELlRmCDyqwsEZaoky9+
 3Ljto68QmMjU3hJT7jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170139

Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
0x1103 (WCN6855) before 0x1107 (WCN7850).

Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth")
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Changes v2:
- Resend as standalone patch, not as a reply to a review comment.
- Link to v1
  https://lore.kernel.org/r/20260616025632.3697863-1-wei.deng@oss.qualcomm.com

 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 94c3f4b7ee36..b5ed80d03953 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,10 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

