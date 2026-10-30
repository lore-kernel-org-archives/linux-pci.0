Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380863;
	b=OQOOzj3wCcxdBnhcPsSqbwcCx91g+snJkMdyBfvUaToILjdFw3e96Z9hKsMGkBXkBf2t
	 r/Tf31xSbsdHoPkZxljuF29LkaPiJ5hWrZQvD9hRxxoh6Wis4h9qGy2fCIphbfNG68JHJ
	 FZ9cAkjFwkGUBNl+N7ZaepzRFs9yX2hj5IcTFNZpZ1eEvBOkqstLLSqqofafv7JpGTZ/J
	 FjS9iAsANT81MiEh7BG0+2OEe+tG8+Pl+ovaWmxZIAwdjWIrOiA5GCzvaIDVYiTwwLSNe
	 a5Hne3m0ZdHAq8fnPK/UETi3gJGXv3RaSIXKnMBODltQnOP+Biw0eRUQqI36Qmvuheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xw++z2bWKsuKUWAjFjfbRWQ9JTz0TTozbnWJhhbnsNU=;
	b=vsJ7AKC3jaw+LM7tRmKC7pmKxboaWEwt6I3s4gSZWzd95U0925WOKLX3w3eGBumx2Tzg
	 Tj6uS3zfop3kZNDwuaO2CN8Gqk6+V40roqVopQasQkQf6AXvc/XCfZcUxWrK8m7hOeCGn
	 O4qt/pZLqPaxRz0vYfQimU0oFB83sN3jn/oOIfoZbKn+7344ftInIxBfY3E5P04gIsgwU
	 ozycNFF/n+LtCYA0tZYBhBXpVYMUk1lj77QEoXf9wTAMPRfroL9qF1OzGaDGqfR/CLONX
	 u0U1Aj3fZp4R0FGH0joK1WpnQQj13F3X+Ce5UTvXHsIy7kh2zPkbqs1mecluqQbVuig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+DARjqw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AF606A31D
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+DARjqw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AE51F0093A;
	Fri, 30 Oct 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380863;
	bh=Xw++z2bWKsuKUWAjFjfbRWQ9JTz0TTozbnWJhhbnsNU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g+DARjqwDxycgulgu04Y5EiANk7TYysqi3Xgl8765Saiq2JoSbH5CnRdgB61F86l4
	 YBj3ppl/t/Bru3zXWR6BAPcZ9V+kFTMtCyaUBUehJDNsXbzx+gmecxykjkgl04xHIU
	 /kxVv4ucuQaMd+zp0efBpbbNVvnm8QvEp+sbmbmonkMlrZkEvz+1zA6ohp2eOJVMSc
	 npOdvqqUPaue3E0czbZmRuICiYc+kGSgfagm4S9DB0uTBPm/rfXebvzt3URrsruEX9
	 IA42ChSksiqUX657CGc8bGX5+4ANP8j5nyixOeJvwJ42IbjNEJwCKeYzCBYme2wooi
	 JdHP0HBmfTkAw==
Message-ID: <sashiko-outbox-191325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] rust: pci: drop driver data before remove
 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-6-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-6-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:21:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>=20
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D5

