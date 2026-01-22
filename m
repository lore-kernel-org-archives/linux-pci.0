Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6A33033F
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072167; cv=none; b=dZdFgVUWFpaZ4AWR6dIAt/XtjHgfKTmuweuTewa88ArKeHT6rHy0LfavXUIiYuQK5223LZUhou/C1ikjjd1WsGCrE/hX2c6CxHd+ghJE6HBj+4w9YQH76zHJ8HvPc9joP7eoJQRu/rnEoT0+xksY6FGhFsyly6rAlOztocV16Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072167; c=relaxed/simple;
	bh=sxrjrgW8WH6NV27QNQemzOWuFTjAyb0azFThgsqhkWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyIWlDsDIFn0mmEZGxVs9FJgWYEsiheo33qNAyyRt3o7QZnhBe+kCyibWb4DWh4NXmZD0ug+BbMVFecvpRxlJCJRkkAb1APtH7nZyqngFqu9DjDQoVpHCP4dZSyWJBd1CocGPIMqaRGa+lEaIpzjjXkcODblD2cMSJRzZm3UJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=As8jBQuo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SU9TGydc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="As8jBQuo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SU9TGydc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6rdVe724842
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XI2H5e56tHmM8b5yVgBxgJ1Fc1KtkdHABVn4ocaEfcQ=; b=As8jBQuo3bb4Ttla
	XHIc66frrAQOaZwxtx2wRqTuOM8yeKKqO7/2jFx9HOqjiA5a1nXhDkB9PcWz4+Di
	EdyplU+SdRednlWk/CmIiOP1vfK3wJTgNB/Te8ZXXLxYW/+tjo0DI2rPg5/WUgU9
	cxGdgNHCfCJnKptcUeoedNdy9KGgvskTuv84wBo/yCb8ICkKfqoOICaqrECP5nJR
	Mnza+GGcBVUmwnEJCIp4vNZJVPzjUcou88HFKq5wNweka2i6VqmXgbJOgCgbQeC5
	6gnbBkf4pXs+oBc7pUM4tHyK2VRpxo49UWVr/P8dkQNo/Xw+8+V26PlsYMzuGIf+
	mNE07w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buf1bgbd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:56:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7dd05696910so555116b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769072162; x=1769676962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XI2H5e56tHmM8b5yVgBxgJ1Fc1KtkdHABVn4ocaEfcQ=;
        b=SU9TGydcqvV0mMtgB4SNR3fpaVnJvrriELNPulYeC02ScWnpJvwL+IiW4bnWaxnDuj
         0oZMbB2RnxZWXwU2YqsDEnn/Fb5Cw6qqNXuwLqCSJBPmte9iaKoIF57n2uBnW5vKKElc
         Y6JaDUrf/uy5eZA8UqgFiW9PqbA6BkYy2I9YqF/Dr6A35CNQn5hYrPFndvvfQrr4m9H2
         5TIEtctcJrX8H1dqbaRMZftGpzrBlp2THkpu3wLNmPTPURxV9GypdbQ6n+JiwobUficF
         lWLdtG8MMaEYQS2pPWnR3KukbK0Pd9zMYZSoE+IV2tpPcPI6OO8p/am65Qy5IBCvOV3w
         ct/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072162; x=1769676962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI2H5e56tHmM8b5yVgBxgJ1Fc1KtkdHABVn4ocaEfcQ=;
        b=XyW/30VT4O8h+1RkEoYiVGkcl4bfl6hsT2gN6Th28C1/G6rDujh9iUTzv78x8UW/sz
         eXcU/zbTQXeQzHciVDjoYe8PviEntNjG6V0D/vIeZBRopnnGttLM60kUaesDpYiurWOI
         DaHNSCjivul8/CNAeJzn4mThAYdOmKnWXHx/N2h9ccuBMbbMxUF9NucDiz8rhGk6E+Gk
         DZ7vZYnf1flNaK6tPPCvKAa6ylKcCkXXeoKGrm2gTLggqTBRm0jCOvw/yDcsjyFJCQdQ
         yPxJoxafws9qPrklYzl9Se1VtZnCXlFMrqB/f447gxw1loV0GHFnK++mdx1PLL0N7GCo
         FL1g==
