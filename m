Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EE1D7995
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793119; cv=none; b=Vw4wko6eltf13UobqyfYwsslu10KC0+DO0AAK8JrPttZt2iwHV7iCs0Tny0Fv1Nd0EWAQu2nAjX0Z6CgDtj3UubjgepvrirsrfGNZmUoNMrs4MHbShdJYvxqvq7rf/AEWp79geHWSiHIQXqYW2IRvXyPbqLKfsNLN+SVScLW3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793119; c=relaxed/simple;
	bh=uTR4/2BKw2dnFBh64MYHRVSt1FcY/0VygD9aHUzgiCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhvVP0oIzK+uzjIaWtsvvNM1B5+RjQQPGhuKFz28fA3xxGHk2ugjkL0scE55mmcZYHy1lgbGEb2Nrm1X07D/m3Qsrvp7YVgM/RUz88BPRr/u72puf/XlKizkYhEBJnlTdnmLdbpCUG52KbKnY/R42DLaaqyZu0U7MHWjRcH+Pnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ID5KbRuv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNIBF20+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ID5KbRuv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNIBF20+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264afH31087507
	for <linux-pci@vger.kernel.org>; Fri, 6 Mar 2026 10:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9kq8Rwj6Nj70RxlwjNL/YWOuGNBkH4XA9hyPzQZwSg=; b=ID5KbRuvUC1SoizJ
	umuQ0puANJIk5HMtDv7fekJ4BBl2DaXH40Orl6y+Zc0Zt6unBEzS3YDVNPCk0em1
	ZCyb2z11eHx3gM57wK2rbdoQc1hV4VEJI/uibL0Z+ZoeNM1y/Rq2Zu8OdhJfowEO
	qBLW4VB4SM2SXULUEOzaff6DAzMYjDqw8nTjaeibkWWnI65mVKplnQByNEtk3Tio
	X1NSyZEyLHPI8WvoD08QMNerJp1Zh6xwlbIRGY2CdVW99xDgjYu8oa+SFrpkS02X
	slfB5qWOYr86Zf3pS2eo7iOFXo6ZeF3lvtRXRb5UEuAiIEem2guRfQpcXtiCkrmE
	NMcyZA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqfg6as5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 10:31:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c503d6be76fso33748618a12.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772793116; x=1773397916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9kq8Rwj6Nj70RxlwjNL/YWOuGNBkH4XA9hyPzQZwSg=;
        b=QNIBF20+KDOXLwBF5uk5a5etR8QaS8ZCRtYPQlSQ6aulqmdjjtyIEAkkpYt0A/tH5+
         e4BQCXz2mRyGb5QFNKDokYg3st7NTC/qnVno5L9OO/YuDZKP8yPm4ll5jPoNlgOSUSK3
         EKtR+K03X8+lDHwm93B50rPG8/gGICqXr2t/83eEEVGMoC+RUEg5BvQ2D7Q2AyyRiboY
         hvdwyol8adCtmekm6p4Lo1CsEFX8/3wSrVsm6mmUSXmaCtbny8zkAngWsAJfBoVCP8ZD
         i5JLJUUHQ6+BTiLyOEMx+lBFCBvkCo38V5mL4Q/8NYCi1lSSFND4iigBrBGRPeX1Q1Kz
         QQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793116; x=1773397916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9kq8Rwj6Nj70RxlwjNL/YWOuGNBkH4XA9hyPzQZwSg=;
        b=h7ndIyjnjHOG8OnEVpDP//0tVhAquQT/Kb13byjbdMT6E4/hCy3yV6j6eugszYU1Yu
         UzQal2f9uc8QeJfCEFPAPZ7KbZ0+9DIRcqiCIERJSxZWddj2FTrW0fvTr7jLu1cDj1pT
         E4180w78HisqdZmn5PTygGtaPZreqohl6XPWmNy6a/GlmVI3DlHwS8OYRAqdxlJ7Tnb/
         Q16cObGsluWgJhqpK0AE77v7zah8Ym70y0dN1xXgypBruoKV84pZq/WJwSYB5lOqpT5H
         cWd5aAx5ah1pqXrFKHTvMgaYJL2UEXzyn3/kREOyAOJ0ZhvShwRC3BxOamxa42dQ3VHq
         LURA==
X-Forwarded-Encrypted: i=1; AJvYcCWoPHIkWZt/wRnnOviT8bzDo3nmCjz4ZTW7RNvwCHQpzB27tiucPT/yVPddiyMuml5XEqpN7EC3OyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDxls1Y3uQQtM8BUMo7o14YiXr4mR4BGbXVAvXlDfeFx1Bz67
	zt2iVotPUro7dvEl4xoRBoanB/K4Fc8S2NxDB84zTIaKwcikGqbsY69Dtpbtwh/4Vxf7dHouWC8
	ihjl1vecu3/3+RqoMmaQXr7BPe8zXEtK2d7E1AJAoj0g8KFyxPPhRbidtqO9j2BE=
X-Gm-Gg: ATEYQzzNBDa1/vORl2yHHXdBpfW+tpbaH1omgRWiEAjHMFi4vJtIgAz92r1G7pgraMD
	Hjh7s6RLtA6xe2kAVoK6P52spzwNa7Q8IgSGFmCXr/q9rABt5XAXykOOqCmk9nr6C3G2aiy4B0A
	1q1amgz2kc3DEyyeERpriy0/fLuXItlO49cQpw8qeYoVxOulS+tsLc0tLKqQ8jg+JHGSMgUiJUU
	b5GSkYGSCotTNvd+TB+F1sdrWZFzTA2RG/yo9oe6ALardRPheol7xrNVyQZEju3VAwJWGnRo0qN
	eifDdXghJMxbhSSg3r0YwgFdD0vEFMMYSHanfBzNmcH7AJ2i6iMbnx8wVMZT9qK0/PEvl9MxmQ2
	H3gUKkmfbeWYd3cZHs6RmWm1/mSVT5yAlhYjEIo3bOUyf+6nSbOI77w==
