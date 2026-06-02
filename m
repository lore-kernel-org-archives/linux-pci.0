Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3923B5820
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442821; cv=none; b=DTpOsYJGPFOyqBeAQ+xSMhKAaVmzPjZOf7y3bzQPKEMNQhABtrU1TgP8j4qAEz8C90QubxYMhaARKN0W0Tn6MmDyjGbiVGuX4XPC8zVHzVzXpNxJc/zTCw0R7a0JpDb4F0G9V1jPoIBPMKCFULk6hUrDf7YHy/GL/W6ajjFO0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442821; c=relaxed/simple;
	bh=AyfzGk+FPNYvqu5IFJOsKSXjKGap8fO4JFQLWaJdA74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5uzhl9OtqeG0jnqHypM42V6HMKLjQR9dyOHzWUcX/lqDaagbBNwnS0FvpXSo6zEq34xOPF179j0y0dH8TGwqHogeQJdIK3WL0VsNN2cJy6km59Tk+bwX+jtao0HG5KJEoV4+HQb9rlMqvTeACWFzXggCzZdS8838l4R0GX8Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jhdtc7lf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRhIXIil; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jhdtc7lf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRhIXIil"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EVYjC1638282
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 23:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZM3z6XgtOJGq5dRvkwF/rhFZhGqfFrXQUUSCUIYj4o=; b=jhdtc7lfiY4JugZQ
	sUCIm3hmlGI+0cTNSD94SS1/R4o5t+O41mwrUhZY6yvL6rvRGKg9vKHzxpxbnTHC
	LWrOqmiyVtNjVG7qvILSmRMBWX3VZu+Ca4jUVoLP71n26pPvV13zzEDI1Kx4aMu5
	nwxFs+oQ5oEDsHqllzLlPgULNM3o+nhcMXttscyds+cHSh9ml7mpOBznM1WkGPgG
	T0UKrTpsD9Bs5xCcboGmS/zrR4oVcylVTfJfUvemveeUF/wHlFL8LGMBdBFh/0fC
	xgpw8nPvEsw1jbJrTpa06gojPNGnlUl5+5ySES6YW1IxxZCL7IRam4tqaaVwYuKg
	zm516A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu1ckran-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 23:26:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3041ab826ddso19871171eec.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780442816; x=1781047616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZM3z6XgtOJGq5dRvkwF/rhFZhGqfFrXQUUSCUIYj4o=;
        b=ZRhIXIilJnQaz14h7+IBXpPceOy/Ansp4dtw/aBQQEIQw1X8Kgik3Ykfvl5nOpVXa4
         KjGkQdp5viYYO+PVdjiGgOmPSzzIsOlLY4eg5j5ve6mMy9YHo5vJT4iJS8gMMlKWJODJ
         KV6doGNl3ArTFPJWyk1bcC/lFaZwJoKj1z9QHRKlSNFJnew71kZijt9EqO3lLOMYn6FA
         tu7wKDLRiacgszPd/M1YKZnUk8p8dLr2Bt4ihyX95RpT3TYud47rccKkhoXfeV8d0bvP
         Gg1A12TvCzqM4S0wg6I1lOuFar7vSot3vPkRfzyORpPrAvqwJHHq1Kt2Y54k6rMUfcMu
         Cj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780442816; x=1781047616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZM3z6XgtOJGq5dRvkwF/rhFZhGqfFrXQUUSCUIYj4o=;
        b=i6Y0aFOmkMrFACfA6DpqEP3BIj5gWeJu65duZWZgssvJr1yAOIHaUyVn3pQ7TP+mMm
         zgvDLBUOluHcPD9mg15knsgOXxBKgxHb6WzdWp3g0Zn9JMqhkV96o54xA4Sz91Y1sgQ3
         Cu7NBB7moMG7yuwv7yjizfCE1gVsAvCHm5xdEwLKKbjwMEYcYVSDDiqrUCVMktQMEGBF
         54ILaIKzYtNsSP1hepIbkxiEGLisGEkBPek65epNduwDHfp6/J3yR1ky9N0CEqx37Cp5
         /KzWdnP2JlEqGJouu+78AZH3IeZ0uMop+MYkJuKYsektKsIX0K3yuGgvufWw/7/AcW03
         1/vg==
X-Forwarded-Encrypted: i=1; AFNElJ9YzF4uS8TfuEYFWNDpjs41m3JtGAD2XzzoUFv+bA9RUvHCl2uKOgKkNJivo8XAO5jg1wMcz8rMl4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRW8V44owmabzhDef+lvbjn0l0qX/aZ7SRbwKLb6u1yUGjJ02
	wN70r0q2T075N00Bg7PtmVVd30+YGo1GsRtjzV6vUNffZrlD/4wwi4ijP/VipgHsaLaOQYHRLyw
	KiyOg45jmL19ClaJJ2GUgNQrt78lr05oxbzi6NbEIbRwmwYx57Gf3n7qqjb1COTU=
