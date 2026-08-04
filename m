Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3162476064
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859878; cv=none; b=E8fweBCbbYOYN8TmfMkNA1d06WX7ffANuyKGH1Ok4pls9QfaWIXvUL3CDALtmEPpHb5sp7V+OnFfxZQGOHyx43Ex3si9MosR2hOPpsDVQvCJMgC/fkztg8ygEKeXV3itdcLHTY9rliTCAWJnIPAeJixbRDGzz8B0avJNzjMyDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859878; c=relaxed/simple;
	bh=ZP3KH57ZR7DYSSfY/GQK1FfefC8tW7EZbiLzIbD9N/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDyln1mRbAbfHrLb6XM52/4zaRicH4K3cflg/PlryWf/czshjNQvvxyBg9fcjqhJIYdLBljGEoLt/e5Fyxeb3HUw7S2jPBzdO9hXdpxl6iEjLZvKcYcU/r2qOAKD+zLJh0+olcMpiqbm+vVi/DDmdNP8kzRBCE6IjmBm8DljzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmAQTP5d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOnlEkYv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmAQTP5d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOnlEkYv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Ffeu21255088
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 16:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	te+2b+J4wuZdOreQbWtcR1gW8u417OS8wKw5ezP58Ho=; b=SmAQTP5dD0nWzWWL
	1uz2PGUclWIcbSaYkWP7qW57fC1YdhdDI0Lz5dAzU1LScvkTt1imsPAB0UOMSw4h
	qWSDkMBCuDX2sIsfcUGhjwNgbkLRPuCtZyJ2m5wU8JDdhtd/UneMb795K5XUPuYp
	czzsppnezT2Jk3SLywqwUpHVqzALCg0vYaK0Q84bzfba/nduWUjdmTaF8+nTNLWg
	lx6tNzTdO7WCmMHK/836euOJUcUpOKXk6P+tgdeEfUa8VD/gfdKaRF7jbfBh8pLv
	GLO9B1Nx/RIzY9jbbSKFOmDLu4pPuTtyxZ1GUsJJ+xpzHvz3qhV4QfZgjt/MUoDW
	ZpXxTg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud1dhwvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 16:11:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so343465ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785859870; x=1786464670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=te+2b+J4wuZdOreQbWtcR1gW8u417OS8wKw5ezP58Ho=;
        b=kOnlEkYv37tli5YpMFyE4a3WrFp29ifhSEWt1Yy6RtxCaqFsy5ar/D+rEivtIyux1H
         xpKl1Hl2Yl+Ssh7nHa0HT6FBCgT0xS3fO3qcTfTK7pi9HhAJVn8FBBH7KLlL0m9SrYLu
         9iCzI4F22ALJPv0xP06I/mblN9bVygDNNugCR6jm5xQoXHS0cVjgOyCJisyzthpV06Np
         WNqotKXeiHrFIk+EQqMdO+zU0uv2l6kp3s3XUtKoIJz0PRQ9L6Q0iuWbB8Cqbxh9Uvaf
         RU96BUMll3ZbEROpAyTE6QJHuJ/ReD41GgP+VqSCydjoTIDB9Qs8s+0K4hyqGvjhXrhD
         z0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859870; x=1786464670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=te+2b+J4wuZdOreQbWtcR1gW8u417OS8wKw5ezP58Ho=;
        b=aNCWZ6BObkYPYvmTNZAassB05EHHw3HFyeaeXGc/pDnN/DaNy6l4jJ3yXutuO2kL+s
         p/iW28IRh1GKX57JAJTR4IPaq3/Tu1ctymY4ggWIdkwv2xBPH1pR5qrWTeHzVhQ5RZgU
         XilsPS5+FK0QOziOkU0QffYUBc73uHFuo3RdDbW/dcMTPMG476GWBawLUGahXAoUg/HR
         Ppivm16H8EyraGbJswAnLTckHPQPkAxST0su7W6I19gHbT1wuKJu33dicHHHnzgo3g4/
         FrqfCBSlryOsMCO5TpJY15Trbd/6z358iQQGJNpU2KzMW6H4ZPXjnoIY/y8UJJULFsjh
         6eZA==
