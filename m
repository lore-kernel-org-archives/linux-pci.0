Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1D3CD8DE
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579175; cv=none; b=hFsszRe/jYH81OJVqFz1qqBnqj9fQaX1jPQLBiELn+CwW74jhR/AG5B4K3O+d1IM/OfxFzz5b39RLbHYMBX9lVid97cYHLsFyUzQUKbyj+gbJX4yfufp88QMJQN8myI1XGJXbXFcVzlFpWD3eDz8IcE7ykiiCc060KM/yAJ/yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579175; c=relaxed/simple;
	bh=zMcrxCtoqCN6v7GMmrzMgRaRS/Yg5RMN1qKr6ncoVvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hw2J39AddyffnwtjVE7nNW0e0pK9zfdJasbfUytTtn7njqXhy+QraKv/ZKy4wbPolHUAm3WmGCsh17a6M2b+KGJf/qE25vGUdYJP1Yv3ICMJxbGCu/ZhxOTkgttL+2bMQgwaONWyUukJ70eG7ISUd8EtrQ0osjtbNiEcjgRoXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guFIbZ9o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SLh6ffx5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guFIbZ9o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SLh6ffx5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960Hng887963
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 06:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Y5D1mUbwvJ4UlYktwnKee3CyKSTLraYPvFKzyS9cMs=; b=guFIbZ9o6HKLykFn
	C3BfPQCE3uQCJihYV+6Ym6Xmw6QGwCvbgpfVtW1Dof9pbvY5ytM0241vOCFjxGXF
	K/CpOZyk84+EYR65DzhRfv7KVedoOxcZhm83jcfkycewZtD3Vlvf2YND/2MgsJV1
	h+Exq6N1NtS6U/izPibt1g5rW1RAKGxOty15PRvf/tDe2Hgy/BLlx3GWjSNHCL1s
	YbfhmWp4kyaYrRgqHRzIk584wmxSBHsV9U9l6BEwajIyF031EdJhz/7eFombztYC
	1L0Ync/2XtxO8RWSeUPmKhHTxDW3Rh8/Zz0Qo7OKFd/aCcFMJTzfm2Y3p+EzKY2H
	HSh9CQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq3342m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:39:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so33868865ad.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783579170; x=1784183970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Y5D1mUbwvJ4UlYktwnKee3CyKSTLraYPvFKzyS9cMs=;
        b=SLh6ffx5tiMpw4mrRQqOz8iWdzqWgHbycgnscVPeHv4oSWVR/TGKdrUaaejDLh3TfO
         J2EJz4+PNO9hhU02hg6AhzxfDbksXupsCle2/nZfnOTou1KitvD4sPV3OXRnHO+k6tZ+
         DykBpiZPCzPA0bmzK6KbAXY3AzIlEM05z9hgo8X61dARjxn4dB8EXOBVWxpVzWQ+D82W
         pXRtOZjdB1CA5LBAAqPWzDncko8S2fXSTLzMslX35n/Ghv2uGwkF/aLCNOo8LE+y3XMY
         xumcjluqcfwUbq74TmjSQ3pYVTbwa8kvgqTBA9P/+YHM5RG8rAt6kdfV3rJ5Jl4q/Syt
         Z4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579170; x=1784183970;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Y5D1mUbwvJ4UlYktwnKee3CyKSTLraYPvFKzyS9cMs=;
        b=UKj/X+FUTvnBonIZDOMKC4p7OJq6aNFc8oTX4sEKpNp4Vfc7xqtjQMWZZrzXUnFC1M
         XFfOWmhDfbkTNg0GK18thu8HYh0ahg4gnCqcAYQAP2HdeXOS6PMsHKhIPIpll6nMh5XE
         CkPrTZy3YSXAR6bROkC+U6wkVi2YQRz8qQMgDx9pXwI4K+rqFuW4mi6FMycmFk0jmm5H
         wkMrhSBlr2ohVkjOJB4b2QEzmDYeyco7/0AdaMAHvWlWpSvzrdlmqQqKfIuP+MPaqhHL
         BRm8uTheJE+IZKvDsIq9CcG3J1PUD8XybXSJulr0xp69cExQdKXqhoQvwlcjsLHaPmCW
         B1uQ==
