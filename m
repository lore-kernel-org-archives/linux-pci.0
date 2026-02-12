Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B8357715;
	Thu, 12 Feb 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899020; cv=none; b=vGikZTN6ClK4j3xQ1GjmcVKdqgVjyytrK7qnkV+PnoUcWeHDu2T2F3P/bHT8a7Y2isvR+qp40AOlc0AnhJy3KFM4yiEA6ynUQAKuuEnaUs+vWIlJw1ruCXqUPuglmjZZmCNOT6DMFUArfwGBN0KM8ij5N0kvkpfBa7xhRfhiiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899020; c=relaxed/simple;
	bh=FMH9DcLB+OZvvgR3jiOirkmEzNAmVLaoyD4ZGLgOF3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FgffYgymRED06KQ1t2fDond04mI2cVw8Z0ItNk/PtQ5UBZ1KybM8LYDPZ6Vj1N8gGNv7WijmvW5qO8PIXjFMtgknFdJm8WmzR/FLMLOtFX0wA4g8hP0AgkP1E4WzL/5JAdodTKYi0k+7rukbWkW8yXjG9Yt4ZiLPGZRn7qo6v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDmjgNdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDmjgNdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA66C2BCB8;
	Thu, 12 Feb 2026 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770899018;
	bh=FMH9DcLB+OZvvgR3jiOirkmEzNAmVLaoyD4ZGLgOF3I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pDmjgNdJ9S94KVEwO8j7q13ejHJrYBHGLNXPt+gJETaJOpPkB3tKO839V/hcD2DXD
	 MoghgErKf2faQ96aVnzU9C97kA2NvWZ+ACGOl5KOaUIzwZeiHrDzzfdF1HsPGU/U5k
	 j76Cu3Iczh22a+nR63EuZaemErkfb6TMoPSPnxIMT8ETnKjU4Slrpml87VEezyskXD
	 ouixlQpm7ZZE1GcMHn1nSCXTmE7A6I9+ArawTFRrHnBD+S9OgSFt6Mm2Soo6pO0Trn
	 Zcrn+aO9pZ/dDGCJR6+xbvrWbjBERLni9in3y9nQmsr7JQRhEFVFmKsRz4/kszUiOV
	 46rI3gI/ZTVag==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 13:23:32 +0100
Message-Id: <DGCZB3HCBV35.2VTPDBP3IR1DU@kernel.org>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
Cc: <lyude@redhat.com>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
In-Reply-To: <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>

On Thu Feb 12, 2026 at 1:04 PM CET, Alexandre Courbot wrote:
> Danilo/Alice/Daniel: I suppose we want this before this series gets
> merged? If so I will respin.

I think the corresponding fixes should not be part of this series, as they =
are
independent.

And except for patch 3 that implements another I/O backend, they do not aff=
ect
this series, right?

So, for me it would be good enough if you post the fixes (if you want to ha=
ck
them up) and paste a diff for patch 3, as it should be trivial. I.e. no nee=
d to
resend the whole series.
