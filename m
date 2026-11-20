Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194651;
	b=MVIm+/EEXIqsTEmXbNOB1RVbViHhoTx5QQTMkbFSNWhhtqcHXQtjBHCvPrRy+FG7fqQs
	 wR8I4Nu0FZ28cmjuKmo0UyBxpLISG6c/GTQJsfW70PxIZcED2EwE2wac+yvwHqCy3gDfL
	 tgRyhVRRCrDTTwTa/GtOxk6Q0sLk4dJlseqg+OW+nccTeYonHFDGFcbEY75LYhGAkhJr2
	 yLV9hiEkATP3NlZZi7GvRwg8wtHNWovRRHs8Ls96lAMma1XiiEistK1rnV9nhsWBAc0r5
	 +q290xbMCHU2kle0P3jFXbjCkkS0Gh0dlk6zQ0eQLGpNQQlhMWSxP4+wKNwZvdf9FtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194651;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GmtUShSZk8dAryboQHhYbp46r+uxEVP1de+hNEmgKDY=;
	b=lPtBoDxvrpSWyT+yMbfsg65aRGfoHGHnCoECxcqkHSCuZ3m0WReVDCQttiXgavbVkq+P
	 pWQ29BQIFc0xo3NWVFxiXptbsyp9k08WO/PXUMdqZnJapoOt/2A1bqxsa/rP5+3kAnXvl
	 x3WQX32InNGLxk8f9kOpzvUh2nHVI/kTTnUFCtVeeN5kpqADjlHFZG0AYXsEM5IspBIW6
	 AReVRrl2sRPFLVogGcKiGEabDtM2GbVvJz4xlNzAzxW2mqnsEsutAF0DusGapCMFG1Dlt
	 8namxU/Ckt8Xg1tu82J/+Fuslzr8QEfcbiIw7VbZgP1ZnL82dP/EBRK8Sos/TLQh+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6flx0zT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74C60A2602;
	Fri, 20 Nov 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6flx0zT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0943E1F000C4;
	Fri, 20 Nov 2026 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194651;
	bh=GmtUShSZk8dAryboQHhYbp46r+uxEVP1de+hNEmgKDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=k6flx0zTNWTz/4HHWmMhyY7XQf2WCk/uNzeZZTqGKCzfu1dKOX7SgmCicX+0to2u8
	 Myl/hBnLWfHAB/5fDKCAagwnHqqrTiwho5PFTwQnlnNdI6JGh3ow/8zKU48W23rGgn
	 Ps7YuHNVPATTtC5KRjRNRFQqBGSetnFR27mmq0LlMWGvAhC0tiHOWGORsD8t8YfUEJ
	 SB1yCX7JvsbzXLH4slxguLnjoezNYUGQjHkBE2xzt6eCrwgay5usOmT/dluFSm+Tso
	 iEXLy3t7dvPYjvEHkktd4EVwfuUqIoFrw8uWLHhmp13xdDc+jjiGBKM5b1Ahro/ZhJ
	 E+pc9WXKmyTnw==
Date: Fri, 20 Nov 2026 11:10:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com
Subject: Re: [PATCH v6 3/7] PCI: Add pci_lnkctl2_bus_speed() to convert
 lnkctl2speed to pci_bus_speed
Message-ID: <20261120171050.GA891038@bhelgaas>
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
In-Reply-To: <20261119-bwscale-v6-3-9a9a715fcb46@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 06:26:35PM +0530, Krishna Chaitanya Chundru wrote:
> Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
> so that other kernel drivers can use it.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Nit below.

> ---
>  drivers/pci/pci.c   | 15 +++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..a89955617bec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6056,6 +6056,21 @@ int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_link_bandwidth_mbps);
>  
> +/**
> + * pci_lnkctl2_bus_speed - convert Link Control 2 Target Link Speed to pci_bus_speed
> + * @speed: Target Link Speed (TLS) value from Link Control 2 register (0-4 for 2.5 GT/s - 32 GT/s)
> + *
> + * Convert the Target Link Speed (TLS) field value from the Link Control 2 register
> + * to the corresponding enum pci_bus_speed.

Wrap these to fit in 80 columns like the rest of the file.

> + * Return: pci_bus_speed corresponding to the TLS value
> + */
> +enum pci_bus_speed pci_lnkctl2_bus_speed(u32 speed)
> +{
> +	return pcie_link_speed[speed];
> +}
> +EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
> +
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
>   *			      device and its bandwidth limitation
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 352079393edb..d12875c95491 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1739,6 +1739,7 @@ int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  					 unsigned long type);
> +enum pci_bus_speed pci_lnkctl2_bus_speed(u32 speed);
>  
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> 
> -- 
> 2.34.1
> 
