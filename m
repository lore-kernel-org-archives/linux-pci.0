Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BE349CD6
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581603; cv=none; b=EmvyS+upmuNzOM7MiMfxBvUiEJnI7eSz58IGOyTAo+zRkt3tHoR0E3L+dxMQp3pf8F+dRM2ov0NoMtmbc51S1z+lJis8diTYT1su1FuIZJf1owARYAoWHmYjg+fACgEs4I3W3mqB1YWKAwGQzFHk43bmVPU6WOGHjVNKjbwKFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581603; c=relaxed/simple;
	bh=wWufaAspikOQf97TdyrRbiiR4Z1Bn28LkgAbRhwLlJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IY5WGCXi4BNQupixq5+SWwfFqjhn/mvdyk9xKqxWdN86aVUILRQfjrQKhwDWCO0KzwWrsPuwdNEY7+x48WPcUdPf/kVBRvo2Ys4rJg4yNuuQ4lmLJhLpecpA+LYjBAf47ygHLHiiYL0vm73G7QSVfmBhb984qSl64Lk/Bwvy3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8o4nP/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkMrRMEg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8o4nP/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkMrRMEg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5Dok22202417
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x4mIjIDyTp4fGlEs2tz6CwwYjcggLxk5gOYgPihpIhM=; b=T8o4nP/IUaipWkMV
	oib01KvR5sBRjp4SI1jGmMd+KFyQQ4CmMV3l92MgAeDC71D181uVQ3h/nkawUqI5
	xz2x9qmR1rg1K9lKPKNgB882FZo/Md32Q59+1cj/2CMyZagpu7rFNCDx9XJRV1Qn
	yeULADxtT9sV27MEAlWv+5/rsgtWDKYEZ3aF/p09NZcXjIgiKptAdYQFCzSxDo29
	xlp/iVYe9b+YyYMVkBJ/K6VWJsoUthU0iSH4OtJZhxsMQt5SYrlkrS5h0PeG9PFt
	YvUVoIzvhD03Az+2XJLvCGn3OolQrmr6yLA696Io+c9yt72HqDtSHuVuL0LbDMot
	2h9kCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyjnss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:26:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bc977e6aedso28523555ad.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778581600; x=1779186400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4mIjIDyTp4fGlEs2tz6CwwYjcggLxk5gOYgPihpIhM=;
        b=HkMrRMEgQHb+qaOUaZD7Pm9RGtShMQtmxXq7lm5tS7pj6vBtrpJiJ+dmDbBbPWprd3
         ORL5YMlglVmZxoBmD5tB6V/yXREJjspIEDc7zruJ5kb1AUwwXnqS54g/TtGZDDOPmtlo
         MOIqVrvhWZWXtc4McqOW9SKTQaODQNDYSvmIrdS9ehw5SUBbit7mYmv9VcuV1Hm3hA8T
         iJ1DeLBLmEO248A3w43erBv+WU5YXI528Dp1KB1be+FI7s6Wp82D6TNiVVGfHWssWUqo
         mcsUEudwEt485O8mowYA77/Szr0/PwT5PO/l73G/lVAtW89Vo3G0jFjl2Uvc1W/8/UOO
         /sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581600; x=1779186400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4mIjIDyTp4fGlEs2tz6CwwYjcggLxk5gOYgPihpIhM=;
        b=Hj0NUKaaMZsforOEW0IA6WQ94xTnKWtqdIjp3p+ue6pojF5IGg/0rIEuwX10Y4+gi4
         8/dKwxqFt1336v1egTg3STSheVGGpb0U9gv0OwKwT3tJPCi3U6O/frVyMDkKmuX0XSVU
         0dMcOmT+txy+zAgmRSjpy9zH7aRzJe1w7bXj/WXHHZSMnDRmPhgzoUwoIlwQqGmeAcoV
         31Xo4IlxEdZDs0xdEL2SJaIY8bK3lqYgM62e0OJtWQa9m+N437FHaFHr65Q/Ysntpoyg
         8dBQtfSNhyy6RT/yclN9e4AQHtsntNzS0T3fxtRXxelRTXTEY5q+TDjCLb6DTOufAurE
         Sujw==
