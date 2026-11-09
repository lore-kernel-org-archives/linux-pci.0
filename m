Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234586;
	b=xuEMJFX9po0oiNn1CQuI6Rn7J7CSjmtZtrszAO0i7/1pDJTe8iKyY8X9SectbGS+jmTi
	 kElaY+wbT39QV7ebqxoHK3Y61mPt9+bUudIkOryGLCOJf/voF5kSa7/25dMNBchcg1eB0
	 AmmoX/Z4eddR8Uhir7di6k7nPex5IgfwyXCbXGFC7Z0nA/nuKBSrBWZG/zwDZLUbZrata
	 PESZlYggpVDIbTbiQideXIjRJY2U2JQd7u0gx7hAq0IwakzoImKdscDcykJS4xAELEzPw
	 sXEcRU46y6oiZpasoqBw6r1O0efVCG23LoIkZd0PDr2zrNvY8IDgG8YjzKjrbiBhdDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234586;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=S7KDZcKU/Io5XgxBPImwgDSYRzpyHFK91x9pGyphsAM=;
	b=cKBNGnLL8v/rBQ5RwCigSEMcSWc8XkJP+PICFg/40LRvUoPLuTMTscWBOM8/NDpJNMUD
	 DKlMAdvMxrJyGFmtqWUxIOIxsFuuCbL2vN56vKBcet3A2QoZZrUOm83qG0I1JZtgwiA3W
	 Jm5j7oFoRePT169HTDJCRddnNS0jii8yicc7HLSM2jm/o7h9M/O0KISaBZ/ro5tjfuXGs
	 lV4VwE2wxARPvUWD8TOZF47IhrW5vJevEoPxjvbcHuTnY2Z0DlqwimZCZO+RumlalYqSO
	 j1bb1sa0AWorAFOYZaVEeOVYSYP9V37h9VIC44tzXvLgv4oaBzQCVN85Q7VnMOHwcdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hsUSmamq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dt0m4BWO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C4606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 14:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hsUSmamq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dt0m4BWO
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFJJ3022951
	for <linux-pci@vger.kernel.org>; Mon, 9 Nov 2026 14:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7KDZcKU/Io5XgxBPImwgDSYRzpyHFK91x9pGyphsAM=; b=hsUSmamqp+4mG1SE
	KUW3SAIjEc099jEXwvCQNZqDxsS3vQvHCjIM+5B3BoN7z7sqS7O7QrgeV88ZoJTh
	mjt+RbmGUPGbyQGVrx+LoWEJuhY+eDxW8H7C3p4T+C55dPaQH0Z6d7ZimAalRx3q
	BOF0MZB6HkO8jSfTK0Ra40Z6nvrkckSC9pa3mIFiYUS79qzRsS+2gqDcdYk80C07
	/qLRjX7YjRhwcuTFP7yTF33rjKenqqsila2AURcFh0f2/poJv+Efmqvznmu9YSdj
	v3MwHvujMgKbY0uKlOEDvlQCWK5VOPUg9Jje2gA6hpT4usmLQWJruPJXdSVohW1r
	7fQ3og==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydgqhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 14:29:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d2c5352d1eso30760137.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794234584; x=1794839384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7KDZcKU/Io5XgxBPImwgDSYRzpyHFK91x9pGyphsAM=;
        b=Dt0m4BWOe/YA8aELwuFjAOZYBdspZ/NqbhMD0bGx5OqwsgF1LlOETgnxpMwWWrtBgz
         EaJ6b1z1eWAhB5b6IMW5rRQr7/APE+fWQ0VD9wv+0+6/EQ09hb+fzFNuYtP4FpnrycLY
         Ca4XO9lP5tCGbp9QAd99+1AVeyHf4BpzoDXK7aWOay7BEtPmkR0860tmW2y4w8AQBblS
         pp8kM4VRlo8doJV8O99GBxm8k1cnIB9QXQq6l1/XaPudPY1qSQXKQvL11S+o/A78XvSu
         yBfOweXbKKECepekZMOrZ2WK/8IXnbzP4Arz5WTodrX6NpBIgtcmC+tkqW3+/nvdKCrs
         lWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234584; x=1794839384;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7KDZcKU/Io5XgxBPImwgDSYRzpyHFK91x9pGyphsAM=;
        b=WyZExny/HCWGDhFIBSe05KbgI26ScXZ4k0y0+tz/VwTCatfFy9SxS2XGrz07k2gZNE
         OVtsWrUQAlYfduA9aea3cToe1jrCmzn7+Je0yN2Mz3SIH1zvsJX+D7FT6pnEZWLvnhAB
         asmEXBVT6+z9m7I4RCahTJjw2Y9qYO12I2sRXmSgz/Oalg0xwED2dMcmzXv4+/CWlLXd
         gCpT2/3+MJNxm6qqTiJkLtyhE7vcFHGttcNdcz98/2CjDYMoCzBy8bI3prpP38M8hoR9
         FAwH3nLGEFUaLqbaoBOVmvYq1qjbWto0HsxwNyw81C7vIrk1yEWdmHfCgrzWW3kbulko
         EsgA==