X-Forwarded-Encrypted: i=1; AJvYcCW6HhLq/Q7umefXMItNdwmCnC+Yuzf/lW8iUh29FuP1KA8dsQiy4J8URCGxnRAXmFsPnhUTmWtX8tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hYv5uIEvJID823zhcfew1LbRH7B4iQ/3mwKbxOKQIKffYr9A
	aU1BFEDfmqJ99wair3GEBCxj+pQpkwT5SVzHw+43N9UVdJfpfmBP6eRxHSbAivFXBaa99w89UGo
	z83pYU8Fs49W6ISg9yPEA8i0bN7NgpUDzUjIYFPKug4Ak/n/uHBCSXEaw4N4ezME=
X-Gm-Gg: AZuq6aJf6R/3vcgwteOX/0jfmoecTaU6W7na/6Zl7mlDTZZPAG5H9AZU3ikF38u64MM
	nwC4GK+UEaaUhwhGl1hHZg2FJaKwhI76+bMjsCt3PFc/26oDqaN5lkOk1fdPwduafEV8jaLSPwc
	rGcIgtpv7RiO0S/OPZM16PMD6qJciCoq7HNaHYh5DVvZbD7D72tGKR+Q1TgizEQaISzksjncH9C
	1+PNL7HXpH+wZFKRAmlkb3Nyo6TVKfSUCgyAJ4SpfA2AgH8jGCpdjsJASQz/rLgON18q1Yt/nY7
	9J4rg5oObjcfcqhFk+p0b8/WCuiS26093BsJE/iuL3HIe61HlMXZFRFdyhTgyxwjkLB1uYfkvXe
	bS+ibID03fZCA9e3NCcbpeL/viDqbZSu5zsFW93srJA==
X-Received: by 2002:a05:6a00:1804:b0:81f:37b2:5657 with SMTP id d2e1a72fcca58-81f9f6abac6mr16169135b3a.17.1769072162438;
        Thu, 22 Jan 2026 00:56:02 -0800 (PST)
X-Received: by 2002:a05:6a00:1804:b0:81f:37b2:5657 with SMTP id d2e1a72fcca58-81f9f6abac6mr16169123b3a.17.1769072161927;
        Thu, 22 Jan 2026 00:56:01 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51fcsm17343898b3a.68.2026.01.22.00.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 00:56:01 -0800 (PST)
Message-ID: <acbbd966-2406-4b25-baf1-7fd9b5720bc1@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 14:25:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: dwc: Add support for retaining link during host
 init
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109155350.GA546142@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260109155350.GA546142@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FP8XkwoHhaW-k11cjA-OY-QTbo574BDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2MCBTYWx0ZWRfX8ofpcEzI5Bra
 Yhnj05+GSseLO9l7U2hHeG1a6W7CVIx0u6ufDfq+I+w1vUdRCP8hPpbDFJ3I3XIByp0BaHlRsSQ
 NQtXrmGKaPbGNeNI1Gg+yVizLxKyzgE6TN9zbjdq5kRhWCeowfA8h21X4w728BEWzf3BrBDyAJM
 lbErYh61gam4XtnW7nMCc4riZkyczVOvjXZZslsVtXz0gXDHhZroPCegRTXQX9DlB0vNgJYI2Us
 SKRFSaFtaB2d0XMAU6JbL/0Vfpu2e0XVGkjk16GYeX7wRPxyXMZ4gpD0baP23W1iZB8U/D4w0x/
 5MDhWJACO9m1lk146XOrlaR78vB/WJNR3DV4OMHE+hPNnXE9lXaKovN4IwAx5nV1s+IeUfUh3xa
 Bbn0haGtwOlpbpXy2G9KFBHzrL7WMzu64bLFnNVSQM+p4ZXXGA01d17ukjxB80eBhfmzTmCYipr
 MvBGnFRbn7lKTHxiLgQ==