X-Gm-Message-State: AOJu0YxWbT5H1K8KeY3kqLSGsqnNpJmTYy0YDfhrDIDCDf4TkreqM/NZ
	LevrgndITxelMCl2vz/gDTwaBKiyxBj25kW9y2IgSj73g3jjtuoA0/SlR7MOC1uPQfyg8Ls3YkW
	CA4HvsU4NxogoCr1Pkxi+mYemcsWCq7NrrWoxA72k47JA1AJo8Z1fG2iWeZbkWaE=
X-Gm-Gg: AR+sD13akBXdIVW4QiZNiUZB7zmqJQt4oZwRWbJqtXPmiXbhHFvyy1lGDzRThnXFrYr
	+H+q527f65C5WJcP39clp+jdESDldiuyMY/gAm6Uukjb+lEA9BNQUgpjsmRogamu9dX5iFWetWI
	gG5DepJ9/eDtQgF3q9buge/BLjXznKigI2OzeTHVcAW39a8+ErZxdIH8x9VZunJwrgANQPLFX7o
	pAgqVNP1mkKiTEFG7GBL/Cg31zzz1P4IeYroYuFZe4zCxZYUKtFquQ2TaU+9MWzV1oCLovdd+Uy
	c9nCWWHydPYvRvNz3NGDqjNVbQ3+iZXwAVlrtDXLsog93gaG7Y0a9wBoMaPlrhdOWRS0HGlq1If
	Tl85K6/62PDz5u90jckKssWdiC5603ZrdnQ==
X-Received: by 2002:a17:902:cf09:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d0521e90c3mr157918095ad.10.1785859870106;
        Tue, 04 Aug 2026 09:11:10 -0700 (PDT)
X-Received: by 2002:a17:902:cf09:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d0521e90c3mr157917035ad.10.1785859869402;
        Tue, 04 Aug 2026 09:11:09 -0700 (PDT)
