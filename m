Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3C301708
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516605; cv=none; b=A7ceUnT1G6DT5vAbA4yDSNsx+snJoRG3R9rRA2tjFQuV7s1a2+49pNW4Hn/nVO8LytGGw8DjwgO5EhMgEz2YWP/rnykl+e+k3IfJTJnPN93YVEaeAT1F9YU13go9RLy2ZFVN186iqUc7M08ay8w/4HTMfbt26r3NqAvpNx3lILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516605; c=relaxed/simple;
	bh=zJva5cAsyjmzVqBVumTX5Zywhnrx7uMtvJBFxDGeIMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS9iM8ZhfTRu6c2I8zz67B06ERJ6UYBBBmGYz+WbUYYO09m1aWGZ3YFxbEZn1mRQ0TLqmjaKJ3L3uy5HfLvbkKOUrYseO+EsuUzYxb0zzhx8bMbN4o3FZYJW58A1TVyAgEy1Js2YTMf9Ki7bye+NJTkTLpDvQVJS7t8yDxQQIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VteuG32F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kj02rgB+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VteuG32F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kj02rgB+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3VtV2727503
	for <linux-pci@vger.kernel.org>; Wed, 8 Jul 2026 13:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=; b=VteuG32FZRLC87er
	yf2b9CrafHqJm1QWxUNNEHbAnav3n71OmWW8m+kxEVDFgkmHT9oPlFEm3BvyHAVX
	sO/0i88dVGTYPWFP/z7MKEDMbrNy3Jjo8n3bfhtxXIGr7DDL7DuENaeMLnR8IaZn
	tPdiTCAYGY9fKEKcORew7h/KBqBMmhP8UboEZ/A6y5qw+oyABiypxIjA1x9vfvHj
	wPV0Sfn0jQBh2nUTOwf/ClmrcYj3Tp5oeVKnnjIQ5IFrD8wEN2VoIXWu2RUiYkIK
	p2cphXlgQuSrQI+DzYVEn79nE2jxp5NFAA6SxS5f03TV5y62EzXTvaRXfr+KcK54
	WRx2wg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6aaqp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 13:16:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8efc8d8e897so2759966d6.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783516595; x=1784121395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=;
        b=Kj02rgB+kYolpgOfwPVbqPxMeNZmWRe8SB87z1ZuFl9qMguDM7U5GVCNcue8SPMwFn
         fBlkjHQSwVJ6nyAU+dYdth9X5QX+5+AUCZeumH7cIJAZ2FZ5y9cB8skOKd9OeTKh9+pV
         fQVcOpeO3bsr+SbLGE0X9jjizTnmbH6P7NqMsKA7rHcbb3JpfeIRIKJj6jLPrpbcNGqQ
         oBWBXodA9uJxSrhP7CH4dPOCK0boD9hSMge7R0VlzgL+p+iKJk2qnHaWXQfJ+Yr/uVgE
         mX6za7qdUQLzBdlDAUCLwN2vwbBW1yzxpwtLy8sW25L3ZOaDCAELitr3TyC40TNeAqVJ
         828w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516595; x=1784121395;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=;
        b=US4TUVKtD7i+wjrmrjk6Z6828hkMBrVIqzQA1cCli67HhJ8y45hAZ2uRcJMLVRRRN8
         r0nj6LghQQUXQfPMPb3aJCZIB8HyJBL6s85nvy1S+wS8vnw1Veosfc0qpmsXbHnuMric
         0SiZVNAsL7u1Mtvj6o+EPXGNYwrL0wnNsNhgGPpEw8q6XAoB5/IlC0Y0fSWW/0Efzw7G
         UtkMxG1dQkg20BvIb0FNSuCSQfk04ynxG8SDQZ61w1mjan7+Pkc9hJxsOy0aS3775Lru
         gTGf3aWvQcapvas2Zq0dhKheFjVsbsRuQjuZOf7+V6fv6ShQBRq2WGMwja1Vb7Z3bd1K
         FWZg==
