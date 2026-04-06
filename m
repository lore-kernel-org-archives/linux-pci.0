Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4D39022D;
	Mon,  6 Apr 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496950; cv=none; b=lIHUL8JxreVE1CIbfmMD8Jqg498ZOHx5RiLds6nx1TQJyYrUyR+up1WI2JCi5UssX35oqNNGYP8rry/MEFDc+BV+wTQPdo9lXBKwQQ+Rd3jDbobL9RdXGpBDNwZMdqT8S2lHYvxsC3aIrAGAKAczhRQXz84kcs7PQ14y+nx1m68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496950; c=relaxed/simple;
	bh=36mA1fJzXVF5opZN8xfXYHXC/Hv/7P20YGLftECaIcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ICUZlxmqIOvC1OogyFaMDk1ta12zQuC56+Swb3eTJ03zYeMK1Jnz+PQQCn19bPR1isugCx56bGrDbJ3UCSSPoqze+r95k2jfk4skW5YmAobDSt0pj5mUghjgkCwZNH5KHmVIrHSbycgHFrjVJU6M5/cZlPBOtOqhqMPWU/qYNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7QajwOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7QajwOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD4FC2BCAF;
	Mon,  6 Apr 2026 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775496950;
	bh=36mA1fJzXVF5opZN8xfXYHXC/Hv/7P20YGLftECaIcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S7QajwOUHOQ28JTDl/8w+QQ0sxvsZUcJnjHnl6G1yXBVVLJUMJIHfSbs9zUZw+7fV
	 YYzvKa+tIAziGijfq+9nWwMku5MO0oKDicNuxzqAFhHhmZMmH3HBHFI+juc+DBvjF/
	 +qc8WkmCzF4bnHdeCMghjaj9JbG/GAbkoVdEszBPMeq2AkyYCKsEB2Yc8RNPXPu5hV
	 e332fjOkLGtjhc80Xq+m/S5EL3q2jv6MG7jm0FhA9x+XaQ8OrZ1tMqXwvW5Dt9Ubti
	 IbAZuulmvwVM4JjNoy7UtWiZ8jY0v21R86FuxQgjRUJZ6lh3Imq6X++IkKW4O4aIPr
	 9iHvnJytgtCQg==
Date: Mon, 6 Apr 2026 12:35:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jan@nvidia.com, newtonl@nvidia.com,
	sreddym@nvidia.com, skomatineni@nvidia.com, vidyas@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports
Message-ID: <20260406173549.GA171987@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402093850.23075-1-icheng@nvidia.com>

On Thu, Apr 02, 2026 at 05:38:50PM +0800, Richard Cheng wrote:
> NPEM registers LED classdevs on PCI endpoint that may be behind
> hotplug-capable ports. During hot-removal, led_classdev_unregister()
> calls led_set_brightness(LED_OFF) which PCI config on a disconnected
> device, returning -ENODEV:
> 
> ```
> leds 0003:01:00.0:enclosure:ok: Setting an LED's brightness failed (-19)
> ```
> 
> The LED core already suppresses this for devices with LED_HW_PLUGGABLE
> set, but NPEM never sets it. Add the flag since NPEM LEDs are on
> hot-pluggable hardware by nature.
> 
> Fixes: 4e893545ef87 ("PCI/NPEM: Add Native PCIe Enclosure Management support")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>

Applied to pci/hotplug for v7.1, thank you!

> ---
> The bug was triggered on an ARM64 machine with CPU model Olympus.
> Kernel version is v6.17.
> The PCI topology is
> ```
> $ sudo lspci -tv
> -[0001:00]---00.0-[01]--+-00.0  Mellanox Technologies CX8 Family [ConnectX-8]
>                         +-00.1  Mellanox Technologies CX8 Family [ConnectX-8]
>                         +-00.2  Mellanox Technologies CX8 Family [ConnectX-8]
>                         \-00.3  Mellanox Technologies CX8 Family [ConnectX-8]
> -[0002:00]---00.0-[01]--
> -+-[0003:00]---00.0-[01]----00.0  Montage Technology Co., Ltd. Device c002
>  \-[0003:80]---00.0-[81]----00.0  Montage Technology Co., Ltd. Device c002
> -[0004:00]---00.0-[01]--
> -+-[0005:00]---00.0-[01]----00.0  Samsung Electronics Co Ltd Device a810
>  +-[0005:40]---00.0-[41]----00.0  Samsung Electronics Co Ltd Device a810
>  +-[0005:c0]---00.0-[c1]----00.0  Intel Corporation I210 Gigabit Network Connection
>  \-[0005:e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Technology, Inc. ASPEED Graphics Family
>                                           \-02.0  ASPEED Technology, Inc. Device 2603
> -+-[0006:00]---00.0-[01]--
>  \-[0006:80]---00.0-[81]--
> ```
> We're targeting on 0003:01:00.0 CXL [0502]: Montage Technology Co., Ltd. Device [1b00:c002] (rev 03).
> First use `sudo setpci -s 0003:00:00.0 0x1f4.w=0x0002` to set UnmaskLinkDisable in CXL DVSEC.
> Then disable the link with `sudo setpci -v -s 0003:00:00.0 CAP_EXP+0x10.b=0x10:0x10`
> 
> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/pci/npem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
> index ffeeedf6e311..c51879fcd438 100644
> --- a/drivers/pci/npem.c
> +++ b/drivers/pci/npem.c
> @@ -504,7 +504,7 @@ static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
>  	led->brightness_get = brightness_get;
>  	led->max_brightness = 1;
>  	led->default_trigger = "none";
> -	led->flags = 0;
> +	led->flags = LED_HW_PLUGGABLE;
>  
>  	ret = led_classdev_register(&npem->dev->dev, led);
>  	if (ret)
> -- 
> 2.43.0
> 
