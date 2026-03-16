Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A552135D7
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663737; cv=none; b=ImLwWnyEYqPzx+uqaveGo7Z1zAoUtiFiUKMvt7Jlkd/fYttOOTCUqDpByuEKgAfcdRYSnNK1Gb/jZwRtUrH1edHDbZZwYecuANYKYE601FfmtYWR5i1hF8EEqLYJQoFTYF/c4pon2zY3osGVXAwzzoWhnn/6PhgCKhxCJNtwDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663737; c=relaxed/simple;
	bh=HiiAm8Ora0mp19tzLyYJgj5FHJ+Q4afMRgLHqhHi8eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/2j/FE9Ynv0PEHzMZu3cW2x2JDJlDCp3vl18hHVlKe88ZgVlkdcU4L2y0nY2VXf2ZvakQug6GMOf5F5ViJ3dqGaiFjIkJIE3hqAyxKVOqUSAbFKiWs0uCGX7n35/KGUz8YTB8tgIZh42MKVgos6SbQvaZ1Zp/03YY5yQiqm/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iw7STTLU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g6EyrDoa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iw7STTLU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g6EyrDoa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBm7ts1282132
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 12:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F5jZW70c1mVu3dGOsuxOxRHHZs/ZTHfG90z3TOkm9iQ=; b=Iw7STTLUwaBIO1/i
	dndqZlJFI3uEki3y98pSISAJTlHe0+wvcxbyYVkvB9C1TTMg3YybBjOLuPyry4s8
	TfWHxVHlgK2orMb9fLKb4PR0/rP4mNqh1stAwusurKowZs8gCtueeGc+T5jQL9LL
	ROGSnDfgiU8ITIuNwk6lIrFI6NTd52+o2jYrvSKF8x60I7VFwGYM5+/te0012UMQ
	xXPE1elaxJQ1xyZWQOhqQfECgxslvtB1qAtGTJQtk4sw8rvwqiSqhEVAzY9RWJob
	P7rf9L9c6hMJDBIFhj/+rhVxYhUduxnkJtF0kVLuybTMryh8VZPkaOkGRZhCIf7L
	bZuWPw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc5hvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 12:22:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso3510504a12.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773663734; x=1774268534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5jZW70c1mVu3dGOsuxOxRHHZs/ZTHfG90z3TOkm9iQ=;
        b=g6EyrDoanfhOIDSxhIL/RltVOyzhVNMNMAgM/5UdipKTLPJiHspK/U30EZDFhDgNz6
         fJmf4RBPoWyKck2GAMDdUeW6A+Zub1U0tUr8HnsQB08+H99Yfjgz/za2eUKrV0K35gsA
         gZR5hwf2zogVm6bAlkn48ctC2n5let08arV1Wy5fXx8FUfgi0cdICurILk+TeZskxX5b
         6VgfkAcZiF74ejNmZLeKZHZR0+AdkBIAsmwbgljtiPsZmWtXbtQIYbvXPC5Zu5FQAFHR
         bc56rDD5a5hlHYsB1O+nHoo8DrQ5ZsZhh5bywjQEGR1KYDMfedkcnomCAIiX3n+nX6nt
         WWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773663734; x=1774268534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5jZW70c1mVu3dGOsuxOxRHHZs/ZTHfG90z3TOkm9iQ=;
        b=cIa3GxvDWksDQRo/C8w8X1QMIn71KkgMUzXt+FS1SA+bPzrp3MJGbZXIl+nL6QyfRA
         5JFhfB4Mi9WnlE8DOfC4cHb6bGndfV/AMKqoZReAcgOao8/EekeulV4EvWnTgWDDRZv+
         O6OEGO5J7a51sTc3R/ShzoBrmQ2hbjIMY8/IFucj7S0aJTI3eu6zMvutByzo1CKDBoph
         FTVrq1nTWKy9Ki8LTYUKrNC0ke7zPqGroYThwVVGjJqm7x1wBa0eAfqe5TDm0K64qgF1
         Uu+Rxi+lrtdjGuWDawB+Qx4PtpDymhbovUqOiWfEWX6ljtcv1NY0PcfNdm5k0fEz8qge
         /1rA==
X-Forwarded-Encrypted: i=1; AJvYcCV0RDJvCz7nnO7u4tuk4djtY/J93lc4kGOCQaPqf0sDTaVRDcpnpWHIGJfuX9R8zCRtaPHcOGAd9oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvLYfqoKE4/pvXrEJZrOS1wWJxEzbLLMiDNjTe8W6qOLOmHA7
	7JPxQuPkenU4DIVIoDxJum3RrgPsvVx7mSiUb2bZPRSkKZIFwVlK6xQMvhVn9eu6Poi5T1p7hk/
	ZT/YTK8DvxA5wo6xExOdQ9VZiTmesVd6lY3Vx3PI16exacn4qoOBmb8j0fOH51/AnkLHxLMo=
