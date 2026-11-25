Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602833;
	b=lqRtv4dxP2Sm8nlUCJZyUY9c7jPGTaEw8hP5nI4kkoazYsrlPCc2QXh8BZIgLxsFrjyx
	 Ncgs52Gv2iAc2+0Mi3afZzZCgQcD9OvA8WtHpbE0ROvohdMZg4xCKRmRV9MQuKac/Q3QO
	 yp+/oJDrsNigfm9K+2F6iq9w6nF64NtoUC8iQ3nc+cUbP5LGXqse+jfyPLGSDWNVzKMdb
	 dhCX7QfxjFQjADydKxFqQuPPN3o5KkTG8Wu5Q7nCxj3b55MkgjOREt5JlqAAaWSElKVSH
	 ASh4IHW2BY6S5Lt6hbGX3+sFwlzQaIpgwlGnwSIrdpcl2Cvf0t9qIRge94xYNR0IPvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602833;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
	b=A0CCfZst6mvK78c3jSpybBF1SVD6xZRwkV12BzRPVoROEGObFzxu6zmPBAn4qQ0j9lrJ
	 yEaniXl20mh9+bbB24WFMErXAZteOqPfpUwIT22Z7EDNKz6BKBCqDgYzwDJ+b11OYsEaz
	 ickCUsFm+IkUAiWbMEvtcf9ZOJQhJGbsaF0CDEKMkns/SfTQEdlbEFyX1mQsen+4gbHg9
	 GmOLkxz+7M1fUbfxcBVNBEU2zC3XG+UploN4LNiFjwO39agJQCJMwMXTXIW1gYZdPwzuZ
	 3ZxssMafntm7Xb1pQvs9Uoy2izhz6x/OhArJFHgJ2cNO7m0+7tDhHysHmjYjvaqR8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1jkhZIa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RaKf96Gr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1B606A326
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB1B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1jkhZIa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RaKf96Gr
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mTgM4034201
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=; b=g1jkhZIayrjzYxTj
	uUBCN5a/x+W2VAyWny9Xm7cCzFFqQNiQpJ4CFS6NtKtumxvjuhMrm+y1eiktdRf5
	o2MlhaQAlF813ddB1/efHervQUd/jA9kj+SVq9ZAK5puN9Yp6M/G3pdXzMILDVUC
	MgEPRlyZrMpFP3qV7n0mvkzgAo+NkJFjH+l+ygH18hIGU4kPxS4i13SAwTWBjphk
	KgvWc7W8ofJbN7EboJCKUmJTfrnRrdFZHuRyxK3PNbzvGJOXxjpW+bwt+0yw2bNU
	CvMfNamR9lCjwRYqAp4X46/uVC8JEH28eNIDuwmO5dhRyn6FSRM+AP0mhsq0Q8vY
	IHz4Eg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbja95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55c4997063aso16502451cf.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602831; x=1796207631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
        b=RaKf96GrG6zG88VXlSI/sleEgjHzkgXkHYjLCw/XlKaQJfB0xDKTAiWD97axAeDlgn
         Nsfar/VVWh7/mCzZRp5aFY8u75JBRBX9+uSyDy0bF2VY7WplYRi8kBviGDrKCjgpZmd4
         8RyeK66n6pP7w1Vm7eNDEcGjkcJXeRtWSdrMRIAvAr8yKTwG/7r2uz/CoL0eb5vMYGPl
         ujXLPV02G7VKHdIl5nirZLLPMuaJEirM2rzs6/ScNU7ZibMXaDhtCjLYk4y/Rz+w3exJ
         Jz2JzJPrgaNb/ZhfVnUbfFebKLl7NBKeIMr1qHGc32dShdw5ttQPcG7HwoDkfVe0nwZX
         mdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602831; x=1796207631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
        b=NJQ2Pe0iqiAjR8GvBbgOCKS7NCGuMQNgQodb4ayWxOKcXZI/0dzRqhNbYP4oQrVkS6
         6bo8xgxoRPsWrKIBlLrfVCwKmWMNYqE2vJprhIpwKn5moN6Nd6R9HJSHOEqUM0KNBvl0
         8I+CL7PztcdbvixbyAGoGzdd8bPFCeQvtqyKGPTBC7e8fW5sFKgS0w0itEVLOraxd1Q2
         0LyI10bR3gsRsvKU0TRAwzXdUjXJvXTfJEt2E0kZ1i6wg87aEKOEyE9uxWKhx9iZ+JeO
         xO7hOfxyKBcOd03JOrYLRfUpjYzPMnneQx4cjaGY34xg3VMKnvJCpU7IkxY8SvPL+ULo
         m6iw==
