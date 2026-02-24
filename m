Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A186341
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910479; cv=none; b=hSd+Wnb4MKMG9I56Sw0QymU+lZAMc/b4VXg5aDyUfgRn8IAaGcqCXo6zU2lP9JfERBspwd9nyPYbGYrrY5MdPIiPBzKJP6AVFq/bA+SAbYvObd2zuYvIrWdei7Pof7AOJAR/3Oc3Zzs60CNzKUZeyDaJD56aBxi3Q5scnPgAGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910479; c=relaxed/simple;
	bh=nUZBF02KmJhFyymkXuV4+FAWr0DdIov3/U340uqJ1E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lueie9/73nF6d2wC/aG1agAfXykuxfADwlpMcmZbXrlQEc/Dunj4N5SL5hB3uC/Bat97gsb4iX4QJGdArwFAqpmZvDw1j9BprUroy5D7JA2zp0m9kMtkqnYCGw1MuJwznPrcGF9BOgFZ3ybbz/f2O9VspnXsicTIIQPdWKAwhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SiGeUp4L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0mIOoiw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SiGeUp4L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0mIOoiw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LdYQ2317645
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3txuPy4prEUuoyyH0QQ6NjioZfBD6c6AvHOjoJ+brs=; b=SiGeUp4LdhaGNicQ
	dFgKspN2VqgCLfZHEJ+TEpdkyIeAUrIYwNRM5Y5YIBpKj1IMthQGj8qzAGjcpzE9
	AATuIRFWiBmO3X82sAKt17Rkw7g+P0BwE0bauTzq4jceOXzF9tb3lBMRotncTwwy
	WZPYPPWRYnsC1lcU+7UH2+Yc3+al1yfEFsMobhkMkE7tUUQA+xs7ldNzeJDU823R
	RZCQKSaS30DwFLEfQSeH7cfYaF8PKw3Dbp3+NjfFb54NkJ0wz5/dZoylLIMd/MGa
	A/uYeGVp5SjbPgZjlDSeRWixJemP99PfcO6ifPSkdaWBOjXrZEvIsZY9qHFw/+ax
	mnR9kQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj9tut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso3103866a12.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 21:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771910476; x=1772515276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3txuPy4prEUuoyyH0QQ6NjioZfBD6c6AvHOjoJ+brs=;
        b=e0mIOoiwkTYB/oG19dzf+/MJryyKg/mvM/PxO+VIORWqWtsz3X+63CYzmdcJ+Ymi19
         R4C9HMSCQxlHyHrVT8Q+fyfgVDLjUR7UZhgdI1fCHj/2aRAlcPrWKmpCt9XHge7OD439
         0wwsupaWYoWFGPA/Dwi4cRu9ZtiK/DofJlGDEzCMMeisdtiiTA1MfbQ7gbBKSmgtpqjv
         Nu3OZR1C8fBIikLUCej2GD1rQ/17Qno3mdNMJ4opkCP+KqtBKjaup5eh+U9m3ZLSKJHX
         xlVwGKE4wG5Ti24gNFiO8m4GwurUkXjB46+niPYIR4h/LGt0TLMF7I1jjZVbzfU40cwc
         2YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771910476; x=1772515276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3txuPy4prEUuoyyH0QQ6NjioZfBD6c6AvHOjoJ+brs=;
        b=b0M7EMV4yvrhTfESSHJMQgI0mC//5hq540tBAYqqqFPZkGIk8O7ppC2H1jf+92mv64
         AnVadfyd2LqNCoDeDFnn6Dcn5/xpUQ4IqtMcCxnI0Iu1cW7RlFP3y9hxsOhre8Rm6EbA
         ubnG9MK0JmEOREdLcZVpE4SSqtMtq5aODvJIdLKq9byo7txAJu6uZ5cZovtPcZnD8SI3
         2p3noHP36L3YR8F/4aP99j7kecrwWLVlUsb1ZarUNLas0NvkujRfBOKoORCW47aJSkZi
         UlNdWBa/O80X3Nk2RQHyumPcgeyQH8nHaGYi7r09Dqeb1sWztOh1yV9JHLBLvha6mRUT
         Ezcg==
