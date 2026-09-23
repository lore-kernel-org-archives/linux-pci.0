Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B393BE635
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139108; cv=none; b=KnfzOKvr5f+cbzJzBEGR6pVgAj13F7YZ9uqFKf/M2E+0A/doY271kk1g7lfCLPJlnNo8zlAf5r4eTJQ04VC5lQSoS8j/rccAWEIOWM6EzKXHdQXsGHZRTI02p5VYtCy7g0OdeSrtaaidbOUFqZSIcelY7FI24XX4aV+EiHvL7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139108; c=relaxed/simple;
	bh=gecKvURIaASpwy5OuMmJh6XsWNCm9L91BUQ1Aqi4Qrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDF8AvIUGuq5ZyNX4NzZZA9bPv33Z6hTpGRo5ZbFJHVgcRFYDGijMxNKe3JDEJuXJxAPh+TdclkF2pO0Nm+SOZoXE6KVa96JxYtQPQji2EAxJDkAleIXSlISIjP0LrQiuMia4jetYtymayhFDXkigGuwgePgYv8QyEp/YuduDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nr+fuC4H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEmWJFDc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nr+fuC4H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEmWJFDc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3ifsd783578
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 04:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gecKvURIaASpwy5OuMmJh6XsWNCm9L91BUQ1Aqi4Qrs=; b=nr+fuC4HOiLkIbY7
	sulsLEi2NsBD7Cz9qK2IQ2cXtwzCu8IJJDtMPh4UExleRiYODOCkNplUz7W2FqLf
	QVSIRFC4/PbRXyRsyCqMv7HCkjtrdhuIVJ0Hry/0ekeDR+ZuHC1At8cd3c0UsD5a
	7LD/sU9OmgmiYchchje3AM+c2QTa/mL8H6Hoqyu5Ab+21awnXbkxpq8fqakYXlDe
	Ki7bl7zfcnaMMEaye8XxFq409nGQs4+llk5/4LG+ksz0fP8i1dVlOjGY/K5n5nOo
	j6qIu8cP/u8vuxpnCk3bz8SDkYHBHGsLT6aY9RRLMKj9VoX+K5fhwU/QLP+CBfco
	tRx8Mg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma21pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 04:51:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-143803143c4so1050607c88.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790139106; x=1790743906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gecKvURIaASpwy5OuMmJh6XsWNCm9L91BUQ1Aqi4Qrs=;
        b=VEmWJFDcvTzgebnWV5fIOKLd/rYfaqMd9LnXzh9m5uLcqYaWe4Zwhg87eWC05TrSck
         OQ2Se20P9OdML1Xfx+CoohCogMnMuKBoNA17Hvhz5s6xDPXK6r67zA0FYe45dhndMIeA
         HnoSnPLuWzLxS5YGwNSuDvyyVEa8s+kS1sNDdDd9Sz7BGeG6vEB73i7TsmbNsyNlgQHt
         3QTwn0zJu86F38JFprlDBRZoi/5Hs7Sk1/j4oycjZiDwE5CZIUwdSrmOLBcT0uFungee
         Hdec4HrGsb1zBRJWhrxQjKTtOrBF4aT28TT9D7UcwAgmQRgtQQm39GB1yBDYRJ810t14
         BTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139106; x=1790743906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gecKvURIaASpwy5OuMmJh6XsWNCm9L91BUQ1Aqi4Qrs=;
        b=qFdlAQ5TI7W/Xfxc/NKpbOyDyuCmjWwuGgdm6DzQXz3pH6XuFzt2uT4ltoBvRFITS9
         +tM5EXdLERx0HWwAizsvvms9vSUbDkj+WAgaTZsE7Cn8m4OpYtp7ZWE82Y40Twd8XFT1
         PJrew2Ep8UsctbKFFSex48lSh886FnzVfBiP/XlZbLaHApMHYYMwRFpIX688LQ4e1UuK
         1NXs+xXCdqbSmp7UhEVsRLgL2++QnfRQXR8vHOhlrgYpq1WI6+k6uER7yokDAcZodNQA
         B7CR0Wz8GpIFYhw8mo2JAwf1I2YkKh8w6awxPNOj5dWDC6UK1J4yokW7oX6r7DphyrSp
         ub6A==
X-Forwarded-Encrypted: i=1; AKwUvBwlI1HrIqO88Ln3Pbg5kElznRyiX0AjCUWyoy5EAnRz9GNjovF224HF5YeXSoYKWvfITg88OFRF6QQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l9OYCBtGzr+6KSpmXWC1tr7F6cx7mREp3LNaw7cQcFLk8+eayy
	6CI4mwuxbAsaT4YQyxoOYenm4SHcaRE6wF/b/IKZm6iruzTrkAI3e9/vHmQKiywyA5Sc4+xN5SI
	ORAgn3VKrg6m2xpbEalxb6PmC7YuibLECJDv3JaIe7uGqPDEUCofx9wAgnh5lEng=
