Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5E39AD5E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042700; cv=none; b=UGVdL+k7QCRj2b/GUvnGop7HmR0uJ+ZTrS+HVhGcFFSxF0PNfOmLckU8RZnR6bpbcBF0ESdhymr3N/A8L4FhFVlP/0f4XkPn9y7rIs3MZcJpRnItWNaK9bVW4ZUUOmM1PKxAkn+AEYQZiG5cObRZClSavNSEkk5iv5oJ/ifIHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042700; c=relaxed/simple;
	bh=djlkaL8yNHbm1bKws8z7fdDy4teOlPAFCmBAJqwMgG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0Y6+Atx2/XMEiP3Ny0qFS6nYDCMoj+wXVNOX4t243FJQ9ekR17F+5oqL7G02l4Hn7cVi59ydUTG0yIuPF88IDRXH91uUjfEWpqNXBrTVUlh6xkoMiTUjjJfxW+oK4HxzKSbcLLvOr10ahtJiZqMVN7TN/HeUWQePJFJD6oYZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwQTIkR2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCLpdpfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwQTIkR2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCLpdpfa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676II1cf3046125
	for <linux-pci@vger.kernel.org>; Thu, 6 Aug 2026 18:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=; b=iwQTIkR2VXvbdkEk
	3qITKPXvhxLYxnBvZUpGVmVkqymLj8GgS+W82BfcXF1sJdYia75dV/nGb71H9Ood
	C4CtWaktWb828zuvZFkA70eK+/ebS99R+sUoKcCwJQOMiNBNfzbVAHHSk7ywffXi
	jqJEa3dF1yB4L3Ast8D9BrjU6JnMBsTwQbDfc44SWjknfh8Ri7Pvtilb27XCo2nK
	Kng2358V0WBrb9QhsA3bkJSnfqlRHJuI9pG94MuIbd0w9W5uaTUsiJ8Xll+NP1D0
	gfBOmHR9AoSKorEySnWakXQpNLeanSYEetf8MEUBTx5Wk+PT4GGaE9tzA/5w1zPP
	NGgYig==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gr91r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 18:58:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso4273385a12.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786042695; x=1786647495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=;
        b=UCLpdpfa0qhA1Iu85a8obO5xLsyVa7muKrazscYPeZnJ15rTqo6mxo01sEdw1KOheQ
         +nCznNcLELVSL/6Js1absNcNt1NLbCj9FdqOYSr5fD0k7s0DRPBWwydzCctJXoK5lvjM
         mX/3BH2gGg7p8SsX5+ZUzVr58KXAAkIOapl4GPhPqWx0OBBu1GHBcd/aVzIGLoZzLRTC
         4DB97IRxR/mZ9o1HG1rb5hMYs6D8YC0N6cF3SRge922GftgdKTlLkicCJdKusYqYjaZn
         qdUpuCZW8n9Zfx2SfxFg0zLlmw/ctnurb99X6taoItbuk9Oc71/4o9vTjrE8IwgCyE1h
         +olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042695; x=1786647495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=;
        b=nq4KVWKfkJxOKPQJbixKSiRPTWNfiKJ8JWxkeJuGvkMDSPrtSJJwvDYZ+S88+aOOgD
         vjy2WZU8jvOJVjud8O62D1hdF4JxqftGFHLIQLFqRsSYPJ55xNt0+Qi1FTkTpjKaEw5g
         r/krH+KjFEzNNTa+X4+AEGqY1xhBtfqBomLFmJJdFPhJ6F6gVY7r6dLZAxCaHIBQ2NVA
         3xYZTyMGBlGVWOfQQ2UqOSquW77cKuL9N2RcrEGr1VU40P0XIOC7DTy3pndKDMxV6RKs
         zEY77QBkh6fZLw3KuJ6RjvKBSopM5W670JhWxFu/ISHsBzdzbN1W7eWkzGIY3jIYXNyW
         cN5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoiuNYf6w//vv9crqFxUeMI79qQGv7DJsK4Tsnv+5ywCBzH/csqtk2HzJpzQ8lMC+vv/jZzlvZ0Eco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+ll98uy8Gt/Xph518+3naS/73AzNuQzdIBEw0PjFjmX+T21b
	5ru43kbg6kBiVQhlnFu4Ct/EN9tKN66tJ4zPEJ7EiaThilbvcZ33IdLpE3nSGmAGLR28zuSM+4s
	uvKIaAynQJns1W1XcCqTv6SSFAm3fpRdHOxR+69VuBMzlEMnd7+YIdWxMAYb6PK4=