X-Forwarded-Encrypted: i=1; AHgh+RoO3176OJji25cmwi/yAGau2CXyigKViEsuJ3mwFc9WNvMgF7jbICHtNCekGZq77FBaZmLczP2WQAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6piEhx+01aL1wK4yE8ZJDJL15Ctl20GvK3A+8Ft32yE/Oxrl
	OnQm+DwSLWh1h6NJpe9LwqocsY2B0+58U6EakMU/nVxw/xRfAcW7Qc017xHkMCJQBivsVBmPvwY
	19QejXEdMW3rt1M1KfnVTEaDn5xhSG4ffrDNREnE7If6X7Km7xJu6eqEj1vzgcVc=
X-Gm-Gg: AfdE7cmShuqXQxmpFwU43glDX/fQBnHqM17gc/gzXLyG3pL8jWZ29hT3+YCk9gM+iA1
	n16nsSdB1uTNuk4ATpaeShiwyNwz81qc62OnvcJJbMLbEXhsh7FQ3HCeYz80RoKWOJ/hWY5snGx
	JuSak+a7l+112XCL1jqwQRu5wWaeaT0W7t3XRBuAtIULjPU20hZyohIhiWSKXKUg716QORWcZ3/
	Dt7MsymQ7Pu+hrm9gRqN8FlFtMtLBtgwHbsjcuXJ8yTbUX761D8xj/3uNkTa9XNcc1NUDmRIkn/
	UNOtsXFqunJWxU2UHe/DIaiai8Ise/vgjoQdbCsGA/uY6rOq0hHCRAqeCw6/E2zscOA23FWeCzQ
	g7MHCINc5tNRR0X+SLSLipdNoKhwrd0Vqlq18tXoBHw0=
X-Received: by 2002:a17:902:fdab:b0:2ca:d666:df72 with SMTP id d9443c01a7336-2ccea39be30mr62231185ad.21.1783579170024;
        Wed, 08 Jul 2026 23:39:30 -0700 (PDT)
X-Received: by 2002:a17:902:fdab:b0:2ca:d666:df72 with SMTP id d9443c01a7336-2ccea39be30mr62230895ad.21.1783579169587;
        Wed, 08 Jul 2026 23:39:29 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdddsm38167755ad.77.2026.07.08.23.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 23:39:29 -0700 (PDT)
Message-ID: <851ffc42-657d-4b26-a47a-7cc713bbe64c@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:09:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: qcom: Add link retention support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
 <20260521-link_retain-v2-3-08ed448b081c@oss.qualcomm.com>
 <8bb365dc-25b4-4fe3-8ad9-1f110bad2417@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <8bb365dc-25b4-4fe3-8ad9-1f110bad2417@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4fLsCFOLghE_9SqrBi4hlncZgW-I3Wpq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MSBTYWx0ZWRfX4bWVUXoogb/k
 fWZMcomJ0jPlvs7BpCGdx/aWn9hrw73xUM19f+MrnXcsrCPTAQWhebECztXf0qxXfqIaQdCxAA7
 HA5ocRGdpwltjxc4lTwYi6rnhYhGBAH1QD8lCxo2DYAhOT1vX4dHRTrDHsXKZ7tJdtcDBmQsqiY
 veHArGIxmxDXHvZlRGPT5YN/PK5QCdgSq/17dELW2epnUJ34ScfV27QwdVtNi222X+aziJWifyQ
 jv6RqxxecwbB3xeHuI6AcJlMRwhRYSCtVm5ejx1GIL/YdGvok821FthTLNS5L2KgK8oOl4xEWTV
 Pwe1DpNcCxdUiBqWqcB4YfCHeDGRZMDWRjwKSlyWqSQTfkHba5pwIvZUBUwt6uObeVV3ccpiXwy
 xVHuit3o/Ju/RgazbKObsypKe09CupG3tmLJZnh8tpQJKz1fzbc367DTKpp38XFfsrByCCd4Cql
 bRlyD+fxhUpOM0tcU+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MSBTYWx0ZWRfX8gdPBgnyLcVR
 gDZ0FbJTdivOH2w7frApZI0gs31Uqjgead1tejgfGLwkLNwNFCrw7O9gIOtywCddLREK40BC5Ch
 fp7MVLShENGqIFAsZXDoQ/BA4fPlfR8=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f4223 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Zlw8WEmqWycuYniGgb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 4fLsCFOLghE_9SqrBi4hlncZgW-I3Wpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090061



