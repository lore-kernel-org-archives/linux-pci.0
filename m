Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078413F1678
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336157; cv=none; b=C7qN/VFAkwvdpqO0Se//ThVO+6QZpAB0pJuElMZoAjrp+sOiYUHRd99zYJlXaJqIQMNk7L1tVfR52LIDv+v904pO6WIS3JVBAKQOMyuBQoMKExxM5uIlVvi/p6UoWpjMOJcPdHOFZr9I7M8Ep5jM49diJWUNFIahk/1tY1pCp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336157; c=relaxed/simple;
	bh=UlUGm+5OZ+8JqqvNZawdAa2owaUcH9oYB51TM3r5ZH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPhJR+8GT5++yhO/N3csbexREj6I+e2RfFx7fQRQIQKihRwbVBoBrxaqhpkNlubrliN9Pocb39NHawDmdo1JfYU+sqSTITfSmDs+ZQ8T0Ubl6abL1y5uPWPMxuTVlE8Gb7uCutZuE1ODaFd/Hs3g5yxETDnxpB6g7G9BbDUfVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ipKLXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ipKLXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD691F00A3A;
	Wed, 29 Jul 2026 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336155;
	bh=6Jt7hYNuChunqhQBrJh0809k247tUFj4XxS71TdNxpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/ipKLXebVPr/hmQF2Uqj2Vc6ROEx95Xm3eURp9A7bRfjWXp/TCTSQ5baNg9UA0gO
	 idtkVxiPGmEGNkZhQ+DQtjvAEZ6yly5x1IFFzMmcAACp7tzjJke2NK2Ui5/+WuYzUH
	 rnQyCkpExzAtyLkhQtn8KHhkihoiMuS1uAlnO+iImYIqOsF+u2d+50cH2pw5S8FLJl
	 cMlWc924rjDa1PiHV5gu9KzxzgF4CLK9Li+nQuZwznBCXM64CSfh9pBYQoVDFjhcX6
	 XVkrjtG0WvwP4g42OAAEKkgPZeEHl82kWJ6GyM2qIShOyobU1pU7Y/85uJgRAUfrgA
	 rc5wx9L52ZwsQ==
