Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093032;
	b=cu9TVjPdesSJPBLdyWH9hB22LiVFR5Jie4rWCblcWPNhhK7sV0z7gkH7UnIf/V4eAUQi
	 TAfTtLgmviCVUfuRaanHDyHkFqU06CzF0aZh2mXlrZiJ5C4x6iNOkprTcDdOK9oAnE+h3
	 Ks4qGNI8eLm3dIqwoMrsPfVc2cS7srXdSMxbkwwrEqHC8I6FpMMtLwMPFtx/iGut8u/mD
	 l2moiQf+U7PRJHBmrS8TptiZOeVD3rF6b/sNQVLqpb3SmeRLWTpjtriRCEe6hwPCMfKDE
	 LuBjhFIjkGafEvY9kakZAIzXOexywW2nMPy+pAY79fQkAPVLQuN+G5XsVUYqb0c/v9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cK9FQB1eQfoYcGbuRQMgSid2tZEykErFFsoGc4qtmho=;
	b=0DMYlYBdKjpRtCRUFMGO+cTLigFJYQIdl/rJ5HV19Q8wRblJDqnw6mwT1eOl8bdk8Q8z
	 c3ZzMmi1Tb1X3+uue7b/yfyunn7PuKP5HGgfp7Q50aLXXHOJr/MwHbbVezn8Y1NNEFJEr
	 bdtbuhCsC5JGXcqyaF5tl12CTR+Dnh+Wd6FAnc0/ujcWGHEtHwvJxTIeHrnHvXZkGiy83
	 FGP32zJskdoY9piO6bGi3DyC9C5l2k+tawG0BZBkxN24AoRviDJffOWM5o6trJXtT+krv
	 RB/XaWwGWvx5rbY3VGApuOJQth1ad5JC98oYPW/p++FoozTHr6Va9N9hxF7gN8V57Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8nRjkNO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duggvRRJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFD606A334
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0EFD606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8nRjkNO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duggvRRJ
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBjtuf2179415
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cK9FQB1eQfoYcGbuRQMgSid2tZEykErFFsoGc4qtmho=; b=m8nRjkNOW3VPr3Db
	nULsFpFVKB4d+oAm1XxQzMs6sU04/hZg25z6kvlIEnVyHGUyIFPeCuOSC1og88QX
	pD/n3jwP2ciTLpHtt4ovUbDQAHsEt1ONIpuWEaKMjQOnLdePpfS8S3A32A8rjVqt
	gGtzhWhC+pE8rPQHUzbCusc6542yrC0hxHr06nMMaC0B6hmld1rPbdzO3C2mJl5m
	ekCm4Dp7oSZhkKDWMTLnLUq6qeq7v6p169cp+FMPbjks8aavxmMhc+0qBNVzpXNk
	8O4jqv6bKsXxeBCRVwJZw7+SE4+IrwqKi+dVNguahul9MjaixLPoCEgYv+hDnG70
	suRBMw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx68cct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383d1190b49so1111727eec.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 04:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795093026; x=1795697826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cK9FQB1eQfoYcGbuRQMgSid2tZEykErFFsoGc4qtmho=;
        b=duggvRRJ2lKdCPuEUgWJStfwgCvxJnSiJrNM6cmCH/XjQfk6KVkoYuAZsZcX8FciQz
         RCxovNVr+eCl4QyqPViKZVTn1fF1xbHAkwdZOUGcRU+6eZeYfWHW3PK4ZDAJDTZ+s05X
         cJeFiquOV47wYGux8vRWckMwUP28VF/8HOKC41br6MxSjAhlWggMTAsPx2ZUOKuxUO0R
         DtXa0NBp246g3MtvswP+R/N5eW6VK+YdIeSNKVa3BlK05DDheB5m1PJCJu0mN+Gk6I9g
         KMQZ99K1aTI25uIEBrKpucTCjICjr1GlUHMtIUgMYsWhXwlLimSGT6NQxxKHrae5I2b/
         X52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093026; x=1795697826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cK9FQB1eQfoYcGbuRQMgSid2tZEykErFFsoGc4qtmho=;
        b=Y9KF6Kz4FyQC0MR7sTF9Hyyggj1KultnijfjE6ui7vuNutswHLylLRO0xXA3E3dpx3
         hqxZTJtoOO7e87f8jgyAH+qyALee3pDYSi3eUJFvsNMK5WhxxKwx0+PaJCRNKoAePW8s
         O+hQqQ37GPqdDBzw94hvgtuAONtM5hWMfdZdJP4P8QUDHC3bF1snUXkK251GhubcE8z/
         ijnv6Q6WC7q4IdiBRKRdPkTMZMEAscSgh4p8zlEefil+5wQtv7cNqXe7Uq4SEiz7I7sW
         q23+hVHe/G97cSWgbLperIwbScvYP9xCfb7dZyCloYXfffuwDlj2nCJsa7oo9djIXJ+P
         lnlQ==
