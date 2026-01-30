Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171C2AEE4;
	Fri, 30 Jan 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767043; cv=none; b=Q/NUNYeWKycpNq6wjIcwRsulP8g8m1kz9u8Tbz2hSWFIVQpX83JHdSsewdeFk9n18yfeCRCottZbajfP+5+cTrLi2ZDTOvtpb4nnBVEpdExAj5rIjixHQK8R86ByTECJUxqVKHtQ2c+KXfZ4gnF/th1hwGvwcqHhFOOUARjDKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767043; c=relaxed/simple;
	bh=VipHF8LUWJo7+GiMXyPttaDivCFGrozVFJ/qVru9nW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrvdY3bXJjcUoqjEhVNSbJ1at5hQ2xAmqR4m9z83EEeZtHgTAhIMs2U9e4XpqI/EbPo80XGNsN58n2xYsWQCluQ3Eew15gxBRo4jOkhpZy8wo2bpHK+JFZ7k/ovXzCzFmGelK1jXP3A8pDOihumykHQMSgGz+AsQf/f3A8Tw9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+unsv1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+unsv1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF23C4CEF7;
	Fri, 30 Jan 2026 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769767043;
	bh=VipHF8LUWJo7+GiMXyPttaDivCFGrozVFJ/qVru9nW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+unsv1dqq1ksoOmJ/duFQPIfgpS2e2LufXkP87csNx8oeJhRmiO/KASI5ZD1drpx
	 uYH5a/WOXz0i6/hNMJ2WD6bCxFiPktmTw7BWw/SmiVkTlhvomRxOMvBT9e0pd33e69
	 JrItY1DIfd0UOyFVkzccsF23/DQQPco+0G+kV7HbsauYRGtphQM+GEucoCIyiEzH+b
	 kzNzZ1vg6jlw8nPobNvZQJApKh/48PypQF1UVRIAgxqSisMqWmineIVxzd0dsB1/zn
	 MJ0/UlLPbLhWMg+BCF4J+ZqOlxma4FGsGdsKuh/CtoUu/Ba9fClsf1rXtMXQReXxNh
	 By1W5RgjHezQw==
Date: Fri, 30 Jan 2026 10:57:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aXyAfilrBOe1cEEk@ryzen>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>

On Fri, Jan 30, 2026 at 11:21:32AM +0900, Koichiro Den wrote:
> > 
> > Koichiro (he is on To:),
> > 
> > don't you think that it would be clearer if we had a:
> > 		return;
> > 
> > here...
> > 
> > I mean, a BAR can either have a BAR match mode mapping or a subrange mapping,
> > but not both... So continuing executing code beyond this point seems pointless,
> > possibly even confusing.
> 
> Thanks for pinging. I agree it would be clearer. Since it's orthogonal to
> this series, would it be better if I sent a one-line patch?

Thank you Koichiro, I think a one liner patch for this would be nice.

You can also write in the changelog (after the ----) that Mani can squash
your one liner patch into the existing submap commit if he wants.


Kind regards,
Niklas
