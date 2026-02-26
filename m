Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC138F958
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091877; cv=none; b=PAYSosTOp09Yp7PBMLqSwC0hf+lsjbQa8cCb/bKSuhw+sSCQ1X72ttlN2WFbzYK7uzt68OJ9iZ8AIQvdnhLlNl5n9V8ywPbUiu/wgEfJvqjkTTmT0tzAToL+7EiuzJTavXloR/G6YaXK39rUBOUxti09xpaufMziRqsBfSGkCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091877; c=relaxed/simple;
	bh=rhPAW8YQWd+vyjAyXM0So2b36TUQ2zEuWwxHIKft9F0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTo0Mr88lBFZtkkdjoxkP2Y1c7WChmMitGTBexnmeGWrASMxVUi2cNGzoOdl2pCX0BhDZ9fgovSgPs1pwnle9XTaTkZtM2bJrBMjtFQpODAgmVTiffRda1Tnw0BXSmqlUEMx0sZlLHA2TwRzNOZC9h/UVpp9jGzuBvHPG19WqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhr4mHN/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NK+ir7Wu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhr4mHN/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NK+ir7Wu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4UrtJ3776956
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9yZdcfmQMxJ0CDJjnJVtDP6g02hjinSCamA08XHGric=; b=bhr4mHN/6qY5Vj8Y
	rW8aPNlPVwlNWuT+GoH3wlE70tg778R6wBGiztwIpzvjbdHBoFPDGq5ykFIXSvcN
	VHi3yQ4UphWbjOAOKJ9UoxIwcHxhyT5a93gXSp00YJI3va7PBhRxsJIDoW9CKK1c
	CZ8w6S1OIN+4p/DCnkrVxou6gru7PUGGEA2aoxxmZcF9DQp6BbCkcCYe4lJIwRuE
	NnemNrQm/bnDxe5iG9+l/EV+5mNK0FC7z+I0JBWmyWJp9xPGs4ruubKDlPyQnQ0k
	SjqpUJ1LJ8WlEyqWpe0Xv2K87TQ6aVfz9F8G2KItTzoramNJq1ql+gIgVjMpVbtD
	Z5bRnQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjae0s8m0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:44:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adcab21141so5928265ad.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772091873; x=1772696673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZdcfmQMxJ0CDJjnJVtDP6g02hjinSCamA08XHGric=;
        b=NK+ir7WuS9UT7jjB+iSwy5TBMwEHff3CLlQXyL0D91rIhZ0aZyYyp1BWyfpbH8n8gM
         optZpDJdjzQF1EqUNgJFH73I/I5iPbsI2QPsTOe6c8kInG0q4tsQUA8sNB2CLsdX/xHx
         bZS6kPG/XWdgCM+RJoDhGeuTenLxTNTP5sA6Oz8attKN3qr5ZCB03NGNpAfLdbaEJgCp
         AXVWRcAsH369l2QXp77jDJDOid9nFsy8KC6n+IpVrDu3t482IV4mz9BUV3/2qNJ+eHAR
         Oe2QQ5JCiOalvpaPqciJ9U2NFgHZfKTRqoefS1nTlCByWDi3+yb9i5JGYRV8NXChT9Mr
         RZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091873; x=1772696673;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yZdcfmQMxJ0CDJjnJVtDP6g02hjinSCamA08XHGric=;
        b=ksOis8iTcIF0z5Tpdp7Wes/rn6EVTb9GrJNdd2wvLSeruSiGSByllSN0Fsw1J4xoIA
         48gBJRjSocYDD/mCLyShr+tTjTkM6u8NOe+aCvrlFmwJ59j/Gh69UEJ6BEELBnGGq4n9
         1rQE4fpCrt1RtC0KYhHZexT4OG0Lg0MMQnr0W2/1P/mYaVLkbXC0I5oldb+9y4/q8Ura
         lkCD9owXyRoJkGxx/EWcDezNAykWcfvHENgXZr60aCuFntHg1ST1bi/DX0kFgz9ANMq1
         ybrh9PheIh94lxCmuTduIh9YQsCTlF4dqk3564Tu7GMdHZWz/plceZIpRlqC4P6HOKt/
         PvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuwaRCjZ9zqaGoGzu0SjQzMPqWHrT9wrXiVkp0L6K8y0UTODhPProA4ABjTr7XQcWTDXBo1pp0Zgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtLdZBnVTMdZ/b7lrbLaVB0FeavP8qCPaRrz4B+rLV4xLt34f
	Z+cx10q3vRInMi5oVm3bIxsPhKPeN9F/Ry4oOBQpfXKeAFIagIgdGG2DRs0iHVKyC/8EvVXkSk7
	N9m2B7HRNtR7AtuVZxjxTSigHwx8wKwBr3IkA4bHM45rnd7Lexz7kxqrUPbGhN6k=
