Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E333CFF61
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564374; cv=none; b=KRde2MCTBI5o5YRMD7sznGWfMk00HnLXcKOLuPXPUL3AbGaNyrEJdEUaIaWxHJUiIq1bsyyzxAB0S3ndXmGj0hqbZ49n0DtXSE5MaL/ZI2BLR/YfK7pl6twuUzLGKb9gjKgnOEshfeDC8X7jioiq010ZCPOF/vdyyJ9HeJojkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564374; c=relaxed/simple;
	bh=0qmNZ8+q3BJWMc2ioSyoBvo1zE0dng861aBkK2fa4xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLx9gxp/dvFPvLbWUzp4j8z+AOfX/gF03wetyP7bq8YZIJHg8Bny/TqiFf73T18rQ2N2xFkNKOuU3r3vmzyuBaPKjbotzeVuw3izY+42IEiVQeyeMKv3ralnaCr58YcPxEvMlkMgW1tYYeZzsz6A/DOfYcUEKseGjTBl6/N6rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fN2kZVE8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSPZ1tnu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fN2kZVE8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSPZ1tnu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5PNZl2172834
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 05:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2R3YimF/KydOq9roznHyrcrTN3jOxsCUbDTEFZaIuqY=; b=fN2kZVE8r2c00G/+
	sCe8xvNMkULQrJW2iuXQ+nmLP4PtP+AW7rPjv3LLyuVlt55jRwHWa7M+Vs9tIafl
	vfYqzx53oZx7vRFkZ4nPAZT9Ju/99xi1JAtpoKzS7ULbdl0qzIEjn5eutbGuKPZV
	3KLvPflONDbQdkPRWGacl/o4Wl3h/bF3INoDMbPuVF+7E1NNLD4BAiCWF6Xf/3k0
	5pjCkMS60Ds87LApQGKkbdeTh8+fRkZZwIDdqXBYATA+NwIf2/hNdmBpOW8sgHzF
	PNrZB5nEQMvzmU0lGZDowCnZZkn3Qq8KQssyTPfXAYgPg1S/zh/llIfoaw/JLDVz
	LG69cg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj9nu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 05:39:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-368b0dc7731so324137a91.3
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 22:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778564367; x=1779169167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R3YimF/KydOq9roznHyrcrTN3jOxsCUbDTEFZaIuqY=;
        b=dSPZ1tnu0EqKBK1YZbXSx/p5f3oaq56zKNYWMrXgWkj4FLP8ApqmsIWjeHVXi4TXLA
         syrXQp1J0NG4OOxeA94d5jWVlzmNUmvpJ5V9Ss+Sx4bRvYvXoRwyl3xLwt8CN3blKshc
         G/wzotLzKoVB7RAtIPG2PRcuCx8DiJRqZO4VL83uG9QAhE6FWCxpQEzP2jTTyPSXeTuh
         pOzcUfMOJSBM+icDeOJVPdye4kaJ1GztqxSWHiXnRWXpJ2Du7wotPBNXPFxqXIW9jvTB
         q8V3NufhdHg7670kuaVPc9ieIp+rFSRh/3HIRFhrDtTWqtDcza17cCY+w/e2mgAFay/n
         hxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564367; x=1779169167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R3YimF/KydOq9roznHyrcrTN3jOxsCUbDTEFZaIuqY=;
        b=RxSza5RGkB6uQdzUV1oVyug4sBtXwEh6Pmc3VkAwB/Si47q9uu8YFkqBSBw684ETQZ
         IVPPOUl5IVLm+Nl42PALOw1YTYyxfJHTS3AJnvnsVKLcOQv1c80lx9KK4AnK/5G0ggVV
         XjwyWN2o12drQrU5y9plR/+8DmMMhelavm0OGjX/ph88m0h8r8zVbLgqiFvN03DTzBT/
         ibXzl7n/xhhGFW7fjNfT+A0aKtpVfW1d8vOXUByLKqu071Dvvh/qMIdWBVB9WZ2fd5WL
         odCcId4sUvyzMr5fQZTGnHeY7FAwIoctzMmV/imDzYhapk5Cp8Vb/dufeMmPzutdDhQZ
         ajhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j81FgZqdpT7QI/2txWgAw3KPf0WP+/c2FAJTWEUthu9SIC8shhBcOyIsc9UsKOhkpmA94taLU4gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPW7bCGtaILY7k9La/I4rDPgVd+5yN5OB6XDKAaUe+tXipGkaq
	S2zePxFwXCHT8eIyPVVflxbneMlHQ53v/6QK0F/dsskuIZ4aLRcBP2TwWYOOk20QZ3Cd1kAZFya
	HGpsjJkkihTG2Yi4cmcXftrlliWl3woanmmemEKS+HeJtNRrZn8mk13auKyIV6ro=
