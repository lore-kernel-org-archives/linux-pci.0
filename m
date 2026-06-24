Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58220165F1A
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307878; cv=none; b=X1jCaP0+BYn+3zA6N1hwiM17Y9HvtvzIb5WQLFcyepNS05Bz6+JPVa7a+hWmnvaLobaXjoTs+7WNdJyKEZG3nVg7JGsvKh7q7I9rbxQd7C0dTb4yCvXc4XXhd/oUE9Buudj6BvO/h7kEjedG8UTVfYNVG00sEbc9hgZwvWirCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307878; c=relaxed/simple;
	bh=p68CpGnxGyhI/fzAM1TyvEKb0jamzFVRALJYl6w47Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8tJa8a+tP/vwi9Ht7D8bpYVNx4z36BVe/cpIZ14OvhCnUEeDFc1ZBGdXzYnzEh4NGU0+GfA4rQ9k8xTLXAkCY1PtNvqA390WhTgJstIGUpJVZ0jSzX0TiDOwNJ7VL8mekRTrhp+ssCtIxVThbbgffvkgVc1fA9lED8Od5HeyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcYJtdRy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMNBtM7U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcYJtdRy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMNBtM7U"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OANbbh2869062
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QmgxxMOLKanyQxux/RLrDVM/FIMyBx8HNKmxCp6pXzY=; b=lcYJtdRy8wHjEc65
	RK1n5W8oPVuYhdZH1msntOIjVtmEYMo7OzVjD3mrAL/Lg4a1NkxOdZl36VF03p8H
	4tvePZiRglHbFO77KW3N6LV8wKwrEF6fqSwERlIPwbybxtrCbacFaSsW1Dn0x+UC
	FP5Sv2g3WmW6gIQuGRmANrBivHoI5inGaE/HX+tUT/NsijWhRYLTqxONq+/p6bln
	KCTK/YQmR6qDmTs0XupZ7KrlCP5uULNrywYk2McqqWyFc9/Uhw+/+K1GefbKAi6d
	2F28MD0U4Nsd3odxC3mLLLcd23OrHOlguTeQlzL38AN/U7FQnQkMSrIORa0SGlAZ
	S5bBUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq1c7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:31:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7403e80b0so12263295ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782307875; x=1782912675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmgxxMOLKanyQxux/RLrDVM/FIMyBx8HNKmxCp6pXzY=;
        b=VMNBtM7UNlxLsz2+2tIPmkwdsY6IorXVhxzYS3GGEWpr/GYbzaH7LG7D89IKYIQ78d
         rmhdXUfjaYXZ3mHsknVvZZV0tloYQ9p3E4ZCH9fcoBDEORhQM94AdU3finBJpbzx4wge
         Pz5HHgxHf/ozGTlcViCQkIBL8oC8uOZppi2lT9IxIq22HmyMVeHo6/5JAbBnAn06p+1R
         Ahqwub5LGxlccsZQZfnKc7YA2ZE9OLsMtf4PpNruhSS/LZXk//f+wPiFwbg2qkBheQu+
         4EtjB/5LRmshymrKlWscS9jEdompa+GizSjmDSGOdtVmRY6NYS47Hwll8fNURCe3Awfl
         a3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307875; x=1782912675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmgxxMOLKanyQxux/RLrDVM/FIMyBx8HNKmxCp6pXzY=;
        b=aVolHAtyOyeiKusdwAvhamwYooYJ8UrjFHuFqaL4MtTt+6n9P3vTBtx8tODEV/ihBe
         Y54RxiNqu6b4yHAjM8VYPBBpVBipLHxqwaqUJJhtA/BiDUdIaisEyb63M+klgXN8KwLO
         +FjfoQfdIP7dqIQZHdaxJUf+8hzTv7/tiEM+aFFL8VtWOzqIQZ4lPRIwxqKsnXR/NiIG
         V1fFOMkRGoa7eFffPJ17kLvzCyeO+sP5ej+Ve+348kv1t2P0JI6OKWuvbNrsuXOrNfav
         Ul1gH+WUqALhBUzUreZ/0v4rBra/18ScKzMx8xEHAF2MBv2O3JkuRV79lLyC288DbN/T
         lToQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2g2EDnC9D8b6rnNcpUwNgP39dsxn9esaHysmMmv17vIHxVhcNl2FTrJ6qF9AXjDpLGlX25U20Fr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdpJwY1FgI9hyh96r0Ia1qjw8puVkIbaZkl53BdwOiOsn+JLh
	mcIXd4zwu4S9gBnxFbz92QFXb9BNxVYS2EoHt5O46QXD+HAfESfDXxJf9IQeEYn306DbsoYK93V
	S4daXAVF3Jl8IMJJ0lnLNg8J5RUFuQhsqfj7G3b/DV98D5aJ5wIFOsmiQDEv+Yns=
X-Gm-Gg: AfdE7ck6BxfSE5f9e9djymxyGSxy4Svn0ysiSwIa032CSlzov+5xG/etSwNes9PTvN6
	Gg479mXnptf+lhfOGaoITsOxiLabqKuU+HAeWDaI/7jVIF3wriNDiMEifg/Qh/H+6s3NLGTdhI5
	tJDyfROd3Bk4WW95p8/1eNWHzsEjJIWEragGfvXY+fix0C1LR89gU90eMszWf4kjT2/4oHw/XIE
	HU1Ld7g2Q236JUSfVEEfBvpFOVGkeMHiXjr3J2rJdB02Wo4/muH4Gap3/yFmPGpTuweD/5WwAas
	NqgVQPiKDdSUAW5xIekgckC+W4dESzVVlHjZsNW30Ol/wRuD7ZYQP4tX1ajYVdgWmJt8zyRARtt
	wHwvkY8mbWZ1zW6NU2Seqk+m5j15miIjx2zk2ZaCdKAg=
