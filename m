Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACF4C753C
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276503; cv=none; b=qLcxUHwJsGVgHDo8maman+clkezD3qbQwT6QoA+5+JO8iOrFMR5QpEe4nD4EZCn0TX1mSHPkjt0dGbz7i6ZyF7S9yFheAk/OhVv7MToYQE3IEF9mcNcR27eWtIbw9yodJzofX5wbvXhG1J8s0HNXeliQZPWQPoPDKyIMtGH3BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276503; c=relaxed/simple;
	bh=TacypWkMJAz9/w3fRPT9L2BkrfGtu6/HOdt4g7YcV4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aR31ZQdxoRflwtBRiAOUKmzQOML+V96/8Pl/2Oe+lOGsNUm6AkqIG8h2NWsxNKlJ57yh9irPd0Jz6gQG/8qjrpdfVUVtjibJwuFMzXYCvJX7jMQzDsRt3jstcHvWVBSekqTv3geF8yULj0ZJMyN9YQud5kfpOnn489c7DZyWlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Tg8veN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Tg8veN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D11D1F00893;
	Thu, 24 Sep 2026 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790276485;
	bh=TacypWkMJAz9/w3fRPT9L2BkrfGtu6/HOdt4g7YcV4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3Tg8veNsMErQipemeL7gQXZrr3PR4gW2j2agRh1Yfs2FVKHwIH3phf5SR+jvcbRg
	 0KVUKLMbchHC5AMEsA/V5XKZH+FgRX2nJ6OU4ctuzA+IApuTJc9Aw2t9WXPSSyX+6e
	 3vzkWt2ZRf0vo3nDm7pouG/9rOafzJ1+UConEcKFV2k9IdYCv0NkZSZf4VSM6T/iND
	 8SjhCKoIDKRzM0HOylhNmvi2yQ/iS0TYqR0hNycwHxH/YYKXBm0hFB05CkWR22lg0r
	 ZqwGEpITu6qn1VuLNHvkfKNXEPjf3i/OwQ1eWlxJZRp7tfxMAdhYVEcKLwktNLDg0m
	 3R90ALjgoWK5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] PCI: Remove the per-capability save buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-16-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-16-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:01:24 +0000
Message-Id: <20260924190125.3D11D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Delete struct pci_cap_saved_state, struct pci_cap_saved_data,
> pci_dev.saved_cap_space and the helpers that managed them. Every capabili=
ty
> now saves its registers in the offset-indexed capability store, so nothing
> is left to find, allocate or free. That retires the last of nine separate
> save buffer allocations, four of which ignored their allocation failure
> entirely.
>=20
> Rename pci_allocate_cap_save_buffers() to pci_reserve_saved_caps(),
> which is all it does now, and drop pci_free_cap_save_buffers() from
> pci_release_capabilities(); pci_saved_caps_release() already frees the one
> remaining allocation.
>=20
> pci_store_saved_state() and pci_load_saved_state() no longer have to appe=
nd
> and consume the records of the capabilities that still had a buffer, so t=
he
> blob they exchange is now just the saved DWORDs.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D15