X-Gm-Message-State: AOJu0Yw2GYsCuqJkp2EDU182GL4D8KrtyxgWUmu/AyiAh15ntGwJn9FQ
	Djj9I1kmUGinMo9gnZZnttMLg62USWVA+gFVe0LdaLDJ5qe0TnyCJD5V8t4+8ATsG+sWacaTtP4
	ecPKNDFXVE+H2XoHwqVsglIKWhqAfymFQCqyeD9IYOqZ6QZvicEQh/aedWY6O5MI=
X-Gm-Gg: Acq92OEwx48Rf7kqFwepXsWkN18zIXz+ijAe6SzIcbRfDQWsjh/NxzAK8FM8xGG+wmD
	O+Rd7h8MsfuPQwWCyOcNkezudtlGHR4aPnBMo7bUTOsM+yN/8kEDZNxsoBvMb+ebfwvqWfZHRyf
	YU3U384xD+w/o0cgTWWkcC+g2syBRi6yEvGR7Cjy0WH9qNvGhwz5fgBiCNzw1j0Op1OKQxhMN9j
	km3iMrVz5FFW5Gf++5eyquehz46P1e/KweSmgXZNwcAFhVmDwDyJwmRIsAmU22ziWh0QnyQrHWX
	HdQM9rP7N/UQPjDuwaF/aO3bJUb566doX3k8fpuunE58Aa1cjnPoMJsa99RFXJBsBXlqQm/vOYS
	t2N1fglulVptrndM1C+sdt2rej+kV8DeK7veA1nGRqtXobsPiTEvahg==
X-Received: by 2002:a17:903:8d0:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2baf0e5e35cmr174643285ad.38.1778581599904;
        Tue, 12 May 2026 03:26:39 -0700 (PDT)
X-Received: by 2002:a17:903:8d0:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2baf0e5e35cmr174643035ad.38.1778581599436;
        Tue, 12 May 2026 03:26:39 -0700 (PDT)
Received: from [10.92.217.84] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3ff52sm133993175ad.26.2026.05.12.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 03:26:38 -0700 (PDT)
Message-ID: <e1c6649d-06e2-493a-a4d4-e18b9044892c@oss.qualcomm.com>
Date: Tue, 12 May 2026 15:56:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Mask ASPM states based on Devicetree properties
To: sashiko@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com>
 <20260512004624.B82F7C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260512004624.B82F7C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwNyBTYWx0ZWRfX27zYX2oerma3
 EvdBAwaJbwNXK3G8FrmM2GzBet47tt9u7aKGfzF/5/EqTkIoI1zBOSDvUrsSADSLSUka8mcmcSZ
 vXL4zHIDbf73LJialGZ8fTcphTy+RSX8OlCeG64w2KnHvE41TjRNs6DKOpTpcnGxQ8x35lEOE9T
 wJIpz3xAe6YweAOScmVaYVDU5HrbWbBUXxXxElEtB1jxnglZqTroZ3/PVIiwIfE6gsXsLsHQS2D
 /aVvGf5gZGJEkZgsBwTytHHRK1ffUO8d6x6n8dntIWdq+TQWy49fNpsFsNNmOBeBK4MvYTlPKi5
 3ShCADqC1zVlNrRwsF/a0lIUqZGs9imtqC2uZ7Wey/yx02Oh+CKVoxsLd3pA51nrVMLyVDRK9dq
 FMluy1T4++E8G1QAgHfkxiN3JxnNfCRzzVqPQK07rnhoYi45M+gOKnsCPCyohjrpTfIpQeTcleg
 FOOHEzNnT76MVHgFxyA==