Received: from [192.168.29.63] ([49.43.230.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa013dafsm10095525ad.35.2026.08.04.09.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 09:11:08 -0700 (PDT)
Message-ID: <720fd45f-fa5e-4c64-b3a3-05b33004815c@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 21:41:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Add sysfs for local loopback interface
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260803-loopback-v1-1-508f7f19e47a@oss.qualcomm.com>
 <20260803094710.5F1301F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260803094710.5F1301F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z6_fsa2ST8kaNoEjZnt6SELZFav8hvVa
X-Authority-Analysis: v=2.4 cv=SJRykuvH c=1 sm=1 tr=0 ts=6a720f1e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=81uY1gJ5F700u46DBsPqIQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iYw6Kr4hDCYGKP7cAK0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Z6_fsa2ST8kaNoEjZnt6SELZFav8hvVa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyOSBTYWx0ZWRfX7kcBCCTP0s8v
 BRmeQ6gyrSygjB42ifaasTCIs9ZebsloJ8qEyg7HiayKoggOtCQNyReZ2queWxkpqp247jhCSLa
 rm7WtZ/FxPYM2lOV3Ck5sKPlXK0bg+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyOSBTYWx0ZWRfX+Lr0N7cCuIgj
 aVA7GraWQ2DgnNviZ3mzIJ4vB8QbbQrWRKUIOAlYZbFObDnKBTxXoxxzfoe99H/dFYiLWTM3KX4
 WfUhwFHPN2sG2GOuktmrDxKzdfoHnAQfgEgJ/0WfaGVBEHAkz66iZ48ODshU1PpU552O+0vjO+I
 WTn5N2bvt/CBkDxluEIenqVgdxhyyJtixPB5YhToSkZVcuQf/P9XlK5ieC/V6bie/EgKi3wm5IQ
 Kvx+LBgvBPwjR7XXzNNXnY74uub7npThCjM1m2yJc8d3b1shFGWwHXH4Y1dPBVozsO3HiO1Nuq+
 XgJfe0DNAW8MRC7LX/hmjS+ZHTfA4Mpm+HDlBYJc5rHaVZGoOeNFSpS6BoZG/4yVsFTA4JmKw17
 CfxKB+lFNVtxIjzaBpLyAw4o+enbpRECfQcGBE6sDk4+kSkP88+9FKjmW94JnetrcQ8CpA3+D5S
 97bGT9mMoNeP9SqKJ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040129



On 8/3/2026 3:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential issue(s) to consider:
> - [Critical] `pcibios_align_resource` is used as an alignment callback but receives a `struct device *` instead of a `struct pci_dev *`.
> - [High] The inbound iATU is programmed with the CPU physical address instead of the PCIe bus address.
> - [High] Inbound ATU window configuration is overwritten and permanently disabled, silently destroying prior hardware mappings.
> - [High] Hardware recovery via `dw_pcie_resume_noirq()` will unconditionally fail and mask test outcomes.
> - [High] The inbound iATU window programmed for the loopback test is not disabled if the controller requires reinitialization, leaving a hardware mapping to freed memory active.
> - [High] Missing pm_runtime_get_sync() before accessing hardware registers in the sysfs handler.
> - [High] Calling `deinit` and `resume_noirq` during active system operation without blocking concurrent config space accesses will cause a system crash.
> - [Medium] The loopback test uses `kmalloc()` to allocate an arbitrarily large test buffer (up to 1 MiB), which is highly susceptible to allocation failure due to fragmentation.
> - [Medium] TOCTOU race in link status check can cause disruption of an active link.
> --
>
> --- Patch [1]: [PATCH] PCI: dwc: Add sysfs for local loopback interface ---
> commit 4f4d57ae54b60f668971d41c20d2d0f542109200
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> PCI: dwc: Add sysfs for local loopback interface
>
> This patch adds a loopback sysfs interface to trigger a local
> data-integrity test on DesignWare PCIe root ports. It works by allocating
> a DMA buffer, redirecting PCIe writes to it via an inbound iATU window,
> and verifying the data byte-by-byte. It also includes a recovery mechanism
> to handle LTSSM state issues after the test completes.
>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 06722259d2e37..f0cfe9e885204 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> [ ... ]
>
>> @@ -567,6 +569,297 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>  	return 0;
>>  }
>>  
>> +#define DW_PCIE_LB_BUF_SIZE_MIN	SZ_4K
>> +#define DW_PCIE_LB_BUF_SIZE_MAX	SZ_1M
>> +#define DW_PCIE_LB_SETTLE_MS		100
>> +#define DW_PCIE_LB_LTSSM_SETTLE_US	(DW_PCIE_LB_SETTLE_MS * USEC_PER_MSEC)
>> +#define DW_PCIE_LB_LTSSM_POLL_US	1000
>> +
>> +static int dw_pcie_loopback_run(struct dw_pcie_rp *pp, size_t buf_size)
>> +{
>> +	struct resource lb_res = { .name = "pcie-loopback",
>> +				   .flags = IORESOURCE_MEM };
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	enum dw_pcie_ltssm ltssm;
>> +	void __iomem *src_base;
>> +	u32 plc, gen3, pipe_lb;
>> +	dma_addr_t dst_dma;
>> +	void *dst_virt;
>> +	int ret, rret;
>> +	void *tx_buf;
>> +	int ib_index;
>> +
>> +	ib_index = pci->num_ib_windows - 1;
> [Severity: High]
> Does this code safely reserve the inbound ATU window? It seems the index
> is hardcoded to the last available window without checking if it is already
> in use.
>
> If the platform driver or PCIe host core had previously programmed this
> window (for example, to map system RAM for incoming endpoint DMA or to
> route MSI interrupts), could this unconditionally overwrite and permanently
> destroy that configuration?
Ack,  I will create new element to track the number of inbound iatu's used.
>> +
>> +	ret = pci_bus_alloc_resource(pp->bridge->bus, &lb_res,
>> +				     buf_size, buf_size,
>> +				     PCIBIOS_MIN_MEM, 0,
>> +				     pcibios_align_resource,
>> +				     &pp->bridge->dev);
> [Severity: Critical]
> Is the alignment data parameter passed to pci_bus_alloc_resource()
> correct here?
>
> The pcibios_align_resource callback expects a struct pci_dev pointer, but
> &pp->bridge->dev is a struct device pointer. Architecture implementations
> often cast this parameter directly to struct pci_dev and access its fields.
>
> Since struct device is embedded inside struct pci_dev at a non-zero offset,
> could this cause out-of-bounds memory accesses?
ack.
>> +	if (ret) {
>> +		dev_err(pci->dev, "loopback: failed to alloc PCIe MEM resource: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	src_base = ioremap(lb_res.start, buf_size);
>> +	if (!src_base) {
>> +		dev_err(pci->dev, "loopback: ioremap of PCIe source window failed\n");
>> +		ret = -ENOMEM;
>> +		goto err_release_res;
>> +	}
>> +
>> +	dst_virt = dma_alloc_coherent(pci->dev, buf_size, &dst_dma, GFP_KERNEL);
>> +	if (!dst_virt) {
>> +		ret = -ENOMEM;
>> +		goto err_iounmap;
>> +	}
>> +
>> +	ret = dw_pcie_prog_inbound_atu(pci, ib_index, PCIE_TLP_TYPE_MEM_RDWR,
>> +				       dst_dma, lb_res.start, buf_size);
> [Severity: High]
> Does the inbound ATU programming use the correct address space?
>
> pci_bus_alloc_resource() populates lb_res.start with a CPU physical
> address, and this is passed directly to dw_pcie_prog_inbound_atu() as the
> PCIe bus address.
>
> On platforms where the CPU physical address space has an offset from the
> PCIe bus address space (such as those specifying dma-ranges), will the ATU
> expect the wrong address and cause the loopback test to fail?
I will check from dma-ranges perspective and fix it if required.
>
>> +	if (ret) {
>> +		dev_err(pci->dev, "loopback: inbound iATU programming failed: %d\n", ret);
>> +		goto err_free_dma;
>> +	}
>> +
>> +	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>> +
>> +	gen3 = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF,
>> +			   gen3 | GEN3_RELATED_OFF_GEN3_EQ_DISABLE);
>> +
>> +	pipe_lb = dw_pcie_readl_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL);
>> +	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL,
>> +			   pipe_lb | PCIE_PIPE_LOOPBACK_EN);
>> +
>> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc | PORT_LINK_LOOPBACK_EN);
>> +
>> +	msleep(DW_PCIE_LB_SETTLE_MS);
>> +
>> +	tx_buf = kmalloc(buf_size, GFP_KERNEL);
> [Severity: Medium]
> Could this memory allocation fail on systems with fragmented memory?
>
> The loopback test can request a buffer up to 1 MiB via the sysfs attribute,
> which requires an order-8 physically contiguous page block.
>
> Since tx_buf is solely used as a virtual buffer to hold random data before
> copying via memcpy_toio(), would it be more reliable to use kvmalloc() to
> avoid disruptive page allocator warnings?
ack
>> +	if (!tx_buf) {
>> +		ret = -ENOMEM;
>> +		goto err_restore_link;
>> +	}
> [ ... ]
>
>> +err_restore_link:
>> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>> +	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL, pipe_lb);
>> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, gen3);
>> +
>> +	if (read_poll_timeout(dw_pcie_get_ltssm, ltssm,
>> +			      ltssm == DW_PCIE_LTSSM_DETECT_QUIET,
>> +			      DW_PCIE_LB_LTSSM_POLL_US, DW_PCIE_LB_LTSSM_SETTLE_US,
>> +			      false, pci)) {
>> +		/*
>> +		 * LTSSM has been observed stuck outside DETECT_QUIET on some
>> +		 * platforms; only a full controller reinit (mirroring system
>> +		 * suspend/resume) reliably recovers it.
>> +		 */
>> +		dev_warn(pci->dev,
>> +			 "loopback: LTSSM did not settle in DETECT_QUIET (in %s), reinitializing controller\n",
>> +			 dw_pcie_ltssm_status_string(ltssm));
>> +
>> +		if (pp->ops->deinit)
>> +			pp->ops->deinit(pp);
>> +
>> +		pci->suspended = true;
> [Severity: High]
> Does powering down the controller here pose a risk of a system crash?
>
> This recovery runs in a sysfs handler while the rest of the system is fully
> active, without blocking concurrent accesses to the PCIe config space.
>
> If another task attempts a config read (for example, from lspci) while the
> clocks are disabled by the deinit callback, could the unclocked access
> trigger an AXI bus fault?
Will not expect user to do this test and in parallel he will run lspci and also
expects this deinit and reinit happens quickly before axi detects this as a
error.
>> +
>> +		rret = dw_pcie_resume_noirq(pci);
>> +		if (rret) {
>> +			dev_err(pci->dev, "loopback: controller reinit failed: %d\n", rret);
>> +			if (!ret)
>> +				ret = rret;
>> +		}
> [Severity: High]
> Will this hardware recovery unconditionally fail?
>
> The loopback test runs strictly when the PCIe link is down (no endpoint is
> connected). However, dw_pcie_resume_noirq() starts the link and waits for
> it to become UP. Because no endpoint is physically connected, this wait
> will time out and return -ETIMEDOUT.
>
> This seems to overwrite a potentially successful test result with -ETIMEDOUT
> and abandon the controller in a broken, suspended state.
ack 
>> +
>> +		ltssm = dw_pcie_get_ltssm(pci);
>> +	} else {
>> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, ib_index);
>> +	}
>> +
>> +	dev_info(pci->dev, "PCIe LTSSM state after loopback exit: %s\n",
>> +		 dw_pcie_ltssm_status_string(ltssm));
>> +
>> +err_free_dma:
>> +	dma_free_coherent(pci->dev, buf_size, dst_virt, dst_dma);
> [Severity: High]
> Does this leave a hardware mapping to freed memory active?
>
> When the LTSSM poll times out, the code skips the else block containing
> dw_pcie_disable_atu(). Execution falls through to err_free_dma, where
> dma_free_coherent() frees the DMA buffer back to the kernel.
>
> If the link later becomes active, could incoming memory writes from an
> endpoint corrupt kernel memory through the still-active inbound ATU window?
>
> [ ... ]
as part resume_noirq IATU will be cleared.
>> +static ssize_t run_store(struct device *dev,
>> +			 struct device_attribute *attr,
>> +			 const char *buf, size_t count)
>> +{
>> +	struct dw_pcie_loopback *lb =
>> +		container_of(attr, struct dw_pcie_loopback, attr_run);
>> +	struct dw_pcie_rp *pp = lb->pp;
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	size_t buf_size;
>> +	int ret;
>> +
>> +	if (!sysfs_streq(buf, "local"))
>> +		return -EINVAL;
>> +
>> +	if (dw_pcie_link_up(pci)) {
>> +		dev_err(pci->dev,
>> +			"loopback: refusing to run while the link is up\n");
>> +		return -EBUSY;
>> +	}
> [Severity: High]
> Are the power domains and clocks guaranteed to be active here?
>
> The run_store() handler directly checks the link state by reading the
> PCIE_PORT_DEBUG1 MMIO register via dw_pcie_link_up(), and then proceeds
> to modify numerous controller registers in dw_pcie_loopback_run().
>
> Since the test intentionally runs when the link is down, is it possible
> the driver core has runtime-suspended the PCIe controller to save power?
> Accessing MMIO registers without calling pm_runtime_get_sync() first
> could trigger a synchronous bus fault.
>
> [Severity: Medium]
> Is there a race condition between checking the link status and executing
> the test?
>
> The code locklessly checks dw_pcie_link_up() here, and later acquires
> lb->lock and performs sleeping allocations in dw_pcie_loopback_run(),
> such as dma_alloc_coherent() and kmalloc().
>
> If an endpoint is hotplugged or finishes link training during this sleep
> window, the link will transition to the UP state. Will the loopback test
> then blindly overwrite the PCIE_PORT_LINK_CONTROL register, forcefully
> disrupting the newly active link?
User might not do link init and do a hotplug of a devcie.

- Krishna Chaitanya.
>> +
>> +	if (mutex_lock_interruptible(&lb->lock))
>> +		return -ERESTARTSYS;
> [ ... ]
>

