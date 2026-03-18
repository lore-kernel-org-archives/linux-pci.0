Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8F3EB7E1;
	Wed, 18 Mar 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849815; cv=none; b=qA35gt+hdXxzYJ1WF+TDaaxxCyipgUBkPB79+KbVRZPEi+pqcxajvriE94oMGYuMvKPF4/U93VNUf5Ky0tDb4mn3Y/XaH1s2r3Dy6UiTgqperMh3m2V+6D01+XRH00l5oUPtYp57K6sOluSU6Frvp0QSNuPP+lBPvsdDhxBnEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849815; c=relaxed/simple;
	bh=aNn+fWw0djIb7dqDy7dLKcRFCOkUefcH/gjoXK/Vs9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bku92WW2xFjL1IAdWUaj/E74UtnyF3IBKRGAaMRz6s4ceZwJIQDfKtdGzk+/Gw/OZGPTLbfqcVF5Cerwc0gOvMFKdl4GB0bkcAkTs1oXtoXoGZNCjFLhkGnbpw6tPGMktLcSwxcfD4tXkZ61QDCS5xIpH/QgTIvXJ4+tbtKGnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlosT2SN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlosT2SN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D906C19421;
	Wed, 18 Mar 2026 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849814;
	bh=aNn+fWw0djIb7dqDy7dLKcRFCOkUefcH/gjoXK/Vs9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlosT2SN5hWG5HX8Futk7jLWgV7BImofp+/g/PJDRrmtx7DtTLc4HP9KWiGdtFDWz
	 RjJn9ioriyx8OsCUsYxN53VcFjgKMA+2sdXgM7RkdkSIhYWsL/RkZC3cC4O1INHErz
	 wZXzH7hyKz7xsLTr8jJW3eKp6AcDnrQrYrJQ7Va5Rbtq4Ke1Wo5k1qqJHaNa5i2fEV
	 kCYveN1RFfSbAL+Z3pld+VxlAb+du2ZhnlR4FzWuCT+aVKFQAZlp+Qr8BZWKQPHfZJ
	 aVOGKyZ9+R19wKYm3hUZA8Jy8NDKcx96sdheQcdFJam/5U6a/8cBBWX9D18vSww17U
	 xevxCknVq2NWw==
Date: Wed, 18 Mar 2026 17:03:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Message-ID: <abrM0Jvo_sdWSTLc@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>

On Wed, Mar 18, 2026 at 03:46:29PM +0100, Christian Bruel wrote:
> Return -ENOSPC instead of -EOI when the status reports the NOSPC bit.

s/EOI/EIO/


> This signifies to the pci_endpoint test to skip this test instead of
> reporting a failure.
> 
> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283

I would drop the link.

I would put this patch after pci_epf_test.c patch and before selftest patch.


> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..34ba06fb53f04e48c1c05f4aae85e6ecd03ef447 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -61,6 +61,7 @@
>  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
>  
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -476,8 +477,11 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
>  		return -ETIMEDOUT;
>  
>  	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> -	if (status & fail_bit)
> +	if (status & fail_bit) {
> +		if (status & STATUS_BAR_SUBRANGE_SETUP_NOSPC)
> +			return -ENOSPC;

Perhaps this should be something like:

if (command == COMMAND_BAR_SUBRANGE_SETUP && status & STATUS_BAR_SUBRANGE_SETUP_SKIP)

Personally, I'm not a big fan of having a common function for both
pci_endpoint_test_bar_subrange_setup() and
pci_endpoint_test_bar_subrange_clear() and then sending in parameters
for which bits to check. It make it hard to have small differences
between them (like checking for an bit that is only valid for one of
the commands).

I can understand why Koichiro wrote it why he did, but since we now
want differences, perhaps add a preparation patch that makes it two
separate functions?

It is not like pci_endpoint_test_bar_subrange_cmd() is a big function
anyway.


Kind regards,
Niklas
