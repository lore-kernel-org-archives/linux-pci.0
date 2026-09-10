Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508583793AC
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025359; cv=none; b=qc9TCYhRRKGl0lX7tbCuLSljNDYNcy1FF/tm26CHI1JLDVJa8V+7G8oLwHmYKpj5BFT+QDAUOqAtRhJn0j051SKnLnrkIXO10TZ7K9vGc+IgoT6fG7Uv0XkR9tTi+Ld2P6gGspiw2iLwAwro79BotN76xvbBeP0wLknpJc0zIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025359; c=relaxed/simple;
	bh=ubn8C0i/LhdZcwBCfJzPdJhodrnW1sUuabb94kkckfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip6nChddeiMqrEq0Ljvo7hkpFWn2IDCdKClLU71yLsMHDbDve+h+G1j/H+G1U4BFhNLYYti4DI3DCOs3oUW8UAEg1tnq5QJjPK4he8kmXTlPQ5sQxa3yp1iWqKui6WlaNo8UEqAgem+/3gNkcRW5jnIPXNwpIvabX6xcLzI5pFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aaj4bOj3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6CPs1P7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aaj4bOj3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6CPs1P7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5HQcL320885
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6YNz9aQncJ1CZpH4BcRbIvGfWFPMmLPfprY8Gmu0G7A=; b=Aaj4bOj320dR5D6v
	wbaN3MPQjYF7rVVSxVaKvfBKpJ8GOJKqqXXmIuHRDtLeWXMDo2ruaBFkxynLt+SV
	WlPxz86h1cN95ZVKExJwIK0lO8gmcgVZWBjrjQXHfo+JnNPXlZrb5w4y06BzN55+
	1GkPASd+1H+uSiJbw8/tlJ4EPBoHGCxoTpPZknCodatO+Q5a2E8EsQJqpO62SzW4
	f/WKKolBeVtani6d48+SFbA1KX/N5YXpFy2FKE8lSCvVwuyXkxaZo9lMtdvioNiH
	THwvmmi5cDQBoM/b2ebZzuFHwZBmN2xjXjB0qPRfO1y6vwntHaV43ZmyJ9Yi/4Qt
	TPhYdA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg2mvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:29:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9392788b3f8so131537085a.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025357; x=1789630157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6YNz9aQncJ1CZpH4BcRbIvGfWFPMmLPfprY8Gmu0G7A=;
        b=Q6CPs1P7ke3lysN1ziBfN9IQGg9mtmtgrnhyM/YeBV1JBxHRR9sSabZ1m5ksCOqSfH
         7EfBlQ2fK3WlCU9zGP7HH+HPnQ8sG2cesLRLiuiSiX5ZRiOmW1cBnqPzOOukd1fNCaxG
         7uuZs4tEP0XWT5KfHW44xXexhWjvuaRGbfOxrYZj7lv2T8vxDOaHY0Oc2X5jcxhaLNoO
         0JeaaSi5a/bHDU+k3HNKXN8ZhCvCZNrsa5PV82DCE08zimhTKAvzrqY5tghFPSV59KDt
         dell2DPwgSuZ+lK0A7MyMDim6ehBxVxQlL+nv+NUJ2FhLuSb3I//cFqcdQxBS5xbEeov
         f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025357; x=1789630157;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6YNz9aQncJ1CZpH4BcRbIvGfWFPMmLPfprY8Gmu0G7A=;
        b=dFzE8+WV8BcWPHJKwk6p64mMGep24pCMne/XcWjdrk6VVv9L4BxnoJ6nmvKIVq7nZ2
         3UVQF5uHMfIeoF4xMot8xhk8kVFJGRdg4+w8BZykfSBGRLD+X1kpJ+2gfpKe2fGWgJwm
         LhN26uCfhtDSi8Qwg6kI2d3p0E9UWu0fWh6L31gQjV11aPNkx3tfUCLQEPp1S51E1zVs
         eVZhxhkmLlwnqo10B+A9R9i+dKxgB75VkQ9izXWzkBMZJDBliLwNr3SclX/GivplkFD+
         IBXcg0/Ts503ABbIqcuVlJKDgmV/F420IvnjPZVwjWieCYH0bLB/eWEFTsvsEYZL6LDN
         mY9A==
