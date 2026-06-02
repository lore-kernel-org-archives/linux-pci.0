Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CDB640
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374871; cv=none; b=n0JNNZyWCFsFMNpDU1cwhYeIXDJPvGpYWBVRB4Q7GEPD/ob5VkK9mRjSA0r8yg6moBaipCqP9x9BTvpt4HCrKXYfDLxH6Wwl96IVuH47H546h6CsLJtvhAFUV04xZsEdlD9ZUgoJGNFmOx64jRU/31LNk6RP/azyMhhFF5HCpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374871; c=relaxed/simple;
	bh=ty+HAAsHAxkUJXff9F+TEX/K6iMhWXyTR1OBcpL/1fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1D4XnJmqTBwekuOK+my6X88WqEhYjiwa0Yz6sKsRmZPfSDUJb9lxb100Cfcr09FsHIIK7neKvQlTdP9jB4tNDtYuEg416nd9++qUBBroNuuqY2OSp5JbFY32uCA8/+1LuOatzFFI4Gu8fay+lKJNiEUut5ew7Cq76TLt1f9I5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FV6dGG8I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aRspB8lT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FV6dGG8I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRspB8lT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65203Lc71214129
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 04:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ehXOCZHzAdL2E3/HvP4lXm7p39a6i3gpcELOmcTa4Lg=; b=FV6dGG8IuMFpF+pS
	MumxC+FMJW4eQmnrKCs7cfPWR2FwYBp7kggCWgcpjN7UBoj/MLhh8lOhXLSO0N6d
	I2FU02qo5iFX0hbGjnl+YmRVX5vFjhNAcqhR2fIsCoiSick4eSoy90zdTFaKlf++
	ZA5XcPfaqcmZXklbpoXpXBe4ZKoa3zaUMvlcwG+Di+dAO/ddgwpeVhfJI825Vk/+
	o2q25duMRUNhOlT7/BmxpOHYCoa1QW0lKSEc1DCg0qpScEK7OhbCrfhbAKSr6Bpn
	7X6EnO9GcQWeSzlraltJNCAPRP0QEL87RGiiK9P5RpZEfDh5DrXhDX46tyYhOYPd
	iFhS+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s9ch7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 04:34:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so5061718a91.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 21:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780374869; x=1780979669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehXOCZHzAdL2E3/HvP4lXm7p39a6i3gpcELOmcTa4Lg=;
        b=aRspB8lTqRjj+xQJMBkLdc0usKolUlmxrQ6QpkShpmElPuRFQKHFd9PRWtuFn5uByu
         X6wWNfwrfVtRclIWk2MldAe9oPtqSSC5JO0CKmLjFPXoAFZByvbadQNpKDIr+DmZaP8+
         H8B3CJXJBHI/kzlp/L95HqhX02UWddg9TP5SdDuqftwTF20Bu3Mot56/G9XexAhRhtM0
         809On6yg1F5PRVhMlaeLN46ozjntuHhmC/QhXCLmDDMUcLk82Dqc14DAgLHIGoOCEdAi
         tuNv81YJQfUV0Y2+MwcZuHPA+z3l+9n6uaPAAELnq7HmKdkTCwXyhbFoonUknjKriybh
         9+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780374869; x=1780979669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehXOCZHzAdL2E3/HvP4lXm7p39a6i3gpcELOmcTa4Lg=;
        b=dhnWTaaIN1jPJVDqY22c9bWcqQ53Vrn4+7ECtnmshzYo+pTRTZ0dC8P70F3uNOjxuS
         ur0xpjoyGZX7RIh/xnsEXH41GzZII62mthy6juZcjpr0ypSOAoIoyraCz5mPw5pKdGs0
         jPOnZl/Ig4mN4bEKR4bOuLcASqVxXyfFfhVKTpks9CLQ7txP1MpldSbdf1JvqYwCwHtb
         cWHVA5xYkRo1iLpaoM3m5UfTNTKsx0AgMWncyHGhyLNmGWrq38qF3cXAcyoRFvt46IFI
         kVDgv0T0ouPLUPvE9WfEC6QmhuZhcjhVfq4ZjSi2mgkaleBQ5juImguH/M5F9Amy1n5M
         aN7w==
X-Forwarded-Encrypted: i=1; AFNElJ8pT2Jjz/ICVGtxBwsFZSNlGTuMQ4PrTcHOfzJ6cZNnNGmLTrh6e7fY6AmRHyk6r3K3VKEP4sm44Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+o3FzKdH6JDdq5jJuUt39+P9iweC9dvweobbIMJoIlEIJShZ
	ESXvVWX/E0io0gkT5I5djWqYLYFEZfo2K2LBYza5u1+5jtHzVkQPzOuAV+RJPIlU34N9xYnjk23
	tBq7xFzD/ZWMYCXxWshOROwcA9hgZYoogUFagiikK5IRy6K4gwW0CINQlab5okts=
