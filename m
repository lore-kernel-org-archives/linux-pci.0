Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309863E95B2
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274999; cv=none; b=XPqad8Bady0yyj9A/ZeU+Mkwxren1kMxEup+O2iQvQxP8BwY4wL4nHwykDF+K+p6VjBjr4ponx/u2bi6QYImrXOS+ZXd6XDgOxir1BCSsfLlRV8Khynscw8prv5nSWMziBNjagG8Z+uwvpBWjj0Ucc5K6petbX0dqfFmR98J5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274999; c=relaxed/simple;
	bh=60pkbJSyjWm9vRhkzDTGgSLnaVaHmo6l1fi8T4ntXqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O31jkZTt1wTUdb+/b6Z0comuyNm12i4LjXJRTjP7i1DqbDXomfpsaGf5hJhEjbfRnZXV87szU+bH4sFyEsmRAeHwprv2N9BGv/5s4dzCtSkP8fjB6AO6MaPwnCP5a6RDYH2IdlBhpn38Q8rZYxmOo7DGi2mQjEIQjvuOE0yA5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq5IzvfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq5IzvfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980281F000FF;
	Thu, 24 Sep 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274997;
	bh=60pkbJSyjWm9vRhkzDTGgSLnaVaHmo6l1fi8T4ntXqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lq5IzvfSBKMxbXqrcrood5+KDaHO/n3sDHi6R2PAMpZYL0c4tUEzjpjsWCnarPs1U
	 AiVg9bQHFGrUk4+vzEPhVU5RJfNYN14ozBlqYXckzTMhOUkbRWg83ywLRhIfARslpG
	 1Z0eYLWMcF0D3kywURhrV1D70z2kIJXyz1jxvAKTbIAPq06drhV9xn5czdipoPxlVj
	 1yu31zUdecU65bLRosXqDrP2VfojOHZsFgMCTYE8Sho3htRz3xstxR5wsJwbZ2qvj8
	 vRrTT9smgn99aHj9Z+a5wYZBfoHafCgcCLOyBAjUuD/aO+nNN1h8qCCtBCNG9J6MoT
	 4E5TLu4YKd44w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] PCI/TPH: Save TPH state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-11-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:36:37 +0000
Message-Id: <20260924183637.980281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the TPH Control register and Steering Tag table through
> the per-device saved capability store instead of a private
> pci_cap_saved_state buffer.
>=20
> The Steering Tag table is variable length, so pci_tph_init() had to compu=
te
> a buffer size and both the save and restore loops had to walk that buffer
> in step with configuration space. Reserve the table by offset instead so
> that the loops can address the entries directly.
>=20
> Report a reservation failure. pci_tph_init() ignored the return value of
> pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
> noticed later as silently missing TPH state.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D10

