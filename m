Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4230DEAC;
	Mon, 22 Jun 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139942; cv=none; b=GAvGDeu07hRQB7KBVIDE3XJ8qG9DuSRj0GkhqCSFHYx4zVYLaWufF0uCk4zezDFR2K45JCs8HyqUhShSnMS8C0JIrJlbU+f6DdP8KPqkeWpzoVFnmyy6QvhB2ZUgFeMB3OfrUTXweow8Ym7qNjmPTJru+58Ki+pXF1C6CyXISN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139942; c=relaxed/simple;
	bh=UZrjvP2U+KnpvOgkwz6utftmD4zbORWlkF7J/F0Hifk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqGGx807FD0Dye0j+105WSflol1iQ4o8hHlkT59jxrB1X6sfx58zJ9QobQgoVTz0xxk9J8CowZ0hUEzrqST/r+V4qwFgxAlSo3VTA6+Yn9SJ8yoBhRYkl0PZ3DcO0QiklI8tvTkxofbJZzda2/KduAFtUWcyLhBphJhYUvdpoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk+J5dKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk+J5dKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712C31F000E9;
	Mon, 22 Jun 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139937;
	bh=MRk82QwwQ0h9J0y/PqCawImukpeJnfRLpbydiH898bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fk+J5dKxpVVgzAXe6D1AdzHmgmKcPTAaJwagi9u3JUEXbDisXafMljRrDSGoRU+wZ
	 BzNN4F5v7MROrdY8FH9XqMlqpryp46qr4gC2yjuFvDjHOJbFWusxhHi8uIdT5ep1c2
	 QDyJ/Hd78JpUorLWiTMuSn1Zz3v6vQcWvdSH36E/brYyixAqCArZ9tGdfb1W2gVuIH
	 5GznVxwGtRg1LMLWPS06eQFqCmgg5SCu7rZIG7CVkH+FIsxA+aT0bcdw9qzygdDbZ8
	 xHmnFogFtq6gtRxFe7vDHjS+NR2xfB1mU3wrIG+X8OxkyN6jUbaCYaNVLJUVaeypVW
	 +0SK0nUK3gVqA==
Date: Mon, 22 Jun 2026 16:52:08 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	mpillai@cadence.com, unicorn_wang@outlook.com, me@ziyao.cc, 18255117159@163.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, danishanwar@ti.com
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
Message-ID: <4lijgllolvtbvmzmluuslhkc7empdpizxhva6ysau7kssuqd5z@drkzb5afd4ba>
References: <20260605071922.1724499-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605071922.1724499-1-a-garg7@ti.com>

On Fri, Jun 05, 2026 at 12:49:22PM +0530, Aksh Garg wrote:
> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
> during the resume operation blocks the resume operation unnecessarily for
> ~1s even when no endpoint device is connected.
> 
> Add skip_link_polling flag to track link state across suspend/resume
> cycles. If link was down before suspend, skip the expensive polling
> in resume since no endpoint was present.
> 

Won't you need the delay if a device gets plugged while the host was suspended?
We had this same concern with the DWC drivers and we left the delay as-is as
nothing prevents an user to connect a device when the host was suspended.

- Mani

> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>  drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>  drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>  drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index bfdfe98d5aba..849eb8bb9e45 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>  	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>  
>  	if (pcie->mode == PCI_MODE_RC) {
> +		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
> +
> +		/* If link is down before suspend, skip polling in resume */
> +		rc->skip_link_polling = !j721e_pcie_link_up(pcie->cdns_pcie);
> +
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  		clk_disable_unprepare(pcie->refclk);
>  	}
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e8..d78c1282a5ee 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
>  
> +	if (rc->skip_link_polling)
> +		return 0;
> +
>  	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 0bc9e6e90e0e..026414c21ee1 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
>  
> +	if (rc->skip_link_polling)
> +		return 0;
> +
>  	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 574e9cf4d003..01e49ecccc7b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -117,6 +117,8 @@ struct cdns_pcie {
>   * @no_inbound_map: Whether inbound mapping is supported
>   * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
>   * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
> + * @skip_link_polling: Skip link polling in resume if link was down before
> + *		       suspend, to avoid long delay in resume
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -131,6 +133,7 @@ struct cdns_pcie_rc {
>  	unsigned int            no_inbound_map:1;
>  	unsigned int            quirk_broken_aspm_l0s:1;
>  	unsigned int            quirk_broken_aspm_l1:1;
> +	unsigned int		skip_link_polling:1;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
