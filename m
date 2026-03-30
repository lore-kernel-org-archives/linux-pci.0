Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C03B38B8
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869690; cv=none; b=mRgdO8sDf8gEbj3W1gwJ/1ZPjnmcdbVdWiCXPsiLo5yU744oAaqAzzwe1KUQ5gMUJ96iTOR0tUcpKVXArG3uz5nWzp8bLHaLtOaF+L2s+OjspWdsJp9WrdgH7ChY9UMUrjXNxM6ItouX1LP0gMvMFZc1MqyTj7iF/6BLZr5It8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869690; c=relaxed/simple;
	bh=Bg9krAw7ueDQsORyfQo9j1l4u0mDgQNLOjwkDMzxrnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbm2qYH2ySBJBTmsKE11euxHLe9rMqzdVQUsdhzvuBf4OT+WYcPSMD4WlwEy1dd4qmVUL9HKuR+ICh/QpG301DW6OavYNYtR81YRH9Ho816JHJ7Vfo1dI2rayyKx2Q9k1zzq0z+5clnxT5RYCTOUqcU1U+GSK6OXi4P7ypo2SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmCBxfD7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jfrHrMkD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmCBxfD7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfrHrMkD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U9nB1c3721921
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 11:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Ic1nLhA2BVLZfE93GgGLyyBeF9wvtvwcAK8zVyhSjI=; b=YmCBxfD7q9t9r63g
	ibklCkOWxq+X99CAEkisCUvvmaMndfimumjsGGt56ykUo3Idd+NNX4CoZrCn3msV
	Ermoq1ZyYt6DLxBHSqD5EW+9Mo7kdYyFdW1KKhoVGqnwD2LquUGdgrks9twJQQWz
	sFuUmO/tkXoUZpHKlxV9lJKQAf4Zx3nfIKKlTb/mYknDImbRj0PnSoykkvYlAFxT
	3Wt1Xzgwf9GBQi36HV0pMnBeNU8gQQsQo3g0YpZIWbtMm2fzOOPWAqUr79Yh/jnR
	ryGt9jd/98dd/irm2L2YC/pgE6M/1JzwE0L9oTlgSEoHMab/XVezQAODw9ftX2zX
	ql1KFA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmraey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 11:21:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-895375da74bso15415976d6.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774869685; x=1775474485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ic1nLhA2BVLZfE93GgGLyyBeF9wvtvwcAK8zVyhSjI=;
        b=jfrHrMkDwwECD0sqms1v+SxPwy9v8WiB4aIypHfhTG6/+goQmSRikK9Plrd1nkpJZ3
         LloYGYCuGvtunXjvhwHgdnii0/YrXQI20B1B0sDsUM3r6PnPokGArDcAUwWLuvdajgLi
         2z+n6+Rhgr6Mim0jT3QJD8QeC2Zbhjd4HLp5FUbJY0dV3zIoJUzijA78Xa6nkgUTutVD
         mjH9TV4XcggvS1KnBmDO4JFdLwdVO8N0EP2w+bspPbblcMluIXy4LBRjSE4VYoWBlJmx
         QGZlQ0yPErGEk73y9jL5f0l0Vj586VJXVi3XMHVxA/EiTM1WrF4sFAZhsfTFA6xhQ1xM
         mbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869685; x=1775474485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ic1nLhA2BVLZfE93GgGLyyBeF9wvtvwcAK8zVyhSjI=;
        b=LrGGe9Qg91oKPaemi/Komz5yPfjkdSj0JbU7e24z6LH+pXkWLO3UqefMpcdE48VruL
         EYIksZ/675oahqeCeQ4Evy2FzghzH3Yhq+T9XuxNenAmZ3Hs4/c4fdtHEQXmggTlv20r
         aJcOIqUQZ6eTQEUnHxobgtmMp7kzTDSASwb+3fSd1OIM0A2JY6QSXdfN3w5zQIikM147
         rkw1awuG6ritQdoP44wgusbvHO8w2GN5HUIOyiY4ZmcGMgCHHi+5lPLmXV4n9+OWoHWg
         ffwKQL80sokFIdh+UiOfiuDINs0KkkvkKJCsBgA+TefwT10bpm0TbNsIspoHVOH9jqWn
         fl8w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ48Io2lJMwV0Wa41CVb4N4CEzJJBxJD5T41j6LuPMGVtyH9b332VcS9qinLsaOj0mlS9zPRKuh48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSs3MRgY94Hvt7sgl03du0/VMLcfEArgHMG4et/FAX5fZ2O5Mm
	PVrA4faWtR2QYLWHxzMrAUDSQWSkktjGbOVrSVZBuwZtfhSJnhAX8I1Q0OOzpKtG6yCvyYJI8xG
	n5poSt6T/KEp1apOFhEGSlgFeXQWN/J4pPhK+ICSAmfVcGENWJqxN0q21thST0Bg=