X-Received: by 2002:a05:6a21:2d44:b0:398:4b6a:90cc with SMTP id adf61e73a8af0-398590df8bcmr1886662637.70.1772793115760;
        Fri, 06 Mar 2026 02:31:55 -0800 (PST)
X-Received: by 2002:a05:6a21:2d44:b0:398:4b6a:90cc with SMTP id adf61e73a8af0-398590df8bcmr1886632637.70.1772793115260;
        Fri, 06 Mar 2026 02:31:55 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48dfc17sm1726877b3a.64.2026.03.06.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 02:31:54 -0800 (PST)
Message-ID: <aa97748a-cf72-464c-98f6-11d792551aba@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 16:01:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
 <20260217-d3cold-v2-4-89b322864043@oss.qualcomm.com>
 <to6p7yf2oo5qh37hsye4zpputrc7p4bwgqvjc2plieuyapjdhp@7xshxghi4tzd>
 <313d2262-56e4-49b0-8455-2b46d0966976@oss.qualcomm.com>
 <ksd4ogzz2o5uuwnkvq6yzcwm3zsxiaeuotdj6aiqrew7jqrwl4@g3wcnqhviqwq>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ksd4ogzz2o5uuwnkvq6yzcwm3zsxiaeuotdj6aiqrew7jqrwl4@g3wcnqhviqwq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q3tsWBVm47oQwakl_KYGp9BTKOLsgCFe
X-Proofpoint-ORIG-GUID: q3tsWBVm47oQwakl_KYGp9BTKOLsgCFe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMCBTYWx0ZWRfX7f3aOM8KTZj8
 PTigUh4NRuNsSarMKZJHdOw/NYEUJ7ZUaFkenLc9JQ/RulWzVAhbiMFQz9TImv2aREwdoNg/jkj
 V3KBt0DcQxejCKiGh1Q4WP11BL2ZTiJEz1L4YeOSJ5+07gxnkxyRmJVjZboMIAVrYayQ+xfNXzU
 7LHJy2njYisGC1h9G58R+orCz7PBtgNjOj0ienhyf/cRScdFof8THNDWaTaLKDRLTFbL27hIb2x
 yiudycUzB7WzW6+KHaxqv+5icm5yZJk4wCz1xw3C71xI2sI4SVm+6croamiQDYiS1E79XXLzHgA
 3t5yuDJLsPFFmmroRKh0jQ782kKbQ2WcUn1ZAWvtrtquPs7T8jshz2pFMRpxjQlG0rbPjfdQ8sD
 ohTGOOjEu47sVoKI7ubI86fTkS7C82gDs7Qh6CJTEaXtjpPBdRncHHufjfJbbntaSrrToetaejn
 Lg+mG4ltI4xr+nn3Ilg==
X-Authority-Analysis: v=2.4 cv=XKg9iAhE c=1 sm=1 tr=0 ts=69aaad1c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uIgEQj9WjdynuVTCvEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060100



On 3/5/2026 2:48 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 05, 2026 at 02:26:22PM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 3/5/2026 1:19 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Feb 17, 2026 at 04:49:09PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Some Qcom PCIe controller variants bring the PHY out of test power-down
>>>> (PHY_TEST_PWR_DOWN) during init. When the link is later transitioned
>>>> towards D3cold and the driver disables PCIe clocks and/or regulators
>>>> without explicitly re-asserting PHY_TEST_PWR_DOWN, the PHY can remain
>>>> partially powered, leading to avoidable power leakage.
>>>>
>>>> Update the init-path comments to reflect that PARF_PHY_CTRL is used to
>>>> power the PHY on. Also, for controller revisions that enable PHY power
>>>> in init (2.3.2, 2.3.3, 2.7.0 and 2.9.0), explicitly power the PHY down
>>>> via PARF_PHY_CTRL in the deinit path before disabling clocks/regulators.
>>>>
>>>> This ensures the PHY is put into a defined low-power state prior to
>>>> removing its supplies, preventing leakage when entering D3cold.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++++++++---
>>>>    1 file changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 2c4dc7134e006d3530a809f1bcc1a6488d4632ad..b02c19bbdf2ea5db252c2a0281a569bb3a0cc497 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -513,7 +513,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
>>>>    	u32 val;
>>>>    	int ret;
>>>> -	/* enable PCIe clocks and resets */
>>>> +	/* PHY power ON */
>>> This comment is confusing since we already have phy_power_on() API. What does
>>> really happen in the 'test power down' case?
>> QCOM PCIe controller wrapper has way to force the entire PHY into lowest
>> power
>> state by turning everything off, without this bit being cleared the phy will
>> not be
>> powered on even after phy_power_on(), we can think this as a kind of switch
>> from the controller side to power on phy.
>>
> We never cared to set/clear this bit so far. So I'm assuming that if we simply
> set it during init, it will not do any harm and allow the PHY to fully power
> down itself when phy_power_off() is called?
we are already doing set/clear of this bit, its not newly introduced 
one, I am
updating the  comment  to correctly reflect hw behaviour. PHY power on 
looks little
confusing I will update the commet to "Force PHY out of lowest mode".

- Krishna Chaitanya.
> - Mani
>

