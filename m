Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0E361653;
	Fri, 13 Feb 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988898; cv=none; b=hidzw3nUkrBHpl/7wKkaGrciy6t6PBn5aZszisXvvKvhZrBdUMr9oTnYMnQzlMujXVUI6dEWEqUCejLSwuFv4S03jcvmXSF4+IGy1wOcoW7H1ZDwY8KJg6hoePw1pkVULWoiQz+ycXAQ3fQQRs+yfJTWlR5VWKpID9GOHqTvI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988898; c=relaxed/simple;
	bh=kyXJnbWHtVqYzU5oI/WdyhgLoBcZVbYqrHuJ3jB/U4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqcw1HunV3TrDRkqnvpgRWbFrchVfyznl77ZWl3Uby3tkkAJsqQX349Wvw1ZNUmK11zqfZmq2WJzai6MyyVoAPpMWVwZ4Nm0jDlv/J+O/cNuc5AoK8NJmQpgsRGdtVLJ2qHlNGZMXufDZLWrQ7sR6nWpxxUw9rQ2NXY8B8hgepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALpCMQrr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALpCMQrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D84C116C6;
	Fri, 13 Feb 2026 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770988897;
	bh=kyXJnbWHtVqYzU5oI/WdyhgLoBcZVbYqrHuJ3jB/U4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALpCMQrr0ThiCKs5Z2kZgO7LXj0dgJ+wuLIhhja7r5of6AI9dLP3rLHsUr3UWi4DV
	 479gca9of6f3glzP0Awfxi47pk5N06aQzyThnY0HixbhHuvPdkUbpA719YPbYMqMXv
	 +yDG/jXwOtV0gxJQ88fqbUspNyFkARcaNDTV5//2g+WkT3s1mGzU8CQAEDFfJQGbRe
	 nPQjoRSXyqMKD/R0wRAJlGTO8LVbb0zPLzFpRE/NIH4ZKBkQrn++RTdVP8AZ0kv8Kt
	 A0htIRChPUaDEd3wyfRcto1mam6BqtSXcAvSMYEq6QwNOKbFQR7uKs/+0K+BmIbqy6
	 paPpSfliixIFg==
Date: Fri, 13 Feb 2026 14:21:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, s-vadapalli@ti.com,
	danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 3/4] PCI/DOE: Add DOE mailbox support for endpoint
 functions
Message-ID: <aY8lXB5JB3ffiUlK@fedora>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-4-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213123603.420941-4-a-garg7@ti.com>

On Fri, Feb 13, 2026 at 06:06:02PM +0530, Aksh Garg wrote:

(snip)

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..2a57a314054c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -146,6 +146,20 @@ config PCI_DOE
>  	  Say Y here if you want be able to communicate with PCIe DOE
>  	  mailboxes.
>  
> +config PCI_DOE_EP
> +	bool "PCI Endpoint Data Object Exchange (DOE) support"
> +	depends on PCI_ENDPOINT
> +	help
> +	  This enables support for Data Object Exchange (DOE) protocol
> +	  on PCI Endpoint controllers. It provides a communication
> +	  mechanism through mailboxes, primarily used for PCIe security
> +	  features.
> +
> +	  Say Y here if you want be able to communicate using PCIe DOE
> +	  mailboxes.
> +
> +	  If unsure, say N.
> +

I think this new Kconfig should live in:
drivers/pci/endpoint/Kconfig


Kind regards,
Niklas
