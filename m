Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC93438A1
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820059; cv=none; b=m+qSaNa/+dZfPxkiE9P/NM6k0gY0i1fmCs4RaFrpFyxe9QOWXMWdecNJkzrKIdRN6rfy48a+kdJ/mUleoHwcP9YeFy35RyHXxrKqOZHfqYXhKxD9dANanz4kRlYizfbSwibjMjvkiQewxS6BFj2LpnEq/Xqh9lZijtiFYkAHxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820059; c=relaxed/simple;
	bh=g/vNPd8VALc/K45pOjMR098nGh6TjliGmsMVyh6ua4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnZSbCgO8LwQcj8tgd+fhpsAui9m0wzckZFvosYJWfc7XLHgOpWYJrOTjZ8nm5d+dg1NDKvYcB8ooW1/24DHCWEchg6UUBNNdbrDYzc3juxkN5rZdrZa6rMuv+yE3L9fUJrOOPESrWUNv/CTCznO5VyKw+/84lqKK1GH/84edAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfWCmvg8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQUs1u+m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfWCmvg8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQUs1u+m"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILsbZB2820449
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=; b=ZfWCmvg8jkBdBYAF
	TJ6wQ0vCqkfsWQN6TQ9/AQ2dEHQP18zIs63hywJjQ/8c/4G+uLH19a7DwNjf1vYq
	vXcslKmoFIb2cILWMZy4Wr/v1pULOFX2S1jW6FQSc63ZIYJd7Dv7dJxlqGHHAVRP
	t5/o5YO8u4qalBuhUJhr28D7u2EheGMHmMash/rvoSeEM2DCv7Wtv39sPzyP+9yJ
	RGZSN8BKfTqYlxE4OxUB35n9gpvd27VggWYIXffdq8tZHLNd7va5x20868daH07U
	4F7qb70HxJNh2AHXdGksnFZwLsDPwIoLnINlFf98qStfoAdwLbN5gL83Aka231KA
	/LWbcA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s8tnw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304f1820babso1894812eec.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781820043; x=1782424843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=;
        b=FQUs1u+m92VJlyQmPZBkcGIFI0QReIYRcTzbhwv1ixWPw+sd6fJTkfD+xFDXWkAytJ
         i55boBKnstuECm+9CsrpS4NuqxH8FifZQSfdBZOOnSz2OpOQG1JdVF0CHj6foSidG+Ix
         ebCexlpV7sNq8Cggr/ZaLf93DNDSBfHBeHWZzHmx15xENOlt5uH1vU7WY/QHTT/IH23z
         VpNMnrU9nMUt4eUcmMrbtOeYc5tWFN8fw9JaKC/2DekAfaMPw4ij8lef3TPXyuwiqrxv
         vbDImP8ICL8Vb+nNCTryhCWe1YgGpIeB+MbR6YbM71BJz16wtAhRBnb9QseDn/Pp5ZWx
         tAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781820043; x=1782424843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6QseTlbfAn880N8txRVuUBddykUypUNSw2k1D7pjirE=;
        b=hHFS7V1n8Y1E0SLGb+s8WqFe/4TJ1onAVTKvLVM9MiKjUYcoKNLNXeJ9lAJoxxrMop
         IfD8xBHbrRE26uJuhljh/7pLW7BllDbSP0S4cxEq94e6kjQoKpVyKaJzVQDLlmp18Gtc
         uuBKTPvA+yn2wa4kakd6MZvrnX6a9mEp4qH5SXXxWUStWS6aXWdzcxhI/pyebJA+tY3Z
         tkveP0hlpFo+E6sTwkssgB2wmI9tbiOnyck//HrknBbjqieBAmubNYEeMopI5kLoZ67Z
         J8RKiHd9dTxvwrR2w6hT4DKfST5pEYzWEWdVNqzLoGoSy5PgayOZPg2Wt9Dl/XmcWvI4
         Ggqg==
X-Forwarded-Encrypted: i=1; AFNElJ+G+CSnyaghH/gSSHTP/B8NPnmBG/WrYaoXjk0QzONAHf52JAGGzDU3TpcQ8ZReGBUmKTBh2J64nFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6N+UBlZ7lBAVeyQaxlNYedy8XDNqEcIdxISMoBfd6RqS1ntmT
	M51B7W3djHIt9LzbwVUSqnncAUwDqCirlCEzCVrFp2ITP5IQYbUDnTgvCbnLeNrH0VNl9GbMPLV
	0HUx0EBFYa7eVo99cPxKmm3u6GDIzczHCjv5YE1pWUt5BFjCWjPb33EHTi6dnAGM=