X-Proofpoint-GUID: 0CnttHe6i8_xRfvciJgbcpDucmBhWQm1
X-Proofpoint-ORIG-GUID: 0CnttHe6i8_xRfvciJgbcpDucmBhWQm1
X-Authority-Analysis: v=2.4 cv=Y5XIdBeN c=1 sm=1 tr=0 ts=6a030060 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4obT95Fy9AywzWNa8ycA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120107



On 5/12/2026 6:16 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Modifying `link->aspm_support` bypasses `pcie_config_aspm_l1ss()`, failing to disable ASPM L1 Substates in hardware if the bootloader previously enabled them.
> - [Medium] The `aspm-no-l1` override only masks `PCIE_LINK_STATE_L1` from `link->aspm_support`, failing to mask the functionally dependent L1 PM Substates (`PCIE_LINK_STATE_L1SS`), leading to sysfs inconsistency.
> --
>
> commit 3739505256d4ced724de1faf6f3f111a9994fa59
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> PCI/ASPM: Mask ASPM states based on Devicetree properties
>
> This commit updates ASPM link initialization to check for aspm-no-l0s,
> aspm-no-l1, and aspm-no-l1ss Devicetree properties. It masks the
> corresponding ASPM states from link->aspm_support before applying the
> default ASPM policy.
>
> Link: https://github.com/devicetree-org/dt-schema/pull/188
> Link: https://github.com/devicetree-org/dt-schema/pull/190
>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 925373b98dff0..3111ef7fd226e 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
> [ ... ]
>
>> @@ -806,6 +813,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>  
>>  	/* For devicetree platforms, enable L0s and L1 by default */
>>  	if (of_have_populated_dt()) {
>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
>> +			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
>> +
>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
>> +			link->aspm_support &= ~PCIE_LINK_STATE_L1;
> Should this also clear PCIE_LINK_STATE_L1SS?
>
> If we clear only PCIE_LINK_STATE_L1, link->aspm_capable will retain the
> L1SS bits while dropping the L1 bit. The sysfs visibility check in
> aspm_ctrl_attrs_are_visible() relies on aspm_capable, which means the main
> L1 control attribute will be hidden, but the L1.1 and L1.2 substate
> attributes will be incorrectly exposed.
>
> Any userspace attempts to enable these exposed L1SS attributes via sysfs
> will silently fail, as pcie_config_aspm_link() enforces:
>
> if (!(state & PCIE_LINK_STATE_L1))
>         state &= ~PCIE_LINK_STATE_L1SS;
ack
>> +
>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss"))
>> +			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
> Will modifying link->aspm_support here bypass disabling ASPM L1 Substates
> in hardware if the bootloader previously enabled them?
>
> By clearing bits from link->aspm_support, the changes propagate to
> link->aspm_capable. Later, when the kernel applies the ASPM policy in
> pcie_config_aspm_link(), the hardware update for L1SS is guarded by:
>
> if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
>
> Because the capability bit was cleared by the DT override, the kernel skips
> calling pcie_config_aspm_l1ss() entirely, leaving the hardware actively
> using L1SS if the firmware or bootloader had enabled it.
>
> Would setting bits in link->aspm_disable instead (similar to
> pci_disable_link_state()) correctly disable these states in hardware
> while keeping aspm_capable intact?
we can't keep aspm_capable intact as this can expose l1ss capability to sysfs
as pointed
by you in the above, I will do like below, 
 if (pcie_link_has_aspm_override(link, "aspm-no-l1ss")) {
      /*
       * Clear L1SS in hardware before updating aspm_support. Once
       * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
       * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
       * leaving firmware-enabled L1SS substates active in hardware.
       */
      if (link->aspm_support & PCIE_LINK_STATE_L1SS)
          pcie_config_aspm_l1ss(link, 0);
      link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
  }

Bjorn,
can you share your taught's on this.

- Krishna Chaitanya.
>> +
>>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>>  			link->aspm_default |= PCIE_LINK_STATE_L0S;
>>  		if (link->aspm_support & PCIE_LINK_STATE_L1)

