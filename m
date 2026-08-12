Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEE1E7C23;
	Wed, 12 Aug 2026 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560464; cv=none; b=b+HeU6DN8eHuJReAh1fxSm/p8acPR0T8yM5bdXWUjjnORseSFpcQe1QrxK1GolvDc3x5MqxWIK6XYI3I2i67ElnIAwIGrLrEAB0KF7vpbMX+ufV8H9ZS7DbND39Ive+qq6fePpu2WNuJ9zh8audcx2+0jZkVsmVaDkmU/VMRgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560464; c=relaxed/simple;
	bh=DnPHL6bT03rFlC+0bRxzKi9DZhqLuEr3lJ9yqP9us0Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=UmP43CLehMQxaSYTlS2fIr5Nu8FhVJIhQak7ymgYDhQ6xg3D9CE6o6WdaLZoefcWhUOAZ3Ijw3zSEMJ8EnEFZzd2Yc0Z8oMWGrjKAK6wFMuK1BbGjtqt+JyurjP3afBL2HiR4FtrEZUpZ6A+NMYX/K+aD/XcJvwMcobfIQZIL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd4Y46nH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd4Y46nH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D139E1F000E9;
	Wed, 12 Aug 2026 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786560463;
	bh=DnPHL6bT03rFlC+0bRxzKi9DZhqLuEr3lJ9yqP9us0Y=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=Rd4Y46nHvNwebkJq7IxeNR1qhBo5AHIyWWk2x4Uy0qLyF6iMjeUL9ea7lLYRTpDlp
	 qvloxj1Q3HeQ1GKH225jFuQ0s1STBtUT6mRSn7rxCB/iE6TIyWfhiuyturUeUnhd25
	 He88Q1F5RyF94dKboL5tTMQeXuyRP0s5r7lLdx1C+RX7pRcR2MMkeZA+NDk8J0g0fg
	 QmYOdYqn6QOaBbYR9wvvEWV7UFGesJlIzQ2A3NBdP0BQW3rGMWbR9+9SfNVYhlsYAf
	 6zYhYxv9CazMP69hJIX2hhiyBsQ3ZIFTyn3hv1hwULpI3ur/4OvESJM8aJdBEAQHRy
	 iQx2P3XtDqvGQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 20:47:37 +0200
Message-Id: <DKN6TRRJ2OY3.2U6M6TQDNSM27@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
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
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
 <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
 <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
 <DKN6203R3WD1.1NLN19VVBZJO9@garyguo.net>
In-Reply-To: <DKN6203R3WD1.1NLN19VVBZJO9@garyguo.net>

On Wed Aug 12, 2026 at 8:11 PM CEST, Gary Guo wrote:
> Well, I'd expect some drivers want to do `.vector(v).expect()` rather tha=
n just
> propagating the error if `v` is a constant that is less than `min_vecs`..

This is nothing we want drivers to do; this API is only ever called from a
fallible context anyway and propagating costs nothing, but on the other han=
d, if
the driver gets it wrong, we'd BUG() the whole kernel for no value.