X-Gm-Gg: ATEYQzyPtRrO6u/cNIBEALvmXvFd+WqHfNeM+DEaDQkCLFHT96lVCJGK/z2chllSkvQ
	F/IoFlOtSTHw5yL+ROVsR36b+y47wz67RiefBExq2Ek7+7AxB/78258mQmYCxN9GgmrGajdXb32
	D3VCZQoCkakJmRAeDQM+VI+lhEK2ElVO48G0Pc9A3Bbz9EV/5w6F6z2H5AY126eRe2wPy5ITY4x
	YEs6JgnOTWuXXLNohkks6n6Y07FMn5NIWtHVzjNkfK7k3pxAHEHyDXAVng9szlJtldvn777GZD0
	ggcVgt1yDyt0Jf8Qnzn/uS36MiFSGTlCStaD8BSdrzvC4bKu7EuEOHklxncY/tXNviVgC7MAP9k
	BE/f7MOApSST7y+IpaSAZyOqmAhT7fSXUuAoyAcKPPWZSBt4s7vb4QiHqXfSxTzfuOwOO60tzXb
	GVEHM=
X-Received: by 2002:a05:6214:1bcd:b0:89a:575e:ec01 with SMTP id 6a1803df08f44-89ce8ceca2amr129623406d6.1.1774869684860;
        Mon, 30 Mar 2026 04:21:24 -0700 (PDT)
X-Received: by 2002:a05:6214:1bcd:b0:89a:575e:ec01 with SMTP id 6a1803df08f44-89ce8ceca2amr129623056d6.1.1774869684399;
        Mon, 30 Mar 2026 04:21:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fb3sm282004366b.31.2026.03.30.04.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 04:21:23 -0700 (PDT)
Message-ID: <df073955-476c-4abf-a0cc-b5842089371a@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 13:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: hamoa: Fix incomplete Root Port
 property migration
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20260330020934.3501247-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260330020934.3501247-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ArvODb130-2mGKiTWOywdXQWoH9ubp40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX1dNdkwcdnE2J
 H455ZBkiE4+/mpeHsRwT+7KMRiwPy6nNVCU0Pe1+RNlyA7f7ruSJyVLPbNZrpPSVRZBruB/A1wE
 iZVk/t942SJl/dDe/ZnLytLUvRLnF85I7NOItaHa3/I0TKchNsicgsKuS2+7Y6z9rO8jLqvjdvD
 3i4rus512x8f8atKhfaGml65wUY8b7SA4PuY72toXRwaapmLBTiqY6Akxz0MI5lwSR42+1RMVlh
 mjH7gWICFlY+JDYGHs04w7w7He0T3TNUvKglmbKGhOGdveyr+2BvF47rmNiIE/OqDxMvH9P2WIG
 zqHqJyiGUf2FG3KLgk9lR9Ai+pP0nDS0xpu9QJHt02yEaBWl1YtZUqgARAtifjwKl60FgxJB+fC
 9luASoFitRW42K6UrZm8wg9Ce4J6MLDod4T1G3whyd97nCFLGfSzp4cutAqEpwQBlQ03HGUSWNP
 nUQEttI6zvRqX7HtzPw==
X-Proofpoint-ORIG-GUID: ArvODb130-2mGKiTWOywdXQWoH9ubp40
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69ca5cb5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tO3S9EIgoizo5XbbBjkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300089

On 3/30/26 4:09 AM, Ziyue Zhang wrote:
> Historically, the Qualcomm PCIe controller node (Host bridge) described
> all Root Port properties, such as PHY, PERST#, and WAKE#. But to provide
> a more accurate hardware description and to support future multi-Root Port
> controllers, these properties were moved to the Root Port node in the
> devicetree bindings.

[...]


> --- a/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
> @@ -1033,9 +1033,6 @@ &mdss_dp3_phy {
>  };
>  
>  &pcie4 {
> -	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> -	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> -
>  	pinctrl-0 = <&pcie4_default>;
>  	pinctrl-names = "default";
>  
> @@ -1050,6 +1047,8 @@ &pcie4_phy {
>  };
>  
>  &pcie4_port0 {
> +	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
>  	wifi@0 {
>  		compatible = "pci17cb,1107";

nit: This single hunk misses a \n before the subnode, but maybe Bjorn
could fix that up while applying?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