X-Forwarded-Encrypted: i=1; AJvYcCXBHO5enhKwsryadPSgbPA+8dvNhDLJIrAD41NU+4JhU9M1Vj85u18y+x2XohNzj0kNVcUsCZta074=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmHJ7dA8kfEUzNVej0YO3rt2ZFIZzoyunEYpE8qyEKZs/lCV9
	l+yScWokX3haxg2uyPEdYzEh7uAlrHm50MOcEd9U1POo5CJDPj1yVwJdhVwoHtah3ZjgxgLP419
	Uuedi8xTNlr+926dgMPs8QE2cl20LHDwtFoI71QbzcFeoT5XDXYGuWK1HeCoSMEQ=
X-Gm-Gg: ATEYQzwkhbRMccv7PNtOPuSl7tRuS4KhGarDqxjeD/H3/igWNlVq95oFFHBgbHCByvu
	eb9KxqeG7BT/YKOCDUF6sNvbCgpqLdKdUB1p4Oicm+NSIDIQKhAAS183j3QIB/xnOtVPE3gTBjS
	GtUeWPRYN/3Km2xuTy+78DKPCYdL/13/zdHkJbdgrz3JfwacMwom8tsvkfxHRQrAVfWZQ5GVs5i
	tdHIN3MoHEWx346mYUW7afXVSzBvjOG2cquC1yqO265msvGWgVld5FGR/TNplb9BFkeemiN4ZSS
	srasi9y2oDyuVlHSQHiRuI1LvyWdCLzeM4vZLv0DfJxyAUdEc33tjPDNJrpPBQ79ymAPj8x8Ihh
	Rm4gsfKDtdg6U0F8yvr+iL+cgGcYFPpE0APsjbCtz1MK6KqMTZHQGJg==
X-Received: by 2002:a05:6a00:1150:b0:824:374a:1404 with SMTP id d2e1a72fcca58-826daa9425bmr10111818b3a.46.1771910476006;
        Mon, 23 Feb 2026 21:21:16 -0800 (PST)
X-Received: by 2002:a05:6a00:1150:b0:824:374a:1404 with SMTP id d2e1a72fcca58-826daa9425bmr10111794b3a.46.1771910475526;
        Mon, 23 Feb 2026 21:21:15 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8cbb02sm9512889b3a.57.2026.02.23.21.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 21:21:15 -0800 (PST)
Message-ID: <e5296567-db3a-48d1-b40b-2791ccf5d911@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:51:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com
References: <20260223152901.GA3694918@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260223152901.GA3694918@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699d354c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kJBpcOZ6olZWUerAqwAA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 1eCG0SMdBqgnvx-GM4hRGjWRn8tixBKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA0MyBTYWx0ZWRfX+ygiNorGJGWU
 dd4UE/9zC/6S+Uje3Soi2q2MDanaw2FJGEGtBrxHmXi4LMIiOEzUVncnH9xWbJib6yD0d9NmgzL
 GWZqVIgtDXa3ImIsgss2+lFGzej0lk6f9b65mMUJpEtHf+sjn6nvPNrJeSkv/sMoFRdbI9tdgS0
 gqxXOhI1PO0td1q7LTLGJvm6Wns9d8vFcvpgJNgmpr7RQ9oDdkakmzRU9ZJdcbAN1HJjRX+y6ds
 qaJ6NCM2+7f9y7LE9Zqdxb1uwlEbydQzrEOHfOp4Qq8qwLESmrPPdTzN2Ci9opFB9lmAQmb9HEx
 xDOhots7ZQaTjr+GxQ+GE0VxrqV2HbFy/z7SHHWDiFUuedye+0fayHecWt55NHH1wU+T3oaf0tX
 2e1zFvCtdFvdtiOXELpgyqzIg9conk1Zlac3+70P3+YV+iG2q1pdo8gxrqcqXzY99lpxs/A+sqp
 Kpsg2aOZMX/VffAD1sg==
