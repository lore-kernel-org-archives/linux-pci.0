Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E82264A7
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690409; cv=none; b=q71l8IUA/5vMcpdYsc85vU/5pO+8DyA6D2aiiGp6HoR/zXH8mYh7rcJRhoUWWRBJbv+qWUhGgLjzZ8sG6oV54VDMfzBfoWFwcNXuEMpq3PRbU/ACmwORTZDuvTk8N1euwdPcKg3xS6782f4KbHamLXsBo/OEYHevn+rpLC8viS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690409; c=relaxed/simple;
	bh=fu2RJIxiGq5B6slToRtDN/OOlO0rZyjMDU5GoUvQeik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lG9RIhEpa6H7Ke0/0XiiD9xAYCOpWnRt6WHIxqX+Hywf8u5iJ+7pAr0/mnIxTv7n0Qib6xJKvwaS9pMR/DEM/KwRbDy5RZW/oc2whBytCu5okTqBEHAEJrThBIGUhH92EyXajou5xvFDvUWGUPR58d1TgtvDmy3pg71RQAQoSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeCJAnqw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkqO5fgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeCJAnqw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkqO5fgi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BgcZ021015
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 06:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CSPDd+Vt2mnahfvGcdf8DcFPCA8RiCUu8rYUql2KUJg=; b=JeCJAnqwfvyRUQSQ
	uKSSmc6ex8bVAbWco+H7XMkTEPf6+ux3CqGJCvJCcqdc09ezEHFRxlKSX0hv0ti5
	0Ki9QZr/upWAoHibiBh9DNk6wE/v/K6VKa0rNjQbz6XgIILt8YVunzyIWmsiEBEV
	8mLgUrZnh3kBySf4Nw1AQ4p3w/LFR45EgnohkivGlBJDQG3mpnS7l7rXnjLcPYVH
	tyIRLZSXbM3JE1DH1xAFVKmC9e6VVCEDBdW56YbhAX9jhBv3AVuoDIB9IAs+ST4v
	UJMWWszIz37UXTkIJPHxlSiM0wvvS5ea5sWqynpFD5cc6UK4bV/CeIDI5Cyep48j
	AKrl/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpupthcrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 06:00:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35980affbf3so3229774a91.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 22:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772690406; x=1773295206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSPDd+Vt2mnahfvGcdf8DcFPCA8RiCUu8rYUql2KUJg=;
        b=HkqO5fgimvlmuUMMeIem5eCtUUn4LgKRr4bg+D14iizax30XSdpXWd4Owug1fTu4iB
         MNvxpy7r4IVChZxCjH7lt+Ku1pRLMcnhS4Ugms7Yys9ePCu/B3TRVoaQ3k/wrqfUThz1
         9bXEGPtlK3+3RNAyiNVFnyRK7u+/iLrMjxn7005KoS63VJvDFzVktLFCPICW+wXknZtW
         WjRqaM0K4lZBCo7dzF+PUcL4sLPZjVYuFWLl9TswspZC0jQn6aRD6EHWLyKlFXySiWL7
         q+bZCL1QuT7AMfScAMZTFxw+JlxEUjFg59ZUp4MT4VhE5IJULVZ6ZNvJV6f923mrWKTi
         O6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772690406; x=1773295206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSPDd+Vt2mnahfvGcdf8DcFPCA8RiCUu8rYUql2KUJg=;
        b=fFiNu0su8rJJdia2382P/S1xIXxhohsQhwaO0GmZ5XF8g0aFNelcZihwN8b6mE8DeV
         Zy8AxTelxtkuBZYpHEzP1U6GNbY+PxjOfUfCJhszxWX0soya21u+bOcjxDWStqn/wnZZ
         bC4LvAaLgxZOvX7WjH9UWrvtwKxHGICQCftCdR6vf/zZvLzqsI8YqfFQ96vGaonZKJjU
         Gv/KHLuy06uCh61M0AY5/U49ABXphybvjkaQo403PWq1zhdIe24GoMt36kYwnN3juMIX
         ImO9so1sDCwSewgKk7f2M/yl4D08KCQaphO9KkVRIQy3ndbBvb2gpRPS/gvrrE3fL5zA
         m08w==
