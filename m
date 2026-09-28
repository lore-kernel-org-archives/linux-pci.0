Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA83A3E9A
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617480; cv=none; b=UwArM0x1ZpTbYrjJIPjsYHDHTFJWI1tuz98w6PplcOdb4piCM4RTO6wJAb2DhvcX/mZquQ0p0gx8idhFnm6tAC0xtQU2un2QCsc1yHocF3VAKl1+Am21ex7C8Mw2Zf+UmX+BpahxcWsJVS/1udhg7Zb+rpqKfl4OrvSGzuDoZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617480; c=relaxed/simple;
	bh=oVRRwfYjflADGhojGV1sbAEilvYc3nsW16yBnXpN6po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y5XbcQjg0J4ZurOJj6zw4lrUQakNlH1idNRrjqVUQcf2B6t2ja9mch63iGrzei5h7D5Nk/VmIy1Mc+chdmCHEy8RkfZ7sL5Gvdp8D3fzhb/vsLr93y84M3q6cLVX+q+eWZNIMgK9RWqTqyFNP0+BwMR7DljSek0AuH4Bc6bDVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/AbxcwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/AbxcwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACEB1F000FF;
	Mon, 28 Sep 2026 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617479;
	bh=sJ8ZUWFANEWYwlZs+YzAQiYZXTNRD2NLmXU4TK0UujQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/AbxcwGDw7oL8Q9DK/3J73qXK5pEkaEAata16rwRrEGz+gTVURt4HDiNR4R2wWCj
	 d0NVXg4BjPcSey68qIWGkeE6YKmkK4lghVvBPw/ESZHlEvAnUZUyJO7cTPH0/bsQL0
	 BeduJ4LMs/4mxA/jUFokQSHEgJdb1KtrQZiAGYatRnIrP4O0r3dQT8M/KuP6n7p8gO
	 uofe/5DjcN2iSY7CSr3RFvXUQI2c6/t+bZP38mVqfdxtdN5Ps9WgeEx9LYLnfxaVtO
	 6AhaK4YnZDra0XHbqs2FsNwg23z9gHweFjFZ6uq3I6Fnth269+15XZV+hGGrfPcuP+
	 t3uJL0QDKvqYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] PCI/AER: Document that aer_recover_queue() takes
 ownership of aer_regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
 <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:44:38 +0000
Message-Id: <20260928174439.0ACEB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ghes_handle_aer() allocates the AER register snapshot that it passes to
> aer_recover_queue() from ghes_estatus_pool.  aer_recover_queue() returns
> void, so the caller cannot tell whether the record was queued, and the
> AER code owns the buffer from then on and must free it on every path.
>=20
> None of this is documented at the definition of this exported function.
> With GHES enabled, a new caller that passed a buffer from any other
> allocator would hit the BUG() in gen_pool_free_owner() when the AER code
> returns the buffer to ghes_estatus_pool, and a caller that freed the
> buffer itself would cause a double free.
>=20
> Add a kernel-doc comment that describes the parameters and states that
> aer_recover_queue() takes ownership of @aer_regs, which must have been
> allocated from ghes_estatus_pool.
>=20
> No functional change.
>=20
> Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linu=
x.intel.com>
> Link: https://lore.kernel.org/r/4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linu=
x.intel.com
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-fix-aer=
-memleaks-v5-0-ba6b94c9c9a6@google.com?part=3D3

