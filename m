Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264830F55B
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136752; cv=none; b=JHsl1JXkW775a1nDdivJsx7WG94+PFNVJ1uswmH9Up/1sAenfEGxHQMDHdcrBAe7EaMMu5hL1RBRD4hNtDE+0VVTVbjfC03731iV5N/OEcYBorfw8cdhWrgdTJO31jtobILellIVZzOpEhYwNRysVQsfVMjp3rEMH9xyaMh5DHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136752; c=relaxed/simple;
	bh=v9qd3d9nUoDGFpxdI5SXu/r4xYFb83Uohnr3EXtahns=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=GtEfJ1fuh0W70+Ihba2AjYnjeRjFuMbcNg4vog1wRS3ej2sAPfM/EqZNX+A+rSu9YoPKbH0QPJMWxYd6omyBBcKUqtqAVlqDd7+q+pwWAGTivn/b86OHo9OTz8cvys3OZohB68mo85LcatQGPWFxTszM7ZnE0HcK63fImK9deks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InqOj90r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InqOj90r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DF71F000C4;
	Fri, 16 Oct 2026 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136751;
	bh=v9qd3d9nUoDGFpxdI5SXu/r4xYFb83Uohnr3EXtahns=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=InqOj90rSrYSHDF9XTO5BgHKz8L0u5CKrkCd5WjrMV6TmeQwxdI1h7rrpjNoKr9PX
	 9PxPWW/lR1jtKmTx7A5iDE/3aTkMLP0UXwFQ5x2qcfWc2suf6HXfBHp210StXdLRjZ
	 WEAjwTQLfgMUtmoI3Z8DKSdV5mTnBf5JnC7Te8K+7YuTPVdjOyaS2zHXkir6Q9shrd
	 Y1L4YM/hprAgBr9ckCuBlmcSDLCTa6ywN5c3W8Ayhisb4PiYE+TTxL0SlDf+s1fJkG
	 i7tYhES5KmzqNLYZ7uPiwWnxuOW2Np49lIkTDPnMLokxcdauuRdkewVM7N6UvZJ8Z3
	 YQMDI5JLqfVqg==
Message-ID: <sashiko-outbox-173959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: dwc: Add RAS event counter field masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016074026.564302-2-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <20261016074026.564302-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:45:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add complete bit masks for the DesignWare RAS-DES event counter
> fields so consumers can use FIELD_PREP() and FIELD_MODIFY() without
> open-coded shifts.
>=20
> Keep the existing shift-based definitions for now so current users
> keep building until their call sites are converted.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016074026.5643=
02-1-mmaddireddy@nvidia.com?part=3D1

