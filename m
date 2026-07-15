Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7F1B3B19;
	Wed, 15 Jul 2026 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095312; cv=none; b=e6zDQgNP63uwMPHi6YCI+2CE9zfm+JlrUG9p16ut4P8boFiRqjU2Cl5a2qRdaHHWfvXLz+mwOcHWXrFQzIjkEBI7MWhBX67ws6Kq3MZhG6cP72KbMUljjxDpTnGFCVi/VSkJfZ+TjQSFCeMebs7Y+q6NFl+bU8vRJlDWWtYkz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095312; c=relaxed/simple;
	bh=OgidP5Opim6hBzaxIz4BOVD+ePSYgQqRyxkQoRN8f+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5huBpiYIiFLWq4r1YbAYUvXPlj6Z7PTc7zzO1EITbnRY870QFDEqNp8Vdxi/nKEH9nv1NDdoK7PFz/Ko7NFVUgvvPaUZj2+coUEnQhBZYuptciXXqjqYygUub01NOxmSDdknfyGdqhsVRawjYC8HV7zMI/2nF9kocY036FBfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/E9Eeh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/E9Eeh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF71F000E9;
	Wed, 15 Jul 2026 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784095311;
	bh=VFJM6M8jN8MQZ/aRTqYrMcr1N10gngLIflf2XW/jHB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e/E9Eeh2PUzet22YI8O88Iw5baFBKYDNDBG8ReHikoGDDf2ttcBLGE6cmxdzeE8py
	 LZaaNONaEvRNbIpW5V/RXI1rOH9hKKOchXK33MNwRLRRv6T0PDOsWPl6VFrmQHHNdT
	 MBTy3T4g8Zh5gq+0SmKsvGhF2qo9rQ+gExXfy/wl7kmsj1ZRffdQx+AnbbT6GYYpU2
	 2Pxd/ab1CF8RbHYTb3bunLB3gLT3OC6Gndf4VNqJ7tcuYeUZxRxbw/C2geuMiHuw+p
	 N0WH9Q3lH8YNxUheGihosUINGDxpPScQ74iYB1KPzXnOmrH6mj63Z0B7M5GJlTdWUN
	 0fnG5tzeQaIMA==
Date: Wed, 15 Jul 2026 08:01:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	mpillai@cadence.com, unicorn_wang@outlook.com, me@ziyao.cc, 18255117159@163.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, danishanwar@ti.com
Subject: Re: [PATCH v2] PCI: cadence: skip the link polling when endpoint not
 connected
Message-ID: <bwaho225txqny2p24nyhezmnc4r3yv3yckurvz2gtzxpbeqs5l@tx4mwgblp65n>
References: <20260623095148.721206-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623095148.721206-1-a-garg7@ti.com>

On Tue, Jun 23, 2026 at 03:21:48PM +0530, Aksh Garg wrote:
> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
> during the resume operation blocks the resume operation unnecessarily for
> ~1s even when no endpoint device is connected.
> 
> Add link_down_no_hotplug flag to track link state across suspend/resume
> cycles (for the platforms that do not support hotplug). If link was
> down before suspend in such platforms, skip the expensive polling in
> resume since no endpoint was present.
> 
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes from v1 to v2:
> - Updated the flag name from 'skip_link_polling' to 'link_down_no_hotplug'
> 
> v1: https://lore.kernel.org/all/20260605071922.1724499-1-a-garg7@ti.com/
> 
>  drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>  drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>  drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>  drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index bfdfe98d5aba..48db7a6cf754 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>  	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>  
>  	if (pcie->mode == PCI_MODE_RC) {
> +		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
> +
> +		/* If link is down before suspend, skip polling in resume */
> +		rc->link_down_no_hotplug = !j721e_pcie_link_up(pcie->cdns_pcie);
> +
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  		clk_disable_unprepare(pcie->refclk);
>  	}
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e8..31cf50cff8f8 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
>  
> +	if (rc->link_down_no_hotplug)
> +		return 0;
> +
>  	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 0bc9e6e90e0e..50abc657a871 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
>  
> +	if (rc->link_down_no_hotplug)
> +		return 0;
> +
>  	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 574e9cf4d003..1561022c1a8b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -117,6 +117,8 @@ struct cdns_pcie {
>   * @no_inbound_map: Whether inbound mapping is supported
>   * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
>   * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
> + * @link_down_no_hotplug: Skip link polling during resume on no-hotplug
> + *			  platforms when link was down before suspend
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -131,6 +133,7 @@ struct cdns_pcie_rc {
>  	unsigned int            no_inbound_map:1;
>  	unsigned int            quirk_broken_aspm_l0s:1;
>  	unsigned int            quirk_broken_aspm_l1:1;
> +	unsigned int		link_down_no_hotplug:1;

If the goal of this flag is to convey the information that the platform doesn't
support hotplug, then it should be called 'no_hotplug'. Skipping the polling
during LDn is the usecase.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