X-Gm-Message-State: APuU4Z8iO5qtVXQbok1y4v/gq2sonIRGWDuvtuU7G9E4s1s4ZlJcSv+X
	ROUVCUOpSvoQrw/2ldulgSj9QElfwNxS4IUKNYsFFFpeOLt3n7lw1KRNZK/JBZ1HZFHYuU2TOmH
	ed3wLGmQEDfRq6F4W6Ife8Bofy3kGPXR+exTHJHla0OWQbRfzPk+4I8da5BKSgVU=
X-Gm-Gg: AYBFou1DJCYNnM1N1vdzJwzRvDsZFKQavkfiYtjjsHNCVwq6hUSCwZFjULOWUkfs9mr
	oNA3aCCTa6jo3PVnBlKpLHTLSZsEFla1Ab0WNN615+c9EUgFy9NyLK1ijebEbW6Dcgyan6XiR5H
	DKgN9cyWDPCnxJRuKEoPGDxj32yBVAa8HbSEXP+eWrHJ8V7iqrmwhUhvqjducImAPca5jQLqVny
	0DyAcvYIOPR3hQaeCDh7Ewt2Jo5lJh/xF2sgDvy8I5cEJcSZqNfZ4yukoQO3fm6Bsp+FoQboTSh
	b+M4JXKeOtTDhXDLFkHlgnbpE4esG44urp6JKDNRMhhRSkC+wVo/aD11pS1gQAlTUfI0eD8HIkR
	IjZNpHLU6CrZsyS6JV42qStaMlx3ipeuo/86FwP+9PnpVmWrX2VlwLr0DOZBewsC7f7y4EQ==
X-Received: by 2002:a05:6122:360d:b0:5e0:2ba:5a06 with SMTP id 71dfb90a1353d-5ece737a062mr963293e0c.4.1794234583851;
        Mon, 09 Nov 2026 06:29:43 -0800 (PST)
X-Received: by 2002:a05:6122:360d:b0:5e0:2ba:5a06 with SMTP id 71dfb90a1353d-5ece737a062mr963286e0c.4.1794234583423;
        Mon, 09 Nov 2026 06:29:43 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a47515dsm173047166b.44.2026.11.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:29:42 -0800 (PST)
Message-ID: <fd8b69b2-5487-4e99-a45e-d6c2ce9ae1f1@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 15:29:40 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] PCI: qcom: Implement shutdown() callback
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX5fzykaW+8xLG
 yipsXlLAbBkC5C0RU04G4FNqoYA+Xx8TXUDSuHDNJ9rPoEBsP93Mxm+mEpq1M3EVVXJK3rBj8iW
 9BL9lnvjSOr3ILvJx0c3ZPG72dUKSUk=
