Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938E39D6F4
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433936; cv=none; b=bWx9ZNwsu/wFBA/bphhndzDWKfmoVu7NqXLs2u5G4uq+EgRWe66XGnLxYD/8LQryQorWMjLjNQqZ/a/QWmqcJaq+5t2qoEkE0h+hU3q0iOEFoD6pDEfcVqXuvIWgWlU0KowKkPTjxe2kqLO5odyL4nnfOPhzPzCgJQdcbajuZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433936; c=relaxed/simple;
	bh=jsLz9QPCZ657lh+kQV+wCuFG8MjRyfgZqPGbEHb+ODs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASzrpcgg/qbXuMDlUo1t9/labOhKI0hZbMK3hLjaYEWOfGYVOUKDxS32okfaVsT5tiQbda5/2MDj8u7k9PwOBvXNW64OaBtUtq5RXobmKzrcr/uDJUVTkkUkBmqhPtm5CUL50hrSwf6eTJE2IFkRHkfbnZLAZuqKVQuekLU4LD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X6MOycuK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X6MOycuK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb112c09so43736985e9.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774433932; x=1775038732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBzgoYZDjhTKxl6obsy4HR8kQLZOhNu4r9GMkjdheHo=;
        b=X6MOycuK0Czo8l3C17E0su5Vi1Q9pTorLHt4mMpyG5iLbX3EgNMjXvBKYdhJaoongr
         sT3kIqbN3HNCy722gRRgcCuX5LEnTgo0Sy20754VE+ZspFBLPFVVwQ6kjFbNUuLnOIxE
         rbTvCUC28cO8u2Hyh9XxN5NyncfbelQoIcCEB8nd2Tkr0vAQKRzOloO4XH6Y9LKRmMSu
         F1cHTB8+R9KM4/ZTCFDVhfOHhJ6E2DvVzVpkrmkElyk+BREljFFbd1XXpTV6Gpi7gHgi
         x1x3YlxVha7lfOQ/a5F9Nppxi7kuU0lZg5FLkVFbsDQEdXDWWbh31KrOpoyT2SQVKk2+
         qL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433932; x=1775038732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBzgoYZDjhTKxl6obsy4HR8kQLZOhNu4r9GMkjdheHo=;
        b=SrdnTD8Aa22/s/+XCcFDN4B0Y1u03keC1fvfP4pDywJrQ3cqdTEwVNLFNccahVTFEx
         O3P1638aCOxc7joiyAqH9A+L2LtPXnmK8RTGtYDUtGKYAuhq8WMdjyfV5PfGPdN7LeUD
         MyAzH8PHdmDIBNhs7dLV4ddoO+vRBcoy1lL73Rjijm3sFGM/6zCxmy2mX3/UoU0TvOtb
         ET6CM+dM6O4PcQlzCYcd7p0+QITck4opjtlwT+ogkYJA3jRfFXVhEDH2BTKo78KUY4rP
         yYuuTL3099ATOxWPTLY6E6gCqzW6d392jV3ileDeJrohYIgg4LePgsJPQ9DfDjtzuQkA
         Hrxg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1bMVbGrZ5Cl956n8SbZaU6av47nED0epBpCi1I4rXNLatOgPE5sJepWOSB/1pcWntF5StWA8Xws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebP/EBLNyC7m729MI6GmqcX9K4/+apyVFaabCSXJcjuuy7+Gq
	bIQBcafN6Gsvw2oZ/gylFOc493ibPuvfh3+kdhVNqQOzdLtrQEM7g6+MnyzeFjsuNmQ=
X-Gm-Gg: ATEYQzxsjqJeMGgWy5tVk3Lh+MczwD9Fn4hDu0dDLsgmFdmJmPxlHfjwB4kgmOWokCU
	4MfbmZD/QEl7PUM4W4wsRNMil1XTN0vdT0UEy1+ZJsaXVYndU6PPaR9r7YGQ0Et2VfOMHscvTr6
	452uaIlGldVbH5QSDp9h4Gm+C5xcgZKSCHSEYQzFh4VkOv4yBWRvzOyRelVlw3XpNFA1I8T/fb4
	ZGTkwc+sH56/w+BJCOk8zknJMeGCZ6G78bfsJYtF0H8Cg3GdbMJN2M8KO/82PkGJZaCt7E63PEr
	AVQHIqEkHpdg/xmeC6TRE2vYI4wwW8eoRof3t3/z4JVMilkYtILzQu26WbQwvSlBDpYc0NQ77VC
	QWutCDdvt9QU6Bjarl+Vrbr0DjhYKO5ZhPztfYDdI0/Fk0HCtjURzygHGQ0CQPWtxPfA+VN7Bpc
	CihATu9tLtFZfjxvwgyUvpMT7ODwU5UeQ=
