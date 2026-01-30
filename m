Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2E1F09AD
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782798; cv=none; b=Az97+jJuV8HAIdm5TgzKJUNC73uaujiDqcYHLT5jbhMclZVTnYMrBFhR6e8ohrf90jVdwk4JqUjDq1F+y7FKXng2Mzs/TJL4HHuldY/aDRFSpwuInltAAWX97NhKMmCrAFiUg9mixCVuXxuWK3JlqWeYEkgfcMfLj/3UmE78wcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782798; c=relaxed/simple;
	bh=RM2jYyaAJGs0KZpvFRO6884NvQRvdHDwu2gaf4nYWYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oi9PFKBpj8TjkGKCRrddjwXdJvNoPX6tiMIEwXM/yCPFoE0k5UnAPXTJeVljjIXZbGJX8mVe6W3x77d20HUkWMpOj02ykleysCnqCgQV+2exsn0BNLcuEXDsEWCNc5/LKIVZmnn7FiVg2x+b/YHgeHYoy2ZTr1mZTMtTxclGI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loFPxULu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DEyrH2B/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loFPxULu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DEyrH2B/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U9V9ex2675518
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lBX7Xb/c4QyqHoYQVWwEkaV24j6y+poeEuDnKvKxiw0=; b=loFPxULuvLXhBnBq
	vVXq2j5+ePZ+V8JOlaEo9f4uEpF14BzGwmqfPuk7ei5/h2NpTQ3UiGk14Ra73EJr
	0Gb9sc/QmxoQi69tOmLyQGfmukzU0JuIuOjuxc1GVobFPYaYnBIUXqxTIcqWt+hg
	2Dst6NZmtfD+ts/JgOOWleYea41sCkO1SuN2W3IS4iEmaEt+rYhBJNu3Kxczk8xi
	X8c/xXdPwH47YKWASs9zjd+wttT/VScUuwtPej46lk+BWEOIHBv/gGEd5smpKqKU
	WoiFFxQHGKa6qtwGaI7d2fx2+bB7x+c5DtGhqg5/oJydmOoB9nm4QjMd+q5hjGjU
	k7Ve6g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0t340tam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:19:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a863be8508so30253035ad.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 06:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769782796; x=1770387596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBX7Xb/c4QyqHoYQVWwEkaV24j6y+poeEuDnKvKxiw0=;
        b=DEyrH2B/dHjTOB+x3juyzQ8Q36Ui+thH/P0XRYEoydb7j6ZTNEDuSc6g5l29KyNUu6
         y+VWI622DlugSsMPJ4lnSjtJGJ5VslREC88PPcT7DIHLtQGpnyFBBrMdJUmRMXonaYqj
         KeNkFhYaQWQMsFYdwaZQoNoLJ0GZGWgI0nBhRfXq50kbYWLXwuzsa/oXgFXrxva/cipN
         ccRNI+dh4Y7cOcU2EojN6alos8gK3dHzsxSNIoz1v9/lITbYAmg6NlhwS0Ut82ZaRlBQ
         +qjRFK4wRGWWjPDBzZzRtJaeb7f2XI+93fkbvuEtHCmc+TC5zaDHJsX3I6SttiA77n8O
         KfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769782796; x=1770387596;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lBX7Xb/c4QyqHoYQVWwEkaV24j6y+poeEuDnKvKxiw0=;
        b=DYOYiWJShNtYiD1+4OVudf9O2wtjbyl4n2bvYmMCyZsrienTPq5AN+iYUbBPsQxGVU
         WK+RcIcfymnoDzj7YWCJg7OgEcqmokalKCa05WLyIsp8SMMk3aeHAAuUd7Cy2GhirEDN
         zuRji35buXz8kSD7KBB2D/wfWM2xQEkSdO+WLCfvwqV2L6z+Lyu4YZAtk2XLq8mELPW2
         F/F2TO0y7AnIcC8/+CnrKFIULtePEbdGgXhQdsnVRPIaGg1Wy1tiS5h3+vVRMTpCmpqo
         PB9d9EJV0ZTwMasJ1jf2MRVNChznwdvjN72tw6nB9GimqIRwUFXADMb/mFcihteUAqp0
         1Atw==