X-Forwarded-Encrypted: i=1; AKwUvBz6YL6h7g0xvxnZYV7c8fP+L6VEGXSD2w8VBVmGYSKdz1XFZT5JY+V1fMHEl1Fd9FfYXgbFxPWqwa4=@vger.kernel.org
X-Gm-Message-State: AFuF++nu4w+PiBoWo8qE823CJUo+UEpggdCozvkXO3luZhPc6W+1+NG8
	v4V3K5rfFkc+Bb64s/sV9wTD5K6TzE8gnPUF0KeFPnlugdQuouWgEY7j90JHzDsBPLzqHCaQ2Zg
	JwYJ+pbMLR/cKlhPhr7Gz4X+MekEW0lMbKvArCTv9wzoa7KVVKV/fPEjutupC0fY=
X-Gm-Gg: AYBFou3o1pY3ZBLEYxfFRuJ5Duz7ls4FZ4j+spxo83rTduXNoWaeIJZGJQOMN4QRN2s
	ly5r7tDTuNsMWX/xEwlo3Q9yp78ADjdAmbMCSt7X+vIEAqnOlZmiBYRW44KE+93suKk8SUDub5s
	aM50zoXptxhZqA8b/ePMv+Tt1I+OppTR7TspdK2xzvCV6z9WLd3Rhlzg5OmnhXC91pWtnMLW3OY
	kEQXT102n+g5p8hMqE39FheFYAsJLH+wyds58iV+hx21wGxpWXnTrbPFh0YcnH9orfA0hvEeT++
	ITAP9CxWc+KMUBrMSLVexH/W1xRUr85j1pk1hCZRFPR8W82wRRkE73PQfmYKyFCwMXunk958h/L
	bXZzn1opYqfGeVqhXiHZQ7w==
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id af79cd13be357-93991702d25mr3078275585a.2.1789025356641;
        Thu, 10 Sep 2026 00:29:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id af79cd13be357-93991702d25mr3078268985a.2.1789025355527;
        Thu, 10 Sep 2026 00:29:15 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e9aec296sm586663566b.28.2026.09.10.00.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 00:29:13 -0700 (PDT)
Message-ID: <678b6d96-6a61-4689-afc0-363b7a6f209c@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 09:29:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        shengchao.guo@oss.qualcomm.com
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
 <smgyk5ray7laj2ltwnmx3r7cfiouj4hyn7tyfmx7rpsrhu7kin@p5pr7wdoprjn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <smgyk5ray7laj2ltwnmx3r7cfiouj4hyn7tyfmx7rpsrhu7kin@p5pr7wdoprjn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa25c4d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=XiBqvqFe6rftMWUyhawA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX3FgXsp88V0c/
 5u3CLcatpJuUFZ1ehJjCsZ/pb7uSDH8Hy3lFQd4eaQ6XI1tMn/lQ5ulEBner1Ojgc5d4Z2N3isL
 g7UppfPeTrbwZZpEF7cd2bvE3+fWrcM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX2gWSCh9aswSB
 Hx1BrVypv/WHFsD6XNayDMvWjGTcnP4xCY+LQzSbyvsznVTO/PVyh3bISSMZiuynJm3t4YrqkD2
 Qd1dneIbwk0p5aYVclT4ZNnwPkBUV+HhD14aHlFCCrFFGSkrsAE0mZZHY8WEbKyy9wxk0A8+nY1
 t9JvYkwLwqDuMhG2D0PRMON49hQot5QDSYABhcTvENeExQn8CxJSAFxi/+QQfc6+HSQPm5ckeTC
 VzM0ep4im9c6tqPbhU/lL9l1BZPpjActGsjkMeNFPKCnedug0bO67iOMODxUTvzpLnCFZ+vFCbD
 zszpJVRewA9xj2CENFhHOPmYKW2ecKrJrE8/iU6BNsZnne6+4mvdiYC/2BeHEsrMb/isHPv4ZlL
 Z86wkqApBQslNtxV7wmsxyOdmmRp7PvCR5Z4jdpG9rgbYYVYd3eNPi04BzTXe8w6xVsdoekMghv
 4r7En59nbaKP58FH0Vg==
X-Proofpoint-GUID: hzA_gRF6fULfchRpA-pWPgd232EoHNP7
X-Proofpoint-ORIG-GUID: hzA_gRF6fULfchRpA-pWPgd232EoHNP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080

On 9/10/26 9:20 AM, Manivannan Sadhasivam wrote:
> On Wed, Sep 09, 2026 at 05:18:18PM +0530, Krishna Chaitanya Chundru wrote:
>> Nord requires a workaround to address a timing convergence issue in the
>> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
>> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.

[...]

>> +static const struct qcom_pcie_cfg cfg_nord = {
> 
> Can you use DWC IP version instead of SoC name?

I'd say it's fine given other implementations of the same DWC IP may not
have this clock gating quirk

Konrad