X-Gm-Gg: AfdE7clSmUHX8AkiXqbCqa7GzBOnhgSeo2vP9KMnwaXfSaachQkwFYiyx2yUG91fIIa
	Lge6ubhNhNkWdOmfOO36hMNhD3rEMXyyxFmqXsn2AFsr5K+QIfoZ2sxFj2X09th/5zP523c63jS
	c2vRxKFHhKI9kLB8UPhs8ZWOD7AEYYviaPUdbTPTo+5JTlKGGpGx/MSHGt+BAQVNkfyIESIG1IQ
	wZq/rXpEMPeFdKIAiCsMgXxJUtmnzj58Ff53oFAChTR8ssSgz20m/O2q/y/KVXw1d8iQ7Vvg6Er
	oN245uG6wqscs3bgWbPSjiCRG6rMHGurpvHTnh+jUYIT5i1ZPlNuVtar7Bje7SPergje9OAPPmF
	P0hssKhjoYQNd/PbbYu0RR7nzpklvudjLVRb/5M5hVBlkxzU2
X-Received: by 2002:a05:7301:3d17:b0:30b:c83b:f56b with SMTP id 5a478bee46e88-30c06d86996mr991571eec.14.1781820042475;
        Thu, 18 Jun 2026 15:00:42 -0700 (PDT)
X-Received: by 2002:a05:7301:3d17:b0:30b:c83b:f56b with SMTP id 5a478bee46e88-30c06d86996mr991553eec.14.1781820041913;
        Thu, 18 Jun 2026 15:00:41 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c0670a1b4sm628436eec.8.2026.06.18.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:00:40 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:00:33 +0000
Subject: [PATCH v3 2/2] PCI: qcom: Add support for Hawi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-hawi-pcie-v3-2-f31880bfb3ec@oss.qualcomm.com>
References: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
In-Reply-To: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781820038; l=919;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=g/vNPd8VALc/K45pOjMR098nGh6TjliGmsMVyh6ua4k=;
 b=QFphUkJzgyhApyoxYKg6ULID+IFcA3qYKhhuBq05YxGe+7cpgO56OE5WjVqHGu7U4O1BTGY8C
 VnBRywNLNRXAFyjVLN1pkdW3gHcXMCUcwiHb7ANmeQeMFUz2FTgAXcI
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Proofpoint-GUID: IXmO0yWmIp5Azp9wOeKP-KTiqNOuFvqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX3FlH8LVInSgG
 rsflNYuYSY8GdWLJIwCc21Q0udS8Yv+CJEaBw1G3zNAUx6PrAy6xHvn2PfGWZYr7Jb/1OcmvD/r
 HagYNp3hkdeAkGhUCu/dqcrJRci5ZjeYxBE3u6b9aDEnPYJxx4m2NugEI+mnSGeUJVuAEMS0kvM
 N/a2iWLwd9UBSQguRlUWTO6+D28tYdf5q4h2M7H/E6QV4QaaFcPRPt3X9RyLwfCaP1F8o0tapo0
 Fhr+ISgxrd16wATRougyIcVgvByK3S+BDT9Nvu7XvC0sHkfjVwFoqJCf1oKjmjsCMFLpf9CsWIx
 wyg0BIDYzNEkgOX8Ns5jnzFNkRA2zCiOCbByHA9CRk08GZ9maHr3kdKo5eUu/4SVIiuhTKxPNAm
 EVB7h9kSEhQKoCIi/1cL5GbW7xAi8T9+urXUL+h6+EsOUgIkrjY0Epq8JpbKqMvx7yvedyMkfqg
 pFok2Mcd6fNz+T6giKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfXwLJzdNuFwO3T
 7xA7n7F7vUm1ilLu4KUxyFEv0J4tXKNeZmYT6OZf5NV7rqK/4JUCE9LpLVEI+nXgZy1LNRrkcxm
 8qcChPVPsSNTxMHgMBT0gKpbPPUDZeg=
X-Proofpoint-ORIG-GUID: IXmO0yWmIp5Azp9wOeKP-KTiqNOuFvqM
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a346a8b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KdxOZhL9OB_EpBcCT-QA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180200

Add support for the Hawi platform which has two PCIe controllers: one
capable of Gen3 x2 operation and one capable of Gen4 x1 operation.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..89ae006fb6c3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2282,6 +2282,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
+	{ .compatible = "qcom,hawi-pcie", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },

-- 
2.34.1

