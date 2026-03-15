Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFB28726A
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773592624; cv=none; b=E2WpmB0H5gLr40V5EOmZnrr2I1TJfOKeAFwNqur7SSXArGJx6es+2a4nYD7w2UpwcS93PqHlGJK2oDDiQ41kV3Zqt+xwpGUXbkjksP8S/vStQRpMs/EJxFZ2r4ImkvbNJYx2QuprrhW8Wvo2SFnC7aHdB8ZWl969EQRq+AQx3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773592624; c=relaxed/simple;
	bh=qOmcYsZK7XicrVxE5+z1nuQLuQdsWY6oYuG+7of3r3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMoG20o+6ULczt3vKo4tn/yqQZC90HyrzJfjpPRrqPc422+KhHZ9PtUsE0TVv8TucMCT7A4FKWRIIeuudi0Rd31FCyydZqmkXJE4Lbv+Ne0pxqF1MILZmZXVnQd0pyALuiDnlNHjih9l5UOQvd2p+TFRuL4m3RkKaP/SvxjmHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSGlTEYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSGlTEYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C31EC4CEF7;
	Sun, 15 Mar 2026 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773592623;
	bh=qOmcYsZK7XicrVxE5+z1nuQLuQdsWY6oYuG+7of3r3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSGlTEYh1xfG4NEgMycj2rR8yo6Bk/3wVJuRNeoeeinR73wnnwbMquSrLhtuU30Mp
	 4p/ysFMDFKl22DzJ3ujvEgfa9I9z77mfOqFrmhvd6XK1dD+/pa68BsxVY0ie8ioRT4
	 0KJrXrOFzTuM7dHh4fODgywa67SxpYPcGXT7iofn5/NUYBOM1b23cT1Be2hitwHy7t
	 djPsgiI4DdunZPZl0ZnRd0ZS4Mcqqoo3CkKB9TxF3a/Esg3gi3438aPur1Eu6HjZcd
	 5tIbo7CvlrFE5MJLACL8YwYADH9/0mDxbHxy4zn2RBr8SUEMwTt4lVGpjWhl2dW4Nl
	 RNByPLX+QYVoA==
Date: Sun, 15 Mar 2026 22:06:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 09/10] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <k4lsuvv6qxl37mgpgzpv7tfkfe25bokermzcl655eaz2jd4urp@rkqhqb2ltjic>
References: <20260312130229.2282001-12-cassel@kernel.org>
 <20260312130229.2282001-21-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312130229.2282001-21-cassel@kernel.org>

On Thu, Mar 12, 2026 at 02:02:37PM +0100, Niklas Cassel wrote:
> Give reserved BARs a distinct error code, such that the pci_endpoint_test
> selftest will be able to skip test cases that are run against reserved
> BARs.
> 
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 93cd57d20881..89d0aba059da 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -85,6 +85,12 @@
>  #define CAP_INTX				BIT(3)
>  #define CAP_SUBRANGE_MAPPING			BIT(4)
>  #define CAP_DYNAMIC_INBOUND_MAPPING		BIT(5)
> +#define CAP_BAR0_RESERVED			BIT(6)
> +#define CAP_BAR1_RESERVED			BIT(7)
> +#define CAP_BAR2_RESERVED			BIT(8)
> +#define CAP_BAR3_RESERVED			BIT(9)
> +#define CAP_BAR4_RESERVED			BIT(10)
> +#define CAP_BAR5_RESERVED			BIT(11)
>  
>  #define PCI_ENDPOINT_TEST_DB_BAR		0x34
>  #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> @@ -109,6 +115,7 @@
>  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
>  
>  #define PCI_ENDPOINT_TEST_BAR_SUBRANGE_NSUB	2
> +#define PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT	6
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
> @@ -276,6 +283,11 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return ret;
>  }
>  
> +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> +{
> +	return test->ep_caps & BIT(bar + PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT);

I've replaced PCI_ENDPOINT_CAP_BAR0_RESERVED_BIT with __fls(CAP_BAR0_RESERVED)
while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
