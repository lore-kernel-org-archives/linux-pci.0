Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FA43CEFE
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611733; cv=none; b=oCvvp9APIkO9vgfJF0OGBXdNgIeau6N9bJzgCh8IJdgCeeHENqP35N4yJG7D1H6ArQGdnOuT/frksDqdt6Eqi/OnMnzAf/2VB/WCOSEQABvfFnRjYINfBHwSet3p/ST7hPiItAJ8lqP63G5nkbmgCt4n7Y0l7ScKG16lxBZDDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611733; c=relaxed/simple;
	bh=IZhPK19RPTep8vCR/iI+/ZRMbR2540jS3A13ZDFXbZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4MeOnRtMZQpsCccMcvKeAifUCIfy9VxtfIgebcQLXynchJPStKuMTLfzOYp4ZstC9cuzUf6GLHC36zn0d3iwalXGCpxLUvJrFF+M6G7dt7zlUp11Y/4z5E9GTbSkG4KE9JYlvUhnY+E18RorPCBc5bg7qJszSF3BgP/6F6nr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8HHmZ5I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZOrN++EM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8HHmZ5I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZOrN++EM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GACI113411110
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 12:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5sjHg+ZVqRUaGbwJbPdqwnI/I306Wmg8va8QLePtTBs=; b=B8HHmZ5IdwTV2kJz
	4l2F3g1PRU5YhbVq0YDrzIxCRcZaZZrwsmffOiSZuJXUTyfFCFEMERP/bIR09is/
	UIr2GCm1b0Sp5+9jJZuXjSPgLRDcY4NWR+VcRE397Z/rwv8sjzRVT7i+Ryni39zo
	UmEOrtcMK3ZZ9d9FfGzUpKJHt5DUC+3l23O6NjuROVTeu6QAq90LKXIxwlPxc+aw
	OV2EsNWXO5bBBhf5DDqTkpxwsgOTbvNcgweQqVsGgJGR/XUv1v+heQl6PW67kfhC
	Kh5M9N2qG4S4tjEEeyAUdE5K6QwCLmzpvTBz+NAYCfhbchq97NOVvihpPsMj9sUr
	SFV5qw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09g9npg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 12:08:51 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59e239895baso300861e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781611731; x=1782216531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sjHg+ZVqRUaGbwJbPdqwnI/I306Wmg8va8QLePtTBs=;
        b=ZOrN++EMXcbZHMsdL6bOZxaPAO2Gj2Bpo8EHK0PXWfOM+cWENkftUOnP7Xk2k+VMTr
         FwCaeVJnmZYVk3xASmINtIfm2ltZZFTd3USJSdXqmJF0ijzWdiv/zVL8+QhPqVTWG+Gt
         Cv2dvx1gA8YGIHHxZuqD8MsFVrcLc6Sun2z8c9BjuoczAQov+RWOr02wNr0Sm6GLBwuH
         qseLNSHagAvCsY3GJT58aTLlBSLATFb3aQBEOLDCm20BqAQPOGpC94E6Q+c97poNvW25
         ZzVP0WQlEhsqJUdSEZVafxpAGz9zfgIjZ43Gaw5GKR8ZnPl52QPD1+6BUZnL3p2NrPcf
         alMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611731; x=1782216531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sjHg+ZVqRUaGbwJbPdqwnI/I306Wmg8va8QLePtTBs=;
        b=dR6HDKDKmMbtq9Xtn8wdJtR0ydovfHUKpE8xh1AIQJj19USSwd/s9R/MatMXKExrpG
         tHdf3hzo3onywELZFf/rkOFwub6EoNmN4CA9p8B896q3SSwxEf141uXpYeewQsFYHHmj
         fufMJ7w/dP90IkPK66C1w+ZQBDJ0/QJ9QLHZ3onXsZ1mKNvrzmirH332lkdtAWVgJxw0
         TNEAL7CUkEn8dZ6PWCB8B6DbhsG8Avrs92CO0WZW3V7eaL/zb5N9SeqdpSA7Aak9l7qf
         Qery4q39naJyJ07Ms/SFuJku1wrapELbvrEoT84JR8Q59I5rj79mFYZsluT2aXSpz34K
         WoeA==
X-Forwarded-Encrypted: i=1; AFNElJ8J9uwa09dE2gqRX1iU0aGKVn/bP280KTU6jYXOq/0hF5iiISl/2cyETOwLs7061CCy0poXGhNoQFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRShgGXjfQ8ip+RRMzWlYDADwaNFMNpoGLAIqkMcj/MeqOilz
	KoxUzrjwUq7tq1Ol8xwrkymx0UI6Gy+GcvsqWyVKKy05EO3NQSFw0il2YKgi8X+U1RiHeL3n+Kz
	lYD9pDS5d5B3zOePu/kzlUHGrrS49gZppms4poZsmccoIPNpez6A63qTCym8XweE=
X-Gm-Gg: Acq92OGMJjEeNS+6ZRXSuNBA+iND/HVae/DqJDoKN/t9XOdqnbijYRsXjUMwcWMJi5j
	r5LEuYHwheHtQgwQToQdHYLJWU5IC5f4CuqKgCrmo0FaTV7q1BRY2hYU1Zl79g+iehukViJW1dp
	NrTUhEM/32Lj4XQJucRCioex223rbchGQ+bARVOY1ZmhUpVADtLGVVbJ/d31a4R+4Tx9B705g4z
	37WGQXxyn+CWjEsgGAUKfrlqV9Jz5Z1dF5eejycm3ptY4KcgoSIir1eqLv56Pm1h9TBXZdTgyYe
	gUoKMyZ4y6Lfh9X+kAPR6hRZItkGc4TFcDYQEj0aEmF+pHpLH7PBeM4A1qa4PJry7o3NAWiPWHd
	+OFuXYZ16s1cSiVK3L880aNDXq9Qzfzo+EnvGFx2ZeXFJ5g==
