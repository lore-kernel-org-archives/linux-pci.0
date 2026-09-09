Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36255199A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956688; cv=none; b=Bw5+B3cxZVq+1ZPaieDRsyzEeAkVXcA0EYh3lxhh4Qmg1oj+ej7ZXEc0dOT3O+6Mvvx1iEfbozFiv9kEki46iM8j3iEsS9neZJrZNVboSdRM+P6fH4l7qj0p3uQQ0rMjYDvmkw3EXKCRI2KWNpCF6y/RPTSnwalT+RgCA+RbiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956688; c=relaxed/simple;
	bh=Z62C1KjgkUfHo1yhmxjksV4K46Bz6P+GsVAjd37UQdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjryVEZk453YZ0PImG2NUBOrxc0tHxDrHIjJ1HLBt0a7/nGQ89Ov1hZmxEkK7jSNVvoQ7OqkiRUDD8ihSItSGF/Tbt0lTCpFJioQ+Y7sux3kvEQy04Uxbo6uKzayvTjoeAUop0k+SRB2Eiqy9OPjoMDQ8YABWzMjvxpbYM2+Br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpdOwa3w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4/mb3Q5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpdOwa3w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4/mb3Q5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CASnm1233053
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=; b=ZpdOwa3wtIUwRt33
	7q0yH7Ul7JGRRwbwa56x2S86qGVBUepBJZ9KJlaEAqsy1miC8Nlz2xkwlLMxXxYL
	l8ylpzVTz2C1R4I4XbIjV3XvX2rQ2wBayu4qdoYkEMT/gdFTPdvRZLNlxulSTIxS
	gsfFbc5ulJa4BvNcskVemnyuy+SV0vi2kJvVDEmZDiKtUCobGF8H7CIRGg01f3mK
	/9KT28P7ulAy3BTbN3hsh8PK0VRVlA5+y43vdB/OuTsX3SOFzAZ11OhKWZbpWPgK
	TYMH9swT9G83I+b/mM86TY8E+aSDjFsF6jP1lEPcOpZj9fbOA7SXM7HCvuFEInqM
	BCdDDQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk77vg1fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:24:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3b126c9fso56341925ad.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788956686; x=1789561486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=a4/mb3Q5cBchtxNon7yaQA6Q+4389wnoPRjXLduWY9Q5l17eUnNDZq1R3IEQtO22+d
         Ex9i7y8d/wRIDkTJm6wcGoZkEwdmRsiYa1B/AqPfCIYW0M63SGsXbSBUD0nQHiyA2nQF
         V7BBc7+UxGc/cklWTaD14/V8O9X7ni/+2uly+Y8yckZYyaDh/yvK5cvH7nq+Pyf/Yyac
         58cG56spyS4OyA1k6ccF3afjkXUfsr2YwwQ+jts2DtQhuHuASw8r63PbjuGRlmRChbHK
         8TmYfmqNQfBMiz64fKkKIb/+SbUXSX9luiG73G64daRPR/2H7uhGDTnMpLlFoqgL0LCU
         sWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956686; x=1789561486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=GEtLMz4hovoi6tMezp43K/4LQlT9gny7C81T04rrW0YPWQUgqyP/btGxlKW1TRt+5u
         ew7P2RN0w40KVKNmzQM9d42v3mXUW4XwDPvC22sLxPm3slVJ5LHQZtVdMILFZHlhVX7E
         pVwJN04zZDK3GoyvTpCgzQ/qD2up0DUvUQ7Ywf/VXSwbwXlYJLroq1H5ulUSEvjAWNps
         uIAH8QBtQnbrFsKFFYAMursA6VZ0fQKnlzxIE3wQ9cL84ixUHtppxZeFGbMNJAVVxiVF
         LoN8vb5PiyBx69AbdFUgzmS6yp4920pDMF8SF5c+8+L0rY3+H2nTv6TrCGeNWBi0HAyG
         vnUg==
X-Forwarded-Encrypted: i=1; AKwUvBwjyB0C6HG0xhVM1wJsTthqjqaleBg7iy5cr+JTd+/nE2neSpBdT0CP/ouhmyRqm3eZNUSBNMrwwAw=@vger.kernel.org
X-Gm-Message-State: AFuF++kOMgyAKRIaZ3GcNS/T3eujZQVfNHI/DM1fUf/AdFkvC9ARDbLV
	Mxc3PQNzsHpIXNYqG9npyvXn6lZyrgus4v7aBB22j9+qGUz5CdEZpfw3x5PE35HTtZw1uf5vOWg
	v5I8dg+3keR7aVn7vqYHaZCPIhpONKCuhYmEVv8wKqHMWxOegJgggnrcunwyq8zw=