X-Gm-Gg: Acq92OHWE7n9LSFz682DXjsTatTqCQLax7HBp5j3e/fV4hMaEbOgqv9PNOsEdBnFc+1
	EOBf7IiZd9zwQ4uehiRJEB6OlQ9FqSQ1NaMdAHPRm91fvY4SLtPAP51yVAe1Yrc/1ndCmxX0Hz+
	8/EVKG8HKZcRSnCMVedKwSOTxuY3bQ3S3OFgGmiryoqNTOEs2n2K8E59YTVaN0K3nwKhOD1TCfn
	qi2GTlcEQ4pnTP1rR4N0p2w+mQlC+qoZtBjzcpHPDXZfZD0X4bT27O0mGZ/CfxvfVVXHJij861V
	dhKxACgx08/ehtc7jP0sUYF8Gy7n0TicsxOu7XQ2fTgI5QYDka1TIPHdg7LpPRcx9fw+ghJUUUy
	8hvcF+7wwU0OmiTQahfPR8DYX/vG2RtRYwpQnARe9mTLqJhP2ZfuppcI=
X-Received: by 2002:a17:90b:3c0a:b0:367:e244:4c40 with SMTP id 98e67ed59e1d1-367e24450c9mr12345458a91.26.1778564367206;
        Mon, 11 May 2026 22:39:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0a:b0:367:e244:4c40 with SMTP id 98e67ed59e1d1-367e24450c9mr12345436a91.26.1778564366702;
        Mon, 11 May 2026 22:39:26 -0700 (PDT)
Received: from [10.218.18.194] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ac4cfc83sm732628a91.0.2026.05.11.22.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 22:39:26 -0700 (PDT)
Message-ID: <f8d71952-b814-4865-a1cf-77dd47380e7d@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:09:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: quirks: Advertise D3cold capability for UPD720201
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260430211443.GA440215@bhelgaas>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260430211443.GA440215@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iZu_csokacj32joAHgSAifvFbNnT7sKW
X-Proofpoint-GUID: iZu_csokacj32joAHgSAifvFbNnT7sKW
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02bd10 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=i-3TK1uhxxqyyY9NkTsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1MiBTYWx0ZWRfX63jg0jSskqDL
 uvIuLAnwxZYPxhNQcUhBaLD/Du0xsE0w9NXasNbVyycTrXZwesFgFCBaI2eBDLY06v04OOrGa2Z
 qHJX3i1vZqEHYRzfOAmg/irxrVymHbBrfBZMnVPP5OWCezmqT9JPdBxi4gqlLKQBopx3+QxgYNZ
 1Z5uY5G9DfGfz3teERrxM77XlxQ4p2ka1ZFy9jhA0RBUNz5OGpKhJdaS7QfC1dLQXbEGk1dIj9n
 +WbePZ9LZJP5E/sBXlKt3/yqoIs4/eNleXObpUdqd6Ve0oXeIYCC7cJn3wS3QbWFkTraRe4iO2m
 E9chdRNqOEWe6PpS0JPmSTKjFJnW2GjkTukcoMkgxxMt1dPzHd4DaOq9l+hlkpAWCsQS8fW9TLZ
 EzNEPfIiKOP/MO6rLBST2TrX2c1PPHLA35tNzqeEHuaaiUah3hvTFC06qUsM6tT9foKZE3aSQDn
 tpitTpgFSASvxpkoDew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120052


On 5/1/2026 2:44 AM, Bjorn Helgaas wrote:
> On Thu, Apr 30, 2026 at 10:12:18AM +0530, Sushrut Shree Trivedi wrote:
>> PCIe-to-USB bridge UPD720201 does not advertise D3cold
>> support until firmware is loaded post pci enumeration.
>> This results in upd blocking D3cold entry during system
>> suspend and causing overall failure to enter XO
>> shutdown.
> I think you're saying that the PM Capability in config space changes
> when the firmware is loaded.  That makes me worry about what *other*
> config space changes might happen when the firmware is loaded.
> There's all sorts of stuff we do during enumeration that depends on
> what's in config space.

Yeah, that's a valid concern here but we checked with renesas also and
they have confirmed this is the only delta in PCI config space before/after
firmware loading.

>
>> Hence, add a quirk to advertise D3cold PME capability
>> since the HW actually supports and advertises it post
>> firmware loading.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   drivers/pci/quirks.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index caaed1a01dc0..c32617ed33aa 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6381,3 +6381,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>>   #endif
>> +
>> +/*
>> + * Renesas PCIe-to-USB bridge UPD720201 does not advertise D3cold
>> + * capability by default until firmware is loaded post-enumeration.
> There are several mentions of "Renesas UPD720201/UPD720202 USB 3.0
> xHCI Host Controller" in the tree.  I assume this is the same device?
> If so, I think it'd be worth using similar terminology, i.e., "USB
> xHCI host controller" instead of "PCIe-to-USB bridge"
ACK'd.
>
>> +static void quirk_enable_d3cold(struct pci_dev *dev)
>> +{
>> +	dev->pme_support = dev->pme_support | (1 << PCI_D3cold);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, quirk_enable_d3cold);
> How do we know that FINAL fixups happen after firmware loading?
FINAL fixups would actually happen before firmware-loading because firmware
is loaded as part of xhci host controller driver probe. That shouldn't 
be an issue
because we know post successful firmware loading, D3cold is supported by
the xHCI controller. In the odd scenario that FW loading fails, xHCI 
controller
functionality will be completely broken and it makes sense to put it in 
D3cold.
