Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136127EFEE;
	Wed, 18 Mar 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847942; cv=none; b=KjuWi2bvpIIG9HDECOP3ZE6lejg4eESe509JZPl55kVtzIggEtUhAn3cWSOt4hpf4ONDmJG9+uI1u2xCuTY2/f/Q8h+QeJbHbR3ZQEXIIP8QYhmSV/29RBvUe2F/GOLI84SpCGBPyvmp0miqi0e19G7aJcjxJ2hp50QjYzOGOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847942; c=relaxed/simple;
	bh=zcSDVZOm/DIOWLjP1a1OYnDj8XnY+hRZW2+iIhv+0wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdIOXxj6hz35pbUni1kQFJX0DLN0hIM5+C5cw5hhXcijqgAvNn2/3IdIksbzdd9Eh7I9iIaRsirIeBRBKQcikhZpVZzlqBx0Y8aoBq8q154NPheekW541PSc+17mDOHtl/m3IhJ6M1y5h8EamUCc5FDTiMNU4xWGXphGx4jSUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HutKBBKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HutKBBKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF1C2BC87;
	Wed, 18 Mar 2026 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847942;
	bh=zcSDVZOm/DIOWLjP1a1OYnDj8XnY+hRZW2+iIhv+0wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HutKBBKvVtTWpWIhzWm1Vf+XBqTX1mkoyxJGhDZkh2ysLmG2+CrmtNrCflKo/ibwL
	 7y5SvIXuLCGllVBRvFpkw8CHHIFtoJntrFwLBpVovam+ZWigBAm1xMoS2cY8nqt6mS
	 jy+fW7Qs/ylIuvpS63XkiWV+UI3pmU98Sf+9q0nUJvAkp1eyfLk3DkwHNM2ylIoM1/
	 fZK8iu67F8XrV4m9Y92zdMhXtSegXnau7SeyGpnU6Qi2QRsrOaaF08lQ8Z6256A2Ba
	 sk9gD5kGtG1wchboXsJU4QBkVo/IlBAwsGjFADVRLNa4fxDTOIGE5aJd6cJ2lBwoSM
	 bO6bKobL9LBWA==
Date: Wed, 18 Mar 2026 16:32:17 +0100
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
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Message-ID: <abrFgYcgpmNwDvNg@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>

On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> Handle -ENOSPC error. If the number of available inbound ATU entries is
> insufficient to map the subrange, skip the test instead of failing.
> 
> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283

I would drop the link, it does not really add any value.

> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>  		SKIP(return, "Subrange map is not supported");
>  	if (ret == -ENOBUFS)
>  		SKIP(return, "BAR is reserved");
> +	if (ret == -ENOSPC)
> +		SKIP(return, "Not enough ATU entries to allocate subrange");

ATU is a DWC specific term.
I would use "inbound windows" instead.
E.g. "Not enough inbound windows to allocate subrange"


Considering that the selftests is highest up the stack, I would put this
patch as 3/3 and not 1/3.


Kind regards,
Niklas
