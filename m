Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143083EF663
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151505; cv=none; b=p3pU1+pSIGLVrSWN8iV4v3uN/YVoJa7tmxmlEKewKmbgWU+p8emYL3lZLdl/HOEEQIddNtxU7OEolvG30UFNXg2gqkP+Dlcc1nsi1od5nnRMH1z47dZWWIlexAG63DniDOspw3zMe8AXmLI9Rh+jJFlOfCwXKg4yCWfr7wj8sMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151505; c=relaxed/simple;
	bh=sqkGfjJ4euKWc0C3d26wBFvOdB0aQj+cE5reUchQBaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fMcEI4q1SQ8wmWsw/UtbAYVocV4nq/Rm4QRFxPjW9nvx3GredcuaG9HmUJe8GeE22Fuim498wBRHA22ND2QoYc5Fjmc/z4hbyPF8k5vS+NL/vx7xh753DImMHXz1Q/I6juc0uf5XN7BVeuVFOMsAXCTeglDiCygNS0Gr/UVzDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IYyh+wch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+98WqJs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IYyh+wch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+98WqJs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4Y4H1562130
	for <linux-pci@vger.kernel.org>; Thu, 2 Apr 2026 17:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8pRpioEQNrdug53huRZBITV3EkpQJA6xvG0oW5+lMLY=; b=IYyh+wchu4RdZQzv
	B15CmnlE5PrSgNGSAzs/NeHj1wYjypcJuUbGKrOeHojU93lOK/G7yzJnJrELKjl/
	0n37Oa2DlWqyWc8lIo3alN17+e0BQjpi+DKZRUtubKnHZ9eTnb3BDtOv5NOA+7Xb
	nx+d5lrL7LiA4CPPYvM38MU344KfCt2k2ThJmnnnUSymVS2O7KB2+tyS28cNslql
	hp8W3cJfgDJU+3QGP+VMKCMRmOz4F12YefgGF0knMocqbQEgcjz0LK3OMD6UsHp6
	qQeqEcDyv1B6PEnFdYAm91yIk70T8f5G4O1tFi5tvBte5rO/oKQh91uTP4FTuApJ
	VisUvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9um70c8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 17:38:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0bf2b3879so27873125ad.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775151499; x=1775756299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pRpioEQNrdug53huRZBITV3EkpQJA6xvG0oW5+lMLY=;
        b=j+98WqJsxzk5Ux9WeyzhWn27dRB1+1CJ1L3PIGkkqdNolhTMyoNmST67M9xbUBuOIh
         4PGvkXfcA/Um2zU+aU8lKElgjVuqnDb95FoqDpvKO4rYJqhG5WenMn9UkTSgSkaVvJxK
         NealNdsEthuSDA6m1FHqGgBPgZK5z7n66OyS8Q8+zJDjdJfJlCbVRedaW2IcT3Z2haKG
         u/vlotNNF7OC4Y99dbmxYVnU828RrhS0y0pGvS3ivdOALmSAdlO651cnxRYnok3Bf+zP
         U+S9Xm0y/qi3KSO5THlozOlSIBjka6VHxOri/RzusbEw59VHqcYsReRP+2frke5g5eOY
         s3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151499; x=1775756299;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pRpioEQNrdug53huRZBITV3EkpQJA6xvG0oW5+lMLY=;
        b=lNWUy6+ioNa+S5SrAv5+76mglv2f7hMWBLYqoqdh/vB1WvEqpBoMAwv1znCABIkF8T
         QBERukqHsuJ8mh9qTR0eKr8633Yz2cJSqI2QfVXUNbCu6WhlcXDWlbYwqlkHyJlJ07Z5
         OAxyVdYaxrNRuqSFMuzVDKQpbWMeKevweBjGsstq7nL6UHx8GA9x2Cgfhot+M/01tMS+
         65IYGvDfcRHP6ZQoTczLrjCDVtW7u7MSBQhs8AldmYm4BNWQZZTt1ya6g+uNSFMaYfue
         NUtzaPO+gby2bSEAnV1lzdrG+Dl3mbXV2+6cC1UmdQTAYLwKdp6R38oBNGxBYNFtkUR1
         xpng==
