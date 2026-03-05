Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2E18D658
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694801; cv=none; b=VcsZJqyA8W+NmA0EsfTeiR1NFFCwsIOjpOuMfdJ2t23fcx22gmdnqGaVlrTB2OXezpEEXqhGOC8FLHEfFX+oskfnupA9WSgRvLpbtVw2rwrvqYLKwqdUAtcYSv++l8jMcZESeVyXwcANIdni3IYaricqwPUxrgJgjerPgzhtV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694801; c=relaxed/simple;
	bh=i5iDqP7rKRhbcffvvgNgjvEmqRBwe+IQAfIH7QhWYSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VvZf42xkut/igGfYrHDdNEmNLw87RehiqWe4DRHhF75rtESTi4MdK8CxXIALhH7x03OLXNQqDLh/+Z3vKcSO16LQNrqMTJ86GHt02yd/BGkBrRLkiKhFd4xVQ9IAPY39wz2kvVFDk5zzFcZRcyO13PDCipLB52vL2chD7YbuSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K247JFQY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hWjlfa6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K247JFQY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hWjlfa6q"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251Bgx8021014
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 07:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1KWALn+owxQlHHUvDt1bNPDTkMcDKMGZRsCDyWIh+bM=; b=K247JFQY25biDkx/
	mgG7iW1GFCqP7RIzSu8aol7bEuC8gaOGvOBpqDBTvsz2kUBTxc11uAw+P+A9+s1D
	TFUV7XbvMaVb53VawUsY+P/Cx3pK5HeX5PaIX4n27A28aaWsknSVfNTeJ9NIaAxp
	Wo3s2d42g4/1KoyGZb+6c63Bgs2R1mxYGypQCbP8EvqwBbly6TN8h6irikDIOPD/
	V5hyOrAhcPqaEvfML7llDSttGV8TRHbuUbleDqB41Lu806kQzdO13xQwSTPcvl5z
	pg6MLGjxSCzOO3Dt6uhkFX0hLrKh0hHknpgN6t4wYZ3fAkAgPRDh1PnaYrv6M3Tm
	eZkWJA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpupthmuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 07:13:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8297d2c1e64so385657b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772694799; x=1773299599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWALn+owxQlHHUvDt1bNPDTkMcDKMGZRsCDyWIh+bM=;
        b=hWjlfa6qnMu0HosXiKBZKcX/aZxxvrDYRwTsaJdBEoEo9p+YRUQwVGHAu5ZZl0+G88
         1Qklio08e8BcBBt4K1I3cLgQALgTuN1fKGMnZOBRhf4a8XqWuA4l7rgxkYXrr+SKWipa
         G8+bFABmckQrP9xSn1gkrfSaHtRwwNohM7cB6qAGxhtjQ5X1dQcBYTWdsJGyGQcGXMf0
         V2WuFK1B34gZWFOlYkxpNSyTCLRn1JB9yBgg9CfC9QOkuHeBSPYhU3ooyIDFLhgOZnX5
         Da2Pdex8qXlvbuZXQVuUVpyQPLf9zxFVet0la2mbApTdJSTZLTG7A26zNJoCw5rAx1yR
         wIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772694799; x=1773299599;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KWALn+owxQlHHUvDt1bNPDTkMcDKMGZRsCDyWIh+bM=;
        b=X0PpyQ3pER5RapdTgzcL/r9ZxtpeBj1SAg+Tp/u6GcFOR2qxmThz56JdK0hkRPci+5
         NXe+x3e5ebPPBB/dH21yOFxFFsweayVY0QvTInIke5fMBACdDp0XNujmoyS8k8/+Wyje
         2c5i7Vw3OZU907hEqo+9NzAwsnaQPJaYtmUKPLSeYhDxndbr+uHUqUb+/MfViQq1OC4q
         XZ8GtuC2gsicPJzjD7+a4JOyP6hvST3zLlBBNlqZnCH3SGc4KTcu01g44qMUVbyUU902
         tVcRXyyz6izqzQz8ahAxNks9/LIjuCgD2Xv8MXz9TXlW8XfGKTmoDxU9q1u/+FRJVgDZ
         x5ig==
