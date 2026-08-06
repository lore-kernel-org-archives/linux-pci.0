Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3C4C900E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043256; cv=none; b=Ibcdjxo5evgOYjQb7uzHlc6W3BVy04VKDFHcfnF3KsiaDN1gSPjA3oXkJNORyW0IUn0Q3H6dS8jH23GyCqn033BnOLXaov9oy9q8A2McCH9HgqkhQGftDiYCbngqEsBqALZUKxjYWeHMsXXE5S2KlCqNpEvJGqerrFhuFangffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043256; c=relaxed/simple;
	bh=FgwXUwJLSAzdWsl8255gfuvk1MA6m3QamGFDZhQOHuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTZfD7km8ujUdfX6lPK+1xFQT0yg/H0Lyj7cT8x3+KQRNIUjg2czXq+1MCDXnf6nQoi+rnHG84d/6Ki+r/XE7WPxvt0qH7HACU1JEGdXyZQvXqayHVzfu/kUh0sspvEU2pn0sVjOeif5ctcQZsWv+nV0h2dOTwKe+0FVP0fwD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZO8EtX9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jfRnYfTM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZO8EtX9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfRnYfTM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHibQ3045876
	for <linux-pci@vger.kernel.org>; Thu, 6 Aug 2026 19:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=; b=ZO8EtX9ZPSKmw4Ue
	ogJdGGY6I4QD0zNOPjfdL9QOL3RlfvOOSMXfQu0xqprdpVaZsuvFCok89qPH5FZ3
	tbNQD8Dxz7T/vFe9rWJZ8L8Sv7bX1oooCbgg/yG9TUqSqynI+Tkp6PWnaIvstz7R
	F/b+0EhXTOOGkqvdwSngCmKDj1FHNQ/XpncKAwkM3LejzfY3Bs1YGiJfziQaDVWq
	5Iv8opda3eogSjlSJL0eAYRCAE47unQFaK5MQIkTxBtRyPGBmj6rohHGjuWuUt01
	ZC8FLRFSCOJ0gcdgrvTjkt7MFWBRVAaCjTasfZayeZn993kq2lJCkMljoRTG63XD
	7CZgcA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gracs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 19:07:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe62e01567so2189769a12.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786043247; x=1786648047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=;
        b=jfRnYfTM6Uphp85WzdXn1r7ZYOkiXV/0Wnz0E+B/hdOapuuX/o/UuqSbcoBBz1l6F0
         8I35P+Dqx1sgayW8QO5Q2czzZyE9zjRttQF75J78/8ZCSe+F2/8FPL2FTyscujpFsYr7
         kwQb3rtPjFzE0oD/nkVq457KjbvjTrsbXBXO2Atlcwcr5hcCZgxC8OJfA1xceT4TsIlJ
         6xh7z56SgsUa6bJzvhNBl15lz0kWTDj0V2XWLjX2GFdZ2XRjnTXKgc+Flg6dXFvpFNJF
         QZu0B+KecoXt9o4nCh+ZBpMmhj40LyBSaTltPU42fTQoEjAPuhsaUR6qER4byWeFCTM8
         cPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043247; x=1786648047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX8ZxjTul2K/taj0A4BXwYLfVRhcZVy2nUyT99KFjNc=;
        b=BPoQaVK9q9MfYMYkUl5RspJaWfUA50Xw0MgFF8Lxd1/wVF3kLyXTgiVzgCcVHYnQSY
         xCFUb+usRaFdsOmdDXLpPQ2hN8/QCLaF0SdtQEc5iYlW/yT0qlIEyg/JnXESbBlVHHbZ
         J8ubM271ja35sQn4SYSdE5I5XX7CdmfKGtj/wV6oQSVizSl2ExGAz6ORe9NiB//HajKA
         QgW3ZBZIt9h3EH+LKKGw1M4EiADGtbKqGORlP7Y/68e8MMywbWx4DDYlJlCm+X/x+A98
         gB4Y6BKM1TMGnqY7ber5JMjPwqMr6pM80wl8Oz7lZNa1xiTMcQEvB29voqzkAZviHHbq
         S+pA==
