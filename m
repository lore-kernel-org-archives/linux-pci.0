Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70B19C556;
	Wed, 11 Feb 2026 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800716; cv=none; b=SC5qD/B/eQzSBVF6/J6GqUy8y4f7lyv7Y7X52gCkDy3EbCQg2V+TvbnpKQMs5BdVODzTxodADxnT+256aDVOsaw4g7EITMB6d3qN7TigkuDZK8tOb+NFZ6J/xyjyEPEJ7xJuXcMWS+j69QFddRLNnsItMCSho/a0NFk3wI/DKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800716; c=relaxed/simple;
	bh=2WmEyJGi2PIdrv1Ytr5N0UMQTShez8W3zIKyQXDsmfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs7QH1MoJXPeJWIFUDPOR+XMSvpp2QztKX0S/pXO2WW3zqU93ivV6UyIBKro5EqOUPkfnWS9wXXJVlbvUibu9h1vdc+PgBB4AVa76CsI0MvJ/xjhP9xYoJEtWhOIQn+cOSX7F99qZWq/AMZPR9XNdxvtz3UPRZ96vrf4uj/sKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAweA0oS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAweA0oS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE56EC4CEF7;
	Wed, 11 Feb 2026 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770800715;
	bh=2WmEyJGi2PIdrv1Ytr5N0UMQTShez8W3zIKyQXDsmfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAweA0oSln4PIoR6dkpEBn8yznEUexbwCXTddyNtP5El5MfytfdjNRlfmJ7muN+Q/
	 18/M87JmbzoQZKG7y1AmDHPXGEuygfLmARa3lcRtOTyPFTnfzaqbVIibThOz94hLKh
	 XVYziRIRnhw31IkhtPLr6tfvY7I5moPtWQnu1ehunuxSH5pQHclxMRHIorthIY7xkV
	 Dm9Vs4NQESkLcwSuB/Iw77IOOWczy/94Nake8hCbyYGBjPHTp07qUq6s01bgnBZaxY
	 hQDczKWC89d9WY4vGsntxtg84PZGRWOjvA7W3Pj0Wv0RvD05FZE3y+sYdS899YIwIl
	 7596+P0O5+jyw==
Date: Wed, 11 Feb 2026 10:05:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <aYxGR-x3lGt7H1dp@ryzen>
References: <20260211070812.4087119-1-arnd@kernel.org>
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

Patch is fine with me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


However, I remember that you Arnd was one of the main reasons why Kishon
decided to use configfs to configure a PCI endpoint controller and to
bind a PCI endpoint function driver with a PCI endpoint controller.

I don't know of any other way than configfs to bind a PCI endpoint function
driver with a PCI endpoint controller.

To me, it seems a bit silly to be able to build PCI_ENDPOINT without
configfs. What should a user do with a library that they cannot bind to
a PCI endpoint controller?

Why shouldn't we just do something like:

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 8dad291be8b8..d6f898094509 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -8,6 +8,7 @@ menu "PCI Endpoint"
 config PCI_ENDPOINT
 	bool "PCI Endpoint Support"
 	depends on HAVE_PCI
+	select PCI_ENDPOINT_CONFIGFS
 	help
 	   Enable this configuration option to support configurable PCI
 	   endpoint. This should be enabled if the platform has a PCI
diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 0c9cea0698d7..d7a4bea7d7b8 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -16,7 +16,6 @@ config PCI_EPF_TEST
 config PCI_EPF_NTB
 	tristate "PCI Endpoint NTB driver"
 	depends on PCI_ENDPOINT
-	select CONFIGFS_FS
 	help
 	  Select this configuration option to enable the Non-Transparent
 	  Bridge (NTB) driver for PCI Endpoint. NTB driver implements NTB
@@ -30,7 +29,6 @@ config PCI_EPF_VNTB
 	tristate "PCI Endpoint Virtual NTB driver"
 	depends on PCI_ENDPOINT
 	depends on NTB
-	select CONFIGFS_FS
 	help
 	  Select this configuration option to enable the Non-Transparent
 	  Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
