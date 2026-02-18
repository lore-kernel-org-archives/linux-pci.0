Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC73314D2D;
	Wed, 18 Feb 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437644; cv=none; b=CrMKvhPrlv9TMYtEkA1LOUTSx9RVtGEn7wtwWhvPRpIlUjFsqul2JTmEA248Zc4Yt4phhYsFEzbVktZTaCeY+xLCpzk8u3EgvdAKyEu2SJIn2cT823YnKES/7NAyLba1A4L281SpT1yJ/lD0CmEtVMqCbXHHOrzMRowOJaQZ6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437644; c=relaxed/simple;
	bh=XIZkVBIPngMOb3m1FNN0V6rroILRcrHcBG9TGONdAfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OsHL+iO8ZcY8X+T8IXiz7qQwwCzaGx5ikZHRxAve4rMae43Wyf4gvu/Bg2/LnvQPvHa95CdpsumEtN+U+ZgOZmwBG9KkPGFDRF0zIyZfUIuzusecPaw/V+iI/L0aO4kGXXKJfMw0XyYEntZJo5sp2UsTVPz9STnnhFbAu2T7HrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/OPbtpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/OPbtpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35168C116D0;
	Wed, 18 Feb 2026 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771437644;
	bh=XIZkVBIPngMOb3m1FNN0V6rroILRcrHcBG9TGONdAfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y/OPbtpwnKXdxEEGt1WMmF4a4SlRviepx9aLJSVqLPMBUQhNuvPd2GPUqkgZ+G/Tw
	 VRrhgSbc6wc5xGYhxVk7MNNvj+TrKGlpCBtR6N/XElMQoczXMj48NWeqDfUDfeaIEU
	 MqE8g9S5iWgNQCpZKLV/Lyd6/9z3cz2k98WFbYLigajPa7J7o56Z6u2deciB/NLqg9
	 OHSuzoUh44Ytv1/Tf1PL9TNvioO3Xe4i5zGEAJLygxmr/mf+nnZ8wWgVvRZo2ulhsm
	 rZVtnSiS2T7AnCT8e5tupSLHVXTd0JKJrpUf8nZXIiZVwTIExIV2fpSC2wCXFFjpja
	 eq5D4R4P9Ghgg==
Date: Wed, 18 Feb 2026 12:00:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <20260218180043.GA3435074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211070812.4087119-1-arnd@kernel.org>

On Wed, Feb 11, 2026 at 08:07:40AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Like some of the other endpoint modules, this one now also
> uses configfs, but is missing an indication in Kconfig:
> 
> arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-test.o: in function `pci_epf_test_add_cfs':
> pci-epf-test.c:(.text.pci_epf_test_add_cfs+0x2c): undefined reference to `config_group_init_type_name'
> 
> Select the symbol as needed.
> 
> Fixes: ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to pci/for-linus for v7.0, thanks!

> ---
>  drivers/pci/endpoint/functions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 0c9cea0698d7..bb5a23994288 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -6,6 +6,7 @@
>  config PCI_EPF_TEST
>  	tristate "PCI Endpoint Test driver"
>  	depends on PCI_ENDPOINT
> +	select CONFIGFS_FS
>  	select CRC32
>  	help
>  	   Enable this configuration option to enable the test driver
> -- 
> 2.39.5
> 