X-Gm-Gg: Acq92OGPDUsLOvhdROkQdBnv29VRDy4GgsmEEQkPyG3mB4mUcGxXljK/J2cNIYWQ/qG
	vregKc/pfAO3zb0gKrZmXEqGX6eySidIkfT66mZN4QjlZUOxG4SS/9g4g6TmwRpJ+dbmeqkqF6T
	eCR8KhRWkbroWra4evSkSAupkhF5J3MCdI7lBBtq0fl1ykh18oqnaTK5jWUvfPpaOjHQns2a/JL
	FDzb+X6UPTDgykeftRbFko6nyKOxnlnmsvlgh2u+H2NdDd7yaoFIKy2PJPZ2mrey+5Okv2f8RDL
	y5hjeAZICNH+zXu9jZViXAOzWoKAkwSo8xVF0mmbd3BvyYAgR/PaM/JQ9buo5B/3nY08IynqJAA
	Vw72RX6GnaCCbA3TkC2RatLUmsIFyBc/eStMyfL6q+MHxV7fNk/YZWv9dZBBf6d7czu9Vw/J9nw
	4I
X-Received: by 2002:a05:6a21:a34c:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3b427f2cff8mr16397471637.29.1780374868606;
        Mon, 01 Jun 2026 21:34:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:a34c:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3b427f2cff8mr16397437637.29.1780374868135;
        Mon, 01 Jun 2026 21:34:28 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842222e2394sm9874515b3a.2.2026.06.01.21.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 21:34:27 -0700 (PDT)
Message-ID: <0bd70e70-68fe-436b-8366-8a497861e21d@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 10:04:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
 <gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GkvvdyCEsisw-B8YbQyLSMc6ximUr58O
X-Proofpoint-GUID: GkvvdyCEsisw-B8YbQyLSMc6ximUr58O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzOCBTYWx0ZWRfX0U1Hyq4abUVS
 RtpwlMHrC+MP0B63oB+thzPV5U2KT3odNdiYm9PKsMAOeLxhymEQABWIcmhjD4BdNB5obfFGtjr
 BrEq4rPey42YUwurhMNtrWNEQINaw0MqVOJH294z1UdAhgiN1ViCum+BjMX42JyB7tBphGNMZFK
 E9SarF3hUqxkMAvEvSljO93tOFc5bmrUoY0ExYUrEV2NOjPUVRhyhOJ9PoyvOmfxA0P8GqcknBU
 1y9ozCjj1MWZw0U0qcC6Zj+PjoRUJmxRBHVRnS9Ma0jugML4sDCn2zID/36Dd3oT0ndggFvzdxj
 NS7L78FvntjAtaXvrtQ0pCUYYNFUjrH/WLtIB3iF44kf5YKWVc4+FhVfEDj9Q0STNwIvurvI/BQ
 SVY05dGZA7vOgmfnfn4+GmUvF+Y31pouDqjuyh4HPXyPbgF4hFUj9nRID1kjfvUO64Ghq/1qAtR
 buG44ZZQjxuIWHV3LoQ==
X-Authority-Analysis: v=2.4 cv=Zo7d7d7G c=1 sm=1 tr=0 ts=6a1e5d55 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YW_819I0oaYKz_JYO2kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020038


On 5/31/2026 4:37 PM, Dmitry Baryshkov wrote:
> On Fri, May 08, 2026 at 02:54:19AM -0700, Qiang Yu wrote:
>> The driver currently supports two PERST# and PHY DT configuration. In one
>> case, PHY, PERST#, are described in the RC node. In the other case, they
>> are described in the RP node.
>>
>> A mixed setup is not supported. One common example is PHY on the RP node
>> while PERST# remains on the RC node. In that case the driver goes through
>> the RP parse path, does not find PERST# on RP, and does not report an
>> error because PERST# is optional. Probe can then succeed silently while
>> PERST# is left uncontrolled, and PCIe endpoints fails to work later. This
>> silent probe success makes debugging difficult.
>>
>> Handle this mixed case in the RP parse path by checking whether PERST# is
>> present on RC and, if so, using the RC PERST# GPIO for RP ports while
>> keeping RP parsing for PHY. Emit a warning to indicate mixed DT content so
>> it can be fixed.
>>
>> This keeps mixed systems functional and makes the configuration issue
>> visible instead of failing later at endpoint bring-up.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> @@ -1778,6 +1785,14 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>>   	struct device *dev = pcie->pci->dev;
>>   	int ret = -ENODEV;
>>   
>> +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
>> +		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>> +		if (IS_ERR(pcie->reset))
>> +			return PTR_ERR(pcie->reset);
>> +
>> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
> This patch breaks legacy DTs (I stumbled on it on SM8350 HDK), because
> now devm_gpiod_get_optional() in qcom_pcie_parse_legacy_binding()
> returns -EBUSY (as the GPIO is already requested here). I'll send a
> patch fixing the issue, but it's sad to see existing platforms being
> broken for the sake of undeclared "mixed" case.

Dmitry,

I have sent[1] fix for this issue and it is squashed with the offending 
commit itself[2] and part of controller/dwc-qcom in the PCI tree.

[1] 
https://lore.kernel.org/linux-arm-msm/20260526-fix_perst_gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com/T/#u

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-qcom&id=1a23bcb452d95f099e530414504c0d99ee076b3f

