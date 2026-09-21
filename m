Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE770809
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998748; cv=none; b=jkJQ/xFm9q2qklbW6tWPAUtrtuf/GakyhCHm+hbghqk6dBZOfFl2ChfBgSyMRXJfqbCBfqoRz4pLr0hoqk49p9rH3PY2giq0D/XZqUppJcwC5dqd1vuCL8dWZsk1wtCdTeY8gO7yxJPLjSWEip+9lxHDC6bBfwBNPhwUGdjY/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998748; c=relaxed/simple;
	bh=Ts35l+PEnL8VPft81Hlw49XBk5atQ8XQhif/b4F0qak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAS8iVqvlAnPwF95iPDqEyTXUgv0O/Ef5n2zAowz0AuOmDPYVL64HLul4uLz/Munrf5IdyurTnnfoW5Ut/pdwsbkorLMUJrxVPecIrS86FmXtK+5Ldw9IBaZujQLbqUmXHhSjYpzgvRKEFWiSF5GL1o82TumK7hPxwyeolDCA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB8rkH4k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i0XCCvhy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB8rkH4k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0XCCvhy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LDoihU647397
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dj95l/vO2+U8MWvuE/XE4MlOef8+RJeyIZeU0fanVvQ=; b=nB8rkH4kSG9Wl+rg
	tRHB+jL0+WSVKo3teO/XzFV37lsCqxpGDRFKaouYCy3SiA51xSNH4pyPBxFQgPZm
	SXvBuPBH7xRJxa1j7bdI6FtpI3NTI9jvx/MB6XgqSUxCX6WS9JOmQQmpJ/z2dfaz
	zdQoYAQkGuOeeFrcMhC0S0kNe0kAgfajvs7VycjmWds2mAYdbN4SbcbdcgGXt0OI
	NzgfSO+L/RKOA0oQXZLQyqPCZs64VPC17M4Biv0/ZzEspG0VU3CQZxoWGvt//JBE
	MA3cUSILm2Qny29yWRjH3BuzV5f5syh0MBjGS3+JAnLnpdqbu/ZdP6LoJ8ZyivWv
	YsgZ1w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gs7ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:52:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso3568609a12.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789998745; x=1790603545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dj95l/vO2+U8MWvuE/XE4MlOef8+RJeyIZeU0fanVvQ=;
        b=i0XCCvhybcJ4/z+r0vYqS8whqPnWVviF5OGdawz16W40b3JFpjJU/Zux3mP9IGdPgU
         51mDNYtj+2qILFeTdgfVoCX661QMI34IDkOoWujHY9NcPsuGmMS5o7ZskSUF7hC9j/jp
         YFinLfrZRuLCgwFYpBK0ZyMPXdIsNCQtzMkdR9pmqpp7Fc0tne9rbR2Z6LVWV9KdG2oX
         X7usUxb2jQIfALaM8r7GAm8CwdgyVqrzjI6raWAcVwXtHCkJbfal3CDuZhBuFxBsmA6k
         gPO8IUFmYqW2TC4kOsJRQq35VLbrOe04QkrQX4FPj2/cP/ZeCZMq2uizz6QtXMvLyTss
         G/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998745; x=1790603545;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dj95l/vO2+U8MWvuE/XE4MlOef8+RJeyIZeU0fanVvQ=;
        b=vRoHZUDaCDbSFH56Ddf5C0ZGFEryi6gKQcqZB24oxg4+gol1ypViUe7ukERq4XJR4a
         7ZowaZkr0BxOCKDMIE88XdH3EOqKB+w82ql6pzH10fpQLJ4P0LO3aB7yTnTaRkAm2Bwx
         tYvEQwl/46xkZ6zJ4YPoOieex6+bJtja3oKHvpIpAjIbSKGEbHS/dvz8N37OLmxC/Yuo
         tlrrqOLCyvBHk74lkSwAvjVUrkVa60FfC5+xtfBY0oYuWE/4MN5AW9DIBYGwFnITnbuQ
         iIhPZCKW/MntRs8aaqBCPuta128zA2Sl3TmziNFRfB7oe7uFB9bnjuKII8gGAonZcD3+
         O4Gg==
X-Forwarded-Encrypted: i=1; AKwUvBwZy27hsVMUzRkUlV1HP5FsqOGCyPafvZA6vD9xvf7m7+akIB8we6kxbBpXJ8a475DxWEJ3m43JcGE=@vger.kernel.org
X-Gm-Message-State: AFuF++kHvcUHBeokJ4eclo8SqAJH64KR71JiR5V0HgHnBCeSAE0iTKqb
	qyhSJI0JExky6yN4PajTKq5u9pa/8Id6/Q0/8wFz0hvoqHoUK7y7qjYss6jypB14S9ys4H8Byxu
	vmpl0lgv/yLgMGJzJV8ko1qC018fYB3kwAgLCL974mhM2XC6aad5F3x5VBNMEMxo=