X-Gm-Gg: AYBFou0air/0p8rBFHqhypKrIOmEUI7r444jX8rj6n4/DM5r7evZ+Fajn5NLdNBA0lW
	n9WkjHxRAcRrqHczPiwYO0TpEQxtd071Hkd+N2Zu1sJUg1v6GdE4v0XU0Jeuo1rFDF2vZJk6Ndc
	C2Pq+C9kMRWXPWFv9pU968GFtNqQbivr/V2eVw0mtmHSSHGLk7T3F6vrAG8iH1f2Lw9ziSoym9k
	6Xapw29zjGZiBfEpTcygF3cFSkyKJSilY+Fy38S8/3fAM185uE4KNJ/IFreluaid7zQ3PmM2An1
	OiiSNvN//svS86uu/aE73z+FpdMSdJrTJ81Zc+pz1jZbhd9iC3vzGnezpmT8qTWFaZAAPCNh2d2
	Z/c70LyFDubkrKPy5JjykHoOdQ6KCkEhv
X-Received: by 2002:a05:7022:43:b0:144:e0cd:76ad with SMTP id a92af1059eb24-144f916a44cmr2168780c88.36.1790139105807;
        Tue, 22 Sep 2026 21:51:45 -0700 (PDT)
X-Received: by 2002:a05:7022:43:b0:144:e0cd:76ad with SMTP id a92af1059eb24-144f916a44cmr2168735c88.36.1790139105208;
        Tue, 22 Sep 2026 21:51:45 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9895c1asm2785088c88.12.2026.09.22.21.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:51:44 -0700 (PDT)
Message-ID: <cdfcb65e-9a17-4f93-a1f6-d739727ac709@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:21:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
To: Birk Skyum <birk.skyum@pm.me>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "mani@kernel.org" <mani@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me>
 <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com>
 <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w7Rc0-TlltoJWiwRAJo1M1xhewWRwbH0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfX2ApGA8znbLZs
 NBKbdsq5NjJZSGn2Iz5vIPZmJ/o+aQSzmiRy4M1GjogqxJxQthmPaS75UKsCzssZ/YT5Y0uVbFc
 ikC20lCSz1wtJi7cwZBetwtNTq0BSjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfXyLl/ig6WWyLy
 E40WAG8xwnsrmRVLRLeb8QLwbPvGdV4Txc0MipdhBuDto2ZFAx0G6VNnXtgU8IfjvS+EfsWzaB+
 RclNTQz+WJG9uN1uf8qcqwRnkWt/BZ78XgwlfdBCOjHzxPZSWsmMNbiPKjGNKUbzCULuo+JVupq
 KAYb+GJWcXDYjo6V6QrVZCVa/UjQa9uzm1ZXaDH0ukxoYPiSt5z8MRIpWu45ruvQGTibJccn3s0
 r+ahNau4BfS1L1T03tnJk/9/GnFEoCh4hrUK3uqxc+Vmmmy88ym2s1GpNPw0LWbvAFef4++jRza
 caw+ZKwh5B64MSBC/Za2ouPeT/KdOiv/S2YK+O2bt/UpcGk2pPH+QButPxec1FebGTCUQtohOHj
 31beCgETijFilHbSr3OtHUi+b2+/skBM6YZdgDaz6684ej6GmPkVGNjiynf1Z/xSB1yr3kuRc6c
 sCu9oGhQtiSsnygnT2Q==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab35ae2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=2ddeW__lahgUgh2ldHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: w7Rc0-TlltoJWiwRAJo1M1xhewWRwbH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230019



On 9/23/2026 5:40 AM, Birk Skyum wrote:
> Two details were needed on top of the DT. The DBI MSI registers (0x820 to 0x830) had to be programmed after the tunnel BCR reset and the router reset requests, and MSI on the root port itself had to be opted out.
These two should be taken care already in the latest kernel 7.3 [1] & [2]

- Krishna Chaitanya.
[1] pcie-qcom.c - drivers/pci/controller/dwc/pcie-qcom.c - Linux source code
v7.3-rc3 - Bootlin Elixir Cross Referencer
<https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/pci/controller/dwc/pcie-qcom.c#L1809>
[2] pcie-designware-host.c - drivers/pci/controller/dwc/pcie-designware-host.c
- Linux source code v7.3-rc3 - Bootlin Elixir Cross Referencer
<https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/pci/controller/dwc/pcie-designware-host.c#L1181>

