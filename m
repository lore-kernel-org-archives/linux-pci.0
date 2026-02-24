Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4B349B04
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929313; cv=none; b=YqX/qUX+gQlPn9t9uYEN+WDBdg/pCWSnUeWoE+8lSkUroUXpitlkUxuIbmL14UdDUqfCqYhikAOLap4YeIWdaVQvlSADIijCXtl/ZK8wq73P2i3KBNF/9lUm9xe2AqdVx+EVH5RLVxw9+2xPLqt7b6+yaVgztCxl6yPSEjpg4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929313; c=relaxed/simple;
	bh=Hmrd+OfmBtJB17+5qKn46EzdFcAU3+al6tJtRf/o1QY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bsq2IcTRalfCBYw326ARCdNGejPnNg9DR6WOkXbXof3Vi6IJaRrBMBnKWkZlQnfJJu3I8yQ7sEeZ9wiAC+NgdaMp0TDk4by7Qa5oNxdbHdQ8rgZ5sXM0ZG4NowJyZcX7fma3PX4+dLlLDwpvSjR3nkAN8CdZ10eMMsSMlLds0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uc/4G2OA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqFKY6BA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uc/4G2OA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqFKY6BA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFSAD2006479
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=; b=Uc/4G2OAkIdd6eIL
	GkvpSxtmLqmr8VQA8vRb16NlrRo+G8ESS3ynPwe4y+oTxiVJN0JmRpOWbfdANqI7
	vf7VNESV+b+xa5LB4RSCSZUD7J8BgA6Xug/KuLZMoDLIyKR9ZW69eO7bsxIb02H1
	KXZfsz4pc5cmfQzc3hJIP7v2tdnbLwiIXCE3ZL/oG+3yOSm2zPJl+hemgMsuXRiK
	Du64Cv2eWDxeQ0Aeu4DCD56WElsoUJmn1Isb7O3wZS+eG6/C+D0Q4uVZ7i1I+l01
	c2ydDgu19rpyEvR1Rc1bpbEq3vRpykRjQvf9xn8Am29bJhYRpyi7/YK5kgefOQBi
	ZzspTg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch45695ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3562370038dso4867039a91.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929310; x=1772534110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=;
        b=cqFKY6BAyw0NBKcIimMGtpX9ZwKEL5tcAlBx7HQLNy1S6npASk3DghvDOm80HpaxbB
         mvvv9/ShQl+HxB/Yz7PSd4dYPPx9No1AjVDJwcG6LgfqqSfmwkDz6WJZaWSVFguh4eO9
         81L7DKbIrl0OKPIeV9KnutWM70B4vSdcqzjDAr8YPEELOhxXJkfEiS3BZLb2B+Wl9jUs
         2IGDKNbBwRPyqp+/qbK6QXu1aDQmIEOeMENAflOPtG4GJUthlyibWxhHv8eRQPKgSrAa
         l9xEIFyK2ovFo1fxcGJgRgNFGe6d9hkNCi1Y5m6y/p7jEAuHqJr1zRHKnSElAYxbzHlT
         bXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929310; x=1772534110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=;
        b=qVVAzhFJomOoSXBOJKVf3eLa+06Vmw5mlEv/nLGs6t38SmPdP0/j9n4TswWmWpzppy
         PLklaQUyiTj9Neyw3tgtPSMe4uM3yneD7fMioW+Tf0k270fy0KOF2m8u9swW73ffCrrr
         0JVqLjudLSfaUW1UM5dOVFBHMzzBRBgK7gDo6NfMftgqu9XSp8Y7yn/BmJkCYsBRzffW
         EOgq1MxQRgaiQ/ZvRpOOgol3KrHJYFp7CMSRfleXFjGaIlpcCsSw4JRTNHiinWdQwJpM
         +fQbtMddkPv7bQaDtbrqTv3QF312EKFZshnGbJX0P9JVgGXRghpxwtk7iIEe7OWJaANB
         NWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjv8jvis52jURBZ78nyB+ATYEbvgetUNM5tyxvzqg0B5F1hoVo6JK7+MsUcT/NBI8w6cVVbdpcgvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJSKtzlLcNjlOG2k/Bp/ZdfjyHsc/xg8kptdZQYQytsgO/Has
	gTHBy1YwoZPSjYACKdBvO5xBPno3dvenhX2Scmi6C+FKklmDUkqas3VVjiG3bCgmVWCGop66odg
	vxOfymdzWefw5ndPrwY/QD+06Su6ETIQqr9QUxhCSrIjn215FPoWvRVRjKqPSO90=
