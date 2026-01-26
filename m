Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEF33DEE0;
	Mon, 26 Jan 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446952; cv=none; b=EMENJk85aSptt+v1WJA37GNCAF0rkUcm+jFzMFijHjnR4cVoWDGYqvOktw7VpihjaVbCQCUsj250Wv1wUjwVX/UJdu6hBf2C1AHurUd7UZuUEe7GvoRkC97LssghmCKiN/1mL3BZM2ffJtDpzDkoCHZJLo7odNaEE/qobOH9dZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446952; c=relaxed/simple;
	bh=db0GnOuz3Ol+4rvOMvMgPdDAyvAv8l4NNhFQLSuCUe8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BNzbJ7D96qGQu2ztD5M1sShhzXqFmqTT9FyWMogeZBYbzN7+Usz0kXu4+9vLecRzezzlgeJSTCVgWW6DZrQOc3Vmp+OunyyVpCrtmoIZ1pffpzCtPqhowHieOD5L63s/v38/xhXlc/GqSoCWM3xxbF9+DMw3TJQwVIj6+dQ3O1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB894Lnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB894Lnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0717C116C6;
	Mon, 26 Jan 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769446952;
	bh=db0GnOuz3Ol+4rvOMvMgPdDAyvAv8l4NNhFQLSuCUe8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=oB894Lnt2S+YifLfbZn3eWGNIm3hrZJQFPSwIRD50/BtyQJN+lBwOxX7BLwjhvqvx
	 AVkHRJ3aBle1/aRHZ0QhyJV2vdYGblDuD5rQ11LUg/W0QBSVRC0wWDF7AYHD3UXcZB
	 hOSsWUnja6m7mDYdxuFNYDDNlB8Kvoi/SvrDbNTozu+raQKCsz5chAvDa/79FROOSI
	 ljITWQUQ9vL+bXhWvmtj89ppPJTcRe9+Ce2L7oOXy17J5old5nnqiU94yvWCLQmw6u
	 SAuhYuopsdxnf0firHvFGqcg8BDP5oyK+r30AjejKPursZ7nPQlEaAxMab/yOxKF9b
	 XLBqj++1Kx60w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 18:02:26 +0100
Message-Id: <DFYOLDG7ZXZ4.1X9G9U2SS05FN@kernel.org>
Subject: Re: [PATCH 4/4] gpu: tyr: remove redundant `.as_ref()` for `dev_*`
 print
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
 <20260120181152.3640314-4-gary@kernel.org> <aXcxMShqvHzYMllD@google.com>
 <DFYKD4MRY9BK.7O6YH0H3RHOO@kernel.org>
 <CAH5fLgiOMJ_6bUfhRiHorg9HkNeDknSO0bjK61wry1ZaNO0A4Q@mail.gmail.com>
In-Reply-To: <CAH5fLgiOMJ_6bUfhRiHorg9HkNeDknSO0bjK61wry1ZaNO0A4Q@mail.gmail.com>

On Mon Jan 26, 2026 at 4:06 PM CET, Alice Ryhl wrote:
> I don't mind either way, but if there are no conflicts, it would be
> nice to take it off our plate now.

Applied to driver-core-testing, thanks!