X-Forwarded-Encrypted: i=1; AJvYcCUky6T6SrD73J2aMtO9JCvbX6vQ/hR1gNZm1ZD+DlUBdIxnBuRSGoIT9NEViWUW6HAwVPjr7vPyR0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PmTLzbYlAMxO+JblmL5u6yAX86D8qvJsJKdkdueMtyoZibsc
	HNwzIKfmJjx2sGklDOD5TjvRif26hM6x1IY7VWOt/RxBvnYiqAOwJqPYSWi3cw5ayQw/0/SotV7
	6jJeywWMquzfErlIBGlpTyysnggz+/b7Yb1ahmS628AKrLB2GOOb3fyykMW1DmJs=
X-Gm-Gg: AeBDiesX1KHZlfnmCXxOtBWn0O3omVJGw3dFuLOVeSGLtAmkTkwmsptXhgMEeS5wfA6
	UblA0MpKeQBToqhUORkntJqDcO3UPhtbMxRAgTSXBXySvLP3FjKN8PcWZ67ZX3+qUb/pBFCc1sp
	aBSjlhaljpFUlepkGxdDCnEJgbke9Nm3crn97VlQU+evFJPDVw4BmkJdnb5urTsJt2dGJbjgTzD
	yp7y8/LVIJDGBHF1MKldwqrsZ0D1moaAuIrg+ShdunuVxnZIOTl4fnO9HhYqKbN3GtmOatZCszc
	RieQQM8P+8qwIPvXHrLHTitaN5Ua0iW4EZYxXECKnCJHHui1EjfaCeaCDHgJ5ehKi4KZ9iwlvVl
	qnXezq09xjut5c6UB/jA=
X-Received: by 2002:a17:902:e948:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b2816f8000mr2035815ad.21.1775151499126;
        Thu, 02 Apr 2026 10:38:19 -0700 (PDT)
X-Received: by 2002:a17:902:e948:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b2816f8000mr2035405ad.21.1775151498432;
        Thu, 02 Apr 2026 10:38:18 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274779b48sm49273895ad.25.2026.04.02.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:38:17 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
        bhelgaas@google.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260401023048.4182452-1-18255117159@163.com>
References: <20260401023048.4182452-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: dwc: Fix type mismatch for kstrtou32_from_user
 return value
Message-Id: <177515149426.14857.4783311944035251259.b4-ty@b4>
Date: Thu, 02 Apr 2026 23:08:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=U/WfzOru c=1 sm=1 tr=0 ts=69cea98b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=+KsUAYeLG1mN9JXONzlAbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=FzFttBqTvegjDLAfE78A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ZtcgoegjOuGuqG74bmjd15UoB8b8zHJG
X-Proofpoint-ORIG-GUID: ZtcgoegjOuGuqG74bmjd15UoB8b8zHJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1OCBTYWx0ZWRfX6bpOP93+Kgn7
 8BrjOCk4wU8M3n3wjensni2mjiwD+f0shfRF0QTx8Lp5gIudct3LKawOo/Qi4thStv5TI+pOGF9
 JynBQetU0epefaXpVi0BOcJ3UZzfjI8k8qSW6pLETtOP/4efju9bHWtvhAJdmxe5FZeFGYSSuGk
 aw1Cnnn21rvHUp3nPYfPNktsa0hfT3hRSz5TJ5WJpWkuRvHWdm0hp2uB0mk3VYAVKu/dzIn7K2N
 xDCKe/RzRRoO1/E6IqBIS0mdNbGlMEZ+euCwlQFxiwPAFvGnmPX3CN6qN2T9wGd2UmvRO7QR0/t
 d3yWzIKyKcFg68QZyMhf+Xs+ROPa16dgYVBjjP2/tz+d6uJE7ejulKC6llJSIbmx8G3qPxhjMbR
 e4fMwCbUghd0395mMAwicm6kepJzPIODMILSO+0g7hYjcd3hhLYrA9S1yQbpmanFQtYClg247MN
 uv3H9Yb7CqqTfDfrshQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020158


On Wed, 01 Apr 2026 10:30:48 +0800, Hans Zhang wrote:
> kstrtou32_from_user() returns int, but the return value was stored in
> a u32 variable 'val', risking sign loss. Use a dedicated int variable
> to correctly handle the return code.

Applied, thanks!

[1/1] PCI: dwc: Fix type mismatch for kstrtou32_from_user return value
      commit: 445588a3b18bb0702d746cb61f7a443639027651

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

