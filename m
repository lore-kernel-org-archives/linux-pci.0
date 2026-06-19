Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCF1F4181
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845221; cv=none; b=bsJthn8GEEbBQLu4ekE/AvI6U7vQefPLkCA5sC6kaqnjIDbLeEGHP7f7W1HNFqCGXLY/5mKYEc0LUo6nbj7uYq0LOEtjAqODTzuO/7u3CNpyW6cVHBuUBHx8TQOgV4NSSkwkJjScEyNPLWkP+umKpt7dwezmDTQ0l5ktVIv6agY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845221; c=relaxed/simple;
	bh=JrEE1G0VUJr48rydrwc5cx26KVF485AtW5fQEIMh6yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQDuFHUbjJw7oqShEED3GewyPmEhGdmuUpbMKBXmIeigFuMMR6n1ouJgTGW3kcMW0ipcAPbEZ/491GJKbokOXLre1icoJdQVfXTJWK3klGKeJ5OHdvboPykQUUXa3jV2Z3nJlOTUpvQQCQpxDR1LU79zR1dcpnxTbA0tLXaV8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XdZVve4x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpCpDXrb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdZVve4x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpCpDXrb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2tkt3527737
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 05:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbWfbP8zOvWzwTkX5u+oI/cT928jr6o9nUUfDkalaCU=; b=XdZVve4x0Txwr9ho
	eo6eABVK0Rvu13cNOZsk5Urgv6GoKsROYpTby+bJsaRhQduM/WJw0+1h1z2FlzQA
	SFy6aDEIxSSDsH7bZOOUCdsAuCS/H4C+U0MvNcAlbZ32eUZYGGkaO5fp/vTHTuJf
	gGgKUSMI1NLcmuyEM4nZHNUU+zui3me0ZIqCCbolZYkTAp0AW/uRtWsOi7yWZj1g
	NwYXXpvanQbTaC58xxnB4d9nP9VRrLoR6QrCWCUvWq09UGAGnQ0r75G5qmZealgn
	CbFswDbFQHzpH/m11jNhFfG0euxCvBmsd0UMNJQoCsL+mLLU1TwQsffkHkqSWKiK
	h8LNFg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evgtmkf1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 05:00:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f544944so1192086b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781845219; x=1782450019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbWfbP8zOvWzwTkX5u+oI/cT928jr6o9nUUfDkalaCU=;
        b=YpCpDXrbTH2t5rYfn+x4nfe8/s6hB+JIRQu80f+jllZ0S87upnCNHJBVyMdRmTUXPP
         gNnPlpxCFvkgkRi6VRtP1Q3EgvqEJ70b0WXlKsTYzfhsDHBkZmneDPzCwcrOAUHH0E6L
         5La9YregxYYLeCZcMJx0aYzghjw5KI+jTWqJTdldBKH+pfG9bLG5E05zvmIjVtnTZ6St
         ptASZ+X451C/mHhDwibfnqMGd5oLi8vQD65y6oJOsBXlpz1mY4Pqarfzpjr7QgUdAxLq
         bJUS/y7tXjwnd6SPJNqoI1G8jwiQcJ3P1r2LXEV+b9b2UnCN7nVzvuLz9B9PtcKbyML/
         HMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781845219; x=1782450019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbWfbP8zOvWzwTkX5u+oI/cT928jr6o9nUUfDkalaCU=;
        b=D9lpXLZ+ir7d7d3unfbGZYWez5KaAN4yqAn9iBzmZUktmhhE5tiGHjXRwx0/IcZDNf
         y9fsHgJiAThI0MminY9//0YJyCbaf8fytY+5LtDFF4ijdgL+91kf42UipxTLYFRSOORl
         bHJZon1YMLzb9/jSoTFkxkqdK6eOrg6D6SRySArUjrtUiIziePyFmiBtgnnnyt3qIhFy
         dnsd25NlLLKhv3zz8ZACtxnYOv3OT9IeQZfKnL/S+kOF1M5lm1KwuRFg+r+BXShhP+MU
         BaMb7IHhN2gwReS4T9NPI8mhxd6uNo/4t8cbsBqBmVvacQrbIiikfyDwwG0mJqPDmoWP
         aRKA==
