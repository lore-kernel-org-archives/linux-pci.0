Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247589;
	b=esYw6h+WOGghUgxwMLkTXGacaX32l3dyMpREHjGW+Kfr8L8HuFE1hNSoZCrjIR1FtqGJ
	 IeBVKiAWx29eSeg1C4rWUnde4+nhseQyDMAj6mK1uw1m1MKO9gYgKo+4vBI8Zrtx9Iwi8
	 jrL/1tNDpq8i8PEsaGEyCLXrRRmjoeYM46oA/Lv69W0aPsPlGQXVA0/1o80EsOG2LQpLy
	 k4ygIwCfnxOFDhkd6S2ubld/RpPz2MWycPv+smwk3jzumnWJw33Gp+Z4QtSScbFgXj6JO
	 yYp5PMFQVs2e2iDsoaQ4G1kmUZz5ZYBPdrJsLBYlALU2Nl5Ib+iO1+B0fHkXrYtGAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247589;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
	b=zdG135yDFQ22dmRHDgqKf59CV/Jq+K+bNkJDrmzgPMp0DOgMVZSyG/sRcFDSiGVf2GZp
	 +Ob1zmBn6L9X3NGK5KP0KCtZZ7We9dWCKPvomcuJNN1WS9HQGzp3i+LLCTa8P6m7acCTM
	 LswCTY7ZUnVDqMf7QlOLkm9BT9jTX/tjGyUXEu/FUNUpGCrtcftb+811BbtxKpPObkh72
	 /Ph1Cv+Hgbt5Kz/VP+AcPt68g7AazX4ij0xe3pBfLIdZs4mwd6EtoJGFE7qAux2TTRwl2
	 0uHhinJG9l/SRW1C5uQKIoQ6xBTJs7mqEG5uZlz0qzP5OF+Keeq3/DFB7xXHzlVYNvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j3HLayWF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTOXfXHW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35527606A329
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35527606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j3HLayWF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTOXfXHW
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1jZnt3376873
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=; b=j3HLayWFhlPDjyAj
	j9hwoWTnp0m48SVsdVRhPsqD+ifwAsEo7+UpuiuD4gkOVYZqBYoIShf66N6ATYnB
	CDhqptJGWFq+SxEm1J/MT/4ofbuUDXlpUlLG1mWFNfz0iRq8lj5PQeGjkeBW1DLL
	GV9XNuCeylU6MCOqtQdJvAdC0ZA7K2z6xwAP7tw3RQ3z/wEVB8Br4xGpvSTuM6jt
	ExZOAwGhG+mHTNugz449fwKr7rK6eU3BtLEn0e5JyEzr0slTsYprgl8svC6Ue5rN
	lHuZT3TydThfXI5T9mzBAW92JxBSfPfCw9cVgtroH4HcLXlbzoIYXQH/bA2Z4cMV
	1uLVaw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp8v3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso1984079eec.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793247587; x=1793852387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=cTOXfXHWzTZsbxpvsKTfL1m8HCdQwbZBadnRLQSnw3zedns/N3Lh4aekzMoQ9RJD6n
         9kZXA+5nDsBIJMrJkkl4iKyN2FkQUzB5Fgt4OkmLRmfxNnoH6DXs4do+DeZRtY4zAlrQ
         3RZVWFe8hVqIahL7mkGX8V6ZBDRoQK7cK0vztFX0PWz5dzkX5YowlA7yiUfoGTN07LQK
         vbSXbuLvLJPzaPIhyqfoZI+C+mrAYhjj5qnEKYYWPiO285T/bkggF/XerITGmU08NPg2
         8HmuzVp+T9Wvqi2C3Jpa0eS/2nxIzningD1Wv/rnh+3YY3I+3MKtUIjQk8W4V72y23Si
         x1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793247587; x=1793852387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=pWpiy9h5SKcw45tAGd6nCCuD3YU3IrqK58dwuLSi0eXChxgxpKDCfU6SCdaK5GUkeG
         RAYHXsgMQExHd14GFky8akL7NeP9LXiRQJJwwBtV6MyHHcvC5uBeZhoSFsapiIflY0vT
         I7IdYmYBdj4J1SGUtxboBplpwOb7LAlZtorq8s3/gekhz0+dbmrdeUFcnQUsZbDou3xb
         66UhAUEY4Hv9okS+FubFkwOPLk3YAnLUSPBHqlD1l9RSUORIDZQRiIP5XhjDVUU1rCKP
         MQylkb+e978NWmcej+swmWU2Kfu1we+LvdJbbNj4rzobRyIbSmCS8filoWiM3ik75fde
         iqEw==
