Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7C383C92
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401765; cv=none; b=mAMbqUUe7CeCpIcOjiECOi2f1LBzJqfTdAll8eHq48wOzQ5VJ3OMU8wrGkOlFViO1mR7HnL5wt0t8AqvVCkeyhWPV2YTA+gLpGq1JgQ/dtPZhqdgLn3T8lOotEFVXWxUtyBv3H1s30BynUQX+s+SBNAGPisZvq+2YmUIgty65f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401765; c=relaxed/simple;
	bh=ApKlw4zdM1kqaFRJB1TkfiMNzc9jbXcEnTAG9K+OdVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSr7141bzTaPd78Xv5c/rL18gsNoeu36KowduLfmLaxdHYP5xpiSwCG5BTwoPeImIyRO0GDIOFJl1hMhmjW+JsC3tzZxfWB4KOx8UHm5fjLVLVb9iPBo4uEMljM6rLVoPXwpFQAtAod4NKXJv8gZpzE2GDgqE7TvBmhX4/EJ4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVak5XrJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eexlgcwb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVak5XrJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eexlgcwb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748rZP2669721
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uz7oXNCfrlOoGMhAm5/uW2kJhx4TLmOTtca8THmwAXs=; b=jVak5XrJF8UTqII2
	2wV4zicP7nMHMmWN8O9uOWpCPLgbM30BMFwSfOef1wXQnOqZXGyACOlQUW34CBqj
	NX21SMPjKCD59TblcAUkFlAYvMiXvOAl7nsyM31fG86Tz37GN/n+XneQ/bjvWQ9m
	XAq6qH+dzIwY04IPJR2Umwqn4bTjKJ6kVe2UHnVrFbNlt3OVt2un8GoGJ7+Or37S
	1hBZ+Jjr4z6ITWHl/N67P5SCy0XDbbZyaiFHw7tztDAqbvlgJC/PwnerAuuTvfSw
	86Q4qwPJt3AnFKyHa49hs0k3wC/BWSwBz+FY06L4rbkPamtD5c7OONivXulLJ0vm
	tj+0og==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgvc1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:22:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso5769096a12.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783401763; x=1784006563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uz7oXNCfrlOoGMhAm5/uW2kJhx4TLmOTtca8THmwAXs=;
        b=eexlgcwbUAm3Szu4zLBKzXdjV7cKSHUJiC9g7nX558kHPLM5Wzo4BPWiMLv6BiUISW
         f5UFM5IhqubwXMqM33w6O61QVn8GY0+F84pdFpQuYqWv4bLBT7LY+y7HzRu6wSYedQan
         lnT5z/pLcV3IwcSV45hwWw3ZLVzVAwehw67AKqfOX0aMuE0/d32prK0LOAgYpDHkis4B
         auevPfXXT6DvItXz70sHH4RBKmk/PiVhM8s9JKyYkl3RD1UhJqVJ2tbtQwThfwuWF18m
         6BE+WwYyvzaZNkGrfuDfl750oCF5NkjHY3RGb+forIWvDZLiYIcCsnj8b31iWTNJmqlv
         nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401763; x=1784006563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz7oXNCfrlOoGMhAm5/uW2kJhx4TLmOTtca8THmwAXs=;
        b=di7NSghrIOeK9hTSSHDO8o72AKPymEd0dvZY81gTPIJvkv1oewJqzYlrym5d/Ase1t
         HuI7uY+BwJNdRd9v9aQ54tLgrmGzobR5D5CvdKP0HX8Xnl6rZ2rr9TLDQjPVrZDXj4VP
         u1PxQBKTLa5DxqsPxDIG0cTFly8I2z0SQsTW54y2+ALYkxXpBoWxHsIItUbkt+CVbwDV
         eWQE5GzQ4R8Urn4LNWZCoIZWMJbAxBiNd+Q6klCybBNO6BpvTjaAQn4vf+7SaL4LxcG6
         E+S0dSg8nQXhQMQxNuTcuFqN8Bvl1RE92mrQ+2qBRUTMjkv+u5C+sdV51Aicr4cdJ5TF
         HsgQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYrm+tc3yoqZLUImeZnQoCE8qSf5CFmrFXhlVlbC6ZS28cObRMwd/qa2T/6bhPOVO4uEJT0pY8NX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKKQvTMZ++4ue3ziech4CQdnC/1Oni+vYMbx8aGXuZT+QuGx8
	lIblfMLBzxgvWWAEDFVkyoiHvJuGX5Q+/nlq1bpDKeBKUL9x+LiBhVH6dCA3YfnhAVRIFzsOBRY
	g3xCJBJgyUws+PO43qwA7KgRSDFf6mYuMi5zSGvoP0FqyRx/5CRN6IBbELsNldNM=