X-Proofpoint-GUID: 1eCG0SMdBqgnvx-GM4hRGjWRn8tixBKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240043



On 2/23/2026 8:59 PM, Bjorn Helgaas wrote:
> On Mon, Feb 23, 2026 at 04:43:30PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
>> parameter into the T_POWER_ON_Scale and T_POWER_ON_Value fields.
>>
>> This helper can be used by the controller drivers to change the
>> default/wrong value of T_POWER_ON in L1ss capability register to
>> avoid incorrect calculation of LTR_L1.2_THRESHOLD value.
>>
>> The helper converts a T_POWER_ON time specified in microseconds into
>> the appropriate scale/value encoding defined by the PCIe spec r7.0,
>> sec 7.8.3.2. Values that exceed the maximum encodable range are clamped
>> to the largest representable encoding.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h     |  2 ++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 21f5d23e0b61bd7e1163cc869fe9356d1ab87b34..d7f9ae9e48c25dbc2d9b4887e2f74623688098e0 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -525,6 +525,49 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
>> + * @t_power_on_us: T_POWER_ON time in microseconds
>> + * @scale: Encoded T_POWER_ON_Scale (0..2)
>> + * @value: Encoded T_POWER_ON_Value
>> + *
>> + * T_POWER_ON is encoded as:
>> + *   T_POWER_ON(us) = scale_unit(us) * value
>> + *
>> + * where scale_unit is selected by @scale:
>> + *   0: 2us
>> + *   1: 10us
>> + *   2: 100us
>> + *
>> + * If @t_power_on_us exceeds the maximum representable value, the result
>> + * is clamped to the largest encodable T_POWER_ON.
>> + *
>> + * See PCIe r7.0, sec 7.8.3.2.
>> + */
>> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
>> +{
>> +	u8 maxv = FIELD_MAX(PCI_L1SS_CTL2_T_PWR_ON_VALUE);
>> +
>> +	/*
>> +	 * T_POWER_ON_Value ("value") is a 5-bit field with max
>> +	 * value of 31.
>> +	 */
>> +	if (t_power_on_us <= 2 * maxv) {
>> +		*scale = 0; /* Value times 2us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 2);
>> +	} else if (t_power_on_us <= 10 * maxv) {
>> +		*scale = 1; /* Value times 10us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 10);
>> +	} else if (t_power_on_us <= 100 * maxv) {
>> +		*scale = 2; /* value times 100us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 100);
>> +	} else {
>> +		*scale = 2;
>> +		*value = maxv;
>> +	}
>> +}
>> +EXPORT_SYMBOL(pcie_encode_t_power_on);
>> +
>>   /*
>>    * Encode an LTR_L1.2_THRESHOLD value for the L1 PM Substates Control 1
>>    * register.  Ports enter L1.2 when the most recent LTR value is greater
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..eec16fdcb9996ab0f663f4587a2367a676a49ce6 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1911,6 +1911,7 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>>   void pcie_no_aspm(void);
>>   bool pcie_aspm_support_enabled(void);
>>   bool pcie_aspm_enabled(struct pci_dev *pdev);
>> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
> This looks like it should go in drivers/pci/pci.h.  I don't think it's
> needed outside drivers/pci/.
ack, I will fix in next patch.

- Krishna Chaitanya.
>>   #else
>>   static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
>>   { return 0; }
>> @@ -1923,6 +1924,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>>   static inline void pcie_no_aspm(void) { }
>>   static inline bool pcie_aspm_support_enabled(void) { return false; }
>>   static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
>> +static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value) { }
>>   #endif
>>   
>>   #ifdef CONFIG_HOTPLUG_PCI
>>
>> -- 
>> 2.34.1
>>

