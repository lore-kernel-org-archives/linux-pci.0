Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2B33DEE0;
	Thu, 14 May 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784731; cv=none; b=SQMS0+p75h2xCPleahDCek2E8m7eZAeINxQuBJtvSn024w2bm94C6gwOjrBSReRb8eIKq0thG61aZWmlrytoUgh5EgkRjwNOs5vfbpRJTMjsN/ce2D/nHMY06/XeTkIy09D8CTVRHD63S9Bj5GoH34JDbBX3bCL6kZy1ksyFBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784731; c=relaxed/simple;
	bh=memKOZyPomJFumSLFhdkKwDo6BDW8hqipAsmwAWhpIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0NhOS+F4NcBhvwGAE6HIbI1R/03PDZlb1N7PKxZ7yqK0fGM5W7HfUsRLDezTK8NyFp4+1uUa0ROL8zMBGft1yjTJM4qjodwhWe4NKtNGaKKZZYzHrhnka+BYTlmaUa5HahpyBNKRPJgAoOXe9kEtiCnzwinEosizk25xTxTZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbKaFRyd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbKaFRyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E9FC2BCB3;
	Thu, 14 May 2026 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784730;
	bh=memKOZyPomJFumSLFhdkKwDo6BDW8hqipAsmwAWhpIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cbKaFRyd0WCGeCa+r1LHnslwN6FX3tkbvShV11NORRwPqWfPT451r43V7qhMpLjBl
	 O1iX0NsU/+SGjSUZjFj5OoH6HIlPrBH/ZRI5iaK2Tv5q3MoGyDnzldZqy9stSYIs0L
	 YnDni6YIIqd+g3TDSv6SpjV7OOeMeprmhSTUpv1XitG42gS0CQL6NbgGgsr1SzhJS9
	 RAof1NcVvsDoF+8kJCTtEgOocj15Mf3sj4nP9vUaGqndO8CQ7KWOjOzbEI+kX0FrSF
	 tcgeLfwHWFpofHmiPeCEy8hJBD0chYYf+vdOusiddv7kkKfZLyhtulvgR6r6jLQ8F3
	 71I/Z3vwgawSg==
Message-ID: <e0129a50-11d9-4212-99ca-4e7f4e862030@kernel.org>
Date: Thu, 14 May 2026 13:52:08 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Marco Nenciarini <mnencia@kcore.it>,
 Michal Winiarski <michal.winiarski@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>,
 Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Gary Li <Gary.Li@amd.com>
References: <20260514153124.404060-1-bhelgaas@google.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260514153124.404060-1-bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 10:31, Bjorn Helgaas wrote:
> For a device that advertises No_Soft_Reset == 0, a transition from D3hot to
> D0uninitialized is a soft reset, and the resulting internal device state is
> undefined.
> 
> A transition from D3hot to D0uninitialized requires a minimum delay of
> 10 msec before accessing the device, but after that delay, the device is
> permitted to respond to config requests with RRS completion status if it
> needs more time to initialize (PCIe r7.0, sec 2.3.1).
> 
> Call pci_dev_wait() after pci_power_up() performs a D3hot->D0uninitialized
> transition to ensure the device is ready to accept config accesses, as is
> done after the similar transition in pci_pm_reset().
> 
> If the device is already ready, this is essentially a no-op except for one
> additional config read.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

BTW -

This reminds me of an attempt I had at solving a similar issue a few 
years back.  It would be a nice side effect if this actually solves that 
  issue too.

https://lore.kernel.org/linux-pci/20240823154023.360234-3-superm1@kernel.org/

> ---
>   drivers/pci/pci.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..9d0fc9fbb76a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1301,6 +1301,16 @@ int pci_power_up(struct pci_dev *dev)
>   	pci_power_t state;
>   	u16 pmcsr;
>   
> +	/*
> +	 * When setting power state to D0, platform_pci_set_power_state()
> +	 * ensures main power is on.  If it puts the device in D0, it also
> +	 * completes any required delays after the transition; if it leaves
> +	 * the device in D1, D2, or D3hot, we use the PM Capability to
> +	 * transition to D0.
> +	 *
> +	 * In all cases, the device is either Configuration-Ready or
> +	 * inaccessible upon return.
> +	 */
>   	platform_pci_set_power_state(dev, PCI_D0);
>   
>   	if (!dev->pm_cap) {
> @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
>   
>   	/* Mandatory transition delays; see PCI PM 1.2. */
> -	if (state == PCI_D3hot)
> +	if (state == PCI_D3hot) {
>   		pci_dev_d3_sleep(dev);
> -	else if (state == PCI_D2)
> +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> +				     PCIE_RESET_READY_POLL_MS);
> +	} else if (state == PCI_D2) {
>   		udelay(PCI_PM_D2_DELAY);
> +	}
>   
>   end:
>   	dev->current_state = PCI_D0;

