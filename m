Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5E313272
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253780; cv=none; b=rWEf9+zO9DFKJl00lE+8tJ/bRufb+SjHem+RVpIAiu62/o5zwJ+8Im9jIcTsJKpeXA+OQlKUT9D7JYRKjmNQ0y3ikVJkgcoh4Z9WkPsq4gM9EDUuBFWxn+HuBWj5RajMPOJN7TYQNb3ngiExbsTpA64ohLxfW2HmJdoMrpOBjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253780; c=relaxed/simple;
	bh=khjyDN2uhks3lEh5BWoTr1Hhk9opwtupB9YuYrs0yyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmLbzRDu9yXVqB55BijJawfgAet3pNqFubVACX3UR8NBV6/FcUQ5YWrwgbJ2iozTMWDHSxIVB6Va3yjT1SRnkOOiZSedwtVwtlJSYyxyDjjzXG5YtPLNT5vR9LET62KICC69twZoZS5MKxBG/TnNHPucXEMNNzpt6XQ/hxmkZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aOv0twFC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1CgWYTX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aOv0twFC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1CgWYTX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GARVqd3022652
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQWX3UQlIYFi0a7jRaznYPVGKQGU63wx8fL8q+mXUUo=; b=aOv0twFCc5RXC3DR
	x7C4GzqgPXwfHb3wPEvhSjU6l+NsxJlNRA4kXaPRCcS57nvTj3F6HiDKlJCl+C31
	qdSvNCKXmpUeJtTjvs5d/K4WkbGSaKJqMyouhZaGruZfXbwGVyAotidcpwufao86
	Qg6NSw2QM0Fo4RT8fJ8PcmRtNLsFLfNJpIKUdMGTB5ZpwpZHCBxCwPPoPcfBlp+T
	ZyhPIKC7RvSkF+Dk7Xq0Tcuq2gWZCMt5anhmWjN0aVVg8OT6deGbkwWg2TE3LmRU
	UBW+x7Uy/ZcfGuXxHJErKZMXk1t4O3UnabJI3VZ96zDLGjz4CW8CPQ8vEl3Kta5M
	Ek8yHA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cah4smuya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:56:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506a633ce06so26424791cf.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771253777; x=1771858577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQWX3UQlIYFi0a7jRaznYPVGKQGU63wx8fL8q+mXUUo=;
        b=f1CgWYTXnmPZ6Z5sPF1thtYbkP0xJCEp565B95AeV3LLCOs0AI4IFRwCWo/hwLgnP6
         fdU7QGzlirXugYkBYiZw5DjA1eM97B/ShebKQzCZOjJx5qXqJn8VAMOLlkiG10lwp+m3
         +ZdHzUDtgaVi7cUbxGaShPm812djwXgUAUBFeEVMtPUKuyEKKa7oaWHNe/J7JeQQ6YF1
         77Cox6+4RrIPcZdM+BUTI5wMuSw9n95LOROW7xRFY+uf912gPDFiUng/dvUv8yuk2mDj
         uOH3gU1r5bZuD+62BjNA5uDLl6397hfDGRjrxxgHOnhQ0U9qK8+9O4TSebVK8boFt0u6
         c9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771253777; x=1771858577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQWX3UQlIYFi0a7jRaznYPVGKQGU63wx8fL8q+mXUUo=;
        b=hbJER22HLggLTbh76qXzbcQnOeqyPyBv2T+2KexLEYlxlVv/LEOzDStiYvb2EbILY+
         43I2Zyaz4Y48FmQMIM7colqVAIn9Kt30bcCCmrAjAae2W6TofA2tMkFbEAUqtWZ0CjIQ
         oRX/UMXtBwKGBebEsSNTuw0uNNCOSgD921BgTcGF9ss3sWcVTXFWDLwEaMRXjq8e9WoQ
         E9VwOc2eF/UM7x/BrhGSjFYHQ/sT30/xnv1+/sx8mMW9cwTImc/HvBV36iV3OIn5l6Yo
         SHV3ZN/HKx/44plcXD08sRBXOO0vyN1NgvBxl1U1WPXqbtOTq+wsye+a/b/mYg2hDrUH
         UBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcW1I4E9YpfpzGDmKIvu/ah+eyfwuogjAtAb+SGLx3pqaWEPnNhn6wuNNQb5QkKQIbLLUOehHSTa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOskSGejwFy/Fa1sh5OCHM5PlRIBBfShKAbmWcXzWkbK8IxA2
	RnXUrOc9JT8w1Eexk77yI1l3rwpLn+YCbX9Ia1jUmfJw49kCXwVrMsIcQM1e64hRqOwslTcWmrZ
	qDEpouaqT+kK8jgF1YtmPo8ZInitFlFyMffxsKNfVU6Jz2BQGdfFJRfcsczH0GvY=
