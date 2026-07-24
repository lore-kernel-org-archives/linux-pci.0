Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A5348C63
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909553; cv=none; b=qLb0liw5o4Diovgseiw8I9bFXrJlQRhDt9rmpZPgzX08UIgKrfLhVk2m9iKwQI0YMXavk4dgjfWqZNTU98L+DvOG7u0kkytxc5z+C/+3rza5IdZeiiZCO0VGLHJdbTghabNrJo/IeSck97kbSvS4psSubn+Cd+lNyrJ7+88wICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909553; c=relaxed/simple;
	bh=tnxTMvV3BILP7BBMIIH7aSpDSYpC/ZKfkaCSjHr2sxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c61TaGSO4ROYV21u5Mbyz3vWH60LKzFBdm4g+TDMORRB2brbydZGqLNy+NioJlW+4SPO12xBoZjsPhAdIG02p12Y20th+gpF9LIuvaXHbdvw4mYFF3YjvLSXiJ6nwiFoBSSD+gXnOaUHYzD7QDaa7ICg3h3lBk7K1YQFCwbJu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy5lvrV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy5lvrV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E89A1F000E9;
	Fri, 24 Jul 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909548;
	bh=jZWwAGfENJa9vbyYH4+qi7UgVOLagpAyXFeugfh+veE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hy5lvrV7FK/dtRx383JMzu+u5FcX5KGM5hfpaVd+rGVaB9mUjqyv6XckLMZNKY07/
	 r2VjoAVw3dtQOvpDAmt8973QvaKiibCwd1ThL+VgbC6lrAXFmL4eT6OVfwuqvnqMTT
	 bFyL9xy1Tm6jDF6yRmzXm1+8blvXelZOATyXtxt20rpHPzl+44MtyXczFyRt3kOfU8
	 EkLhXfRYNPAgsOIeAfw2Zh9OuygYqgqjsF8mNtauoQVe0azFiuWqSpGpZK/QOz5bdP
	 BvQ6oJ9dC+GO3w6DqHdXiTrjJE20f0wrUavj+9Z3pCdqk8w4Yg54UWaK3tZ414Cmph
	 dlMuHqL7KI0HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] PCI/AER: Move retrieval of FEP and TLP Log into
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0f2f037c7ccf099f0c253cbc4ad9be526c68c5af.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <0f2f037c7ccf099f0c253cbc4ad9be526c68c5af.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:12:27 +0000
Message-Id: <20260724161228.0E89A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When aer_get_device_error_info() gathers information on Uncorrectable
> Errors from a device, it reads the First Error Pointer and TLP Prefix/
> Header Log and caches them in struct aer_err_info.
>=20
> Those two fields will also need to be read for Advisory Non-Fatal Errors
> (which are signaled as Correctable Errors).  Move their retrieval into a
> new aer_get_uncor_info() helper for reuse by the imminent Advisory
> Non-Fatal Error support.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D5

