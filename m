Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAA2E414
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691415; cv=none; b=E4DLLhjW4AnExVBsswPutGJOTS6VG3y3L+YGxgfdYDB7mDpswvi5dYq01dBDGSksxkTrzKA9+Hzw9tx6oUgUPGYbcdmKMwgXgf8f7uBzuyI+MfvtA0IjzMlk5+q1u6CTttBoiiLpVk5RpAQ2eLFjdCWQIJQF/D6snWjXwGPZ9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691415; c=relaxed/simple;
	bh=S64l/ihfhHjuwyeA615gOMNZezoh4wUaaLlLEC+Nb78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZkGVwZN+6dlPMgbG/c+5xgv1UsLL5Axk35XqxGM+ljpFc6SlfYMGD6UFARBuludoWpbiHnokQ0b9d+YYXZby1FUKtWlKnUVHFdmsBSAxongi9FtZuRCaWsUOUAYJpYHjbwz7SqbiCWVgQSBPvHtR5g3Ux8+Z6wANe74Uxzm2Vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIqp0wXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVWEnRLi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIqp0wXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVWEnRLi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BwUp3160348
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 06:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0VMlY0r60S5v7bIHNBx8ctepOha11VRcQ1O0keqpiYU=; b=mIqp0wXCGH+TfP+H
	Sk+BijUIwXFUdwZ+crSrHWmL6ErG9P0ZLRHa27a+oKBjxxaj6O9ydox5NCeeCZ9g
	fkNIkuuIo50ZLdtF4jwqWbIpfBvD8Ff8U5euAWK0+wKAecNfuMfgqsSl54Upc7JR
	gEfL4dDopMJmO3WdfdaoAsth0KayjmapGp0pYQnkNdOe9VQ5iCSIbZzj2jZ7qmgp
	b+b+0ScLK3ywqaWYT8/sDIAaW63QH0loCFuROSeKLn7dnLJgNTE+rEOVe80j2N2V
	NbQrwgMZvbECOVvh1AAbXbpt1bF9pFCkCmg5Xjcm97Jnly42zT6lLhiaLS2hvGkS
	VyshPQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpjh5ucpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 06:16:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35641c14663so8094608a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 22:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772691412; x=1773296212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VMlY0r60S5v7bIHNBx8ctepOha11VRcQ1O0keqpiYU=;
        b=OVWEnRLi5hPGAAra3TlEMiKGufYUHyev7y+8AOJvuB5V28NNsphHCEA1yDbccW6HET
         FxDGtJ/xEmhHcAtIDy/fuRN3G2mMgWxeCBTIeaFxU43yMJVlLSVBSY4SUDhoTgyr3GEP
         fc/4yYPgCNU3BCKZ+8jbkyqHwKAThks5ImchWYk9UvrH+3LLMteMx0MNctmXzab3Jil2
         thPkipgdE4nB+cEHw/uKmJDjpDZWngJrS4dRQEPxQiPXeSMgSyOxg6Zl8dyk/77PAym6
         q0qqCR+qOywv2OIg/UoyXs+wYogdhT+triO+TIq1XzMIG5OdWMkH9C5q9BijiB6CXIAc
         3Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691412; x=1773296212;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VMlY0r60S5v7bIHNBx8ctepOha11VRcQ1O0keqpiYU=;
        b=mWwRiBmz3PGqsZo2JrgPovNsLT3Or3VluQ+oPZWr0PZHSvm36+NyRjKRWliJZu0w2Q
         L4a9Oh3Ae/NhUT5DVy4PO9vSFabYnwSUbJd26k2Nog7dQ9Odz87DaGIrXH75igyCYYqU
         xS1bagVIxzoBocKzPm0FIZGxvMWUi5sednzcu10DdvX9EG1fj5RLag2XpC2p/o7x7AcB
         QJfWe1j3yeI8djmEI25r7fchoCMpjXDNJbrfSPM9VLkYSkS0qump884Wl2YZAFEPdMlQ
         AcatAAEUec2FTWRRtFuA+BbjkA2B7T5PqYP/+AYw5fr7b1/I7URlkwS/2e3mOihahp/Z
         d0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXitP5GoiKFArHo1D21zjDM6aCvbvKGA+xjnThhn8iJmTkHElUEPGEXXsbNYIT/6SNt7VErYCW5hnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxeb4UA57WJ/8uaH/m62W8shEbuEFqbdkf9kN3olZLwRWZe+Uh
	TujlAUPhFLdLUx/HLZKkaDNZq6qT/royy7dZRLIe+13CbdIvlhna/8JWXqtUUW2Qc74VQktuZyR
	qL1WxhjfWLa8Br5cHgX/j3yMhaGdy4Uys5Jlw2gnsDS4vPL22husw+ri9RloYbgg5DUQ75VQ=
