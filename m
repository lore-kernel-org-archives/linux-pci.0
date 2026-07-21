Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0C39EF0F
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644196; cv=none; b=A3PCx5XbEP9J1XOcW+HOCTBJ5C3sHoO7xb4ZVJ6JhWB2ic0Jsu+galyKW5i+Jaxw7hf+muh6bnL23uuOFNeNwX5BpOEvuhiUNk/6XZUWb7+qmr1d2Io1Da5llh6pCukj07wypOPoKWt5FF6CK5QAxYyMwmuOzEthOs5xAXe9k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644196; c=relaxed/simple;
	bh=Qo6asdBsJFAV0Lv58WwH8JVlF5O6ZEi9Xu1l25YSNHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcrNR21RUn9Rd0s3VoMEU4xSVp4TwM9rZyUkgJGTtlvXcNIbAdeViRCNEEcxIHaXRUgM6Awc5EoQkiabTZSfhHPwuB557MxUvo1ilDpGxRk9WTlhH9tAOF+iRYvZC73uA7lH+OHLCknBcG1eLej8n8UXDy2KPh0Gg/et1REjo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H35NjfHO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LQkNLYIZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H35NjfHO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQkNLYIZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg7fi1958770
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=; b=H35NjfHOWu48YFiR
	1DrnUwAsRLGTZl9PAJAZawf9ic//r8Yz6n5B9iCcUTvzxmtmdIxWafCMkHAdiBd7
	z8Sonusa3d8MXQP7MDa1zsATYsAA1jc4JygqyshXQkyAQXZ1XvQ5cGFDuMOxZGLa
	AoZx7oOnHxrowfYfkS6ZveOMkFjMlOel29yTPpOqrwC+pUHXTc3JRkk+vTuvrgHb
	JlJwbFvN3LgRiaSRoFhvfGEc/1yUdkbtSN2uDeqz7r92Z9MXqtZf+2dwb+5L9A+D
	mOWutJiPsMUN4gd/sa/psro2OJfbFW1QF2nD5t2Qb10Y8lYT4EoW0BxSo5tYVfYW
	Xto03g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvtwkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:29:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c27616421so31559841cf.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784644193; x=1785248993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=;
        b=LQkNLYIZsjlYITMIU2kgfuRhAvnRRP8d6frU17bia+PmBkJFK/ysVFitcoLnf056i+
         dhMZTtUnMqImHTx4HiLgh7xNMCB3a6ukaSwC5iZvtIU9GJ+Z0ONmF/lq47fCGHVdZtgr
         n68upyanSqc+9V0U041CifJNe1ID6UR+I9Fhk4I7ADRJ2g7xE4FfzpSK+AWzMCeLsPLg
         D+wk2EsNZwPKRYnPG09EVgQk5OjYxUkt0wHKLtHf80k8OabN6eZ+PbtvYdvAdHWTU/ij
         dyxSY7H58E7ONqoOSIFdIJ0AbO2XtkqIXY3aIX9SRBW7Jkk0nY2mjy1z0VjeUJdcZN/C
         Robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644193; x=1785248993;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=;
        b=YWLDteGBFRBxL0YHq/Q0q2NCRNnkpzl0UF5N1XlpZqLgF2XK7BuY6G7HYh05jfsavU
         opbUEe7CVYZk8L2cGx4Eb7IiV6d3L8gG+Zyh7vokQFj+uuyQ3LDyGhhTjIDUWLY8pnxB
         FkEFMEdkcIBHYSvhU/U8i4Xa8F2/HPq3D8BhrqGAMnH1MIWMbPITw2a5/mPPyntqIsP1
         BfJdLQyWsSEMfz44pIldZ7aOCLXHNbIkz/pudu5aUvjZr6ZdaA0qcXabEkk6eiptZS13
         V+g5/gJaxKTdnjrNm8KIHiRZj0ti1mpAwl2uDKHcJcJIP3anDvUQpA1Jgs3Su1sO655p
         766w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ZUAw1LVQEhVMJ3jbLtyIGNcLeWorv3epkQniLcVZG9uG+7MAocQ+JccqAnTmW2AfdRJPXwysKyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnB99a4RQQ2pRC5ssrBbOMQ9eKc57A5F0sNu+5D08vrO7vGb7d
	cY9RJ9s0QDYKqoK/RtcNTLaxHmi+Se3dFxmmyH99wIALkroKEbEvBq9n1h8Q69qlJY21tKiwqJV
	G3I5ryJoyXE7z9d4AqRQ+UEHDcEDdDmhLbnmbYwkEgEjB5FnAafWuifRneurfQNE=
X-Gm-Gg: AfdE7cntcpAGln4PucqM6i6ZSAYBiyeZvCNfy5rA02KY9/L733Nt8ZCMpIjWlgsz+QO
	FoLap7DmPmDC29aocvOFzmxp6dV236ROKygMdUls+/AVMPWmCHYDKn8YCR7X5y8XRdPxfKHzopr
	/8dinSd+33ERpZxUBDCbQE0je68CdNWp2zjXx+9+sEzed4PA5SPkDBeDVqH77yExMQ0+zLmFdJp
	MXn8pK9+L+S2yspOSe/7x+0W/EJfLbxmrJjBRQLR/eWVVfp8u3VPOMgHOt2AxHlUGYqfk6MmTiN
	c/vAGh8nj49SOeqhlbnHohQN8gUQQKposaiz+5B5OoVJWbEXeMVeiqAEJsA4Oj/6Bvx8iYqgDUf
	fswT79McoCB8VeZZMHB/NgpQj
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr27287761cf.7.1784644193101;
        Tue, 21 Jul 2026 07:29:53 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr27287371cf.7.1784644192705;
        Tue, 21 Jul 2026 07:29:52 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705a099e7sm598982766b.20.2026.07.21.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:29:51 -0700 (PDT)
Message-ID: <3507b575-0f66-4542-b86d-431763b237d1@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
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
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0MfYiEdq-bbkYShtvrKw0lQBh3orJrr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX+8DDIxoYaFDZ
 EbyP9EW9tasRpsNzx8BgJQCGsA9Mja3qGsbWbySleGGemnBkUtgi2vrEZFETbfz/BYE71e9CXdc
 nFzte6P0K87PmznQZWiD/jxbSa1P3FU=
X-Proofpoint-GUID: 0MfYiEdq-bbkYShtvrKw0lQBh3orJrr8
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f8261 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX01Ps7jXdxDS7
 rxUy3sKSrW2gcNkRMSmikn28bapMdmRRZEN/HU+9+NYZ0tpnYNgXODs5XAgP34o3HkQ2A/Sym2Z
 68Iz7cC8Idfa2ooGsRH4SEbMvMFWwUx1JPLMY5rLRJ6bhN3Meu8VdNaJTvhu2nf0YnsPxtcWTnb
 hh7IgwlyqrLEOVn5IliQZafxDUsdcU0EV5edsErC7G0UOR2Ty7/9HMo7kUTsleQjGa40H6xPw5o
 ylgrG/95tHK9wOZHutxsEvVfNCGzdMvWs4X7lr3LZFtLW2MHe0FgFAzK/J7LhzLReUQfAYKI0h7
 X/cj/iirop0PuzRCkGxtn1c1Rdrr3E4opXvROMLlZ4N73xsh4UoKaV7opcGuOnDbVtvMoFMlGxi
 DlnYBWXtle0wuIG9P5Fmgc2FeyeKMAX6tOUde1tJLgW50+kxXzgNv7qOUTOXqnvMKKgo/Us0GbR
 WiEm6MeNreq1mlspG+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210153

On 7/21/26 11:32 AM, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
