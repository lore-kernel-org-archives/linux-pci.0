Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B3411689;
	Thu, 13 Aug 2026 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601494; cv=none; b=oSjAH2JfoC9zzOU6F7LGIPHYO1iNGwtcqb4q7NkchYuiDSfJMagSzt4H53YMnGbRXG1IqlCi55KEK8Tq6831Hmsf7DFMQoy5J45CIft8BV+RNmgiKzpgb29hapR6TqgsYmwJoo2UftOI3H3FDujjEbSLj491L28nHomiHOerKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601494; c=relaxed/simple;
	bh=+S9gUgJJG5dE8tUT/F2b9epT++riJ2gSXPB6Cug0CW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/OV/LXxyPJZnehqWyFQJJRY1g6G1cX7iURvHCebe+lIszymIoDMfasb5oyEAXl6t9J/ChE7S9weLEiGy+eQFd9fZ4/Ig4/dFOJlaxmjmI9PO136/fO/UyFObz5UNRC/ihCfIzq2JKhrSXC9WLvMF5t9+Ni0oLc70eR19ghCe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyWc0Tmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyWc0Tmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E7E1F000E9;
	Thu, 13 Aug 2026 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601492;
	bh=DiMpXMq2kKaP+/B/szyplC/vH/8xNTofLUmS8swihFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VyWc0Tmo9Wv+fxLqcqJfoaVGgyIFTg8mA9I2WCIdrV1QhOhk/pHP7vS7rvv1ltU6I
	 VosNxR+wFEEK9LvsGX49PU51B+sEQ4fbwP6kf8MrSBccfoIYW2noKBrq8KDv1C/0nm
	 LAAwNqC5ItPAwGRtaOovKD88dwL0TNKWPeM5UuZP46QVB5pwvsoJHFVYKL4nKa35um
	 TOPlt8xTz0pZ4//OsCUp50dskPk24OJ72Fy4lRbUd+Cz3GxM1hY5LxUaEyZTGrpj9A
	 88VqnFOkXHpvQJfCCjACPAdQkYAi3sqUEkaTrZocWqwNP3lICrVOPt3YSi7/DFSzXb
	 Vyys3XXQQL7Sw==
Date: Thu, 13 Aug 2026 08:11:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Keng-Yu Lin <keng-yu.lin@hpe.com>, "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Vamsi Attunuru <vattunuru@marvell.com>, Alexander Graf <graf@amazon.com>, 
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Andrew Donnellan <andrew+kernel@donnellan.id.au>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <Akshay.Gupta@amd.com>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/12] misc: Unify code style for various *_device_id
 arrays
Message-ID: <oydzthptc2dbmpj3t3oubi47xsacf6ulqv42vcjzhk3sojvyxd@j52tf7obevx7>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>

On Fri, Jul 17, 2026 at 04:50:58PM +0200, Uwe Kleine-König (The Capable Hub) wrote:

[...]

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3635741c3e7a..a10fce77e0b4 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1416,18 +1416,18 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
> -	  .driver_data = (kernel_ulong_t)&am654_data
> +	  .driver_data = (kernel_ulong_t)&am654_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> @@ -1446,8 +1446,8 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
>  	  .driver_data = (kernel_ulong_t)&rk3588_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