X-Gm-Gg: AfdE7clqLz5pyRJ7yYKMQwKbMO/pedVW9t+rgMHR5nSqd0HQglbp4z4GJgbgtKC9E/0
	nxIKy6Mz2jCj1HiIlzGAx8/Y4wlWob72RkSKKz3r8MwZzarkTAon5adi5HU6GF2yPwyxDdJmaWk
	jXKcg2BI8HPS12iwUdTzsW5uyGI2xBQ95fp2cEW3EsgAtJepHiqmNY3WQpUeAL+/Vv5g6CDQGzc
	dx1WGkACltB1fw8qLtTl2baQg0yk/p8BGoqXDCc7Vu/pIiK8GUB9/zjiConB4owMdoOU1wJS1RY
	ZDkgd1sTk8dD/ngDDGwB5o1WdH8UrhDMDTaIz9V+2EJQVDpENL3E+qQCBhwSgNCbHaEf503vVAk
	S5dkj1E/I/Z9KKer6zXvYyX//Ma3MjuKIP88PzoCue3JxW2KRhOPvoZMK1wzYQBY1mnQXm9AfYK
	Vo+lIa
X-Received: by 2002:a05:6a00:234c:b0:847:8107:1bd7 with SMTP id d2e1a72fcca58-84826decac2mr3441058b3a.53.1783401762573;
        Mon, 06 Jul 2026 22:22:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:234c:b0:847:8107:1bd7 with SMTP id d2e1a72fcca58-84826decac2mr3441022b3a.53.1783401762139;
        Mon, 06 Jul 2026 22:22:42 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a915sm4707164b3a.44.2026.07.06.22.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:22:41 -0700 (PDT)
Message-ID: <27b3c359-d8f6-40f8-8da6-48fa6decbf36@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:52:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: shikra-evk: Add TC9563 PCIe switch
 node for PCIe
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-8-e1a721eb8943@oss.qualcomm.com>
 <2efcd4b6-0a99-4bb2-b428-4cb4805c20d1@oss.qualcomm.com>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <2efcd4b6-0a99-4bb2-b428-4cb4805c20d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2qpoKM7HCFOnD9XhaMKHLpaD7TO59VSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX2a+bEEE7ivpR
 RP0DnS5tc25OikOH6uDjCDn5TRxKladrrlD4kOTDCwruNQwZXRDdRxxbueJdM3QG4iA3FCWCMZu
 UuD+UHKy+HTRt4lYbdfpmUTpAiU61QFrXr4muNTz1mXmcz2XX+E4yeUdkmzqjqBusIH8JTtcxQN
 SLR4G81QuLvHqt8l4vmMl6iWFzc5AtbGPR4JvAqk2UOf7/qPgdH3YXriAE5eH9+2Yf9J5m0WFt6
 J2NrS6NeT3gbZLq15AuioQqSteRRIYimJ8QD6ZMcYwkeHn3wVhpSh6zY0Wid15CV8GDwD1UAnvV
 oAVhV+IJyAUGO+WJLHKQ8zDLWsanHsipwcTdmmqKJtgJxwZ98gkqShTfNgG22cGX2DfyBuqCakU
 kmf1WwB79fR8r7TIo5XnhkElbrZqLI6ffaHWLV117WuUxw0H98+RUSES9ukh3dKj07ZCtYfOOKc
 K2U6tI3ulG8SpiF9mJw==
X-Proofpoint-ORIG-GUID: 2qpoKM7HCFOnD9XhaMKHLpaD7TO59VSV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX78KUIca5hwgo
 GyRMRPiGyambF9RJ9O6OUabauehWnLKLBr9RnRoVz0WTZ4/Pb5AepazL8kQaYpVagLD5YquZtfM
 ZlzaIbtUV16bz0h2koL1VzwafJBF6EA=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c8d23 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=S2spThItiBpve86ZF9EA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070048


On 7/1/2026 4:05 PM, Konrad Dybcio wrote:
> On 6/30/26 9:02 PM, Sushrut Shree Trivedi wrote:
>> Add a node for the TC9563 PCIe switch connected to PCIe. The switch
>> has three downstream ports.Two embedded Ethernet devices are present
>> on one of the downstream ports. All the ports present in the
>> node represent the downstream ports and embedded endpoints.
>>
>> Power to the TC9563 is supplied through two LDO regulators, which
>> are on by default and are added as fixed regulators. TC9563 can be
>> configured through I2C.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
> [...]
>
>> +&pcie {
>> +	wake-gpios = <&tlmm 119 GPIO_ACTIVE_LOW>;
> This property belongs to the port node
>
> Please also mention in the commit message the reason for the
> PERST# pin remaining undescribed
>
> Konrad

ACK'd.

Sushrut

