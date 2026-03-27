Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDB351C25
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620286; cv=none; b=sgqrDZ1kFe3XR+qFzQvivyt4qBHwX2T3C2K0+58QJ537hAoKyYPWGtnPRYjMS2mHO+raA2gLgEqIlwcq1pU1L5RSGgpBm82UAczrH1YPTdCE77QaL+5hDc951CLDn5u7X+iRIyTOG5xsQMJ+KU2LS9ZPo7/sUYwW8JvQFGuf88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620286; c=relaxed/simple;
	bh=q9V97Tr+6k2fCh537AkmCOo0/qg1EEGC6ygs46eoSNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWH0bVsPQVAeWsg7ejI2Picce3RK4b+OWt9fEh1mLWcLKz20TxPiX7Epa+uh3DqKIxrEuZuXuIB3klq6dNo1JR89eBFaw1jcSjtDO5kLtLexEHrbro8WFJzzs0TrsZ5E1zgg2h8sHeL0F3pCEOXK47aFYNhyxGjsMlJFHxQ9+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oTCSg6E1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTCSg6E1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so25747235e9.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774620283; x=1775225083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnwOxiQgTrY2GQTcPVQdPC36P8UQNWjAuceWpM/pOE8=;
        b=oTCSg6E1R8Drfgc/vnfQmcQJJZ5t4RwdAYzyvKsj2uVb6Q8woIlTPSShPn8E1ni2J/
         bwW532e3faPT1djMherB3fiU6V0SHnuTpAF1NSdl2fLyeKv1LGdG2h2BOzGj0XfPEYxZ
         WwbzKxXFtaovCGEQXSp/9/D3ebskF2IWVKZFwNThkRP8pi4v2kaYccrBfCe3FPMTRuRP
         6EIU/zy+QI4BlCtX5Dk4fDUtaQbxgmqoO5oQP5dpUiZzPvsinCPTxeQBdbxvVA9JPgKc
         6bN1tRPevSRHVWvh22pnXzthftR5j5igXSIMKm+WamfFDVFgiuCZlZDUcQ4gxt9lybma
         LKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620283; x=1775225083;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnwOxiQgTrY2GQTcPVQdPC36P8UQNWjAuceWpM/pOE8=;
        b=D+8GUFBSodlIGSiIaLYUFJr+kAr2efXPlZd5+xE/xemNKtu9vSSGoP6DaTaY/ONPOF
         DcNLi/5EbjWsgbj+kgQQfZBwMOthLch2O4cOFsJ37zZlWFQiDrEmg7G+sTMhumut1Ksb
         glawrIOswQZe4mtakxzwoq2N3wImc0ELDiFTIYUCI+QbC4ebZFFzjaBB+Lhml8HLzpwp
         YgkRYLQeGp+n0VN5VB3SvOiJFSLSLkbtOkaBKCKuwWJ/+mpiys5P3lxCoaA7l11xSfq/
         tqoE148ES6C1m3TyH7KIeE8EgsPbfmEVZOapT0pXpVzkg9mzGM2uRre9B16exDbCESI7
         rfyQ==
X-Gm-Message-State: AOJu0Yw5DsTetnu15y+h0QBvBPARdTBspEubmfTuhMB8TFwdn2YGl8i7
	BycZ5mnGVjU9fupr7A3Q3ZI/+mtYzP5ik1puCMSuC8Kv9uer6h2VmRKcOawl96xqeAw=
X-Gm-Gg: ATEYQzzLe5dKVC4YIphoq8Tng5V4IguowgcTBrgRJeaUOCraTwILLDvWrnUh/oVM7z+
	4C+rNX9+splEd2NYy5xrLHlU16VFm1vZM/XxGwSOgZD6fOK28RP5c2V9/lUPQ2VSTNhyimCRr9K
	KVFzYjWA/0zIuA/0u/jW1Mxn9WPBZwvaaMH3Yhfe0BhDqyIDDoEsPa8Mj0aJRx5R7N8O84ePcRb
	3pdSfze94pxRmQWnnoWvPJ0kCmBrVFrj5gRXpCzpSql3Xl+walKV60KuPjTnt0kTITRJRxJ7JOF
	PpDqKL5CQfJ/b+vSAGeYuhjxHFysRk0M40NvmUxLfPn9WyITde8gqI3znBVOHQEnkmTUV7oswzd
	i3xYX1TMyhA7UMu9ibPvD1fYOi0649xpPR754RSWvgE3C1etGqJyTv1tA+LDEVH1bjNZYw2GUS2
	Pm7R4eThGNYx482y0I4ItAjOyFyogXP8AwGQ/6gkr2I1RXmR+Fw9AtdBLxTZb+C9HRdMmytpXhy
	44D+gSmm1P3zt9m0LQxQLk=
