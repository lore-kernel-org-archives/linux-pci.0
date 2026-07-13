Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E518D636
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970201; cv=none; b=AesPk2WAjfaNzyGQ6h2/a3JNrvK7mD9z1Xnj7e889LnZqKiiil2Q/2ARXVhi9GG6jJiCBqI3t84JFv6C6fx3hWggPO948qcLGjxQ08A1owqbQDq5+SZlLNoLCzktd29qg/6OSRWGifPFWYjlD9CmZNqUeEHZUUa+3E2s9aEK6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970201; c=relaxed/simple;
	bh=FAEdF7Lrg48y0NLfhB/RORpfyBn8g0cZrBXKjSQFum8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N770NDQOT75tS0+M5km6atWSbHBdi2BVjT9ERUfLLZrH0p6IJMDl4kSChH8AWw9BVGMkbunsEVVSvsWwoZCwUvqLScPyIabJS6BJCbCIECOyOCT7al1TdMizA/kTrj+ELAT92myICZLE4eXW2Wqa+RIc7fm7akOhdB3+gngoWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFAABbx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFAABbx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD5A1F000E9;
	Mon, 13 Jul 2026 19:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783970200;
	bh=FAEdF7Lrg48y0NLfhB/RORpfyBn8g0cZrBXKjSQFum8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFAABbx2iEyeK6g420J+HycxSiZV3naeWTME3t2/nlSj1i9AFhim/0dg3rvPG44Ni
	 0wVmOtrB2KtkHvNgYCQEo9G5mwIDKu1/MxHNC77DeotupeD1ANXN2ai+ASCNK1r2J/
	 WhNvDIhbiowF4VM2F+bddGGvxAd12w2TOaWUlhL4kokd4drwysTIGGPnuZzfOcVS4+
	 GFZ7eLuvRUTONHBmD4dz5WbJLqcLWiiy/9ZQa3WWneuTKcJYGknDApoYeOiivttvUb
	 DIhCTdeC5adHbA3PYVYIZANrWhCAG67XyfGy1iegO6fE78UFeZMtqk7M1KXdnMbO4o
	 o5H2szd7zQ/mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs: ABI: fix typo in sysfs-bus-pci
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RCdPcnVzIFRzaXRlcmE=?= <dorustsitera@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713-docs-fix-similiar-v1-1-257e25150346@gmail.com>
References: <20260713-docs-fix-similiar-v1-1-257e25150346@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 19:16:39 +0000
Message-Id: <20260713191640.0AD5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace "similiar" with "similar" in
> Documentation/ABI/testing/sysfs-bus-pci.
>=20
> Signed-off-by: D'Orus Tsitera <dorustsitera@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-docs-fix-s=
imiliar-v1-1-257e25150346@gmail.com?part=3D1