X-Forwarded-Encrypted: i=1; AL+hErF8mTyb6bvujh58yRL1cWZKYJrHDQ5rcuWhbH4DPf1q9DDye52KKsvlAbSXy1ytcojSB7hp6JmC8JM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1ypvSymPPIVV7MfKwHybkr9gv6bAM3kqKVrB/7PuTEzwAv4E2
	NOEmiQYfL4YprsHckHUgJz1G0aljJEvJ+SLshXNR/xAl3S0655rx2mJ5M0xoHIZGmNLo2tyq9an
	e0nQ+qnjdaKoGNsC0TQHVfeV947vxOzvTRjwi/JeqHQmHzYDEjFB5jj8BLeVmTeA=
X-Gm-Gg: AZFdTZfKzIwaoJpDf5sdKxCBYU4og/2+QGGQYiH26M+JkSL3LUbpuzsfmk3BLuNiaXe
	mzyuN64Ktrs/axWlP2p/q2wa6mISs+QsTYlsQsoJ+Chl/wDyGTjXGuxWDSG9iBhLMLUuopI8JL6
	eCvou8BgF/yO1oBghawpM/Cm5QQB7hrShLQRpdRjkN6sRXt1hZjw8rW/f6V+QCd8sdG2PZX2lL6
	X9Zubvo7Vt4kT5V1LR1dDuzNNNG4DMe7UpQgrm0eR/348OG5346TgV/RUghSijrb2+1pQOiNb2B
	YsWyoqJ+oWR5b181SbW/TR+9yLH80qj07WNhtthm1lTzphYPAJrZp0FC4JyUE+gC2ivijObS5xR
	eqHtkMkd2B/tBd2KjXsOvTJiPdXIZnhGZBNF/6OF4t5wg2L9YhdZJ7zjIFxylALu07NLHluE=
X-Received: by 2002:a05:622b:113:20b0:55d:36b1:9291 with SMTP id d75a77b69052e-55d76741cf4mr301145891cf.0.1795602831357;
        Wed, 25 Nov 2026 02:33:51 -0800 (PST)
X-Received: by 2002:a05:622b:113:20b0:55d:36b1:9291 with SMTP id d75a77b69052e-55d76741cf4mr301145681cf.0.1795602830983;
        Wed, 25 Nov 2026 02:33:50 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm7990385a12.18.2026.11.25.02.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:33:50 -0800 (PST)
Message-ID: <25ba0a24-85e8-4aa2-a2a0-23c64729fd70@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:33:46 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: glymur: Describe the PCIe thermal
 inputs
To: manivannan.sadhasivam@oss.qualcomm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
 <20261125-glymur-thermal-fix-v1-4-b93a9feae156@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-glymur-thermal-fix-v1-4-b93a9feae156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX0L9MVPkqVCjr
 nJu8qAiK4TXqIA5eC7tdjbhPdnCWIz7nBNlTCz1aOT9OiIgMWwkIFFli0L9V2iVc5nEBtXeVXAL
 eDLjslXSkEp0Fzg8fIJSssXLvNDv+as=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b06b990 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=TtJGJgRM3qr-9yLlEbAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX4hLF6D7qPRqT
 eplDLpohYsj+QWSpX5YJGLJGDKho82ZiyR3m7dyJY+1Ue8gmUXSs0rO6wBvuBoVwud3ACXGOJeU
 EahllSQQkPcCkZvKn5nFnwkGsE5awuZ70gB8ptuC3HdWKH6o9ok+K7UjAS2t3Zy1uBWnLaC1aOK
 5KtnorpJEIEPf17tmceo/zcFsR26wg/oV4j8UoGl/YwJMgEGJoD9JFWbpvwiSX5TlngEs2AT/Hv
 uRs3A7KMUHd9Vu92HHue0XCuN8V15wtyrCPfthiqQmsuGwxNY1OS7NwzG0IDRbosjHrYqN0hFBD
 qSlNalARqYiPHSIOGpBG6ideEQtFCXluyU6RFF6fi0mQnYr0stRrPhmknYbcUelDChrbWKcVDDH
 V+Q23OKs0EgTFCT2NaT3t+tZFY7jWnvm69n3B4oEIJoZDTfPUYTlbRYZinBsms6UKp56jLcJDXN
 GtYhW3nFfq7212BsGlA==
X-Proofpoint-ORIG-GUID: WPCdV7lvvSvXsMTKAbinW9m_4MUIYll3
X-Proofpoint-GUID: WPCdV7lvvSvXsMTKAbinW9m_4MUIYll3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250041

On 11/25/26 11:17 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Some PCIe PHY instances on Glymur benefit from periodic recalibration to
> compensate for temperature-related drift and maintain stable link
> operation. The controller driver triggers the recalibration with a link
> speed switch once the temperature change on a polled sensor exceeds the
> defined threshold, but for that it needs to know which sensors track the
> PHY temperature and the drift temperature.
> 
> So add a property to identify the relevant temperature sensors,
> 'qcom,pcie-recalibration-thermal-zones', to PCIe domain 5 pointing at the
> aoss-6 zone and to PCIe domain 7 pointing at the nsphmx-0 zone, as those
> are the zones whose sensors track the respective PHY temperature. Both
> zones are allowed a drift temperature of 25 degC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
