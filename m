Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255724;
	b=BssV/9/iYVwyc4AbWvzYaM9560XWA80ZyZEuNK9lJygJpPbP4UBZsTVzp3yvpHtgGzaG
	 O/agOJq3FpudCemJ5BuxkaGIYSAZVbHVgOswt6uxFrHH93r56cwYaRln89BANWz6RM2aw
	 /7fZqqtzHNJvzlbKJAF4rKG8ZzJANSz0FjL5briCE7OvctnTCENmvehaPQ5pMpFYCQz1L
	 +YbyMZAkj9TppflgfycxY8XnZlb14FtbDkmNQ53c9zeMfEaCFs3UV2TNgSquUx3jnN3J9
	 rUuy0CvgzYFG+DkJZbOebS3DUfBFsLGWXlJsoUEGFZ3oH3HSl9xl1uqzEKJXNUaYFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255724;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B+N77ojB+5okIxP4FGww0vK4os8dkwh+znxCLIQEsBo=;
	b=ve9sigJB/sJCDlZVfJLXuAWbE6Jt4PscwdKP8pgUqUng8tRbaNBr+sJOOzOXqT8iZcrh
	 xdud50gb6Mai91LoNdcMkT62SeMGrBEWD2KLWnZo3j0ttKgiB1YJAfqgwM9oIMY1AwsN2
	 sUzFiauwX1BzRYZjKOg4xY3oyWsql8W/r499qYP1m6PG7VuWyLvQlhBoaeO3p7FejYyYj
	 38KEZQaXCLcQuEDEN9HP+KKqwtdaMsfXfbEmUNWGKugoXLR2v4+i2m8NCeOScGQjRRy+7
	 Sf5NPwuu+6k5VQTltM/jsPppa+Jg8aH+T3KtRsPlVXnNQNdZ7QurIvw5eu1Jp5ofpIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyJ8DhbF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A2606A31C;
	Mon,  9 Nov 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyJ8DhbF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D51F0089F;
	Mon,  9 Nov 2026 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255723;
	bh=B+N77ojB+5okIxP4FGww0vK4os8dkwh+znxCLIQEsBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=EyJ8DhbFWoPZqp7mVWIgmJ8qxnlt1XWnUrul3lEkLYGnVX4P53qStNYfiPkx0bYTV
	 zYHiUrc4T9hIwZmcc9YJVCkeJiKBiKFWMUrz7WHx/7bXQxw9yBCnLltMqxVSdqknaR
	 n3rWgjP7Zm3cDXi+TkyFqKBzplJAdAnjp6Vy0d/3rDubmbU58yuwkmtu53Mi2zlosm
	 vh+ckIUxR5UT7mzL+A6/Uhk+DejbWsFdJAGeix6mg33M+XvRsu8baK0G8ckSvxvWMN
	 +On49msmgAzxwsFHE/yUA+bWfalrGd4+viw9kOeKdnlh83YcZKP2FEPkMlvOhKTjRe
	 FPGScfYNl01aw==
Date: Mon, 9 Nov 2026 14:22:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Message-ID: <20261109202202.GA265423@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>

On Tue, Nov 03, 2026 at 06:07:35AM +0000, Igor Velkov wrote:
> The probe waits for the link to come up, and with an empty slot it
> holds the deferred-probe worker for about 0.7 s. On ROCK Pi 4 with
> UHS-I enabled for the SD card, the I/O-domain driver then binds only
> after the card has switched to 1.8 V, and tuning fails ("All phases
> bad!").

I don't know what the SD card has to do with PCIe.  Seems like there's
some SD issue, and making PCIe async happens to avoid it?  Sounds
fragile to me.

Other changes like c0e1eb441b1d justify it by allowing other drivers
to load in parallel to reduce boot time, which is a good reason.  But
apparently here it makes a functional difference as well, which feels
sketchy.  E.g., what other drivers need to use async probe to avoid
similar issues?

> Probe asynchronously, as commit c0e1eb441b1d ("PCI: qcom: Enable async
> probe by default") does for the Qualcomm host driver. This does not
> order the I/O domain before dw_mmc in general; an explicit dependency
> was proposed in [1] and not merged.
> 
> Link: https://lore.kernel.org/all/20230904115816.1237684-1-s.hauer@pengutronix.de/ [1]
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on v7.3.1 with the Armbian rockchip64 config (PCIE_ROCKCHIP_HOST=y):
> - ROCK Pi 4A, empty slot, UHS-I DT change posted separately: SDR104 on
>   3 of 3 cold boots; without this patch tuning fails.
> - Kobol Helios64, JMB585 in the slot: link, SATA and disk reads OK
>   over 3 cold boots and a reboot.
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 5b071bdc4f90..1e1556e436b8 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -1027,6 +1027,7 @@ static struct platform_driver rockchip_pcie_driver = {
>  		.name = "rockchip-pcie",
>  		.of_match_table = rockchip_pcie_of_match,
>  		.pm = &rockchip_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = rockchip_pcie_probe,
>  	.remove = rockchip_pcie_remove,
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261103-rockchip-pcie-async-42c1c3863617
> 
> Best regards,
> -- 
> Igor Velkov <iav@iav.lv>
> 
