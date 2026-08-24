Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC13397923
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570820; cv=none; b=if5adq0MT35uKgkVp13VD9Rc2vimksGzmPJ+J5IYYBSCl1+GG9553CIjozw6V7eEVGd+XgZhv8+yFKo6uqR8dYBGIkviCOfn7E7P3ZLmA/0vFirvEYAHyg4ZtPlTzYf8o2NTpDbYBkP3+Ni4/6d78Yn2HOmC6eJmcPPTMlaa5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570820; c=relaxed/simple;
	bh=tOOXAP0FQlsikOY78xrP0MSwhHJ9C7dKegtzGiN6DGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PHp4y2vheO6aSX1+ElLdltvIOQE/4Q6MfBraxGXlnt3qYwCK7mjz7qI+c7GE811NovDxq/7QyJ9pE99AZauCHJSS8VftFm3gWUZip/zoInfqjqLVhPse2a0nA2jMl0oXlq2wZPEImLxKhCVtUYz+guOA0i+W5rLUcPqY+jticeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPk6SRp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPk6SRp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14521F000E9;
	Mon, 24 Aug 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570819;
	bh=tOOXAP0FQlsikOY78xrP0MSwhHJ9C7dKegtzGiN6DGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPk6SRp+vyNJ7jN3diovEEqTmuusUBodrroeCI5vHsKv5F3z9WZyN/QH5JXuJJzl7
	 bsPedpl0Q0chMEIQ4/4TwRkujZHZnNKwTIsGS2D9kRg0oUKcXR+nHx8odkGKwhdx1j
	 Sdpoxl6fusKzUupI6pfYaWZ1a5tgE6aGTTdy6DmQxoSg9odQruvanmBIcPvMxCIAW/
	 Lua7kxz7qA5AWGMce5WXrNO2K0ZZuqdV2P2u8SPHuV/6n8Pw5g8JG3e5joO+5juoq8
	 4gpGTpf/IGy38QDc9qSZ065CGa7OxlMIZhRD/rpHY/nEvpDfCGq9sSUbPbYrIN1KgI
	 vbo/uMz2562Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:26:58 +0000
Message-Id: <20260824112658.B14521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D4

