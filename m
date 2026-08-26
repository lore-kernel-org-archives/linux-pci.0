Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150634F49F;
	Wed, 26 Aug 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743933; cv=none; b=dxOCTRNFNM2uXgzYzoumhSj6ESx7TNfcYgBacAKUblkStFogUHU/MhVfa3AG9v5aePvajZ/0MF793Lxkj/ruIPK0ugRdTh6yvOiPBhT6G+O8udpR0sT0+cO127KsqKsUEn/t0HlTF3SyZtoFybR4imZVXGtXZYPdMJ6YVqQNFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743933; c=relaxed/simple;
	bh=XyKqh3iD+KmcwDWPOk8IzT4qJt31ZyUsuNq81scfDp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=P6JFH/UOPpIJRaV5or756Rx8RJxJ33+qMyMhAj1M0IG1Fs+zcQutLgN91Ml9lS+cBXMs3G/nIsSAmnRrOnW2/RUM/2GIeoWy2Ef4v6/T5UKE1VYLZm34HOU8XCI9V2nMN8ALbdZvUyM/GKFSc023mpH1W3h4LLgzFOoShiI0BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+QUErqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+QUErqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288FB1F000E9;
	Wed, 26 Aug 2026 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743931;
	bh=QPpaCWX8PK44p8ci4YplG9h2mslNj5HzQdtXsZRVyrE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=P+QUErqk1/9+DlBCJYbljLYLA6nZlBrWp7SquRyjufZRDDVr4vWncvSpQSCVr4OpD
	 NnoeKewuWmuiOieXhZ/hh/IqB7YjpSjkY/OPqPFqIA4q+JrdIrSxv3iuwL+yxtZp4I
	 Ce48Rie5l3GoLfljKs3zXf7bQLqlSxOne+1ABWXLu2Xrn7WE1PY+vRnZBPqnzNMLZQ
	 GSMJXJLmab6vBSlDJZvar1JoBp77YFUWPCezva2A0f1iMMdF4Q1fnG0W1CsxqtJMig
	 bL61g3xPzdbjCV2p2h46BR8Tk5QiceuUXoFJpX8xS3hpoLG1cjKZ5ZcM92BgJ41+qd
	 hKqmLqIqVoKiw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 13:32:04 +0200
Message-Id: <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKYU6ELNN060.154BHE2QG442C@nvidia.com>
In-Reply-To: <DKYU6ELNN060.154BHE2QG442C@nvidia.com>

On Wed Aug 26, 2026 at 1:24 PM CEST, Alexandre Courbot wrote:
> Coming back to comment on the conclusion: we have settled on a solution
> [1] to handle this nicely, but it is likely that your series will land
> before it. So meanwhile, please use the turbofish solution that I
> initially proposed:
>
>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI_=
EXT_CAP_ID_SRIOV }>());
>
> While it's a mouthful, [1] does remove `u32_into_u16`, which means we
> won't miss it and will need to update the code to use `const_as!` when
> applying.

I don't think that works; your patch is not backwards compatible and remove=
s
casts::u32_into_u16().

So either this should just be a regular as-cast, or we have a signed tag to
share with other trees for [1] early in the cycle. Since -rc1 isn't even ou=
t
yet, I'd prefer the latter.

> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvidi=
a.com/