X-Gm-Gg: AZuq6aJaPCQNktCC7Sp10wMCuE/+0AYFv+Dfch0XuQW9MEspkdzE8xyPfv1MWMnSulm
	7QT/vu2b3l/9nQcIZ7TAeRbBsJw4DGkxee1GNdjmJfL/t0YZ73VPzj5LPLyHhrZHwDHyrOfDpMc
	RLTDY4zJjBLFPF3Bdy/X3LV548wnNkgbgMgbV+KchWMpxDLQOk5CAHPKYYnVSrZln+XRvTQc2dM
	Rp7uJzO3s8Awve/OoksZtkJS2nNozahgXVzLBqsdGR8rhNzcQY47oRe2ys0rKJ9T2p7af0+hxRt
	LE5Mt/zFVzGPvYYLIthdYiHPiK88r0Hdde446BQ0HgweIWnDLGzZNgg67CdVa/1HJsb6fEpyvEO
	qVxlaoOmQGgJDPC9zLdcePsXIrQnbBS6smvFbZJohWh0evLDfywHaikTPS9hBR9hd7eUnnyYKMo
	gqHU0=
X-Received: by 2002:a05:622a:1109:b0:502:a1bb:632a with SMTP id d75a77b69052e-506a666cea5mr115892621cf.0.1771253777218;
        Mon, 16 Feb 2026 06:56:17 -0800 (PST)
X-Received: by 2002:a05:622a:1109:b0:502:a1bb:632a with SMTP id d75a77b69052e-506a666cea5mr115892171cf.0.1771253776687;
        Mon, 16 Feb 2026 06:56:16 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56a476sm3269353e87.32.2026.02.16.06.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:56:16 -0800 (PST)
Message-ID: <49540c43-894b-4d4c-8c46-4fe09d649729@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 15:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
To: Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
 <nmle3y6nb4kjcwstzqxkqzaokeyjoegg6lxtmji57kxwh5snxa@p76v6dr7rgsg>
 <53f0c45f-7f5c-4abd-af84-cbb82d509872@linaro.org>
 <cvxvq7f2ku6aq5gbbqav42ckqk2raesbxq2bx46mxvapcza5v4@5zuyjdtn5us2>
 <aaqqdz2ssnetfgtybuerjfnkgr7r22xj2whaawaqhgm4y2ygom@jtkn5z2nw7aq>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aaqqdz2ssnetfgtybuerjfnkgr7r22xj2whaawaqhgm4y2ygom@jtkn5z2nw7aq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyNyBTYWx0ZWRfX+K0B4Mh1tHIC
 yGfx76x9FcUB2dFtb9iMIgR+Kl7icJn3BU4+7zgelaqepQl2haofCMn7+U2XOXBaMNZjMTVJFfO
 eHzVfRt4/lYEV+FZG2fKb9IpC6ZyNV6J+dH2q7lGxT9tSPEoWvNv11xWDo+zMf2GJ5YaDEp3t+4
 mhROJnM18VMji3NNLKbRQ7sxvMKYgkOfrpHABt598IEjFVYBu5AN8s7Ph6udRzTuJ321sHgdQhQ
 G1s5DGQVVSj3VaqFQpXiFAFWv6zDOzRta2cjXMYmv9la0W5HOXM4eq+8K/wUtd+YLToLBzDbAI3
 ngB8PB8ZDejq6af3nkbH2qfahv0V3FXO0B0cQtk+PN3lryFBawLk3KBMrWxZZJjStTj4WVimtT0
 NS5wfjGZas914dd4+974Mx/k7cvbff7xWvy6P2BzvY3pt7XhvWS0HqAnQTY6BWqrLAd/8GtZqdn
 brawbQjgVlzEcFJMWaA==
X-Proofpoint-GUID: B_heSJpjLzdMCV4Uafanht0NKcoad_E3
X-Proofpoint-ORIG-GUID: B_heSJpjLzdMCV4Uafanht0NKcoad_E3
X-Authority-Analysis: v=2.4 cv=EbXFgfmC c=1 sm=1 tr=0 ts=69933011 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gjtn7LuX9S0b4PncKSUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160127

On 2/16/26 3:53 PM, Manivannan Sadhasivam wrote:
> On Fri, Jan 09, 2026 at 04:03:37PM +0200, Dmitry Baryshkov wrote:
>> On Fri, Jan 09, 2026 at 02:10:49PM +0100, Neil Armstrong wrote:
>>> On 1/9/26 14:08, Dmitry Baryshkov wrote:
>>>> On Fri, Jan 09, 2026 at 12:51:06PM +0530, Krishna Chaitanya Chundru wrote:
>>>>> If the bootloader has already powered up the PCIe PHY, doing a full
>>>>> reset and waiting for it to come up again slows down boot time.
>>>>
>>>> How big is the delay caused by it?
>>>>
>>>>>
>>>>> Add a check for PHY status and skip the reset steps when the PHY is
>>>>> already active. In this case, only enable the required resources during
>>>>> power-on. This works alongside the existing logic that skips the init
>>>>> sequence.
>>>>
>>>> Can we end up in a state where the bootloader has mis-setup the link? Or
>>>> the link going bad because of any glitch during the bootup?
>>>
>>> Good question, can we add a module parameter to force a full reset of the PHY in case
>>> the bootloader is buggy ?
>>
>> I'd suggest a simpler thing: if the reset was skipped, reset the PHY in
>> case of an error and retry. That's also one of the reasons why I asked
>> for skip_reset not to be the persistent value.
>>
> 
> I'm not sure what value would resetting the PHY provide in the case of failure.
> As per this patch, skip_reset is only going to be set for platforms where
> bootloader has already configured the PHY. So in the case of PHY link failure,
> simply resetting the PHY won't help IMO as the PHY register contents are going
> to be presistent due to nocsr_reset.

We can pull the not-nocsr_reset though?

Konrad