X-Forwarded-Encrypted: i=1; AJvYcCV+UCxEYek2QXtKkg/quSd5t78GCUkai5sEV+/Ht1q/k9h6CmFyDlMkEWShfhcQ4Qrb5ueIRKKgpuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJJe/vSuA8S9pkURDpvaMaVdP6D8dep2DvrRwmfIgupV8+kTw
	GzSYhLUOz8xqUPvGl8y6FvT+SAqCkBlIkXELD3DZ/r3xqVv4eNrV9p3nm3sPEtlmqMQMvTrhO8t
	TJnPEBadTbDbTP5eWSX7DeCuJnKTYOxHZcfaR/NUShN4b0ugIKL4kRQJnkXu+Ax4=
X-Gm-Gg: ATEYQzyUWhKhr/TtJzV4C/UifU/RJoRX0BcmAaPBb+vhKV1tvxcQ73KOI5i0ZWV6ZQY
	JGkFFCsigZkY1H0+qbyXVCDCmI9CpNUcpn1Z5q0mWa9tYdlDoknLubtx/hX3HOMv/2DWP751ICI
	GBsOlmZTvaysb/JROuxnEpWoHL8OKMV8B+dmAIGEezRkUmplL9pXHwxnSWsPq+IJgBjJeYUlZUZ
	9oLXyfpKYRQ9AEy0zuLI4omEhY3PWE1st1J4acY4RJYK83HOxMH7LU3ZQxyMZtATQPqe+HZDrBE
	AiSV1w8R2wgtSCNS5zvY8Z7/2l52Gd8hm3ktyIvSWdXYeH6187eGjv5vF2db4hbR8xKDAETvzfz
	Z9l683lEe4CMamuxVzFm+O44=
X-Received: by 2002:a05:6a00:4288:b0:827:3321:7a23 with SMTP id d2e1a72fcca58-82972b63764mr3933233b3a.24.1772694799067;
        Wed, 04 Mar 2026 23:13:19 -0800 (PST)
X-Received: by 2002:a05:6a00:4288:b0:827:3321:7a23 with SMTP id d2e1a72fcca58-82972b63764mr3933216b3a.24.1772694798532;
        Wed, 04 Mar 2026 23:13:18 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm25271446b3a.21.2026.03.04.23.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:13:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kishon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alok.a.tiwarilinux@gmail.com
In-Reply-To: <20260227030701.40533-1-alok.a.tiwari@oracle.com>
References: <20260227030701.40533-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] PCI: endpoint: Propagate error from pci_epf_create()
Message-Id: <177269479555.23838.3081091400517601270.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 12:43:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA1NSBTYWx0ZWRfX9/HfOsxqPDtm
 zXRLdrVuW7MpDStVLkWcKP51XnFJ7sO1ednr473syh5pCmtkJ8MeIvWUFLUxCgcWoSWQZUYy7C2
 ooFUYVmEGtCNCBV+qbR6HXGVFQxJAJtXQ72wKVHxk83f0Urk05QisudXcKLa7Z8MOqER80jeHg9
 +JWe2yMPiUm+5DxzH8YTT4LwMBc31GloYt3QoM5Ye3++PMhiBEBZFf25rmCKBO1RY/jLMF42ZO4
 yCr1C0yU5EYcoL7kSCcPU14YnpSzzeQPDLqNvLPCCFfCsp5VXpX4HP9IOom9cR6tYDAp39IZxHW
 sEpXkkETdhv70Cz1EnT82AMytYPaTLFu8yKXqv3zLOcyxdJ5dCaCeJI1TfqNXzarv269Zogc7+W
 oUVxeVVDwbBqyvb8GDJnKmprx3rYZvzocmfy4HWTQT33cfCyh2NOGImeQjxVeQsPflqJSCm8KI4
 JWwaDzbFWNxWpd4wdng==
X-Proofpoint-ORIG-GUID: naYO_mVlA76ddJ1aw8tIsjuUwKWYfBH0
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a92d0f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=s_YgZJk1io9OGwFR57AA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: naYO_mVlA76ddJ1aw8tIsjuUwKWYfBH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050055


On Thu, 26 Feb 2026 19:06:53 -0800, Alok Tiwari wrote:
> pci_epf_make() overwrites the actual error returned by
> pci_epf_create() with -EINVAL, which hides the real failure
> reason. Use PTR_ERR(epf) instead and print the error code.
> 
> 

Applied, thanks!

[1/1] PCI: endpoint: Propagate error from pci_epf_create()
      commit: 0b74f7d72399d4c4422ed3d68ef28b3612f71e74

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