X-Forwarded-Encrypted: i=1; AJvYcCXsmjI6VNdtbyQDq7cjrnOGNBCwIaDK4cidTgEAnIBbVCmBIX4nzqlRuEhqrvALS4yFM901z2bJePA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU42a91iaxoik4zyivQAZLM/9hwbZ6/FdlQCoifhJZ0kBcIfik
	bryvXpv2XgaLfwWzVmAk3LO/dCvhcUZtxq3EW3EuDm6dzngETJDphwirHFP0Oxm49Ngr3OZjWah
	OczDUtZQwOQYEaBuZCGmKgEjid5JmKt0Ye2D4ebk6uf/sHRnE8YdWjDuobdswTWY=
X-Gm-Gg: AZuq6aKUn5lu3bBAljLosyerJDm8o9qiNFl31C06eCVsfgWR55f7/xrX8pxn2QKbMYB
	VDfDpz+3q7jr8m67aepFm6/WvxBDDQNa6wTIwUKYp+EJhHtLK3mWMHvC10hkJlSdf3RbZWiNUQx
	BjkidUQChvorDzqKFEcieKXbTaIp4/kVjMMxA04KltxIwcr1mlLo3fCpB2sTS2rPU1UhtTOcKjf
	Bqyf+RX/OC+GJfFohl5iCeZgGP6mGofeOfzsMUk1/cmpZMnblFFXhEu8YatkG+GzQWU1u3RzFjm
	fVE3X4n8x9sPt36ZWp82Chm+IQeddFaSBdSW9Z/gwJa0Wq1GNq+9H3pjJ7P6yWj+Rc1d2QQNSql
	NQd+s
X-Received: by 2002:a17:902:da90:b0:29e:a615:f508 with SMTP id d9443c01a7336-2a8d803819bmr32743145ad.28.1769782795914;
        Fri, 30 Jan 2026 06:19:55 -0800 (PST)
X-Received: by 2002:a17:902:da90:b0:29e:a615:f508 with SMTP id d9443c01a7336-2a8d803819bmr32742685ad.28.1769782795287;
        Fri, 30 Jan 2026 06:19:55 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:d344:e8bc:3382:4c2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3b29sm73906345ad.54.2026.01.30.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:19:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Niklas Cassel <cassel@kernel.org>
Cc: Frank.Li@nxp.com, dlemoal@kernel.org, Koichiro Den <den@valinux.co.jp>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260130113038.2143947-2-cassel@kernel.org>
References: <20260130113038.2143947-2-cassel@kernel.org>
Subject: Re: [PATCH v5] PCI: endpoint: pci-epf-test: Allow overriding
 default BAR sizes
Message-Id: <176978279120.8260.1628300698854466072.b4-ty@kernel.org>
Date: Fri, 30 Jan 2026 19:49:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExNyBTYWx0ZWRfX6Fnpki0dFgfZ
 BtM0qwWrb43mP3a5p7XDvueDe+ailN87iYNzW1vK9G6SqWGUdta71UjxBaRVplkz7M0yp622+yC
 5gI4b22sjK+jv5NcjWL3R0pVz1JRugd0yJj/hdeZwUKQw+2x5mVmaHhRVHAxc6CO49YHEeTNT8f
 5h5h96tqCgEF7zFZjPD7pD1E5eRKWD1kYK/cYItgEck1DpnmTQry3V+lOSFG1AJd0tnEHucHzMm
 1nNFNJpZ0o9++hvFdmiKLHbfb/iOr2rRNYXf92TPb7WnblJaVov56BdXiDyBhivfs7rPXW8LYRD
 HBWPgZjC3a26eIIuKYYJgaG1o9fbglLVyCYPnqDDwzyrMy2icoRvM4A18T2dJCcHibF1QsxNhgE
 Z3IiGJ0eO1mEqSoQS6YiLscsGFqrf9A15xIJcXw7AqroaN2g9hGRxMDuCiT+X2K+KvRGnnuh/hL
 mcimj8Fsjw74lnpIJYw==
X-Proofpoint-ORIG-GUID: EhCiUe-Fe7KxFDek6aPp4Qhz9djDSxBS
X-Authority-Analysis: v=2.4 cv=QfFrf8bv c=1 sm=1 tr=0 ts=697cbe0c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MIuId-MzVKPO7xlGtEAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: EhCiUe-Fe7KxFDek6aPp4Qhz9djDSxBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300117


On Fri, 30 Jan 2026 12:30:39 +0100, Niklas Cassel wrote:
> Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> restricted to run pci-epf-test with the hardcoded BAR size values defined
> in pci-epf-test.c.
> 
> This code is shamelessly more or less copy pasted from pci-epf-vntb.c
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes
      commit: 930e343cde6c43cdcbfcc8fdb45539dc8d53d82c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