X-Gm-Gg: AYBFou3KWquCa0mYDl44Myb4coxGPnC3t2+1mvTMVlbtW6TgzUsK+hEiAxEcEI+rszJ
	YEMbdhmcOX0vM+Gi1fJoI/H7vAngtYhX9snnYTZCPCte7UuiwA5Fj2kOERG0pLFeDllEbJyJuMU
	Wg9QuG6qtntmfA2xduSzitw15+i/NikRdcdseaaPclSytqxYPUe6Y7rqLPy/Z3w6wmY/dAs6m8H
	0aE57HEheeG+Hf8nN26kppCoHVKbL8K9sobAVdYRNkCRBE6oeAS5KrVA96ra6XMqttJSJi5RE93
	+0wdH9afkLILHaT2DJb7FCdX7YIlFad6EvDBmr1LSwQzYMvmPmQxfCpbAOni1qnnFC+LY7oqw7y
	dHPxSg+iENzm7Tx1U0Hv95jU3+lInRZKe6X4=
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr49703309a91.1.1788956685173;
        Wed, 09 Sep 2026 05:24:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr49703230a91.1.1788956684510;
        Wed, 09 Sep 2026 05:24:44 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm69372775c88.4.2026.09.09.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:24:44 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 17:54:28 +0530
Subject: [PATCH v6 1/3] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-shutdown-v6-1-62b7bd123236@oss.qualcomm.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
In-Reply-To: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788956676; l=2329;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Z62C1KjgkUfHo1yhmxjksV4K46Bz6P+GsVAjd37UQdg=;
 b=eS4Hpewq1kyOsiclxmzTvPNWmLPAaY7CBZESA3p6xElkvy1rVxfY/hHn/OnF5A77GyofIPreo
 YTIMwPOG+JWCZUsd3X6/bLV/81hAg9Fssb5RylxRkwm4bzZOq0eNIMG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6aa1500e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=RIIKlrP-v3AzcS8hWasA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ho0DKDOiFG1e-ltlLm_5dHs9fvDM2sDm
X-Proofpoint-GUID: ho0DKDOiFG1e-ltlLm_5dHs9fvDM2sDm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzNyBTYWx0ZWRfXw2X3ukGGpNSH
 dxiaF6A/syLhCzDSs1IT+wFfdknKIXDQ+vchY662qsdPN8rJO8djBTlEugNnPQbodh1VBDclHm1
 cNpVzRS/6dYIR8sjGIRFZtCu5nkDU0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzNyBTYWx0ZWRfX5jPMroJ94/vT
 61heb9uppYZP7hEtMujv6xC9UUrPi3+ISYJqylhywAlmmszvgdBA961/qw0WcN8qCUCf37Hq5XP
 7fdocx2ydLvXXOZIi5bcrb1CftvEm/40/k1qFJcWxjjuY8hoSoerFlc176xspkQloMQ3Xcs4Xul
 ZOucz6d7EPLD3iYrtu4cuymp2S3Blnq+GJAfsKLBk8jUchtDbtPb+IFln2Ih4YqltTevYhiSJF1
 /4hwCzrVeGYu9zpPNNS6G+P9MtiEpOOseEztbBwBytJwRPBwpu8rcNQkt7YKj8oQ0h/qpyH0bAf
 UfaAEl6hMbyQvUaokqZodFp0nOW3E1JcSvjViB+7k3tOyxA4r9CwzzYHdSG/n2G3Iv9WUqnTjuS
 7pmEhCo8HomXrAqUgzzrBY7La0LyMbyvF5yNS669qexvrRELsbqCiCc4H0JNGkvLmbVseDGCZI2
 biPLpf9bWknYbfNP/wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090137

__pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
the walk as soon as its callback returns nonzero. Any device enumerated
after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
capable endpoint -- is then never visited, so pme_capable can come back
false even though such a device exists on the bus.

Since pci_host_common_d3cold_possible() already returns false whenever
any device disqualifies D3cold, aborting the walk buys nothing for the
plain suspend path: the overall bool result is unaffected. But it
silently drops pme_capable detection for any device ordered after the
disqualifying one.

This matters for the upcoming shutdown path in particular: unlike plain
suspend, shutdown forces the link into L2/D3cold regardless of whether
pci_host_common_d3cold_possible() itself allows it (see the following
"force_d3cold" changes), so at shutdown time it's common for an
endpoint to still be in D0 and disqualify D3cold while a later,
PME-capable device is never visited. dw_pcie_suspend_noirq() still
uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
result here can cause Vaux/wakeup support to be dropped for a device
that actually supports PME from D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index a23907a875e5..c2c852c64aa8 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -275,21 +275,16 @@ static int __pci_host_common_d3cold_possible(struct pci_dev *pdev,
 		return 0;
 
 	if (pdev->current_state != PCI_D3hot)
-		goto exit;
+		*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		if (!pci_pme_capable(pdev, PCI_D3cold))
-			goto exit;
-		else
+		if (pci_pme_capable(pdev, PCI_D3cold))
 			*flags |= PCI_HOST_PME_D3COLD_CAPABLE;
+		else
+			*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 	}
 
 	return 0;
-
-exit:
-	*flags &= ~PCI_HOST_D3COLD_ALLOWED;
-
-	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.34.1

