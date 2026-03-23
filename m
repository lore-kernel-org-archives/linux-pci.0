Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6538C2A9;
	Mon, 23 Mar 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261378; cv=none; b=jvPgAlHF2mQ/+Qa/Z68fRQG+hM9fk4AuZ9PfXoP0OOKI7iiWuAQeuNw05UIe4QiIz+0VDB2DH777NeOkAEOiuAeMdcxM+TwU53lkJNm1mU9rC+/UQOLokpmA2MPeaMQk/Bir7vg/cYlyCEa9UphbJeU9og4mb6/HFJnX9hVsu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261378; c=relaxed/simple;
	bh=kwL2TZG3MQFr35EFwGgX9orSEW0x8Jl+Klg6gb6T7VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkTu6g8hAjo6oikjiiSHxCStprOplrbZjTBHmJKkKmifueubNxDv02lgXZm0uyA9vfFarmH0uSJV1Kavp5+RswF3cdgeWSGxAaziHSn+pZ/wEXt5BLzhsJEIQbeJ+x5CZWEQfaF10exIxA10/3CMTk2z6QVbWZ+kh3EN6SEbjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOlHdU8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOlHdU8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED2C4CEF7;
	Mon, 23 Mar 2026 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774261378;
	bh=kwL2TZG3MQFr35EFwGgX9orSEW0x8Jl+Klg6gb6T7VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOlHdU8HjdXZrHUJpophZZUWOmX4XjGXgXZxbvT7qDRhYl0co/tLLvrzY60LuJTQC
	 F/l5cFJYSPT49O7p0sHmjqwBId54LFi9uafzOV+W20uCtAGPRpe9vDanpbgVZYi51A
	 co3ZNK2Y40L68hpZvOp4ckcZdpUOChw6n1+Y5u+CoYiYd95DW3owOk8cc6gs5Gpx/a
	 5eKQI5OrlRHzbOU7S0b8Xj/gxSSYHZC3/FQ0BXnF+QjvNTDQzogIFQtbUQQxO3YIue
	 jGOVrxf5xWg0+t+i+0aEJBUcu1Vf4UQMsngxxL92T6WT9sLNABRpl5CQ4iTgw46oNR
	 NY9+2W62mwxwQ==
Date: Mon, 23 Mar 2026 11:22:53 +0100
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
Subject: Re: [PATCH v2 3/3] selftests: pci_endpoint: Skip BAR subrange test
 on -ENOSPC
Message-ID: <acEUfaPC1BfirjYc@ryzen>
References: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v2-3-2080f878134d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v2-3-2080f878134d@foss.st.com>

On Mon, Mar 23, 2026 at 09:15:25AM +0100, Christian Bruel wrote:
> Handle -ENOSPC error. Skip the test if the number of available inbound
> windows is insufficient to map the subrange.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c417fb3a198b2d92c3060938c23807cc8bea5573..97212a0b41c930f981687086b588b056cf44ee62 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>  		SKIP(return, "Subrange map is not supported");
>  	if (ret == -ENOBUFS)
>  		SKIP(return, "BAR is reserved");
> +	if (ret == -ENOSPC)
> +		SKIP(return, "Not enough BAR inbound windows");

Nit: I would probably just print:
"Not enough PCI inbound windows"
or
"Not enough inbound windows"

E.g. DWC inbound iATU supports both BAR match mode and address match mode,
so from a pure hardware perspective, I guess the inbound translation just
matches based on the PCI TLP address (with some extra logic for this to
automatically use the correct PCI address when using BAR match mode).

Thus, I slightly prefer to not include 'BAR' in the print.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