X-Received: by 2002:a05:600c:3f16:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-48727c86862mr44979375e9.0.1774620283136;
        Fri, 27 Mar 2026 07:04:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:81c2:60b3:ff00:9a5e? ([2a01:e0a:106d:1080:81c2:60b3:ff00:9a5e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb5417sm27114795e9.3.2026.03.27.07.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 07:04:42 -0700 (PDT)
Message-ID: <7d9675e6-3f02-49e8-b65a-9785d5b6a7c7@linaro.org>
Date: Fri, 27 Mar 2026 15:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: dwc: Add multi-port controller support
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@Amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Greentime Hu <greentime.hu@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Chuanhua Lei <lchuanhua@maxlinear.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260305-dt-parser-v2-0-85836db8dc06@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260305-dt-parser-v2-0-85836db8dc06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/03/2026 à 07:20, Sumit Kumar a écrit :
> This series adds support for multi-port PCIe controllers in the DesignWare
> driver. Currently, the driver only supports a single Root Port with
> controller-level properties, which doesn't work for multi-port controllers
> where each port may have different configurations.
> 
> This series introduces a per-port structure and parsing API that allows
> each Root Port to be configured independently via pcie@N child nodes in
> device tree, while maintaining backward compatibility with existing
> single-port bindings.
> 
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix error code preservation in dw_pcie_resume_noirq() to return actual
>    error from dw_pcie_wait_for_link() instead of hardcoded -ETIMEDOUT (Mani).
> - Initialize ret variable to -ENOENT in dw_pcie_parse_root_ports() (Mani).
> - dw_pcie_host_init(): Remove -ENOENT error skipping to make parsing
>    failures fatal for now, add TODO comment about making properties
>    optional later (Mani).
> - Link to v1: https://lore.kernel.org/r/20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com
> 
> ---
> Sumit Kumar (2):
>        PCI: API changes for multi-port controller support
>        PCI: dwc: Add multi-port controller support
> 
>   drivers/pci/controller/dwc/pci-exynos.c           |   4 +-
>   drivers/pci/controller/dwc/pci-imx6.c             |  15 +-
>   drivers/pci/controller/dwc/pci-meson.c            |   1 -
>   drivers/pci/controller/dwc/pcie-designware-host.c | 175 ++++++++++++++++++----
>   drivers/pci/controller/dwc/pcie-designware.c      |  32 ++--
>   drivers/pci/controller/dwc/pcie-designware.h      |  17 ++-
>   drivers/pci/controller/dwc/pcie-fu740.c           |   6 +-
>   drivers/pci/controller/dwc/pcie-intel-gw.c        |  13 +-
>   drivers/pci/controller/dwc/pcie-qcom-common.c     |   5 +-
>   drivers/pci/controller/dwc/pcie-qcom-ep.c         |   4 +-
>   drivers/pci/controller/dwc/pcie-qcom.c            |   4 +-
>   drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  13 +-
>   drivers/pci/controller/dwc/pcie-spear13xx.c       |   5 +-
>   drivers/pci/controller/dwc/pcie-tegra194.c        |   4 +-
>   drivers/pci/of.c                                  |   6 +-
>   drivers/pci/pci.h                                 |   2 +
>   16 files changed, 232 insertions(+), 74 deletions(-)
> ---
> base-commit: 097a6c336d0080725c626fda118ecfec448acd0f
> change-id: 20251010-dt-parser-98b50ce18fc1
> 
> Best regards,

Tested on meson-pci (boot log https://gitlab.com/amlogic-foss/abcd-linux-test/-/jobs/13677061036)

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # On Bananapi M2S

Thanks,
Neil