X-Gm-Gg: AYBFou0UX5tAj+MmgCp+IHOJZs20L8Mr3UbYls8cP9Y9kmHCVl7gIGBh3QBTMsAZXud
	a3Q/Vg8gp2Zxhr/qvBfyvOlZ2xqsFH1NF0Dj2J3AY6au+pLdr/+lkoLZIh63NOhsDHbBWRFrVj7
	KacM3UIQ7EwZyvbDL7cGUqSJKOIfIETZwGio3sp4wgMTne8YHH2N8mDzTNaPN8QBvADt5SeWyWw
	ho4bBL+fgUtBNC5TndO1SfspHZ/Qpl6ktIRR9CBhkCbAuoeVkj42EBgpQeBShAIBI6S6NUVeBBZ
	igZ/gSDeQfPQVghU0K64/LjxoU5IDtuEDPhjXws7ShvHtV8Cfg44zvx1NP+WKTT2Mqrr/Hir2zi
	av2iMiJbDOhO1BUux26U4oyMVMDFQ1x+Rsh0=
X-Received: by 2002:a17:90b:2749:b0:3a0:25f0:d89f with SMTP id 98e67ed59e1d1-3a025f0ddefmr6072551a91.54.1789998745488;
        Mon, 21 Sep 2026 06:52:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2749:b0:3a0:25f0:d89f with SMTP id 98e67ed59e1d1-3a025f0ddefmr6072531a91.54.1789998745016;
        Mon, 21 Sep 2026 06:52:25 -0700 (PDT)
Received: from [192.168.29.146] ([49.43.232.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55f299fsm36081162c88.15.2026.09.21.06.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:52:24 -0700 (PDT)
Message-ID: <5c16f588-3ea4-4f37-baca-e5a2807592de@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 19:22:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PCI: qcom: Add PCIe support for Shikra SoC
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
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <e03f3b9e-e98f-4505-99d7-1bcafbc384b1@oss.qualcomm.com>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <e03f3b9e-e98f-4505-99d7-1bcafbc384b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rBDrKGwY3H6BVbJZyZAwY8xx9_mgh0Am
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab1369a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=gjxls31er4aXgMEaaoPcOA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xfGM6EskjLEd39232uAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfX8FhaRCh4dPZY
 BGVg+KkjxyyGV/uUZyJ3hE/FNrXfvATj1YX61PZgtVsJRPjw6ldgowbCIXqsUGQFdQDr9sg6+hb
 Ip/FX1tIqsqhCdhqmTMtI3hm82LalOVW0Mlt1RfbZzKgMFakp5zG6c1+Za1jKM7SpuhFlVNykYq
 BltnwwztlXVDtWK79qxmw0h6IcvkrPI9LWTyHv2Aejmh/uFea9Nipw5igHtkk303u/sIRYSlXyq
 kmrsj4o1WfJp28KajoPaq6S1Vxa9X7X0Y/P4B4xGNMEUB+/aw4EbjXDTsGdng8MZgXYnfN9h77I
 z9rUTQCkC3J5uQNXhV5Xo4k5Fl6GWH0UaPo3S2exv9/ZC7sotbfeFbUXlPk9SSKQN77Ul/n4Vv/
 QNonrbuA3KQ7nyTlPp6X34Akg4aOnCQ8nZycE1axyTC/dZgkhNpUq0xfj72FntuiJTJuj6kQx8i
 yAkN3oMLYcOU9TD9EAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMSBTYWx0ZWRfXw9XvvTPrRtLK
 Q5WH4UDMTEqZufv2Uw0de9pUXSmIJ74qtm1AJJlamYLaJcfWhzGP0cM68w4S9EHrU9/UYUeYYMR
 ooa3vAwEc1FTM6FRzTIXFWMtdaO0rag=
X-Proofpoint-ORIG-GUID: rBDrKGwY3H6BVbJZyZAwY8xx9_mgh0Am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210201


On 9/2/2026 2:16 PM, Konrad Dybcio wrote:
> On 8/31/26 9:26 AM, Sushrut Shree Trivedi wrote:
>> Add PCIe support for Shikra target, by adding dt-bindings for phy,
>> controller and corresponding phy & controller drivers/device-tree
>> changes.
>>
>> Shikra RC is connected to TC9563 PCIe switch on all three
>> EVK variants: CQS, CQM and IQS. The individual downstream ports
>> of TC9563 connect like below:
>>
>> DSP1: M.2 B-Key for 5G Modem
>> DSP2: M.2 M-Key for NVMe
>> DSP3: Embedded ethernet device
>>
>> Power and reset to M.2 B and M.2 M slot are controlled via
>> TC9563 GPIO's. Since TC9563 GPIO driver from Alex is still
>> under active review, current series only contains basic PCIe
>> enablement for the controller / PHY. TC9563 enablement changes
>> would be posted as a separate series once the GPIO driver is
>> ready.
>>
>> [1] https://lore.kernel.org/all/e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf/
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Remove TC9563 specific changes [Mani]
>> - Fix commit descriptions/subjects [Bjorn Helgaas]
>> - Fix PCIe controller dt-binding errors [Krzysztof Kozlowski / Mani]
>> - Document PCIe Gen2 limitation in controller node & commit msg [Konrad Dybcio / Mani]
>> - Add GCC_PCIE_SLEEP_CLK (which is actually PHY AUX CLK) in PCIe PHY
>>    node.
> You also silently adjusted the OPP levels in the DT patch:
My bad;  I did ACK Mani's comment in v1 regarding higher voltage corner 
votes.
Will mention in cover letter next time onwards.
>
> < +                                     required-opps = <&rpmpd_opp_nom>;
> ---
>> +                                     required-opps = <&rpmpd_opp_low_svs>;
>
> is the lower one suitable?
Yes, Gen2 can be supported with low svs corner as per HW team.
>
> Konrad
