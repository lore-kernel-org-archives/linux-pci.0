Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072223F20FE;
	Tue, 28 Apr 2026 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388072; cv=none; b=WPSbFn54ViqFajD24YfEI1040lu6I/W+qAK7IECTeI0yKkTsARij0s4g2BLhZmzRYXUZ1YeuU1EJNghXGTtdYUtsWWbe9JyBTSOhVMFKcSkdn8ObaldPFWEzGKDVYa3+I5AHqa4b3kVpPbjRIvEzSTu4Zde43sl3szhUzIWrjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388072; c=relaxed/simple;
	bh=u5DGLyR5HD/1MGBsf8teWYoDSABc+D9y2JX4a/0KSqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mOYDDdquJH/0vUkvP5M6AerJvotF+cUXfMGSuu+F2GtLfZJYQJIgQ0OB3/AD9tJhDno5WKvRRiYErHxBeFNvkOMDMawASxYJP+ReNe/kgDr41bcoExkhUAYycHYTJBniMGeK6LnSyW2PYEa6/0VPxRezLHCjD2aoLU+OStdhToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l74otaXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l74otaXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF5CC2BCB5;
	Tue, 28 Apr 2026 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777388071;
	bh=u5DGLyR5HD/1MGBsf8teWYoDSABc+D9y2JX4a/0KSqk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=l74otaXlxwMDVQrDfF61j4VgU+FzRLy4fUUwF3H6HBpKmA03eU2LCYfmcAlFs/YEQ
	 A2N1h6J59/02mOogggPqpHHk82Ce1qP2xE/ZCsfZEef+E1pkeHtpUwdynt+dd/hogD
	 7nVypud7lcZ+QDTVI4amd84NirO8RXdycMq/D1ns7Bwmvvhca8kww+1hgsdZEQ64jD
	 bbFaUIBwxKuICOndPlEQBoTNK6lzRoET7Kw9ZKmlc+HWWvN7qOVnDPPfSCHs60E1K/
	 STxdm7uT8irGGSRmDMMd9kfbcEcyK5cao7xuoXS+Q78BjU1udkHw/1+ozpaMgH2bje
	 CBrRpKabXGycQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 16:54:25 +0200
Message-Id: <DI4VHH97CABG.3VW1RVS2O10K7@kernel.org>
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
 <vYp32vOGPut322JQ-5jSBZQNd6eXvnOvg8b6YDhYcYzBqTBVUvSajCJng33oXSQ9wiMvb62VLERzLYSa4g2pJQ==@protonmail.internalid> <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net> <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set> <DI4SY1NXU1XW.2VHPFEKIFBQVW@garyguo.net> <87ik9bp2og.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ik9bp2og.fsf@t14s.mail-host-address-is-not-set>

On Tue Apr 28, 2026 at 4:41 PM CEST, Andreas Hindborg wrote:
> That is probably a good call =F0=9F=98=85 Going over the pieces again, I =
am not
> sure when and where I decided this was an index rather than a byte
> offset.

This is not the first time I see someone stumble over this, assuming this h=
as
index semantics, i.e. I assume there might be something creating this
impression.

However, I can't see what that might be (probably I'm too used to the C
primitives). In case you know, I'd be interesting for me to know.
