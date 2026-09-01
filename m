Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788647D470;
	Tue,  1 Sep 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260947; cv=none; b=KxznHjpOsZGIZiv5yvYZG3+U+cEQymqsD4iPVTHWEfH2uYtI/AiZ9+hNtnXksMERkAO4V/jrqikwbzqa764CwTQpv+bC+YdFCYHZBJelR97mK75hHcfCWDS5iK7O6XXEXzaDE8kFvKUabQ16VIp58lsZAcWC1ykjbN9V+xE9E/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260947; c=relaxed/simple;
	bh=VNLnXhLOt+MCY50q0Qc0CkTZqllQGQfSGlBtAl1Vr6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BmVsQqTuReMH/mK3a/rjSkiMdejeZZZ/53ycmkXDkXBsCTmbghUe3P1rDh+jdlxKhRuo0XV4yqJrcFVlezDXFpdEOjNqXHMNTHvNCOflMpW3UhH4raG3i7gPsLnQxyBjZ7CyU/i+BlFRqEUfdIPYyB2YAuJezDAo+//hXrv5vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY2ihX9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY2ihX9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCBF1F00A3F;
	Tue,  1 Sep 2026 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260945;
	bh=VNLnXhLOt+MCY50q0Qc0CkTZqllQGQfSGlBtAl1Vr6U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=CY2ihX9MxMDxMPHfljgNIH9Fa/9eCdXynGGOMRqQdV8NVhBeLgAO5Guk6tikCuhZW
	 Z/7N7JLM82Nb3VbjIGxI5m7SGbMLGlujuWYDQuwQHDBOM5YRxMd6U4F2VnOmxrQkIm
	 6bssvHCAp6oU9pGyCMY4/Z1L7A9K/EyqsYSNFnb9Bne/H3DPslCmVps8kgwTg5mf/F
	 icJ8Z+PcyuezhGdgVfFyKxb/XmLxcggJ1p1s3ktwGstt0QzD2G0YrdqYoZh4Eypd58
	 5OWJt1ArdpwsBtgySrotAM1hPBE5UfVUvLUZ/kqFrkwmzCguSKs97casKMLgsHpPtL
	 YH4kSX5WuBDzQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 13:08:58 +0200
Message-Id: <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
Cc: "Sophon Zhang via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>,
 <aiqubits@hotmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
In-Reply-To: <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>

On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
> That makes me wonder, shouldn't we make `index` take a `u32` directly?
> If that's what the C API expects, it does make sense to align to it
> instead of forcing users to make a potential unneeded conversion if they
> already have a u32.

I intentionally did not do this, as the common type for an index is usize. =
Thus,
I do not expect anyone to already have a u32, but to already have a usize, =
e.g.
from some iterator.

The fact that the C API did pick unsigned int as index type is an implement=
ation
detail the abstraction should bother with.
