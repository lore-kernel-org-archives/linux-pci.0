Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DD846A;
	Sun,  5 Apr 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401242; cv=none; b=AcnrIzyI3ImmdqKDzrSNgvPPr6m2/ScypbG49C92mllM42hMrUujhmDIScRrZvhWkzpaqSWjjv5biclzra8NKpBBOByS0vu9PicD0j/utCsDWxzRqVuHc7W4KsoZTkTvUTWAMbYerc99jbwU3IOFpUHcuI0B3KnIHDtOliAIdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401242; c=relaxed/simple;
	bh=JzFW6FbDHTaeVe2vtundlESvuRcUb+YzDWWZ4tPFwrk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pA3Sskzupj+iJ6aG2KVJcmmncVbZuYi23amY/CsWu5JBgNu0eugTivBNNNrQAavIp9DzRksFq+PYeqcR3qCRJHdPcRuJtm94QYyk7OI9Se+e4rQ7/jHYE9E6UBtRu/eeial9Bw9eInvAZMxoMV/OuWbuJ05lptGvX1KmCRGQc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM0uZxLv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM0uZxLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0557C116C6;
	Sun,  5 Apr 2026 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775401242;
	bh=JzFW6FbDHTaeVe2vtundlESvuRcUb+YzDWWZ4tPFwrk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VM0uZxLv96SeqMN5zL8fG6Ldo3g2I3VodyjKOMtycxSQzRv7yqtXNXk7Tga1L4ulQ
	 AqmAXtNDFTM1qLheH1Bxizt1pi7gUsIAzO2rrG8XZP0Dp3z6V2eHKBN6aSwFDHIZ1H
	 mC7DcjvpOF0d5e477XQE9nqEciu2thr80wXNP2drO75Sf/up3gLKvgB3jaq98RLAx6
	 jDpg5FVZZvDNX0Ns/nc5B7b/4+3Nfyv9S9J71nvwF/NstSzeA4QZZnRhWi1dfZHlUc
	 0o9UvmNXjlqPm8kXe/aPqEZWI2cSvYtRpI7CaQlYJJLTFhn0XcHfnwW8laDD2o5V4d
	 U2axA5o+G8e6w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 17:00:37 +0200
Message-Id: <DHLB7ORTXAI0.1K0ZOL37E6PI7@kernel.org>
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
Cc: "Gary Guo" <gary@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-4-gary@kernel.org>
 <DHLB4703ZJUX.371TA9OH871FG@nvidia.com>
In-Reply-To: <DHLB4703ZJUX.371TA9OH871FG@nvidia.com>

On Sun Apr 5, 2026 at 4:56 PM CEST, Alexandre Courbot wrote:
> Do we have users of `IoKnownSize` that we need to keep it around?

nova-core has been a user so far, and since the patch series targets the
driver-core tree it must be considered.