X-Proofpoint-GUID: 9DATnvSizQeDoc2ZtuRYixdtIfZ_Z4Vc
X-Proofpoint-ORIG-GUID: 9DATnvSizQeDoc2ZtuRYixdtIfZ_Z4Vc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX156Xf9s2F+ky
 rO8GEjsyJKPbUOdHespxVaC88eN/hGy2MP2TvEoyIpnbOnZGfwAWoU23f5GGMwD9aeZWUO84tEr
 72BZD9a49hGg9R7y/aCEUCyZ4vm7Lr+vPpE45f8BSJU3lCBd5iHraAPCQs+Kc8OAfskRuviCAbi
 Pfczkk5ZELorKH76/jhfkY7wrobEcfzHZxw3jxGIC0/Bx/YUXfc4a04TJOjoYflRB3IjnZcfWKF
 BYZ+iEpkeVxjBslP+0fpAyx7wJ1VjxL7AGwv9dbXHDaeQNt1DhTZBAg2uf1ak36jVwkgdWcbUkt
 tZzOQKEAc7mCY2y8wOO8GExbw+66htD75/w92yqHIMqGD52zR0rtXYgOef8P85zIucL0/V1l+T4
 SZ9ixtNQHBZ6a1gyIu011nXJUVAlLVe8YIhCnnkXb4SG6/pkQdPc6UP25Gr1ONKfoL5yw9ZK/Jl
 x8y9cjpcEwM68XdLiFg==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af1d8d8 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mifKogskm1HCQoUnOUEA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090057

On 11/7/26 2:45 AM, Krishna Chaitanya Chundru wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> PCIe host controllers should bring the link down cleanly before system
> shutdown/reboot proceeds to remove power/clocks from the controller.
> Without this, the link may still be up and endpoints still have
> transactions in flight when power/clocks are cut, which can trip SMMU
> translation faults or NoC protocol errors.
> 
> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
> into L2, putting it into D3cold.
> 
> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
> link and clocks/PHY, since a late/spurious interrupt could otherwise
> reach a handler that touches now-unclocked PARF/DBI registers. Use
> dw_pcie_mask_msi() rather than dw_pcie_free_msi() so the MSI IRQ domain
> and the MSI mappings held by downstream devices (which device_shutdown()
> does not remove) are left intact.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d39753f0e724..c5b06db3b92a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2046,6 +2046,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
>  
>  	dw_pcie_msi_init(pp);
>  
> +	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
> +	platform_set_drvdata(to_platform_device(dev), pci);
> +
>  	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>  }
>  
> @@ -2466,6 +2469,43 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
> +	struct qcom_pcie *pcie = NULL;
> +	struct dw_pcie *pci;
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> +		/*
> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> +		 * still need to be masked off before shutdown proceeds.
> +		 */
> +		pci = platform_get_drvdata(pdev);

Revisiting my older comment, we can still stash `pci` in drvdata regardless
of the flavor and do `struct qcom_pcie *pcie = to_qcom_pcie(pci);` in
places where we need it

Konrad

> +	} else {
> +		pcie = platform_get_drvdata(pdev);
> +		pci = pcie->pci;
> +
> +		if (pcie->global_irq)
> +			disable_irq(pcie->global_irq);
> +	}
> +
> +	if (pci->pp.use_imsi_rx)
> +		dw_pcie_mask_msi(&pci->pp);
> +
> +	/*
> +	 * In firmware-managed mode 'pcie' stays NULL and firmware owns the
> +	 * link/clock teardown. Otherwise, skip if the controller is already
> +	 * suspended (e.g. a prior resume failed), since dw_pcie_suspend_noirq()
> +	 * would touch DBI registers with clocks/interconnects already off.
> +	 */
> +	if (pcie && !pcie->pci->suspended)
> +		dw_pcie_suspend_noirq(pcie->pci, true);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
>  static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie;
> @@ -2657,5 +2697,6 @@ static struct platform_driver qcom_pcie_driver = {
>  		.pm = &qcom_pcie_pm_ops,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> +	.shutdown = qcom_pcie_shutdown,
>  };
>  builtin_platform_driver(qcom_pcie_driver);
> 