X-Gm-Gg: AR+sD13oLw+lv+cEyEiENXFU0WG4IO7Nq9lROf6HtpwbMEKeNNpaxYleHz/IxMEs78r
	k6UHK1tWGwtf7a9BAmEQcJZnc/i+sV9tEJ7q9i5xbUzg3O/ndSAIDKyRcSKTa22+G9X59mRrKAk
	1YnFilp7wgHOfRap2jFbeH7g37sJjBk8DU0qnhoLhv2lIPU6azNC1eJecsazhTLYB3cLd+hqyBV
	yWrcQWelqzZTXIaCoLl8hC0dHIFZilyiJL0JjnDUIPopn0t8xpcYQmjhzFPUSzVEZKlKyq1aCvl
	MIU4K6RN+RYDyNTWel3sA5UUg9RpZReqYE7oTE4n8F+WllEkr6WpNaWDbj8rIM7TIxHsIxuJRjo
	8AUKPWG3odkuGHqdXoNFtCMb/I+NUZwMdGA==
X-Received: by 2002:a05:6a21:6005:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cb85dcc94fmr22487509637.9.1786042694659;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:6005:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cb85dcc94fmr22487465637.9.1786042694212;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14100a3bd95sm460596c88.10.2026.08.06.11.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:58:13 -0700 (PDT)
Message-ID: <4d82ed04-81af-451e-982b-48fe001d0863@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:28:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/14] i3c: master: Support IBI-based wakeup capability
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-9-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a74d948 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=w8-nw_vHdxPODZekXkgA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: Z4hCs3usOARVgIz6A31QqvL3_G6rqQB2
X-Proofpoint-GUID: Z4hCs3usOARVgIz6A31QqvL3_G6rqQB2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfXxeQ0KYyb3toq
 pPPLF2KyssBDmixUYGDb8MulVkH7IaLSfsuGeia/Fp410E4qkl1XA7BZubAe3BXnmMa7un/e3yg
 2bdcneRpDmQj/aLpO5uIsvvDe/liaGA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfXxRNoQAprggr+
 6bR6VinUV1pHKHMhdV6eazA/19jDKSc31SWt9/ETTp6D2Qa+8ESZDBpW4zTwRO4+d0OvCK2FV0C
 E3VOHsH/fDuXtYbrlzESoE+Ob2JXnrjtGNIZWPYLEcN2xP3cPQYouN76GfER+4pA85i4V75+N4l
 u4Jgojo47BpspNegxR8zCu0GKntynffRgSM5rMUaFUKsrvX3fhGgGJAqsV8S76AcpqHiPCgG7BU
 0SVHVZDWG3iCMS1poyzGcR0PqcE8p5k11fGZfqY+47ixjwwUlGh4gubEciEYJqMBj7jfkiPZi2T
 5+SzBBBe0TNTiSa4hxQQ/RejV4fQPt+lPx1+vq+Phcs7Nh1gzcspgwe/VXGH+6Uz9uCJOA26ivb
 ZLMCzSaAqLOdkBCmEMRL2twAwvZvmYIKikQG4i8clCCmcxvSOycYLn76w0lhgxXQTYm+SxPsB31
 IyAv9zwIpPfeNh6GXqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060148



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> An I3C controller acts as a bus controller for one or more I3C devices.
> If the controller can wake the system in response to an In-Band
> Interrupt (IBI), then any device on that bus that is capable of
> generating IBIs can potentially be used as a wakeup source.
> 
> Add an ibi_wakeup flag to struct i3c_master_controller so controller
> drivers can advertise support for IBI-based wakeup.
> 
> If set, mark IBI-capable I3C devices as wakeup capable when they are
> registered, allowing wakeup management through the standard device
> wakeup framework.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
