Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57032D435;
	Thu, 22 Jan 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071520; cv=none; b=XMh/NtyzIWUOJLMwwtV9Hf9bBJijWkb11BJa+6l6ItBwWpez79HIxkFt5AvhddoCYYDxzk8+0lvUdWOI6YNsKXqNvY+I6jBm10E183T/7o0jAl1q0G0gZAF9x3sbfSR3LG+Ne/mJxBWvnUgPPC1hqo8bPddbkcJnByAGH5GV3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071520; c=relaxed/simple;
	bh=j7g22cBbVrss28m1TSmy8QBMuJe5SKfMjovK/r1GnQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emV3umfcmzo6t10y1tlot1kNy0ga9Qr8PieyCC1EECpJ7oK7sywiE3h/xHsTEVHQLahSs5uTC7RR47hbak+iOPH0Roht3XdyJsdjOHbLHMeXexwl5Y8L3V0kPHNmmHNsalP9On6HZSQusddUJfeIK96rj34qbznOFYq03Vnr/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANXGV6hh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANXGV6hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532EC116C6;
	Thu, 22 Jan 2026 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769071520;
	bh=j7g22cBbVrss28m1TSmy8QBMuJe5SKfMjovK/r1GnQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANXGV6hhxVc9EyGxbTbeyhPSij2lj6qUjeX7IuRhfZl3uS55ERl4bs+GviwabhioF
	 oaeYwUgJ6JQFEfKBJc7IVQlxmy82lnFbJa5l/JrfUopOX4UAFrjzWNgYzpyUDZWymx
	 kERWLBLICKljFAVQyMCpXu8QNBO5VHi/hJsvT5XeWPfBUAiWwLIUAkxbgbGtTysflz
	 1a7qFPvRpyhDaaMHKo0tIWVF75AQ9+gI622rka1MSxtX0nKHpVfWoX7AOcSbf11Eo8
	 JfvjYlhSHAVei7NbkNQSuCFYZ+ULNKkWNUhguSXEV2haFfT8AwyviGlbIevRxHuqY/
	 SbqECoysAFxUw==
Date: Thu, 22 Jan 2026 09:45:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXHfUyd0EPFnoVBO@ryzen>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>

Hello Koichiro,

On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> > 
> > In this series you didn't add a consumer of this subrange mapping, which I
> > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > the BAR needs to be split into multiple subranges. Can you explain that?
> 
> Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> work referenced in [1].

Another consumer in your RFC series is pci-epf-test, specifically:
[RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
[RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
[RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
[RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage

where the pci-epf-test exports the eDMA registers (using subranges) over a
BAR, and then in the host side driver, calls dw_edma_probe() on this subrange
and uses the host side driver to control the eDMA residing in the endpoint.

Most of your patches in [RFC PATCH v4 35/38] have NTB prefix.

Would it not be possible to simply include patches 35-38 in this series,
so we actually have a consumer, or do you need some other patches as well?

E.g., perhaps
[RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window

Would also be required?



Kind regards,
Niklas
