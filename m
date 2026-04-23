Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D02F0C74
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951957; cv=none; b=JENT8N0LPDViWq4NYh/ID4sn8Kwv9J9P3mg+pmRvq4Fg6+3U4P2KAOQa1IC0ob/swQmx2VoMcetVtoZGOqdIsYymr6+bLAbW2RR6CMK7wbPu+hgctfNSil4ZwUJk+ENjSKypMS+1BS88YFJgm3wEHVsMlxYxV5Nzj+Q5fjF5DFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951957; c=relaxed/simple;
	bh=t8OdP5Wa+Cr183kt5xldZxgitUy8mPnBLL1Bn+JTfTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH9n8U/qDv/9TTPrzdkF26aDikVFTCEOAsXb8OhwYwH8b+ZysBuuTulquI4TKZ/UiVcmcP+bDbNpikYCZNIw3DlKYZ4AlRGR9HS6Ooe4jlkvOA0jbVhr7DxX1cfmCR0aESYyWz2hmaTjnK6zRThPaB8OdItDfi4HH85tOZxP91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXMWzFJp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EOUZa5op; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXMWzFJp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOUZa5op"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8tqBv028801
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 13:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UR95r8BAMJZnQFiE6CybGBBNNYv6tUewEHhmeWr7AG8=; b=UXMWzFJpGZujc3Mc
	pM9xI33WArrVgXPdAtSVbwU4buGK0LPIP+9M2N3iBAqWVV2efs/CTgH9VAis85aQ
	073/Gz+L5Ctw+yA1LDRJ+j9hUR/byDJa1LsFTlazso4cIUA/5Bg4Pk2k6bqv7Zyc
	NXFb3Qvl069HyMT5wV448nDPelMNh+KFtkwzjttv82EWdjE70LhaD1XTGBEz+0ht
	SLjXdjbsWuJCuGw2e0E0l3naYPF2TuW5uozyT27yJJAw4tB2VRwB1+HJJ7AbLBIs
	hDxc75c4YDvTcQoVM5ziLt6rGGi3u0brFdHFEV7g+2duD9KofBy27yidjHX19X0g
	32OtaQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm1sth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 13:45:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358f058973fso8334885a91.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951954; x=1777556754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UR95r8BAMJZnQFiE6CybGBBNNYv6tUewEHhmeWr7AG8=;
        b=EOUZa5op2Y5FhUwe8BgQavytVKLYjB2p2mzY7SmbW6ONTJuyy9Ohl/TR3A8OwqSG9h
         cT2Gb1e++FkdkclnT4iuAL491t0y42rJTO6m8ve8+kJpIhvM6LVsO/vBzD5H6EtI9m+u
         8Qy8SeUT7V3Dw3ja8V+UDUJEuxFrXjyyxmSEila/EKnGGbnBs1+I4yHx/UnHEpFtBrz7
         L3xtd9xzm6jaKvERVcVNqNCiFNMgFIVU9SE7Twsylm7+Q8HODazTjIArDIgCdCb8ZNbk
         B0Qw0GgArWrpjmP8FYNbjT2acSV1ap24z+xNx1TFgVcQNgAILbVtq+NJhabfNMy/J/5b
         CTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951954; x=1777556754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR95r8BAMJZnQFiE6CybGBBNNYv6tUewEHhmeWr7AG8=;
        b=EHCLAlLCFSDCCGuDkI1zZOW84ub729jKVqu4ziEDQ5L5Qd8atap9/iekQxfUYnKbV6
         TEc2vqHfIzGK5e/oSZ2mlU1QrHqIAMBpb8Xz7MqXX0T83HzUsIxVls+5ech5pl799seS
         natmdDQRHMpY+9UZBLRonLUzk2JtjNgSKRevTiAFASC0BW6SaVxtqom5I24V2bP/xMR3
         HLK1ElvoGQhz40nfHs59eWNwNvjKORjn8aezh0BoSlLATxGlVNuhUwSwGwa0h27xuY7D
         A4Fw34CwMtGvE4r10EUz8QhUZcZ4UpZcHgaQ90CVzqh13LDbyFWPEI8u3A2QMFrf0q0A
         caNg==
X-Forwarded-Encrypted: i=1; AFNElJ+5IwWVK6CG2LeFcOcRZowElv3JBDt8SZu1fDxnxEqqOrt5S2wLJh70ZRMs+sdD8BUW1uSM//0KpdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqhNtVdlt+PRuIvmc6vV/mbqL32473o4Z+t3b/rsD3tqVaBmA
	ODRsZM4p7S3bOCyaN3ZWFPDyX0W3gCPV6HZxsQpP8F8q2RNIPx9Oq7wIJ1LsbCqb/gMFFbRB04M
	IX8Vg4nz/kzrRj5t+By/o2ZZUa657a0muLI5klpQPi4qju60Dvj200q/oQDVsKoE=