X-Gm-Gg: ATEYQzxB8H7RGtnDjWeHrtI+Nr4Daq7gvwVmCa6G4reh08971nBBie+NR9yF0qSpYKe
	OtGcOzTZwPOLkkPvV0C1qDz9g5m3FWyKc4G8q12hKrQ0JuKMN9NpoTbryOuIC3W9xiLPqn6CDo3
	CfRV1fIvjp0LQOik62V0vjoSNwOkrS3rLbFnLGLrc0aJ1mjKNqzdUVaiZBacKp5idOftdKqOyig
	wSVIcW644PdqfS2oy/2WtktQV78HeXkkJKXBBwnMvojgTWH81NqWKuZLiXhB1fT9/IiAs6XgOO7
	/8BsYQf/ekUS10ljoEFMBFGQDaPumyald7wdwPhd8wTsrHRQwSx8VoAHOE6w2nA72RNpBRvw5bt
	urXK+8EBCMODfJKyvrN7aOmE=
X-Received: by 2002:a17:90a:ec86:b0:355:35b0:8b78 with SMTP id 98e67ed59e1d1-359a6a7d2c2mr3568890a91.27.1772691412030;
        Wed, 04 Mar 2026 22:16:52 -0800 (PST)
X-Received: by 2002:a17:90a:ec86:b0:355:35b0:8b78 with SMTP id 98e67ed59e1d1-359a6a7d2c2mr3568875a91.27.1772691411542;
        Wed, 04 Mar 2026 22:16:51 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d560a1sm789762a91.10.2026.03.04.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:16:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kishon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alok.a.tiwarilinux@gmail.com
In-Reply-To: <20260224183927.1369124-1-alok.a.tiwari@oracle.com>
References: <20260224183927.1369124-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] PCI: endpoint: Fix typo in pci_epf_add_vepf() comment
Message-Id: <177269140855.14742.14704090008990433224.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 11:46:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Kr1RaiVj2GOB7igWtu25yCCN8dhor7Q2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0NyBTYWx0ZWRfX9tSc/lHIEJuD
 +PCaWqyGtwwPRjBUKTMkusEnBNeIgBwZWqLG+Tql8zDuqTQlUWMlkZ1+7ZNfibsYzGXEVvxsrSM
 W/v4LHzBWLQp20tRx3NpzZgN7Z2pgyUNXsAt9iWAyPm8xcPuz9qaUAhGnZZNshKHE2C9kWbGVI8
 i+bNgPHKczh81tFW6epSW9rgzYPiR2lo5XsnIXQ+9ImU1pRwnN9O3iACT0ojPC28RegV4V4ZgJY
 w5vZ5sKpJDDa+nz5JI1pHfAZYGVYwCsFAkjRW5oRnls5kfWQ2XEEFh9EFqH2Lirbu7jjSiTAF4L
 p2nYBukE3TpEiWhs62df3g5hkp9c6tPl5CLoTniUopQLZ4pUyfHa//RmTlFsuzcXRNcuVa6wnFq
 hDE3QG8RBUDM/6WQ8Kx+DA3IaP3CpO1Z8MUSxRGDh590xW1Waj39tgUDtvVlnpFR7PUPPBp9+Mr
 Fnzahpyr7K9K4oW7ofg==
X-Authority-Analysis: v=2.4 cv=JK82csKb c=1 sm=1 tr=0 ts=69a91fd5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=XUcVWzrgIBk1SnVQeMcA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Kr1RaiVj2GOB7igWtu25yCCN8dhor7Q2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050047


On Tue, 24 Feb 2026 10:39:19 -0800, Alok Tiwari wrote:
> The comment refers to pci_epf_add_epf(), but the correct function name
> is pci_epf_add_vepf(). Update the comment to match the implementation.
> 
> 

Applied, thanks!

[1/1] PCI: endpoint: Fix typo in pci_epf_add_vepf() comment
      commit: 88ce49abc2185da3d08da9f71290d46a393d3876

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