X-Received: by 2002:a05:600c:5296:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4871605bdffmr43328175e9.25.1774433931616;
        Wed, 25 Mar 2026 03:18:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871736befbsm16244365e9.25.2026.03.25.03.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:18:51 -0700 (PDT)
Message-ID: <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev>
Date: Wed, 25 Mar 2026 12:18:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 3/18/26 14:44, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-host
> driver.
> 
> The RZ/V2H(P) SoC features two independent PCIe channels that share
> physical lanes. The hardware supports two configuration modes: single
> x4 mode where one controller uses all four lanes, or dual x2 mode
> where both controllers use two lanes each.
> 
> Introduce configure_lanes() function pointer to configure the PCIe
> lanes based on the number of channels enabled. Implement
> rzv2h_pcie_configure_lanes() to detect the active PCIe channels at
> boot time and program the lane mode via the system controller using
> the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 142 +++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index a629e861bbd0..d1bf1e750d9b 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -179,6 +179,16 @@
>   /* Timeouts experimentally determined */
>   #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
>   
> +/**
> + * enum rzg3s_sysc_link_mode - PCIe link configuration modes
> + * @RZG3S_SYSC_LINK_MODE_SINGLE_X4: Single port with x4 lanes
> + * @RZG3S_SYSC_LINK_MODE_DUAL_X2: Dual ports with x2 lanes each
> + */
> +enum rzg3s_sysc_link_mode {
> +	RZG3S_SYSC_LINK_MODE_SINGLE_X4 = 1,
> +	RZG3S_SYSC_LINK_MODE_DUAL_X2 = 3,
> +};
> +
>   /**
>    * struct rzg3s_sysc_function - System Controller function descriptor
>    * @offset: Register offset from the System Controller base address
> @@ -194,12 +204,14 @@ struct rzg3s_sysc_function {
>    * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
>    * @RZG3S_SYSC_FUNC_ID_L1_ALLOW: L1 allow SYSC function ID
>    * @RZG3S_SYSC_FUNC_ID_MODE: Mode SYSC function ID
> + * @RZG3S_SYSC_FUNC_ID_LINK_MASTER: Link master SYSC function ID
>    * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
>    */
>   enum rzg3s_sysc_func_id {
>   	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
>   	RZG3S_SYSC_FUNC_ID_L1_ALLOW,
>   	RZG3S_SYSC_FUNC_ID_MODE,
> +	RZG3S_SYSC_FUNC_ID_LINK_MASTER,
>   	RZG3S_SYSC_FUNC_ID_MAX,
>   };
>   
> @@ -261,6 +273,7 @@ struct rzg3s_pcie_host;
>    * @config_pre_init: Optional callback for SoC-specific pre-configuration
>    * @config_post_init: Callback for SoC-specific post-configuration
>    * @config_deinit: Callback for SoC-specific de-initialization
> + * @setup_lanes: Callback for setting up the number of lanes
>    * @power_resets: array with the resets that need to be de-asserted after
>    *                power-on
>    * @cfg_resets: array with the resets that need to be de-asserted after
> @@ -268,17 +281,20 @@ struct rzg3s_pcie_host;
>    * @sysc_info: System Controller info for each PCIe channel
>    * @num_power_resets: number of power resets
>    * @num_cfg_resets: number of configuration resets
> + * @num_channels: number of PCIe channels
>    */
>   struct rzg3s_pcie_soc_data {
>   	int (*init_phy)(struct rzg3s_pcie_host *host);
>   	void (*config_pre_init)(struct rzg3s_pcie_host *host);
>   	int (*config_post_init)(struct rzg3s_pcie_host *host);
>   	int (*config_deinit)(struct rzg3s_pcie_host *host);
> +	int (*setup_lanes)(struct rzg3s_pcie_host *host);
>   	const char * const *power_resets;
>   	const char * const *cfg_resets;
>   	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CHANNEL_ID_MAX];
>   	u8 num_power_resets;
>   	u8 num_cfg_resets;
> +	u8 num_channels;
>   };
>   
>   /**
> @@ -309,6 +325,7 @@ struct rzg3s_pcie_port {
>    * @intx_irqs: INTx interrupts
>    * @max_link_speed: maximum supported link speed
>    * @channel_id: PCIe channel identifier, used for System Controller access
> + * @num_lanes: The number of lanes
>    */
>   struct rzg3s_pcie_host {
>   	void __iomem *axi;
> @@ -325,6 +342,7 @@ struct rzg3s_pcie_host {
>   	int intx_irqs[PCI_NUM_INTX];
>   	int max_link_speed;
>   	enum rzg3s_pcie_channel_id channel_id;
> +	u8 num_lanes;
>   };
>   
>   #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
> @@ -1155,6 +1173,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>   	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
>   			       field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
>   
> +	if (host->num_lanes) {
> +		rzg3s_pcie_update_bits(host->pcie + RZG3S_PCI_CFG_PCIEC,
> +				       PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_MLW,
> +				       FIELD_PREP(PCI_EXP_LNKCAP_MLW,
> +						  host->num_lanes));
> +	}
> +
>   	/* Disable access control to the CFGU */
>   	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
>   
> @@ -1687,6 +1712,63 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>   	return ret;
>   }
>   
> +static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	u32 domain;
> +	int ret;
> +
> +	if (host->data->num_channels == 1)
> +		return 0;
> +
> +	ret = of_property_read_u32(np, "linux,pci-domain", &domain);