X-Received: by 2002:a17:902:d2c2:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c7e1458148mr35429565ad.5.1782307875257;
        Wed, 24 Jun 2026 06:31:15 -0700 (PDT)
X-Received: by 2002:a17:902:d2c2:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c7e1458148mr35428915ad.5.1782307874569;
        Wed, 24 Jun 2026 06:31:14 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7437002aesm137894045ad.37.2026.06.24.06.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:31:14 -0700 (PDT)
Message-ID: <39e14aa9-28dc-44b0-87fa-0ca74a3fcd6d@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:01:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] phy: qcom: qmp-pcie: Skip PHY reset if already up
To: sashiko-reviews@lists.linux.dev
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, linux-pci@vger.kernel.org,
        neil.armstrong@linaro.org, olteanv@gmail.com
References: <20260521-link_retain-v2-1-08ed448b081c@oss.qualcomm.com>
 <20260521132311.4DE411F000E9@smtp.kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260521132311.4DE411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMiBTYWx0ZWRfX2CLCEtucMQzO
 aQAbvFjWooTH9VYppksPBkdHX8vPaPInMqYybl630BH5y/ZvoWfEL32t8KoZ2F4jVHyFdmaSDe+
 JYC1Zv2rMGvhJhESNhFWU38EsTlwsN8=
X-Proofpoint-GUID: kCPqHpgZWSHiJU3dLaI8hcKzvJORoXY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMiBTYWx0ZWRfX/d6YmkiNAyYo
 ioLvisrDwrb+yF4LcoCOXBEgB/fD3EPxaHMrNZrCi3tOSROEVVCRUGJfnsc+U0JuDgfVybNkV6i
 ba2sTMq+Gej+bGJeCBUhTkUBxH8VXivR+Q5PPy4exaa0J+rj+Y/yBDgSmd7UGyKZhw9VyqZkglT
 rJjrODvhDF3rlTh5rYI2mQ9lE1DwcXFsMAP316xghaD5pjrGrVMkMlQvlH8nrRwsZxE4oajJxAv
 XNQ41HWVx8/si5IMi4Ful34XHncah0nQyPK1KI2/iiNesK2pyLDDQCB49y3HIOXkWjq2BfFzWF1
 YEmoCoG81RlUwT1P+bD/gIfFY3tLdE8+4cBBnKFfrRVJZjRV+M+BW1OWmWUSYwR6/6qfxav4qfX
 lqMGwG7ul1GBCvClubwrWG1+iTcD+Q==
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3bdc24 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=brcwVlbegnbOBPMMvKAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: kCPqHpgZWSHiJU3dLaI8hcKzvJORoXY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240112



On 5/21/2026 6:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `skip_reset` condition is evaluated twice using a live hardware register, risking unbalanced reset operations if the PHY status changes between init and power_on.
> --
>
> commit 7deef03fab352fea4d882c35e253738b3fad392c
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> phy: qcom: qmp-pcie: Skip PHY reset if already up
>
> This patch skips the nocsr reset during initialization if the bootloader
> has already powered up the PCIe PHY and its status indicates it is up.
> This avoids redundant initialization and link retraining delays during
> boot.
>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index fed2fc9bb3110..1458ac1478c7e 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> [ ... ]
>
>> @@ -4744,6 +4745,9 @@ static int qmp_pcie_init(struct phy *phy)
>>  		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
>>  		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
>>  
>> +	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>> +							    cfg->phy_status);
>> +
>>  	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
>>  		dev_err(qmp->dev, "Init sequence not available\n");
>>  		return -ENODATA;
> [ ... ]
>
>> @@ -4823,8 +4829,11 @@ static int qmp_pcie_power_on(struct phy *phy)
>>  	void __iomem *pcs = qmp->pcs;
>>  	void __iomem *status;
>>  	unsigned int mask, val;
>> +	bool skip_reset;
>>  	int ret;
>>  
>> +	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>> +							    cfg->phy_status);
> [Severity: High]
> Since skip_reset is evaluated dynamically in both qmp_pcie_init() and
> qmp_pcie_power_on() by reading the live QPHY_PCS_STATUS hardware register,
> could this lead to an unbalanced reset?
>
> If qmp->skip_init is true but the PHY status bit indicates initialization is
> not complete, skip_reset will be false in qmp_pcie_init(), causing
> nocsr_reset to be asserted.
>
> Once the reset is asserted, the hardware state changes. When
> qmp_pcie_power_on() later re-evaluates skip_reset, reading the status
> register of a PHY held in reset might return 0. This would make skip_reset
> evaluate to true here, skipping the reset_control_deassert() call and leaving
> the PHY permanently stuck in reset.
>
> Should the decision to skip the reset be evaluated exactly once and cached in
> the device context instead of reading the live register twice?
All the resources are voted by this time, so this situation might not happen
at all.

- Krishna Chaitanya.
>>  	/*
>>  	 * Write CSR register for PHY that doesn't support no_csr reset or has not
>>  	 * been initialized.