X-Gm-Message-State: APuU4Z+ZbD476Fy8Kwzm2u+K+RlxuHCeKrnrZzJhCf5/qM0Vhk4k8a/u
	ICGgq61LXpf5pam6vu2iH3LBg+rUZctOnvPW0HPXrvLw+K2k5MT/TiiAwq//vFUFfIA6t+95KCV
	A4xzVfznaW1AKnYdSuwcb28wuJN6gOWm7SBXPVnqMnM+qiZwyQYrJrzmFQzUD2rw=
X-Gm-Gg: AZFdTZeZL+383816/jrJyFf61fvojxYBR9YWFJexLdL9V4UoSFKkLNg4XBsVRBXy2cC
	94mKAfJGQmaKHBQQ+R6cX4zDVtY0BVySiB4l1mRk+7R0Q10AlfeoOoJsJaR5MOrnOrfDhD8dC1p
	2N1kmQmsALobDVeejsBO1+D0HuVDclyVYCjJ8qeiTdlZoEn6pwnSVIeQFtINhM4mCAVdInxJ3YV
	+UIntYFI29fUrdJLpX1X/PD+SbL5Tyk/WT9DACmpPtWYde4JkyVa21JTMxKvcWKdc1gbTlEyVwT
	j9UhZlWOoKDj5ire5u/10zUs/8Jw0GpNCbT9HIEPdPQSOq58Sa2mimTG2qu/PhrDqPOwQadyOyt
	SeeWr/fSIH8aoYM1wqtkTIQsOXGrthPZrCEWqp3Om+4U3gk40BnfzqpIfN3EPrgX35WKGVddPZk
	MFS+AeBpdt
X-Received: by 2002:a05:693c:41c2:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3828101fdc8mr4842021eec.10.1795093026272;
        Thu, 19 Nov 2026 04:57:06 -0800 (PST)
X-Received: by 2002:a05:693c:41c2:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3828101fdc8mr4841978eec.10.1795093025585;
        Thu, 19 Nov 2026 04:57:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm18529369eec.28.2026.11.19.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:57:05 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:26:34 +0530
Subject: [PATCH v6 2/7] PCI: Export pci_set_target_speed()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-bwscale-v6-2-9a9a715fcb46@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795093007; l=808;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=W18AFjHkuzlMzGO5/R1VBtRoQyqAsmAJi1evG/8xi5I=;
 b=AkA+fwfO2ceq8nugH0tjdw+xo2pslyfEUD1FzyiS2YWEXpHinZQOqVDEDsAbZ9lUz+gfkXnIo
 AFXVLo0LYELAglKOVKcuHsbzpeARu2iv9LhZUhJLhRf/a2lkOhivbXW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 3JRxkPTp8fWQjzmrcdizvhh7YWXmNY6e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX4nXcvhKMDNyp
 Y2aTks1w0ivO81KgSayf3mPHFyQvzFPxizZIlNHcsISEPJrGs20d6mX97udovLUuSUfkpEeHuxB
 r2QGFFgwK33MuQjWiEtSlS88wLevhGM=
X-Proofpoint-ORIG-GUID: 3JRxkPTp8fWQjzmrcdizvhh7YWXmNY6e
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6afef223 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX4t/r7KqUZhXg
 CZbJ/jAv5njYJon+gmfc62whM7EHNRf3HrgApLunQvKCl3SlbDnDxUpnLRlj/Z1ThBc6t0qZMV8
 RU8L9uKzA4wdNFRgmd9gRR7Gdq4jvrmeFjAWINDGC11ICGiS/wFBKnSim0ZE4stA+bzE5AnPCls
 sODHFr+aPELZeOUz0cCvC2Hd+FimuABYoKX86bzQoayI0RuZFXBiEkQSrGnfVLq0BosnfIw3PCL
 mMqlSiu64HNnd+IC+SGWz/7KcU5zix1pz7amJuS+KMEJ0MK1QU1S30UzFf+qDO/zTMRKEChnh0i
 +N0T4P3cX7Iv+9ZIeDXIJ0oFOiMwxF8jw2SA1Pv6gP2ipeeRS9zogW/5vMUMGT2TleSJlcfq8NE
 Qq6gTZBkkXuJ+G6SxMq3oA1cBWKVXEW6CP7rhTBdOj0rFELgpu4zANM+5A5cwS+lOdAj7aJXCOC
 okKLSDNigwRizb8WhMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190051

Export pci_set_target_speed() so that other kernel drivers can use it
to change the PCIe data rate.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c1e749df5bbe..0512ec62dd5b 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -219,6 +219,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {

-- 
2.34.1