X-Gm-Gg: AeBDiesNAyDXUxjHAE55HnU2oSveOiBz/omu9IzEj27evfUK7uHlLuwp5R0iIy8icFE
	mrzZ/BFQiBUBdwVPCbeYEsBhzX2/UipbcpatI77S3CEr5p/901Rq9eLHlMktKgYSoMJlld5exv5
	2B4n9tovd28+wkN53Ljs/tf7oH/MNMvBV9sRNeNO0gVBfVEbFBslT8QK2rnByOtWu5xzMcE81KF
	gRU3KedcnzgHhDQQrRcRo49KOCnkaOAIT7C1v048wgcfD+ASDLAH/sxc3Z8fhVXZHxFqyPCdQr1
	95v/YtH4/RqwzmoMWioV4tYs9LLnc+DQiqUln08GbZzM1SeK+8JG6IMJEaR5XOIJz8vCuAIq5lP
	F60rdUupKZ82jicAJ49ISh9+I+7ZGDxAx1UPbIIwxeYMaIT0823YtqSKlahGYP4HHGddg/IZGX3
	7MJQC3fskmXYXd3gP9DUIbrEo8XBYZRVIs4vxeJz0Oqw==
X-Received: by 2002:a17:903:98d:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2b5f9f64965mr291583295ad.32.1776951953717;
        Thu, 23 Apr 2026 06:45:53 -0700 (PDT)
X-Received: by 2002:a17:903:98d:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2b5f9f64965mr291582845ad.32.1776951953195;
        Thu, 23 Apr 2026 06:45:53 -0700 (PDT)
Received: from [10.79.135.26] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm199155325ad.54.2026.04.23.06.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:45:52 -0700 (PDT)
Message-ID: <02ad9279-7bc5-49ca-86f1-a7c2cf79b91a@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 19:15:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Initialize pp->lock before MSI domain
 registration
To: Shawn Lin <shawn.lin@rock-chips.com>, jingoohan1@gmail.com,
        mani@kernel.org
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        robh@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260414065214.3085209-1-yadu.mg@oss.qualcomm.com>
 <68f9def1-5828-aa30-8887-4b6594595bad@rock-chips.com>
Content-Language: en-US
From: Yadu M G <yadu.mg@oss.qualcomm.com>
In-Reply-To: <68f9def1-5828-aa30-8887-4b6594595bad@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69ea2292 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5gdTzy6pTaml4LQ7KugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: PANc9F7HTkVkzseIEccyyj15FTXcCmp_
X-Proofpoint-ORIG-GUID: PANc9F7HTkVkzseIEccyyj15FTXcCmp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNiBTYWx0ZWRfX2UNCePAIU2hI
 M9J2kF6HJGCEPEn5x+luhx+UhJiHHU7zgWns+Gwof4YgmnEN/zBm4VisDcgSKmo0BR6xJFmsiGv
 umShsbxjNw6LpIKcEb/pm4kLIBRoP4GoMhUuRWNC47wJzRk1ykFxKfo0sHs7O7BWsEYy1kd1SZj
 Fik3+VolSpiP1TBq07TZKfkEb6B008R49gWQjFhN4rRO4aVsCQSj/J582yGlDKmezvCT+A8R0kN
 0Ek0AZUS+PvY83/rb3hlufmJ89MjcR0v0cBLR1Y7vzNmYBCjCRsVsQZO1uIyg1A0oWi4/W6vUDS
 9FrFu9mjCkAP3m6QMI03qglaNkMZJ8xShgXX7YopU02fIGRNG54093Ch6GjPgd4b5x2wjBWNLEv
 JnE0eyaX6F8a8YWTZXroZ0OQCOAwx0+H31aKNjWW0L+pF+8sYV32aVHXuIDxOg5DTBWiwwzMYas
 kUsMyv37rsSRfoJ5K2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230136


On 4/21/2026 6:52 AM, Shawn Lin wrote:
> Moreover, sophgo_pcie_host_init() calls sophgo_pcie_msi_enable() which
> need to acquires pp->lock with a uninitialized lock with your patch now.
> That could possible break all other variant drivers which need this lock
> in the .init() callback.
> 
Agreed — pp->lock must be initialized even when MSI is disabled.

I'll keep the init in dw_pcie_host_init() and add a one-time init in
dw_pcie_allocate_domains() for direct callers, then resend.

Thanks,
Yadu