Date: Wed, 29 Jul 2026 16:42:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/pwrctrl: tc9563: rely on regmap APIs
Message-ID: <7pys6t63twms4jd4tsd4p46mnnbsr2ucudvkpd4cn5y6jz7fot@oaq4o3gssi7b>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <20260729-pci-pwrctrl-tc956x-regmap-v1-1-20ce61a3ce12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-1-20ce61a3ce12@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 03:34:25PM +0200, Lorenzo Bianconi wrote:
> Replace the custom tc9563_pwrctrl_i2c_{read,write,bulk_write} functions
> with standard regmap APIs. The device uses 24-bit big-endian register
> addresses and 32-bit little-endian register values over I2C, which is
> directly supported by regmap.
> 
> This removes the open-coded I2C transfer handling and lets the regmap
> core handle formatting, locking, and multi-register coalescing.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/pwrctrl/Kconfig              |   1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 153 +++++++++----------------------
>  2 files changed, 44 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 9eec767cda86..1952ab4f29b6 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
>  	  switch.
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index db744fbfc09a..8bccf3abd189 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -17,10 +17,10 @@
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> -#include <linux/unaligned.h>
>  
>  #include "../pci.h"
>  
> @@ -71,11 +71,6 @@
>  
>  #define TC9563_L0S_L1_DELAY_UNIT_NS	256  /* Each unit represents 256 ns */
>  
> -struct tc9563_pwrctrl_reg_setting {
> -	unsigned int offset;
> -	unsigned int val;
> -};
> -
>  enum tc9563_pwrctrl_ports {
>  	TC9563_USP,
>  	TC9563_DSP1,
> @@ -112,13 +107,14 @@ struct tc9563_pwrctrl {
>  	struct gpio_desc *reset_gpio;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client;
> +	struct regmap *regmap;
>  };
>  
>  /*
>   * downstream port power off sequence, hardcoding the address
>   * as we don't know register names for these register offsets.
>   */
> -static const struct tc9563_pwrctrl_reg_setting common_pwroff_seq[] = {
> +static const struct reg_sequence common_pwroff_seq[] = {
>  	{0x82900c, 0x1},
>  	{0x829010, 0x1},
>  	{0x829018, 0x0},
> @@ -141,7 +137,7 @@ static const struct tc9563_pwrctrl_reg_setting common_pwroff_seq[] = {
>  	{0x829114, 0x1},
>  };
>  
> -static const struct tc9563_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
> +static const struct reg_sequence dsp1_pwroff_seq[] = {
>  	{TC9563_PORT_ACCESS_ENABLE, 0x2},
>  	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
>  	{TC9563_POWER_CONTROL, 0x014f4804},
> @@ -149,7 +145,7 @@ static const struct tc9563_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
>  	{TC9563_PORT_ACCESS_ENABLE, 0x4},
>  };
>  
> -static const struct tc9563_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
> +static const struct reg_sequence dsp2_pwroff_seq[] = {
>  	{TC9563_PORT_ACCESS_ENABLE, 0x8},
>  	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x1},
>  	{TC9563_POWER_CONTROL, 0x014f4804},
> @@ -157,85 +153,11 @@ static const struct tc9563_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
>  	{TC9563_PORT_ACCESS_ENABLE, 0x8},
>  };
>  
> -/*
> - * Since all transfers are initiated by the probe, no locks are necessary,
> - * as there are no concurrent calls.
> - */
> -static int tc9563_pwrctrl_i2c_write(struct i2c_client *client,
> -				    u32 reg_addr, u32 reg_val)
> -{
> -	struct i2c_msg msg;
> -	u8 msg_buf[7];
> -	int ret;
> -
> -	msg.addr = client->addr;
> -	msg.len = 7;
> -	msg.flags = 0;
> -
> -	/* Big Endian for reg addr */
> -	put_unaligned_be24(reg_addr, &msg_buf[0]);
> -
> -	/* Little Endian for reg val */
> -	put_unaligned_le32(reg_val, &msg_buf[3]);
> -
> -	msg.buf = msg_buf;
> -	ret = i2c_transfer(client->adapter, &msg, 1);
> -	return ret == 1 ? 0 : ret;
> -}
> -
> -static int tc9563_pwrctrl_i2c_read(struct i2c_client *client,
> -				   u32 reg_addr, u32 *reg_val)
> -{
> -	struct i2c_msg msg[2];
> -	u8 wr_data[3];
> -	u32 rd_data;
> -	int ret;
> -
> -	msg[0].addr = client->addr;
> -	msg[0].len = 3;
> -	msg[0].flags = 0;
> -
> -	/* Big Endian for reg addr */
> -	put_unaligned_be24(reg_addr, &wr_data[0]);
> -
> -	msg[0].buf = wr_data;
> -
> -	msg[1].addr = client->addr;
> -	msg[1].len = 4;
> -	msg[1].flags = I2C_M_RD;
> -
> -	msg[1].buf = (u8 *)&rd_data;
> -
> -	ret = i2c_transfer(client->adapter, &msg[0], 2);
> -	if (ret == 2) {
> -		*reg_val = get_unaligned_le32(&rd_data);
> -		return 0;
> -	}
> -
> -	/* If only one message successfully completed, return -EIO */
> -	return ret == 1 ? -EIO : ret;
> -}
> -
> -static int tc9563_pwrctrl_i2c_bulk_write(struct i2c_client *client,
> -				const struct tc9563_pwrctrl_reg_setting *seq,
> -				int len)
> -{
> -	int ret, i;
> -
> -	for (i = 0; i < len; i++) {
> -		ret = tc9563_pwrctrl_i2c_write(client, seq[i].offset, seq[i].val);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
>  				       enum tc9563_pwrctrl_ports port)
>  {
>  	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
> -	const struct tc9563_pwrctrl_reg_setting *seq;
> +	const struct reg_sequence *seq;
>  	int ret, len;
>  
>  	if (!cfg->disable_port)
> @@ -255,12 +177,12 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
>  		return 0;
>  	}
>  
> -	ret = tc9563_pwrctrl_i2c_bulk_write(tc9563->client, seq, len);
> +	ret = regmap_multi_reg_write(tc9563->regmap, seq, len);
>  	if (ret)
>  		return ret;
>  
> -	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, common_pwroff_seq,
> -					     ARRAY_SIZE(common_pwroff_seq));
> +	return regmap_multi_reg_write(tc9563->regmap, common_pwroff_seq,
> +				      ARRAY_SIZE(common_pwroff_seq));
>  }
>  
>  static int tc9563_pwrctrl_set_port_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
> @@ -276,14 +198,13 @@ static int tc9563_pwrctrl_set_port_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9
>  	/* convert to units of 256ns */
>  	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
>  
> -	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
> -				       BIT(port));
> +	ret = regmap_write(tc9563->regmap, TC9563_PORT_SELECT, BIT(port));
>  	if (ret)
>  		return ret;
>  
> -	return tc9563_pwrctrl_i2c_write(tc9563->client,
> -			is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
> -			units);
> +	return regmap_write(tc9563->regmap,
> +			    is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
> +			    units);
>  }
>  
>  static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
> @@ -298,8 +219,7 @@ static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc95
>  	/* convert to units of 256ns */
>  	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
>  
> -	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
> -				      &rd_val);
> +	ret = regmap_read(tc9563->regmap, TC9563_EMBEDDED_ETH_DELAY, &rd_val);
>  	if (ret)
>  		return ret;
>  
> @@ -310,8 +230,7 @@ static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc95
>  		rd_val = u32_replace_bits(rd_val, units,
>  					  TC9563_ETH_L0S_DELAY_MASK);
>  
> -	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
> -					rd_val);
> +	return regmap_write(tc9563->regmap, TC9563_EMBEDDED_ETH_DELAY, rd_val);
>  }
>  
>  static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
> @@ -344,14 +263,14 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>  		return -EINVAL;
>  	}
>  
> -	struct tc9563_pwrctrl_reg_setting tx_amp_seq[] = {
> +	struct reg_sequence tx_amp_seq[] = {
>  		{TC9563_PORT_ACCESS_ENABLE, port_access},
>  		{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
>  		{TC9563_TX_MARGIN, amp},
>  	};
>  
> -	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, tx_amp_seq,
> -					     ARRAY_SIZE(tx_amp_seq));
> +	return regmap_multi_reg_write(tc9563->regmap, tx_amp_seq,
> +				      ARRAY_SIZE(tx_amp_seq));
>  }
>  
>  static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
> @@ -384,7 +303,7 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>  		return -EINVAL;
>  	}
>  
> -	struct tc9563_pwrctrl_reg_setting disable_dfe_seq[] = {
> +	struct reg_sequence disable_dfe_seq[] = {
>  		{TC9563_PORT_ACCESS_ENABLE, port_access},
>  		{TC9563_PORT_LANE_ACCESS_ENABLE, lane_access},
>  		{TC9563_DFE_ENABLE, 0x0},
> @@ -398,15 +317,15 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>  		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x0},
>  	};
>  
> -	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, disable_dfe_seq,
> -					     ARRAY_SIZE(disable_dfe_seq));
> +	return regmap_multi_reg_write(tc9563->regmap, disable_dfe_seq,
> +				      ARRAY_SIZE(disable_dfe_seq));
>  }
>  
>  static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>  				   enum tc9563_pwrctrl_ports port)
>  {
>  	u8 *nfts = tc9563->cfg[port].nfts;
> -	struct tc9563_pwrctrl_reg_setting nfts_seq[] = {
> +	struct reg_sequence nfts_seq[] = {
>  		{TC9563_NFTS_2_5_GT, nfts[0]},
>  		{TC9563_NFTS_5_GT, nfts[1]},
>  	};
> @@ -421,13 +340,12 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>  		return 0;
>  	}
>  
> -	ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
> -					BIT(port));
> +	ret =  regmap_write(tc9563->regmap, TC9563_PORT_SELECT, BIT(port));
>  	if (ret)
>  		return ret;
>  
> -	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, nfts_seq,
> -					     ARRAY_SIZE(nfts_seq));
> +	return regmap_multi_reg_write(tc9563->regmap, nfts_seq,
> +				      ARRAY_SIZE(nfts_seq));
>  }
>  
>  static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
> @@ -435,14 +353,14 @@ static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
>  {
>  	int ret, val;
>  
> -	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
> -				       TC9563_GPIO_MASK);
> +	ret = regmap_write(tc9563->regmap, TC9563_GPIO_CONFIG,
> +			   TC9563_GPIO_MASK);
>  	if (ret)
>  		return ret;
>  
>  	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
>  
> -	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
> +	return regmap_write(tc9563->regmap, TC9563_RESET_GPIO, val);
>  }
>  
>  static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
> @@ -573,6 +491,13 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
>  	return ret;
>  }
>  
> +static const struct regmap_config tc9563_regmap_config = {
> +	.reg_bits = 24,
> +	.val_bits = 32,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
>  static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
> @@ -603,6 +528,14 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  		return PTR_ERR(tc9563->client);
>  	}
>  
> +	tc9563->regmap = devm_regmap_init_i2c(tc9563->client,
> +					      &tc9563_regmap_config);
> +	if (IS_ERR(tc9563->regmap)) {
> +		ret = dev_err_probe(dev, PTR_ERR(tc9563->regmap),
> +				    "Failed to allocate register map\n");
> +		goto remove_i2c;
> +	}
> +
>  	for (int i = 0; i < ARRAY_SIZE(tc9563_supply_names); i++)
>  		tc9563->supplies[i].supply = tc9563_supply_names[i];
>  
> 
> -- 
> 2.55.0
> 

-- 
மணிவண்ணன் சதாசிவம்
