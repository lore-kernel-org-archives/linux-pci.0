Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B0145348
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364751; cv=none; b=R23G3bSwyYBPsFSPNuwUDbsihzD0GcaQah+O4EhCGQ+zhPjAsi98M5dCoBJYH32E0n0sB5pys3HO8a25KCEmDlUKKt4zFa3hraTbDrynvhfyQ9eTkrQv7QTHMIwCvyizaAQok8z5voJzWdZ8TGl0Mxk7XtSY8B5eePIwBFXvtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364751; c=relaxed/simple;
	bh=hyGuqDP2QSCOQCTeDc0kVEtynPm7nSb2nSLKBvzaVkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh/4LTccH07KzndHHufjit/1WYCI3NFDfeudn5+3QyhZMhCNJzglVLRcbZWwx9OavWt6V8KBjzAjmWXzYz/wp06vI3yzwqwTkYWQJ5BBl1ji8K7vK5n/UObh/QJE32hL6vXYptCVbG7yFCH0JCJgJgUS+P7SmQ0HDBuL6g9HUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbocJ/hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbocJ/hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CF7C19421;
	Tue, 17 Feb 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364751;
	bh=hyGuqDP2QSCOQCTeDc0kVEtynPm7nSb2nSLKBvzaVkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbocJ/hXXq5gO/BMntFoqG7AebGB/2c1emPhB2gHGQDDuw9iYUn042t6OgJ2knnPR
	 B4SWaXTHohk6e2DFqzNYgItwp0yriKWeIfXMIE8NAq/kejiG1hplH9Bgg/D+UGM99n
	 H6VAEFpm8CtT2IDHtHuO+NkhY6TaIK9xE6oWMIlrQBKA2uVCSwoFGJYhORIqjzPAHw
	 If/tmMQaVUDIvG7XVjNf1bR4lJS9Wm3v21lcPzKzofBIrCHQqvK/k+B8SZmjIAbBa1
	 LpCm7yPN7/UGyKZP8uzCn0wJJSl5u/Kmku/KOWPNhAH5RUW4yPOu1F6SEE0sC3+0Bs
	 y5XFscq+z3TLw==
Date: Tue, 17 Feb 2026 22:45:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <aZThizkq5MbGK4NA@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-19-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217212707.2450423-19-cassel@kernel.org>

On Tue, Feb 17, 2026 at 10:27:14PM +0100, Niklas Cassel wrote:
> Give reserved BARs a distinct error code, such that the pci_endpoint_test
> selftest will be able to skip test cases that are run against reserved
> BARs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 74ab5b5b9011..7cffb6e77c4d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -84,6 +84,12 @@
>  #define CAP_MSIX				BIT(2)
>  #define CAP_INTX				BIT(3)
>  #define CAP_SUBRANGE_MAPPING			BIT(4)
> +#define CAP_BAR0_RESERVED			BIT(5)
> +#define CAP_BAR1_RESERVED			BIT(6)
> +#define CAP_BAR2_RESERVED			BIT(7)
> +#define CAP_BAR3_RESERVED			BIT(8)
> +#define CAP_BAR4_RESERVED			BIT(9)
> +#define CAP_BAR5_RESERVED			BIT(10)
>  
>  #define PCI_ENDPOINT_TEST_DB_BAR		0x34
>  #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> @@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return ret;
>  }
>  
> +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> +{
> +	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
> +		return true;
> +	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
> +		return true;
> +	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
> +		return true;
> +	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
> +		return true;
> +	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
> +		return true;
> +	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
> +		return true;
> +	return false;

All these "else if" could be replaced with regular "if" since they have
have a return statement inside the if statement.


Kind regards,
Niklas