X-Gm-Gg: ATEYQzzlHZ+WP7ZF/nZlLwp6YR0HDi6IqQHB1gFM3QvCTjifsboQKcDzGUkzTpfSDwF
	TmHob14eWx2FDcgM00tCUqnZAmQE/qitoWsr94x8vgpjxLloAZZU4Pc/33iTmbjNNn1bv3Ohva5
	hEZKCIFCfV/mQY9qHy115s74YtrEB9LAYsBfBZm4C9MdZAyFXu72Tjv7UTvoy34gh38x5WD6AVN
	Kd87Kelr2zfqO/q/XA7iAiUNRGxG34Oc3UVEA6HPQ1+v61djyaxiqNXNkRfcU6e1+VVnu5fXeGh
	T6+fgHLAV0loEVSUY2L9m63Ly26OeatlRr8If5s0YRM603Xt/e43WJYMN8rOA+Mb7NYuIaVokMm
	9G0K13J2aRr5fjzb7kUteAKY=
X-Received: by 2002:a17:903:19eb:b0:2ad:ba3a:3827 with SMTP id d9443c01a7336-2ade9aa6ec2mr34819585ad.54.1772091873397;
        Wed, 25 Feb 2026 23:44:33 -0800 (PST)
X-Received: by 2002:a17:903:19eb:b0:2ad:ba3a:3827 with SMTP id d9443c01a7336-2ade9aa6ec2mr34819255ad.54.1772091872855;
        Wed, 25 Feb 2026 23:44:32 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:521d:50c0:367d:1d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f0ff9sm16359635ad.84.2026.02.25.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:44:32 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: dwc: Proceed with system suspend even if the
 endpoint doesn't respond with PME_TO_Ack message
Message-Id: <177209186922.88807.6006388594623586270.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 13:14:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2OCBTYWx0ZWRfX6xz7XfnORmhz
 hEXbbzUc9voRfEJgw4xfW/mR2EMhxd2/O/sMxamAIEidlAto6JfTOJOdEQBYduG7At9GHkGKi7P
 jGzHjeeyFSCzmIWPTpCnLKv3k5B+f4dgmib3GYzyr0WbLNG1ST7nEVA7Mu6Eeu8D+Lef/v9sbyx
 4v/boLnAfCiD1pV9XeaXgDtFLocM0n7DxwFHGD5+hBEpFivPJaMUjAgt4ynwhfTEwwLq3vGIiss
 7TKBgts5cYczAnL7/l7+9Q09wUuJJHwJAJ0lQKOV4V8RB1JsPQ1qNs5dc+nwMOsvcQI0rp+o9Jj
 Brn26pOoO+H4jGhiUgoY6dN1DnUrmQkY1aHbobZU4X9LOpxvjA8lMxE9pia3fqgElN8RLDHlI8T
 pqTIzw819Xgjw+RRWWU39aojVZSO9PI+GXZABeCu2IEJbKB3M5EIDZUVzvaTDdzeSrpNqN3BSJd
 HZ7C4oo+ZdWWGhaB4Cw==
X-Authority-Analysis: v=2.4 cv=O7Q0fR9W c=1 sm=1 tr=0 ts=699ff9e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=DU_XNjMczxmctojpdWoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vOFQqqNYVKZ9q1CXP3sD9VRad7s0g1KF
X-Proofpoint-GUID: vOFQqqNYVKZ9q1CXP3sD9VRad7s0g1KF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260068


On Tue, 17 Feb 2026 17:01:42 +0530, Manivannan Sadhasivam wrote:
> PCIe spec r7.0, sec 5.3.3.2.1, recommends proceeding with L2/L3 sequence
> even if one or devices do not respond with PME_TO_Ack message after 10ms
> timeout.
> 
> So just print a warning if the timeout happens and proceed with the system
> suspend.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Proceed with system suspend even if the endpoint doesn't respond with PME_TO_Ack message
      commit: eed390775470ff0db32cce37a681f3acc2b941c3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