This introduces some limits in the systems with RZ/V2H(P) SoCs with regards to 
the usage of linux,pci-domain. I would like the PCIe maintainers take on this.

As this is necessary to index in the system controller driver specific data (as 
there are different SYSC offsets for different PCIe controllers) I see the 
following alternatives, if any:

1/ add a dedicated DT property for this, e.g. renesas,pcie-controller-id
2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would be used to specify the
    system controller register offset and mask for different functionalities.

    E.g.:
    renesas,sysc-l1-allow = <&sysc 0x1020 0x1>;
    renesas,sysc-mode = <&sysc 0x1024 0x1>;
    renesas,sysc-link-master = <&sysc 0x1060 0x300>;

    And use them in each controller DT node. E.g.:

    pcie0: pcie@add1 {
        // ...

        renesas,sysc-l1-allow = <&sysc 0x1020 0x1>;
        renesas,sysc-mode = <&sysc 0x1024 0x1>;
        renesas,sysc-link-master = <&sysc 0x1060 0x300>;

        // ...
    };

    pcie0: pcie@add1 {
        // ...

        renesas,sysc-l1-allow = <&sysc 0x1050 0x1>;
        renesas,sysc-mode = <&sysc 0x1054 0x1>;
        renesas,sysc-link-master = <&sysc 0x1060 0x300>;

        // ...
    };

3/ as sashiko.dev mentions [1], using aliases for the PCIe nodes should also be
    what you need here.

[1] 
https://sashiko.dev/#/patchset/20260318124450.163471-1-prabhakar.mahadev-lad.rj%40bp.renesas.com

> +	if (ret)
> +		return ret;
> +
> +	if (domain >= host->data->num_channels)
> +		return -EINVAL;
> +
> +	host->channel_id = domain;
> +
> +	return 0;
> +}
> +
> +static int rzv2h_pcie_setup_lanes(struct rzg3s_pcie_host *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	static u8 rzv2h_num_total_lanes;
> +	u32 num_lanes;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * RZ/V2H(P) supports up to 4 lanes, but only in single x4 mode.
> +	 * Dual x2 mode is only supported with 2 total lanes. Validate
> +	 * the configuration to avoid conflicts with other host, if any.
> +	 */
> +	if (num_lanes != 4 && num_lanes != 2)
> +		return -EINVAL;
> +
> +	if (rzv2h_num_total_lanes == 2 && num_lanes != 2)
> +		return -EINVAL;
> +
> +	if (rzv2h_num_total_lanes == 4)
> +		return -EINVAL;
> +
> +	rzv2h_num_total_lanes += num_lanes;

There is a a valid concern raised by sashiko.dev [1] with regards to 
incrementing this if later the probe fails:

from [1]:
"For example, if rzg3s_pcie_resets_prepare_and_get() returns -EPROBE_DEFER,
the static variable is never decremented. On subsequent probe retries,
the variable will be artificially inflated, eventually causing the bounds
check to fail and returning a permanent -EINVAL. This would also prevent
driver unbind and rebind from working correctly."

also:

"Additionally, since the driver sets .probe_type = PROBE_PREFER_ASYNCHRONOUS,
could multiple PCIe controllers probing concurrently cause a data race when
reading and modifying this static variable without locking?"

> +
> +	host->num_lanes = num_lanes;
> +
> +	return rzg3s_sysc_config_func(host->sysc,
> +				      RZG3S_SYSC_FUNC_ID_LINK_MASTER,
> +				      num_lanes == 2 ?
> +				      RZG3S_SYSC_LINK_MODE_DUAL_X2 :
> +				      RZG3S_SYSC_LINK_MODE_SINGLE_X4);

I think this one should also be configured on resume (to have the same 
configuration sequence as in probe) even though RZ/V2H(P) don't currently 
support s2ram. E.g. so something like:

if (host->num_lanes) {
	ret = rzg3s_sysc_config_func(host->sysc,
				     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
				     host->num_lanes == 2  ?
				     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
				     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
	if (ret)
		goto assert_rst_rsm_b;
}

after ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);

Thank you,
Claudiu