X-Forwarded-Encrypted: i=1; AKwUvBxgDmy1ZCqrVnBffMwwbkT6x2ukC1IgyLdEg0dxvfSZz9DSaTNtHGD4G/5jeitKiBg+phwmfkuo64k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+CN+tArPHpU8G8OoUhyDCE89Nlr4iTx1S+QA1LhGEU5vVievr
	T0qpvAboEl4HD0Xk70VtMT6ZFeRpCoJe3GigoM9hEhyIrQ8IhNRDT/pjgHuZygA8TMVS17XFY5I
	66BNnKB3MjUChH+twUegRAoP9H8OgA2+UxMOkZqCuOb9x0f6rIOwYe8rhcLOkNhU=
X-Gm-Gg: AYBFou2Ya5JYg+E15Q0RFdeC/1gonEdooFKUpuMQqcu8/z9CtYU7vMWzo1VVATUJkEh
	gn3N96yWxG+rBUEzxNXjTuvviwapQFuUV2+Sm6gqWhYnL9MInahAlP3WGR3FYR7boLZjDZj25Cm
	fvxJ3jE9E1/l1DvxEvfNfW7jEKcPmxE8uOnk8uwoRHkunJ6+HOBytAmUr77KvfssQu8tKPMDf/V
	PzfGhTOF/dVl2y94ycLlde5HHMeI2uSnqDcZbNmfSrvQHKmLLwFEC0PCFT7JnogSKbdzvaRMM7X
	8uU/tvv89ZzUzQ54f5wUgcSIDqgpxpWLcKgT/x5+03DMnbF4ANB5/jxbVWOElACWgUhAJr/Li4L
	zfMlTFYsi/WY6lzB1Pe3wdlKv0PkT1qjXNeXeW6j+Qui6DtivOVpkCJtJYu2TDfo8683h+KZPEO
	AN+vzqtJM=
X-Received: by 2002:a05:693c:6016:b0:36a:1add:64aa with SMTP id 5a478bee46e88-36a2036d285mr5438531eec.9.1793247586777;
        Wed, 28 Oct 2026 21:19:46 -0700 (PDT)
X-Received: by 2002:a05:693c:6016:b0:36a:1add:64aa with SMTP id 5a478bee46e88-36a2036d285mr5438496eec.9.1793247586125;
        Wed, 28 Oct 2026 21:19:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm27504539eec.2.2026.10.28.21.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:19:45 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:49:27 +0530
Subject: [PATCH v7 1/3] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
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
Message-Id: <20261029-shutdown-v7-1-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
In-Reply-To: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793247578; l=2329;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Z62C1KjgkUfHo1yhmxjksV4K46Bz6P+GsVAjd37UQdg=;
 b=Iw7LeukSpt3ZcOOgYAGwfrqVem8LSplH+ckiEld+aTBOcm5/X8ru5QHX0hg+feBVnO8nouRWy
 M5L7nVlaI7TA5T3pLpwySqagPe9UYZQ6vEtQbeIgfqLM79bq9UlXSrN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxNSBTYWx0ZWRfX6NhkYnJbWceX
 LydV34khw3cu4eHPgKwtLhbcRdUqg3dgtM3l6S60LNb7TeMpynq4/IX+yet+mhlAXk6ExrDFrFT
 h65pzR61lwYxyYDrbnDejGuw69J3Ssn1J1Pmj7wVeCvKMcfPv85wdovmrjX7J6/F/2qOF+lBToq
 4C01dn316RkyJAZlp7h81hjm7iefGgQsalv53sqr25Lr/8w8MBErL7jrabhNosuLiSytNczWwf0
 Y5u7AKw4SDENWT+Lmm8GZEAHXLvBgytyPp23eD9+OC1owBjAneF+KjPB3o2X+QqGl5Wx2cIyfHc
 SxCBFmY2sRgFWklGgkLcYAPhCRnmCV6s4l4KJW/BLBTyut5XKGNzZaxXLuwxLAdyk9HsSf4E0QB
 87T2SfgoU4TN0jJJPxt3+NYabrnsQMXb2hPBRRVLdBAE2Di9w82vobmar9c0njbTreWac+C/t44
 GdnjKYP5TREPFuYSxCg==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2c963 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RIIKlrP-v3AzcS8hWasA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxNSBTYWx0ZWRfXzappBgqeuSfJ
 OsdYIwuaDWQLfK4X9y/zFzCwGGOM+dwHOcKfdeZbf58Zr29dPsV8UsmhsqAKxb+IQABmkJ/m97v
 svVIR0E4Fq9RHlyAKLVPFWCmV5VjL3c=
X-Proofpoint-GUID: uv7NnvgT1nKKnwD7wx8p1MvBbukf8oGZ
X-Proofpoint-ORIG-GUID: uv7NnvgT1nKKnwD7wx8p1MvBbukf8oGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290015

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