X-Forwarded-Encrypted: i=1; AHgh+Rr785aWBm9EQCD4R05d5595P+vI9pHLjbZjwdS6wgm+GRHXEfCpUpvsKP59YiDGq/t+XRYv1YG7s7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CHNZCpGb3NSCuP9ZoWAbw0OiAma1gcazoM3GM5iA9OA46lJG
	bVfxOv4tLtlZ/HA12PXezmYC0hjguEvI0hz63LCKq4wz2M2t/YYHGHS7Skt4V99c0nSMeCvZrkU
	62I5ZFZwOXTAZP7VCUSxdZjuEDjX0bxSy09A+dB+19Buh2j16DNizpfJ4bjdW1VI=
X-Gm-Gg: AR+sD12HIi0H4RReOYRzKb0LWhZZMqab9kPEl0xLR8hN4By0NDiKjDmyrIVXvpfgPMp
	JDuhjegtO6mH3pXYUGhuzCkMshzi6rEx7Pv8vocn5sD0s12SgDUhKRt1sj5VnX37AaG7MrFe+Xg
	m+sbmzrAGmutvGSBa3my+nxyI+/kP8xv0Wb+Z5uT6RVKOxar7gWliKtbHBYEvYYikPQB1QUGW+z
	OPLuP1kJm2BylUTmCF1ZxXQxRTA6unw5v7Su5n9HFNyDwbdMMKoaaBNBhf5DeflYEJTWRr0zz//
	f2xgK6SJn1TPv93WqM6XdmAnr9UUjKuoedzZI71atJJxQz2pdiEzJOLzUljpuhx34kJ79syjbjg
	MF/Pk0FFCYmmXEUAdFebnzFzLY1N6s8oicQ==
X-Received: by 2002:a05:6a20:7285:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cb85eea69cmr17032510637.18.1786043247193;
        Thu, 06 Aug 2026 12:07:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7285:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cb85eea69cmr17032424637.18.1786043246641;
        Thu, 06 Aug 2026 12:07:26 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1f9fsm7932348eec.17.2026.08.06.12.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:07:26 -0700 (PDT)
Message-ID: <f799295b-b3c9-4ddc-be3a-fabbfbb97b2f@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:37:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a74db72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=pIyxDqSOQZZ-Xg8wykEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: W0p0S5xZejD3Xysm3PXcxkjaqRZSPaah
X-Proofpoint-GUID: W0p0S5xZejD3Xysm3PXcxkjaqRZSPaah
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfXydg7FsLEfgT9
 0hOcO5czvBFtdhrDA0PpeVC7yUr6XAYi5ZveZOdSkPscrem8LicA4e9QxwLo8LSAk6NpftDtm9o
 DmCanO1B6Uv9nxdqR/ZSJ/AxoGYTKn4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX0qxD5Ds/zX5l
 PJyTn0F3l/dkTP5gJr5+w8Y35v6rZnHbkoDVzt61cL3gF4mwGh23VfrRqHMNNrQXMagc4PywSP1
 ONJcLkDVTcgzuEs8xsc+c1KmtvPGNCBK2NEvBDWDT1Rw+fwb2eUuQ4Qauh+dpTLXJ+QnIo+q4eV
 yVQQnu18fVyp2bNdNiZOqFFCyyitTQfo7Igy8ZRa7B4C4xzFlnXYP/LyGz9BOMmORhJww+pCKj4
 8i2hKc2xP0Cj1LaybI0xsT5onL3MwC6kgSthd0x3qyHpygXR+zSnvOKUN73sZrmYlsY5tnUpsKY
 93vhQvgHbNHvDF7CGPMb0+IP8fnzT6tLhjC5lJOIjcmZ9BJU2vidGqhYjkSYD/6jFh7WQlpz6pj
 jmyCLusDkr7nVR2P2bBdNcurNw72KIiiZubU2aKNdVU6+3lJUDG8C03HL/SBRLjzqcsag3dUATq
 KiMZ3Nndm++Njurl43g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060149



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
> 
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
> 
> The explanatory comment moves with the code, reworked as kernel-doc now
> that it documents a function rather than an inline block.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