X-Gm-Gg: Acq92OHoIyVIgFQh5RgobCa0dUoFn9dLZgRwQLjeZU/NzROR1T+QnJ2Ls/odDpWOVxw
	X3rxWVHZZD8dTvHhpKC2oOjbDCQ0RTzzcirDccPo/hclKpsLLGqdJTgeL4PojG479vsTAV6V4aW
	ZA+uFfxtc9OleWwLpH0ZFBaRxGyXbEYK2M+AYkEQyuPXFwNS29+ieqSBngEdEK4oGvA+PTeATav
	bbNh4gIece2HfS7nCljAd/NdLkOY5/bqlu2X+Klk7OMc+moedbhKwNGnyh6hjyu68JpV6ACcGZ+
	VtFbUof+jIgas2dNRzppQWzDDWO4HWGA/6FacJv5GaBzxGdfTkrTctjmfa88SUPH5lJgs+400Sl
	sPqn6UE44EtxrDSgWVRL5VTjkydQuLjdTZ2vvyZuxulREWuAe57lmqTFQJr37rrdjIfQ8ivZ0ul
	fnABBYyVI82HoNHg==
X-Received: by 2002:a05:7300:fd08:b0:304:d82f:c2da with SMTP id 5a478bee46e88-3074fabc08amr439432eec.8.1780442815818;
        Tue, 02 Jun 2026 16:26:55 -0700 (PDT)
X-Received: by 2002:a05:7300:fd08:b0:304:d82f:c2da with SMTP id 5a478bee46e88-3074fabc08amr439416eec.8.1780442815293;
        Tue, 02 Jun 2026 16:26:55 -0700 (PDT)
Received: from [10.71.179.79] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm799529eec.27.2026.06.02.16.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 16:26:54 -0700 (PDT)
Message-ID: <76bb3e5b-e4fa-400c-b7fb-98f95c7a068a@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 16:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260530-mutant-gecko-of-anger-ce8803@quoll>
Content-Language: en-US
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
In-Reply-To: <20260530-mutant-gecko-of-anger-ce8803@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tkYg2fw26IpCS3f427nV4YX_EzenkAZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIyOCBTYWx0ZWRfX1ihAxJ/kfSba
 CEkhFLLJ0WIVlA9I0pGpTGrM2hAif0pqgj+snYeXQNW49qD6+coX17avxCThjLN3jvV0ppdGXU9
 baaGVK9XrhuDkPKwQdSr/wdSufHX1BbNYujQRozr/5LPErMqa4oDMZdMUlS3J4wU2yY/S31APM/
 1eWh3X4oQdn3RWyDxEeS3AouxQb+1LuaOjbHanM4HZrNGMIKeuMTy0LaiesgES5z1ie14Vq28KQ
 xHBkCXeukNSzmCx9lr464I6sYh9tP3HfoMqtw6w74g2S8OGaDQ6TLgqGnMKGIUbXRESiP4XM2p8
 869tx5yr2iveYeHNSBusqtqsknqiZXeJQxWMpLWooEnOABExRxXxlK1dZ3hOfG/Sc6dS6EUUZ9I
 5nGd2gVugZMYlhDqhVUXYSoIXONF9T4pAzA6JE5rxkszuldzNQAeLoAE6bJ+nXcTRY6PeSoWh5Y
 E/UgrmICJ6CRBmEzqpQ==
X-Proofpoint-GUID: tkYg2fw26IpCS3f427nV4YX_EzenkAZ1
X-Authority-Analysis: v=2.4 cv=O6IJeh9W c=1 sm=1 tr=0 ts=6a1f66c0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ckjglDvZ9X4DQU9YJlEA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020228



On 5/30/2026 3:06 AM, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2026 at 01:10:07AM +0000, Matthew Leung wrote:
>> This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
>> platform features two PCIe controllers: one capable of Gen3 x2 operation
>> and one capable of Gen4 x1 operation. The first patch adds the device
>> tree bindings documentation for the Hawi PCIe controller, and the second
>> patch adds driver support by enabling the Hawi compatible string in the
>> existing qcom PCIe driver.
>>
>> This series depends on the following series queued on linux-next:
>> - [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
>>   upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
>> - [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
>>   (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)
> 
> It cannot depend there it makes it unmergeable and untestable. I skip
> review in such case, please follow standard documented practices about
> decoupling independent works.

Thanks for the feedback. On checking the dependencies, the changes are
applied in their respective maintainer trees:
- clk: applied to qcom/linux.git for-next, commit d6cd9d5692ba
- icc: applied to djakov/icc.git icc-next, commit 07548b04dc36

Both commits are present in my linux-next base-commit and have checked
dt_binding_check passes cleanly.

I can resend with the dependency references updated accordingly.

> 
> Best regards,
> Krzysztof
> 