X-Gm-Gg: ATEYQzxbwTBpLdSxKNX/5Uszy5T8zrUukjqVp3Oaoqf70k6u0yGN1BsRHxqoaaONtkD
	tQbsp6KdGjKFse40CBwj2DGtqzXOlP8LYF3blveQAvFg6dPxVX3Xy2qSxNkarjcjF91E7jOHWPX
	IZBgFJW4DDD0BbQgiK4HISr5OpeuyB1QBqweowTl9DikAcvhKITUpb8pJBS/S52XNAKRQPieRsI
	et5SvwWXwmFMS72yJfhceUuhWYpaZwfCEC71cjP+rt9SK1xma/S4VAWpxc1j/DdA4B7ZZIrUhA/
	EJanTbLT4zlMWfuVlXPtjjZfAQAGNPxLwySyJt2CIItiYKsWdLRvsFNdw5hZzcc33d3TEPLQUkB
	EVgCyWhQ5oQ05JCzE3jOlrb178FE6AribPu8sDcEDvzhsos/n729Lbw==
X-Received: by 2002:a05:6a21:3981:b0:398:80a5:8bf4 with SMTP id adf61e73a8af0-398ec9eb7eemr11219962637.10.1773663734353;
        Mon, 16 Mar 2026 05:22:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:3981:b0:398:80a5:8bf4 with SMTP id adf61e73a8af0-398ec9eb7eemr11219931637.10.1773663733841;
        Mon, 16 Mar 2026 05:22:13 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb649a8sm8896693a12.18.2026.03.16.05.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 05:22:13 -0700 (PDT)
Message-ID: <015d00db-9ed5-45a7-83f8-1b10bc2ee457@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 17:52:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <t66kmmr22z5anjhhez3mwfbmy64pz5246e4oepvpwf5j5l3u5o@i3gsh22x4dst>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <t66kmmr22z5anjhhez3mwfbmy64pz5246e4oepvpwf5j5l3u5o@i3gsh22x4dst>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b7f5f7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ShDbLQTyCWfcQnIfrFwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: C2id-FRyvjLnNxY1MYPhr3kjlImwHvmj
X-Proofpoint-ORIG-GUID: C2id-FRyvjLnNxY1MYPhr3kjlImwHvmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NCBTYWx0ZWRfX9xgVBUtwWx9b
 a5tw18eiNgWdH6wXpccwhfxrao/m4YZWV76PORa2tT+GGQH5B6xhsO+kw2uRFoEVUh2dQMaefqK
 biIBvq4yFULojsivGSkhUNIIeZEPFcgkotbQYWrvdKJY8eSkhteEpUXkjTFQ7OHq5ejEPmlxeCy
 ab0lLFlJdcExRzgeCAC5NGm4pdcsRfhDQpURRW5PLd/mEmQds7YqmS6dtjHbaH5+d14SsbAHGwA
 Rzwjfo0xUCeuzoEt6Q9fgrB+n7g8ovUqEbtoM/jTIIXukoNmx4ABu9M8EJOxMbIuNI5ysd1JC+g
 MM9PJscBP89JAOdFEWI3gYJNgoKjJhTOkgnRdfjZy+Nn6mHJ7in4z/V6mu8Ojo6bZNViDVXD9OM
 gXmYFppQruj7pjM3mbSPNppfje1hrPldn+DMVr4Bd0O+YQ7jER4cQRgUzMqgDXrXs5cUgviWdhN
 VB99skY1F1vk22BKAyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160094



On 3/15/2026 3:39 PM, Manivannan Sadhasivam wrote:
> On Sat, Mar 14, 2026 at 07:26:34AM +0530, Krishna Chaitanya Chundru wrote:
>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>> support hotplug command completion. As a result, the PCI core registers
>> the pciehp service and issues hotplug commands that never gets completions,
>> leading to repeated timeout warnings and multi-second delays during boot
>> and suspend/resume.
>>
>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>> Capability bit entirely, which also disabled all hotplug functionality.
>>
> Just some background: I added commit a54db86ddc153 to disable hotplug for Qcom
> PCIe Root Ports since we were seeing completion timeouts for hotplug commands
> and also the PRSNT# signal was not exposed on any of our SoCs. After checking
> with some internal folks I learned that hotplug functionality was not exercised
> in Linux. So these facts made me believe that hotplug was not suppored at all.
>
> But it turned out that the Qcom Root Ports support "Data Link Layer State
> Changed Events" such as DL_Up/Down events.
>
>> Instead of disabling hotplug, mark these controllers as not supporting
>> command completion by setting the No Command Completed Support (NCCS) bit
>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>> from waiting for commands completion while still allowing hotplug-related
>> functionality such as Data Link Layer state change events.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>   	dw_pcie_dbi_ro_wr_en(pci);
>>   
>>   	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> -	val &= ~PCI_EXP_SLTCAP_HPC;
>> +	val |= PCI_EXP_SLTCAP_NCCS;
> Are you sure that this is the only non-supported capability? What about
> Attention, Presence, Power Fault, MRL etc...?
Even though there no signals required for attention, presence etc in the 
hardware
there is a way to generate these MSI's with these bits set through parf, 
so technically
so other co-processor in the system can trigger interrupts.

- Krishna Chaitanya.
> - Mani
>