X-Forwarded-Encrypted: i=1; AHgh+RpNSvojASeCSbbwlrR6UJTyIgc27rcIibFwi9CoCEGtOY/qQJgw/1AcJIHvJwGbJzO5gJo4gixzP9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWLi5PohLVhYe+KyUy/aYZrOegGv+IjOcbH25J3Xa/JYA/cQG
	MpRr62P12RtFwoLh8TRzersmXHBVU7lxZ8Ri9ws4SN5gFSZJzPhxSZoSAptsiWl78rfKsjI8Zo1
	z3Cstgp2retwUsub4yw7ksdQVc/JFgCWwuk6u1YVXmbGyS0BsWSUNYePtToi10Gc=
X-Gm-Gg: AfdE7clqjougRNfAtN9freK5KOUZXFEfqsQBr1FDHR/1Gj/WPHVqF44DRCZATZ/HXDt
	tCj4zBTN4+7O0yOZBtZfyq1qGYSD89Yknu+zyMTEfHYtYfPdSCjv7cVZOLDw0j4a7vwJto/HB1F
	oBGQyri/vLISpBgVRKKAy3MxmJtbjte6RTWLve1pvw8mzfcg/4gnOpKgjY0s85WW4QjXzXG//yM
	MgxfN/qjwfgzWdyQm4GA7lUeNgp3sTNZtboWadLqHtAXYaip+GiQekpRDfohRk2U69du++XfW9x
	FsNXDuPk/tRXlLYSOvCJ2qCqPNK83EXNLpEWYkav4JVRPio0zFcP1ZQuJjZrT4Be9YTYERTY67m
	qk4lAjfETh/7heX/Aezbx4sBNv+yiG8skiLQ=
X-Received: by 2002:a0c:f405:0:b0:8f0:24d9:364b with SMTP id 6a1803df08f44-8fec3bfbae8mr18446856d6.7.1783516595492;
        Wed, 08 Jul 2026 06:16:35 -0700 (PDT)
X-Received: by 2002:a0c:f405:0:b0:8f0:24d9:364b with SMTP id 6a1803df08f44-8fec3bfbae8mr18446606d6.7.1783516595095;
        Wed, 08 Jul 2026 06:16:35 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a3652a02asm7016471a12.11.2026.07.08.06.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:16:34 -0700 (PDT)
Message-ID: <5bfb3aea-4836-488b-aaa9-ad770baa9c95@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyOSBTYWx0ZWRfX7RtA4tWc/ojk
 XUtzL6+khb5HHun5XQsJP9li5jD2k6czPhmBEAHtGAw9Lcv8Uvf0Ev0QCHCKdNzqfSwRG5xRWtG
 LtPU9bNCKGhJP/8Yq5V8UmXSiwZN01mBzrVApZdOVn7hGKjF87m+Qe7MPC4NI2eEmK2Usl61PzM
 NMHH6W01fFF0kWAG7GfhCYnluVQqvuzzBcQ2OpTkV4gJ5oslFY+SYWFbROZz5En7bTGU/hKrcNQ
 r0xHrWF586qmXtzZhGevnkEt42Fl7RWZexz7IpELsp6VIvcHc+AT3rfyXkc0uelh15sBuwvDHLm
 m1pRzzTy/4NDku8koalavk57JcYkLnx+XNRLP4HFSGZa2jONKaG4A2T68/BbiRWdYHoZCvSaM22
 vF3iQfr38qvb/TszFD9SYWh7HI+TyyaChxiNDZIV8U88MmzhtSE0dqLEBCnExKo/t0ULn4AwdGR
 RvlqHtjWrH1PFyOOWHA==
X-Proofpoint-ORIG-GUID: B7IaDcXUoOe50rDJTHTBqT8KCXMwtGgO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyOSBTYWx0ZWRfX9rzUlppWYCH1
 41JrRoQzetAZM2mDO8SA1K4Qp2FDVoRoxzwpZM5vF07J+HAzAhTBwsPek0w8MsHtzpQBOZH+eWm
 S5t8RsbR4vHDKIyfsALFMUkikyd9vHc=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4e4db4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: B7IaDcXUoOe50rDJTHTBqT8KCXMwtGgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080129

On 7/8/26 8:17 AM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
