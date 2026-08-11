Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB172D97A6;
	Tue, 11 Aug 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466673; cv=none; b=d572yK5/IOe3gk5G3uEJM09iBycmn5ullRLNJWCuNnesXHjvVY90lIoPkVgGZvmzplhd71dGYXwi6UtrVdBRrMH1HjWfzBQBqfGDwdf33iVgydFMRwCn0Lm9Ufrp5JFGlcbfhSryGISANkz4v6nmoLq2dv/j9/4Fgy49i3O/hH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466673; c=relaxed/simple;
	bh=3TXgPDOX2qAgBhRTLA9ETUHMFKNNP2EA1bSuLyCFsPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EhQjYKobVxtMZxUkfV/YUiEN3g5sAVgVFOCzir8Zx3t8FERJK+xKbTHHmub6uQl76pWkcW7KOiwfeaQMx+muot4JfYs8kRbaW9VdIP2I/w0fv0RtV+j0P2IPdAX5f+R+FMcMgHJ59WCO+xI22/5OlUPGzLFsA7Q1aG+t8popVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yelj08hV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yelj08hV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB6F1F00A3A;
	Tue, 11 Aug 2026 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786466667;
	bh=3TXgPDOX2qAgBhRTLA9ETUHMFKNNP2EA1bSuLyCFsPA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Yelj08hVcUyPtNAuXccfQXtiYjEOr8P7WDAmaQbSRLSd1rZ4c5mzdXWOHpR54Iu1b
	 30Ovsl9VfLyR/cPHFQlZPu+IfYSyaluYDV9fUDQQv11wm4FIq0/Br68X47+iLHgub/
	 HlEZonbvYqNOPdQOuxGH7hcl4GZdGUE7+Ca/FZO3KfOf+zUqi3nf36TN5ZNDsn9lhN
	 +ApjA0QHrEGlyuU7828lsB7qq09N4/FtXFUJ1qKsQxeWiQhb8inOr5mbVi4l3Dvbq2
	 kznieP/r6fLPVdLbiBB/kNiSgToryAfl5A4thEpkUu+cUIzdytJcaOwAlR3oILAyS/
	 rMONPtMq+41IQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 18:44:21 +0200
Message-Id: <DKM9KUF12USW.1WFEQNAPUTHOI@kernel.org>
Subject: Re: [PATCH 2/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260810224800.2314458-1-dakr@kernel.org>
 <20260810224800.2314458-3-dakr@kernel.org>
 <DKM379N6SYPU.11KDELXPAG4UL@garyguo.net>
In-Reply-To: <DKM379N6SYPU.11KDELXPAG4UL@garyguo.net>

On Tue Aug 11, 2026 at 1:44 PM CEST, Gary Guo wrote:
> Why is this anchoring thing needed instead apart from the lifetime that a=
lready
> exists on `IrqRequest`?

The idea was to preserve the source of the IRQ via this anchor type. But at=
 a
second glance this morning I wasn't overly happy with that; ultimately I th=
ink
it doesn't really add a lot of value.

I took a different approach now with keeping IrqVector as a new type over
IrqRequest; I will send out a v2 soon.

Thanks,
Danilo
