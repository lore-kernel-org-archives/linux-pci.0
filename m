Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=47.251.158.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476631;
	b=NGBgeYoVn7GBVIeN1J3HD2nKnYcPDa4zofuVKt/kPPBqmmUwuYa+wCIB6mF1nXax293W
	 mM7ZISdpKwqT0TmtTS8Daq3uIkQPPwXQrzVnB+Us45DcohCgQ0HIM64zM+DipivK0uqre
	 8nFcBljd+ed3Rbt1oLTGkARKxzV/Z7PHa/PFeLHfAHuH6xYfub02A5uSh4gC6WIKasrsU
	 +/m0jBGa4Cee89ZoZwFc8gxXtUvLkvHn8Nlu/21ccxBDJHSfe8qhj4A4IQ92ujRKq4qwW
	 DHUF4JGb+JxKsggrB5r+if7Fuz4VeS0mC8BBuGtQOQr3WduqWVzpwyk57EnVWI6gOOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476631;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=dfwCW3XzFrA/MwgKr2yXEIAy57FlBEW9MYzAJ88RhlA=;
	b=UTMpGwqiNBdsGlikzZslF1HaOwhi0xD6wSBmJF6ErZPmLXx3Ft7q6F9ggZQEK+Q0WUHd
	 6aBCfJ+mPyIYvpvC2JFS0okq/CGnuyDD6CzZ6A5Cmu3VKyGZJhwXL7fa7OkXdYenXLpFB
	 sWRgsegydYMpWB0iIzEZmO6iCgkZZow4lcRl2QYRlZJNoflZQRIAO/ENRpC45AljXNgba
	 Jx/PyWicJqJirJgTDXMT3Cex9S8L9pYZmRQaKxJYUrtMfYqwUYhNLu3PgX3cD9hoCqf+Z
	 uTFAsIg5twoEzIB5ixTrEzTKxUsnAU3O2WS5VyYuSRahWunvXyg/ih6ltvptQe4kYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Cx5fgsys;
	arc=none smtp.remote-ip=47.251.158.125
Received: from mail-m158125.netease.com (mail-m158125.netease.com [47.251.158.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C9606A31B;
	Tue, 20 Oct 2026 06:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301C9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Cx5fgsys
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 51aa6b3ae;
	Tue, 20 Oct 2026 14:10:16 +0800 (GMT+08:00)
Message-ID: <aa480e97-e8c1-4954-8ed8-9de195030315@rock-chips.com>
Date: Tue, 20 Oct 2026 14:10:15 +0800
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
Cc: shawn.lin@rock-chips.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
To: Xincheng Ji <jixincheng@ultrarisc.com>, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Niklas Cassel <cassel@kernel.org>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Jia Wang <wangjia@ultrarisc.com>
References: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa157ee96d503a4kunma914cf2f9369dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQxodTFYZTU8aGEJMGk
	JJSkJWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Cx5fgsys7xQjmIH6eBkVTO4LlmbYsYmlv5MusFWdD75Ha69b3dRyNyPEXz9NFpgmhMf6hmDEK2/AhuStu3TKsZa/zidtJxv31m9Y6F3p8+gdAMwBzdaeFcNSJ/xRAToTI1tSgOY1EIXzOHs3vl9YMH2aVoW8X05LCxGNM1lme7g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dfwCW3XzFrA/MwgKr2yXEIAy57FlBEW9MYzAJ88RhlA=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/20 星期二 10:37, Xincheng Ji 写道:
> No outbound iATU translation is required when the parent-bus address
> matches the PCI address. This is a DesignWare controller property, not
> an UltraRISC-specific behavior.
> 
> Compare the addresses directly and skip MEM outbound iATU setup when
> they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
> CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
> use outbound iATU windows.
> 

Just make sure there is no regression on my Rockchip platforms, so

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU setup")
> Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000")
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
> ---
> This series follows up on the recently applied MEM outbound iATU support.
> 
> The DesignWare outbound no-match path does not translate addresses. Skip
> MEM outbound iATU programming whenever atu.parent_bus_addr matches
> atu.pci_addr, rather than relying on a driver-specific flag. CFG and I/O
> accesses, as well as non-identity-mapped MEM ranges, continue to use
> outbound iATU windows.
> 
> The UltraRISC DP1000 driver has removed the now-unneeded
> bypass_ob_mem_iatu, and the general DesignWare PCIe host
> code has also dropped bypass_ob_mem_iatu, directly comparing
> the parent bus and PCI addresses before setting up the MEM
> outbound iATU window
> ---
> Changes in v2:
> - Merge patch1 and patch2, because they depend on each other
> - Link to v1: https://patch.msgid.link/20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 17 +++++------------
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 -
>   drivers/pci/controller/dwc/pcie-ultrarisc.c       |  6 ------
>   3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf5ca281e91b..c593a1f1c2e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -918,19 +918,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>   		atu.pci_addr = entry->res->start - entry->offset;
>   
> -		if (pp->bypass_ob_mem_iatu) {
> -			/*
> -			 * The no-match pass-through path preserves the correct
> -			 * PCI address only for identity-mapped MEM ranges.
> -			 */
> -			if (atu.parent_bus_addr != atu.pci_addr) {
> -				dev_err(pci->dev,
> -					"Cannot bypass outbound iATU for non-identity MEM range %pr\n",
> -					entry->res);
> -				return -EINVAL;
> -			}
> +		/*
> +		 * No ATU translation is required when the parent-bus address matches
> +		 * the PCI address. This is a property of the DesignWare controller.
> +		 */
> +		if (atu.parent_bus_addr == atu.pci_addr)
>   			continue;
> -		}
>   
>   		/* Adjust iATU size if MSG TLP region was allocated before */
>   		if (pp->msg_res && pp->msg_res->parent == entry->res)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 799c05213ae3..128729fee607 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -471,7 +471,6 @@ struct dw_pcie_rp {
>   	struct pci_config_window *cfg;
>   	bool			ecam_enabled;
>   	bool			native_ecam;
> -	bool			bypass_ob_mem_iatu;
>   	bool                    skip_l23_ready;
>   	bool			skip_pwrctrl_off;
>   	/* Set if the RC loses power during suspend */
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> index 523f454c6c52..a0d328c0c09b 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
>   
>   	pp = &pci->pp;
>   
> -	/*
> -	 * DP1000 routes MEM transactions without outbound iATU windows, which
> -	 * avoids the 16-window/4GB-per-window aperture limit.
> -	 */
> -	pp->bypass_ob_mem_iatu = true;
> -
>   	platform_set_drvdata(pdev, ultra);
>   
>   	ret = ultrarisc_pcie_init_clks(ultra);
> 
> ---
> base-commit: 0a2602de077462d3111eb9fd3da5b12a57fc6c93
> change-id: 20261015-dw-pci-fix-c8e51f83be02
> 
> Best regards,
> --
> Xincheng Ji <jixincheng@ultrarisc.com>
> 
> 
> 