X-Forwarded-Encrypted: i=1; AFNElJ+eNhcld3wxGG2FlkHVK+pU/1VCGSlzNiM9zXmbGQ54W6tTztUfYS5sM9D1EwlixDCJ2BlD8u58A1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyN8C/ndqIMqXdmXWk0XiIdKGIp5NzQlZRJZpe2WBObVJYN5zu
	aog3h9/cXc4IDRJjcIe4Gr4ABe2qARnOeuyoiph4TrYodoY1PXDZd1qHNLnZNIWJbFFdmJR1cAw
	jWuhINDLPZjvHiBwwc966xoaLctC495vS4DfEdjAjYpV300q4DV3fFZanXxCdq5g=
X-Gm-Gg: AfdE7cnA0UQWdizMS9VXddGSuEB6Hi3OExbjkuDAThbbSXrY//pzIpRpVdIUZKshjeD
	GKntedh2Sx6gmLoUBYkTx2TERoxFkqW83nMKg5CStqrOfwPL39RePxRhwC4ALpJiOvEs1ZvEcvE
	+oOhhhvRrPmDeiH3iYPHiTdwqB4sqk3QjGOs62htJTmLwKnQ9tNcJzPXJoUIT22Pmewf71C2RuF
	C8M1HpwcCwmxwLlH8kv15DiK+jsbCpfYqUGgpEULRU29Ql1JFHX5UL0IUg2rGnzOV2Ka4PkvKjs
	cxcXHD/qUYUMBmh7OIkBcwd2AHZ7FaDsT0ojzs9UYURQIqv1R4CGD8o6mMHt0swty/nQbjrYF4O
	4hCtbZVKIqtGDmmLlCRVufTdh9ZbCcVDR4HyhvRhiiyO4
X-Received: by 2002:a05:6a00:b42:b0:845:313c:d6c2 with SMTP id d2e1a72fcca58-8455089ecc1mr2002765b3a.31.1781845218714;
        Thu, 18 Jun 2026 22:00:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:b42:b0:845:313c:d6c2 with SMTP id d2e1a72fcca58-8455089ecc1mr2002673b3a.31.1781845218036;
        Thu, 18 Jun 2026 22:00:18 -0700 (PDT)
Received: from [10.92.198.124] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537ff8fasm872324b3a.31.2026.06.18.22.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 22:00:17 -0700 (PDT)
Message-ID: <6fc15f93-9ad1-4009-954b-37a96c021536@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 10:30:11 +0530
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
X-Proofpoint-GUID: RJwROIaeRHvq3GA8sGwekcSda5b95_Vm
X-Proofpoint-ORIG-GUID: RJwROIaeRHvq3GA8sGwekcSda5b95_Vm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA0MiBTYWx0ZWRfXz6H/rXxWNFYM
 Wf67HnzoCWd9rPuPH0XweD/ELUFjd9nglZFEuL8HrvLxsoF8TX/nDkCzLuhVcGgirHIv7qpwBna
 oyknlaOkZRKrvkmw2JSw1P4wlGRZAyhtBK9q5jiLYmE6ZppGNX0WR3bUwDZi/8+jOdupdS6Xfy4
 Z1WIsbyXnEl/hVemp5P4Tfquw/Ol8Cn8nSXhWbRNEHtdVtPpzo896xUoHZETkNYtCvRiXDy1nna
 sdhh4cGK8zogZdWgh0PxnexAySL1xQ847GimO1V6mKRc/e+n42zPaWjJ/zJL7epxvaCGTXb5YoR
 Fef25fbRFpdQAY5Ruplo6QH1IBhVFMUnQgB2TDNTpw3UJkLRfRws7BKT+NYPArb7FB+C//+rhO2
 diSo+zE25hmZgy7rtT/UU5CAhxjuw0XIkepurZ9ExQbl8nagXcoh60EeQ/qGRWyD2Cbx1lN496/
 mpkCAObqdRt7BCS0ciA==
X-Authority-Analysis: v=2.4 cv=Qb9WeMbv c=1 sm=1 tr=0 ts=6a34cce3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Zlw8WEmqWycuYniGgb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA0MiBTYWx0ZWRfXyidgiGodqmmc
 H2bWZdhmOwIhRqR/3q2K8v+wUwT3PDbWGJYmiJNIwYCmFf68E/LrzgjKHvOHY4kIsHenRzdGxLV
 aHr78OgmfPNO9grXeoVCiH0kPUkm2ww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190042



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
sorry for the miss, it should be speed < pci->max_link_speed same for width
check also it should be width < pci->num_lanes I will correct it next version.
- Krishna Chaitanya.
>> +			return false;
>> +
>> +		if (pci->num_lanes > 0 && width > pci->num_lanes)
>> +			return false;
> Similarly, this should be ==
>
> Konrad