On 6/16/2026 5:38 PM, Konrad Dybcio wrote:
> On 5/21/26 2:56 PM, Krishna Chaitanya Chundru wrote:
>> Some platforms keep the PCIe link active across bootloader and kernel
>> handoff. Reinitializing the controller and toggling PERST# in such cases is
>> unnecessary when the driver does not need to retrain the link.
>>
>> Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to indicate when
>> link retention is supported. During initialization, check the LTSSM state;
>> if the link is already in L0 or L1 idle and LTSSM is enabled, set
>> link_retain and skip controller reset, PERST# toggling, and other post-
>> init steps.
>>
>> If the current link speed or lane width does not satisfy the constraints
>> specified by max-link-speed or num-lanes in the device tree, fall back to
>> normal initialization and retrain the link instead of retaining it.
>>
>> Configure the DBI and ATU base addresses in the retention path, since the
>> bootloader may use different base addresses than those provided by the
>> device tree.
>>
>> Also fix the -EPROBE_DEFER error handling path to return 0 instead of
>> propagating the error, avoiding unnecessary cleanup when probe deferral is
>> requested.
>>
>> Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>>  drivers/pci/controller/dwc/pcie-qcom.c       | 62 +++++++++++++++++++++++++---
>>  2 files changed, 58 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 3e69ef60165b..be6c4abf31e8 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -450,6 +450,7 @@ struct dw_pcie_rp {
>>  	bool			ecam_enabled;
>>  	bool			native_ecam;
>>  	bool                    skip_l23_ready;
>> +	bool			link_retain;
>>  };
>>  
>>  struct dw_pcie_ep_ops {
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index bfe873cbf44f..b061eaa227b3 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -253,12 +253,14 @@ struct qcom_pcie_ops {
>>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>>    * snooping
>>    * @firmware_managed: Set if the Root Complex is firmware managed
>> +  * @link_retain: Set if controller supports retaining link from bootloader
>>    */
>>  struct qcom_pcie_cfg {
>>  	const struct qcom_pcie_ops *ops;
>>  	bool override_no_snoop;
>>  	bool firmware_managed;
>>  	bool no_l0s;
>> +	bool link_retain;
>>  };
>>  
>>  struct qcom_pcie_perst {
>> @@ -960,6 +962,42 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Determine whether the link established by the bootloader can be reused.
>> + *
>> + * Reuse the existing link only if its current speed and lane count match
>> + * the max-link-speed and num-lanes specified in Device Tree; otherwise,
>> + * retrain the link.
>> + */
>> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
>> +{
>> +	u32 cap, speed, val, ltssm, width;
>> +	struct dw_pcie *pci = pcie->pci;
>> +	u8 offset;
>> +
>> +	val = readl(pcie->parf + PARF_LTSSM);
>> +	ltssm = val & 0x1f;
>> +	if ((val & LTSSM_EN) &&
>> +	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
>> +		qcom_pcie_configure_dbi_atu_base(pcie);
>> +
>> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> +		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>> +		width = dw_pcie_link_get_max_link_width(pci);
>> +
>> +		if (pci->max_link_speed > 0 && speed > pci->max_link_speed)
> I think I raised this concern already, but this goes against what
> max-link-speed is supposed to do, i.e. this will not retrain the link if
> the bootloader had initialized the link to a speed faster than what the
> DT requested
I had updated the logic in v3 now, 
"The max-link-speed and num-lanes properties in Device Tree cap the link's
    maximum capability. Retrain the link if the controller's max link speed or
    width exceeds the Device Tree cap, unless the currently negotiated speed
    or width is already within that cap, in which case the existing link can
    still be retained"

- Krishna Chaitanya.
>> +			return false;
>> +
>> +		if (pci->num_lanes > 0 && width > pci->num_lanes)
>> +			return false;
> Similarly, this should be ==
>
> Konrad

