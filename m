Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA471FF1B4;
	Wed,  8 Apr 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687429; cv=none; b=q7N6Gacf9jNKkXpieotA7M/ZnqOvB5GQgO/uBNceJqrBXbU4rgw94oAq8gzQgFm95xvnfT0fOKNYUznICZmUhsYqFu36uLuqChLD+6ZbYcz9FeYLP+F+3x5bT1iG8TkGpfiHFX3/H6GisjZekdw1yCK6uyElhbOiMi0+IBuj3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687429; c=relaxed/simple;
	bh=Mauv0T1efrxRem6hfaN6mB7vASN/7vN8hOwJ7UiEReA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IT9RwTr4+k6dPM5PC8tszGlAv2SjNZYm6IQaH+XD9+P60Y90gelvkzy+j7WsPYlpxpVaRR0GwJoX2gUIXId8QxwINiyi33NV6oVaBfQiS+la1oBVcyS3aSUc0mMfIB/Itr0O6WmHPj4qB4/HHiUv/xgaqkUXmrGqvtkv13tsxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOnwgzw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOnwgzw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F9C19424;
	Wed,  8 Apr 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775687429;
	bh=Mauv0T1efrxRem6hfaN6mB7vASN/7vN8hOwJ7UiEReA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tOnwgzw5s6jHKyBDpl87Gm2uQitT32OE2YRRdSE4e/9HNu1SA5AOc2YjkaD8CR/ur
	 sWo2ChbutP801x4VzicFQw9LlL3s98sv4KcGiI0Kk6ee8Tq1j4f0h3yElJqlQZJ5q5
	 /3Gsb4JPMhzK0VhBtV47uKbAhMWgE9uEyCeBsjQxviEgKoPPQ8ylC0VGmiiULdcg/9
	 HP0Ga0q622lOTWGbK/i/eSurUI7X+WnVLbD/7WB2U53Y3kg1sejT90XtwhejLwaQJe
	 RS62vz0oxbKJAIljMB1bgOdwTD8XjUdjnBGcRgarLfwAr1FJ0JAmvMQNWpDIyIqOjF
	 IIa7659BLXHeg==
Date: Wed, 8 Apr 2026 17:30:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org,
	18255117159@163.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
Message-ID: <20260408223027.GA371101@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324191000.1095768-10-mmaddireddy@nvidia.com>

On Wed, Mar 25, 2026 at 12:40:00AM +0530, Manikanta Maddireddy wrote:
> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
> device tree property instead of of_data. Convert the value from nanoseconds
> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
> absent, default to 7 (maximum latency).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V8: Use aspm-l1-entry-delay-ns instead of of_data
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 3278353b2c29..a856a48362df 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>  	u32 aspm_cmrt;
>  	u32 aspm_pwr_on_t;
>  	u32 aspm_l0s_enter_lat;
> +	u32 aspm_l1_enter_lat;
>  
>  	struct regulator *pex_ctl_supply;
>  	struct regulator *slot_ctl_3v3;
> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>  	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>  	val |= PORT_AFR_ENTER_ASPM;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>  }
> @@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  {
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
>  	struct device_node *np = pcie->dev->of_node;
> +	u32 val;
>  	int ret;
>  
>  	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> @@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  		dev_info(pcie->dev,
>  			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>  
> +	/* Default to max latency of 7. */
> +	pcie->aspm_l1_enter_lat = 7;
> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
> +	if (!ret) {
> +		u32 us = max(val / 1000, 1U);
> +
> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);

I haven't investigated yet, but I see this build error on
pci/controller/dwc-tegra194:

    CC      drivers/pci/controller/dwc/pcie-tegra194.o
  In file included from <command-line>:
  In function ‘tegra_pcie_dw_parse_dt’,
      inlined from ‘tegra_pcie_dw_probe’ at drivers/pci/controller/dwc/pcie-tegra194.c:2148:8:
  ././include/linux/compiler_types.h:706:45: error: call to ‘__compiletime_assert_515’ declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
	|                                             ^
  ././include/linux/compiler_types.h:687:25: note: in definition of macro ‘__compiletime_assert’
    687 |                         prefix ## suffix();                             \
	|                         ^~~~~~
  ././include/linux/compiler_types.h:706:9: note: in expansion of macro ‘_compiletime_assert’
    706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
	|         ^~~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
	|                                     ^~~~~~~~~~~~~~~~~~
  ./include/linux/minmax.h:93:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
     93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
	|         ^~~~~~~~~~~~~~~~
  ./include/linux/minmax.h:98:9: note: in expansion of macro ‘__careful_cmp_once’
     98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
	|         ^~~~~~~~~~~~~~~~~~
  ./include/linux/minmax.h:105:25: note: in expansion of macro ‘__careful_cmp’
    105 | #define min(x, y)       __careful_cmp(min, x, y)
	|                         ^~~~~~~~~~~~~
  drivers/pci/controller/dwc/pcie-tegra194.c:1155:43: note: in expansion of macro ‘min’
   1155 |                 pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
	|                                           ^~~