X-Received: by 2002:a05:6102:442a:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-71e88b61ae5mr2830983137.1.1781611730613;
        Tue, 16 Jun 2026 05:08:50 -0700 (PDT)
X-Received: by 2002:a05:6102:442a:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-71e88b61ae5mr2830875137.1.1781611727381;
        Tue, 16 Jun 2026 05:08:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01ee8286c9sm350078966b.5.2026.06.16.05.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:08:46 -0700 (PDT)
Message-ID: <8bb365dc-25b4-4fe3-8ad9-1f110bad2417@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: qcom: Add link retention support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260521-link_retain-v2-3-08ed448b081c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNCBTYWx0ZWRfX4Z7c6zsj5JaH
 9MVxqcY3QTROoXcppJETgdRjGx4cojGFe3VpZxvnlp18ZfGRS3DbLnGAaOaQB1LcFL1sga0yTj/
 K8KRwr8Ky4RIOyLq/+vrUc0a4/6NQndiGy9znGUxwuMfDKSMVV+t3bP8mQlyH7JNoEjNvyhZa4d
 nwAZZMUBcV3ugst8IEQ5tS+RE1OAX8sQU0lj1oGaYkAHZYs469tWv6q8HOKW8S/2qJ+Tq4Y4EX/
 wzWAF8HwRqSb85EaZ4cADFNIrWF69AdI96h//3zvhF9RV5WixGepjRPbqgBS9B0dWMjsaqtTTbh
 /PB9yXXawDc17MeLTcfpoYlcs7hafBnAhZ1HzTHiZNDGo+HxSI6dJVjnCpx4jvLC4EdbTEZhWXD
 Y6bZ4FwR3TpEYHb+5hxVSOQWBVH4mWp03DBYrDtLCTe9ASXQP2RNhNPuqg6fwtPkkm0c3W01Dbm
 T+McQDyBQy4pLnt6Jpw==
X-Proofpoint-ORIG-GUID: _j3pSnbedZ2xb4FgX1k_Y5RRuhNKARo0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNCBTYWx0ZWRfXwZW7c4xFjXal
 saUigtVmvavtNIxXXOIKUUkrX/dY8dciWKCGzN6zTSXA7K+4R42ZywUga7J2gpzRGZuVAgUyqyh
 JcoKnaJMpBoJmjBcEpgmETQ2XEYjBQA=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a313cd3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pjaUC6Pc4IK-3t1tjCkA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: _j3pSnbedZ2xb4FgX1k_Y5RRuhNKARo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160124

On 5/21/26 2:56 PM, Krishna Chaitanya Chundru wrote:
> Some platforms keep the PCIe link active across bootloader and kernel
> handoff. Reinitializing the controller and toggling PERST# in such cases is
> unnecessary when the driver does not need to retrain the link.
> 
> Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to indicate when
> link retention is supported. During initialization, check the LTSSM state;
> if the link is already in L0 or L1 idle and LTSSM is enabled, set
> link_retain and skip controller reset, PERST# toggling, and other post-
> init steps.
> 
> If the current link speed or lane width does not satisfy the constraints
> specified by max-link-speed or num-lanes in the device tree, fall back to
> normal initialization and retrain the link instead of retaining it.
> 
> Configure the DBI and ATU base addresses in the retention path, since the
> bootloader may use different base addresses than those provided by the
> device tree.
> 
> Also fix the -EPROBE_DEFER error handling path to return 0 instead of
> propagating the error, avoiding unnecessary cleanup when probe deferral is
> requested.
> 
> Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 62 +++++++++++++++++++++++++---
>  2 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 3e69ef60165b..be6c4abf31e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -450,6 +450,7 @@ struct dw_pcie_rp {
>  	bool			ecam_enabled;
>  	bool			native_ecam;
>  	bool                    skip_l23_ready;
> +	bool			link_retain;
>  };
>  
>  struct dw_pcie_ep_ops {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index bfe873cbf44f..b061eaa227b3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -253,12 +253,14 @@ struct qcom_pcie_ops {
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
>    * @firmware_managed: Set if the Root Complex is firmware managed
> +  * @link_retain: Set if controller supports retaining link from bootloader
>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool link_retain;
>  };
>  
>  struct qcom_pcie_perst {
> @@ -960,6 +962,42 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +/*
> + * Determine whether the link established by the bootloader can be reused.
> + *
> + * Reuse the existing link only if its current speed and lane count match
> + * the max-link-speed and num-lanes specified in Device Tree; otherwise,
> + * retrain the link.
> + */
> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
> +{
> +	u32 cap, speed, val, ltssm, width;
> +	struct dw_pcie *pci = pcie->pci;
> +	u8 offset;
> +
> +	val = readl(pcie->parf + PARF_LTSSM);
> +	ltssm = val & 0x1f;
> +	if ((val & LTSSM_EN) &&
> +	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
> +		qcom_pcie_configure_dbi_atu_base(pcie);
> +
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		width = dw_pcie_link_get_max_link_width(pci);
> +
> +		if (pci->max_link_speed > 0 && speed > pci->max_link_speed)

I think I raised this concern already, but this goes against what
max-link-speed is supposed to do, i.e. this will not retrain the link if
the bootloader had initialized the link to a speed faster than what the
DT requested

> +			return false;
> +
> +		if (pci->num_lanes > 0 && width > pci->num_lanes)
> +			return false;

Similarly, this should be ==

Konrad
