Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A235B653;
	Tue, 17 Mar 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742371; cv=none; b=HAj2uXgkW/kQJ02riTDYeDHqhYlmnLrB2iXY0jyU5OMao4gZsRAjpm7pTUVj/1WHi6LNYjpaYsnySeky2v/1CEPF+DFnqL/1x+pa1DnH0bEkmkRIEZfXGL5+jn4AU2c7LXvoAyihB6uRFj9l3ra/AMr/35lcIo6j2gSVdG+N+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742371; c=relaxed/simple;
	bh=MkKyld2d7aCJrRXOuXrYB527bFPu/PqYsDSu4AcYE8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0ymmwZB2W7t9DegBBuHxogfrNuUxNw3KF0XKoznjgCQ3pEv7omRVVaKTzmekx6/+RvC2Ram9l25Hmi/e4xq0AvRqEyutOJSgP7dTLd6yrXW7pC5FPq8L47X05+xOHcA7+xJ3r7y3o1EKUqtJ2jsIYKRJMTIFo7HU7AFcpdVbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpfEkGbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpfEkGbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE5AC4CEF7;
	Tue, 17 Mar 2026 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742370;
	bh=MkKyld2d7aCJrRXOuXrYB527bFPu/PqYsDSu4AcYE8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpfEkGbmrpw9L8YgJy6FjPd5fv8NVzO3WIxSlXy5Tj89DTO8r9d6y+VC99okDT2BY
	 xG0u13++0mVW3+kKfaxmi5ddKt3sBgk52N+XSTaQnTFNqtgeWwMH/v543G9NcgbusJ
	 i2lfcW12EYJAZPUig5I6qDecZEsRvWyCT5Q9lhdU0RB4/L/8LQB8r+kRjww9w/2v+t
	 9cqMB9uOeCAytd+TtkKTJe/wlCD0K3T8NjSuw5n2i6bXPWXs73LlDuzxV0ymjlwV54
	 AgcdUPIz4VuikRRZy66UnGjtO3SJoz25bh70m3/fbEx6iNfWaSLbp6M8ziD5h4OlD2
	 JWnbikb57bZ6Q==
Date: Tue, 17 Mar 2026 11:12:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abkpFpD3cM_cI_nB@ryzen>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>

On Tue, Mar 17, 2026 at 11:01:28AM +0100, Christian Bruel wrote:
> 
> 
> > 
> > So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
> > BAR_SUBRANGE_TEST)
> > 
> Re-checking this, no need for ENOSPC test. The real condition would be
> EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.

Are you sure that it returns EBUSY and not ENOSPC?

I would have expected the error to be ENOSPC when there are no free inbound
window:
https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/pci/controller/dwc/pcie-designware-ep.c#L307-L312


I think a SKIP ENOSPC case in TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST) in
a better solution than modifying a STM32 specific helper.

Because the former will ensure that we skip/handle this issue on all SoCs
with few inbound windows, not only on STM32.


Kind regards,
Niklas
