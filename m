Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7925C6EE;
	Thu, 19 Mar 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910041; cv=none; b=DSJxS5G9xfok/yDcgZ/Rbq4WDLVJGmmou5pgWpt7d1Y8vcRM4UwE5Bz3+iHEpeHeOZ84jd6sMV3FVi13h8Le5FnDzV2fd/9JpFSEv8y34R15quGcPs5fgqXRHv65x6wm21tE8uhapII7HIUNfirXwpfiKiNn+p/Uej52Hbvm1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910041; c=relaxed/simple;
	bh=pwvwZxQZtDDSZnYJ8zrqkuvH3FZMuj6jpLZlzktWxo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOYXzSQRzEXTOpS47MqOLMHw8uoW0rwPiCZR810D+KNw3dGPqIMVn4eT/77C0r1YAxJuUdmJN+I74aseoaW30NiByQVeOkZWQdP164vMWV9u7aa2t2NyKkhqCiDyHYWuyW6/O8UvssjNpJMJEZaS+gilPW1UuKdRbgA17ZHzigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnt6CYgG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnt6CYgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08CAC19424;
	Thu, 19 Mar 2026 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773910041;
	bh=pwvwZxQZtDDSZnYJ8zrqkuvH3FZMuj6jpLZlzktWxo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xnt6CYgGMmfUfnixFGE4K9swNrbY3fC8suhYsT4AJgjRqnwVXqhrPL3uB/xUUwuc8
	 sMFfFyFu6j5LPK8rspzTycLGV3Jl0kA+AikWek+n1osvog0PSsee/D/eFnK/Vx+t44
	 ImdeqfpU0mG7rYS8j1kuyogr1zXmkER3YZy99pCgYVrxXKB37oMFj0jtqILmfhR/bH
	 FROv35LALmFSkIet48BnZM3jTcx8MyPlJMp9OAaManIMjQQWlqgwVq4gtw5ol/YBWm
	 eQFpidkwLxDpk98CUa1VCvYV4aUTruIxTH+o5c7WrpAYrOIVoGbOo1qBCyGiBGHe14
	 NpFYSLPvUelzg==
Date: Thu, 19 Mar 2026 09:47:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Message-ID: <abu4E-cQP7SBv1Gt@ryzen>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
 <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>

On Thu, Mar 19, 2026 at 10:28:41AM +0900, Koichiro Den wrote:
> On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> > Handle -ENOSPC error. If the number of available inbound ATU entries is
> > insufficient to map the subrange, skip the test instead of failing.
> >
> > Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
> > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > ---
> >  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> > --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
> >		SKIP(return, "Subrange map is not supported");
> >	if (ret == -ENOBUFS)
> >		SKIP(return, "BAR is reserved");
> > +	if (ret == -ENOSPC)
> > +		SKIP(return, "Not enough ATU entries to allocate subrange");
>
> Thank you for handling this!
>
> pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
> https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
> While that is a different resource limit case, I think it would still be
> reasonable to treat it as SKIP as well.

	sub_size = bar_size / nsub;
	if (sub_size < sizeof(u32)) {
		ret = -ENOSPC;
		goto out_clear;
	}

What is this test for anyway?

If sub_size < 4 ?
 return -ENOSPACE ?

ENOSPC seem like a weird return for this.

Wouldn't EINVAL be a better return code for this?


Kind regards,
Niklas