X-Gm-Gg: ATEYQzwgFojF7AKdZDIz5cCg7jpwQUmwgs0otUB+Z70uJZbyVUzdbDUzN0yOa9OC/z2
	2HNyk6/eUY+YnMfqy0qKQOT5o1tSCIc6/mvFXRGj++soD6obLWcvItXNOhSWQQ6FxysER2yxZWN
	jC73tAfZGgMy8mqay3n+jTzhwvi+fXT7lJcduspe38+9GsKLj55uX1R7LQ0VNAZJwoWKUPtyN0c
	YsOG3XM7fDr3fjCboiGvVd/hPeGW+SAwfZb6Jvk5uslwWPOwSKzHebQStdpIcBS/mvBJ29+DkXQ
	hWWk8GIhiiyBfN9ropQr/2LXBvgGbIgRlMl2aiGmfecMu1UfGbe4/kv+ZwBPwxa3LCsvnjRq2Kf
	Mt1Ejv6h7pdIU2+kWuYDhWmQ=
X-Received: by 2002:a17:90a:d407:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-358ae8c6ac1mr9261760a91.25.1771929309924;
        Tue, 24 Feb 2026 02:35:09 -0800 (PST)
X-Received: by 2002:a17:90a:d407:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-358ae8c6ac1mr9261736a91.25.1771929309381;
        Tue, 24 Feb 2026 02:35:09 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d78a9dfesm1374205a91.0.2026.02.24.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:35:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260105075606.1253697-1-den@valinux.co.jp>
References: <20260105075606.1253697-1-den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec()
 on mws_size[] access
Message-Id: <177192930530.12333.15482985768888162269.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: unlKG49_HisGp6g8lRo3e0MhiWRqHqfb
X-Proofpoint-ORIG-GUID: unlKG49_HisGp6g8lRo3e0MhiWRqHqfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX7FK9VXAR4Yg9
 b16Wbvl0IMWkcElD+DR/Q2c88F6TLPaRFPRlKcIGyjMHyAU8XVtlwg0Zr54SrFq/qmhybMbykmR
 0b0bgz/neIW42ycelJv/wTRU7xoo//Yjs3kJV9mMX9nKlDKh+9EDy8CBcQPKKiuVaIghaw03FFB
 IffHQ+pxidAr1wtXkDq+N4LI3LGB6FjWivwY6ZwWZxzVexrmtuXJu3rmJvpmAIrZqjpKJu6cnda
 c0bl9f8fRHiSpJybq7edzbAlxHZUx4mi30D7qOd1w86mL92PEWkrxE2PsW1w+VapaNFKM0DmUXQ
 mHSbD/bKNuMztdvDPcbiaCBA7Ep+IbUMjpMUsuuFOrpCzcl3I2+LdOEWA/1NQtxjj0RwYW/WH1z
 n9UUG/U+xRD4zZpVGPN3NDqhX2j79Wvxu4G+3l0+Rycit+XGIkPv5OB6VqtpXoVLJ/F++too4mX
 ZcpwZjdSwbvF1cxszCQ==
X-Authority-Analysis: v=2.4 cv=J8enLQnS c=1 sm=1 tr=0 ts=699d7edf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=VKWO6qudhil8k8BZnYMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087


On Mon, 05 Jan 2026 16:56:06 +0900, Koichiro Den wrote:
> Follow common kernel idioms for indices derived from configfs attributes
> and suppress Smatch warnings:
> 
>   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
>   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> 
> Also fix the error message for out-of-range MW indices and %lld format
> for unsigned values.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
      commit: 26cd5ca272a44031c4ff381928aa1b816829d18d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