X-Forwarded-Encrypted: i=1; AJvYcCU6SHQn2UYo5zNpd4yLuNElzXpMi+2LZOL8SjB1QlOzewm/6GyMvO+gekrTJXjhxS9TtGNsTewF/zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUM+ezJIZSv9/2EWick6VcomEp29RiKJvu1q5SXxwFL34gb+j
	GFzs8eMr2X97skvg8zlF51y8UqDOXgXPDDoj3cb38LeGEPfrb3+uY7uE1NbNYgJfSOuxLgOzNDY
	oPoQFjHjPaOJgAWlTNxjR640MVL2A6rL6CWvCgkdrCgotwgMfoJe0r7UOseWIveE=
X-Gm-Gg: ATEYQzwCCNUY6VPUHbOUVMg6jnp7/lUj9/npsGV7v9u4rdvpQPr4BwrWDaXqOvsqYyM
	o/NKoAxBULQZb8x3wUpZzIYSRycodX65FfKLVDh1fKHyCR1FZUvCkxdH0j5A5Rscti6bVlCeHxs
	/zW9lMPcGMhcTBebWMGXRqIKY+Le9d9/6rgJGcBV2v4CffWAey++oA1fEqEc7q5v1Ei/zntO2Zj
	xYEB0q8SXF6uZTGyOuSLpxZoDUekqnIeYAbAmeSJHLtuu4vIgbjbkE+X74wuafFID6RLNk3cAQ2
	zo0gNZ3YK7Shl5YmEflGQtQndlnQ5uEE9/rDbA7bazatXmIlVYoHYVLUT5A6iIUtzgBr+du7qfk
	vMRZFUOqpksbu8HZljzsWJdM=
X-Received: by 2002:a17:90b:48d2:b0:359:1821:b4d4 with SMTP id 98e67ed59e1d1-359a6a9f7f6mr3804529a91.31.1772690406462;
        Wed, 04 Mar 2026 22:00:06 -0800 (PST)
X-Received: by 2002:a17:90b:48d2:b0:359:1821:b4d4 with SMTP id 98e67ed59e1d1-359a6a9f7f6mr3804491a91.31.1772690405852;
        Wed, 04 Mar 2026 22:00:05 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738f543be4sm792964a12.0.2026.03.04.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:00:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
In-Reply-To: <20260226133951.296743-1-mani@kernel.org>
References: <20260226133951.296743-1-mani@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Perform cleanup in the error path of
 dw_pcie_resume_noirq()
Message-Id: <177269040188.13021.4911974718423067966.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 11:30:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0NSBTYWx0ZWRfX3IgfRUBi+rZE
 FlX+Di1TUaA8ZCutgTgxuH7IZ6AQZM0mgq7XPkNUx8m1FbAcMoN8pZYrkeMNhfDu6T7923p8q9r
 73D39jqWfBPpNMvEDDqTim91jPpS6wgmlI2rUdJwlwMlj40YG00CGkF/zlnj/tbSEShwWDen1Dk
 ZtYyvrL9hszh6RLi+geNJYqen1giKbmgjhScKftTTRS/6QmJUlXAHFlZqwlZ4cW+i1xbMnx+5NA
 iKNOpK9FpkfPj2zhLTksBjdjmOaDp5alFaPavQrMbWH61oXazt6BWWqC8kN+AwkkX7u0nVnS/nF
 pT23BmY/bMaK2Zeuf1s2LVsNskY+0hrwcahwlOlSGBcR8yb918Fi9B01emOdJgH5ZocWzK0YE8q
 x08kbPXVzydtIhX1tt15U4MqEsKdE5rcf+rYhkMRtak53PcRO2gf15dOJY2o6wyiHrEDccb3GdA
 7do584jlCorA7mRV8fQ==
X-Proofpoint-ORIG-GUID: OKosBOblAb04DjQMGDGO2GvQRUuLRIGs
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a91be7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=ojn154vqY31M59im7cEA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: OKosBOblAb04DjQMGDGO2GvQRUuLRIGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050045


On Thu, 26 Feb 2026 19:09:51 +0530, Manivannan Sadhasivam wrote:
> If the dw_pcie_resume_noirq() API fails, it just returns the errno without
> doing cleanup in the error path, leading to resource leak.
> 
> So perform cleanup in the error path.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()
      commit: cb5b15bf7a40d76b710fc5367d27f6897ecaa552

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