X-Authority-Analysis: v=2.4 cv=G+0R0tk5 c=1 sm=1 tr=0 ts=6971e623 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OE-RsO10cNmVjs9PPLIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: FP8XkwoHhaW-k11cjA-OY-QTbo574BDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220060



On 1/9/2026 9:23 PM, Bjorn Helgaas wrote:
> On Fri, Jan 09, 2026 at 12:51:07PM +0530, Krishna Chaitanya Chundru wrote:
>> Some platforms keep the PCIe link up across bootloader and kernel
>> handoff. In such cases, reinitializing the root complex is unnecessary
>> if the DWC glue drivers wants to retain the PCIe link.
>>
>> Introduce a link_retain flag in struct dw_pcie_rp to indicate that
>> the link should be preserved. When this flag is set by DWC glue drivers,
>> skip dw_pcie_setup_rc() and only initialize MSI, avoiding redundant
>> configuration steps.
> It sounds like this adds an assumption that the bootloader
> initialization is the same as what dw_pcie_setup_rc() would do.  This
> assumption also applies to future changes in dw_pcie_setup_rc().
Yes the bootloader is expected to do everything what dw_pcie_setup_r() 
does.
> It looks like you mention an issue like this in [PATCH 4/5]; DBI & ATU
> base being different than "HLOS" (whatever that is).  This sounds like
> a maintenance issue keeping bootloader and kernel driver assumptions
> synchronized.
As the devicetree changes already pointing to different address from the 
boatloader,
I was trying use this method. As changing device tree properties now 
might not
be good, but no harm in doing so. I can skip this and make device tree 
changes.
> Is there something in dw_pcie_setup_rc() that takes a lot of time or
> forces a link retrain?
I don't think it might not take much time as it is few register writes, 
Just doesn't
want to do redundant register writes which are costly in general.
> You mentioned some clock and GENPD issues in
> the cover letter, but I don't see the connection between those and
> dw_pcie_setup_rc().  If there is a connection, please include it in
> this commit log and include a code comment about why
> dw_pcie_setup_rc() is being skipped.
The clock and GENPD issues have no direct relation ship with 
dw_pcie_setup_r(). we are skipping them as they are redundant. I will 
add a comment in next series on this. - Krishna Chaitanya.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++---
>>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 372207c33a857b4c98572bb1e9b61fa0080bc871..d050df3f22e9507749a8f2fedd4c24fca43fb410 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -655,9 +655,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		goto err_free_msi;
>>   
>> -	ret = dw_pcie_setup_rc(pp);
>> -	if (ret)
>> -		goto err_remove_edma;
>> +	if (!pp->link_retain) {
> Use positive logic if possible (test "pp->link_retain" instead of
> "!pp->link_retain").
>
> I suspect this would be more maintainable if you identified specific
> things *inside* dw_pcie_setup_rc() that need to be skipped, and you
> added tests there.
>
>> +		ret = dw_pcie_setup_rc(pp);
>> +		if (ret)
>> +			goto err_remove_edma;
>> +	} else {
>> +		dw_pcie_msi_init(pp);
>> +	}
>> +
>>   
>>   	if (!dw_pcie_link_up(pci)) {
>>   		ret = dw_pcie_start_link(pci);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 31685951a080456b8834aab2bf79a36c78f46639..8acab751b66a06e8322e027ab55dc0ecfdcf634c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -439,6 +439,7 @@ struct dw_pcie_rp {
>>   	struct pci_config_window *cfg;
>>   	bool			ecam_enabled;
>>   	bool			native_ecam;
>> +	bool			link_retain;
>>   };
>>   
>>   struct dw_pcie_ep_ops {
>>
>> -- 
>> 2.34.1
>>

