Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028D38E119
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570901; cv=none; b=MM90XDB7U3b4Tf5UpBI5vyxgzV8+nN7kurcmhOQoHjEI9ELAS1ncp9DwjxP6sGaavDQGWR2A6dvjHm+rKbnx2sIDgKBUqGQ6EJetByl1WMNctWQfHpJZETS3teF04I/c0WLEI0mZ0XmMvBpCLBa9LG7+pg/8LZMRq4KjYq/9WBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570901; c=relaxed/simple;
	bh=F+zmGcVMwi5wVj+tQJzbIc0iubGuVKmsi1NYw4pW9s0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPW4zOdktFFLUF8gB8HKE1P6QTrPUdEIXRS6HZYU0QQVP6svtuqkb/bI7DlVPwQYaMSQViqfJWDR2ITcSYe0seX3PI6tBBIMch1MJ5RBxfDuFyk4hq3Sk4ejOpHSrrKHAU3pH4dVBsOwh99dhPhNlBWYRdgzJwyzb/a/ziHN858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifJCOg8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifJCOg8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB9B1F000E9;
	Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570900;
	bh=CAd6OU/Ery5CdCIZJTpri50JvE5CV33/gZSHvSJdBOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ifJCOg8/to6KIb7P2Hsxj0KjyLLoDzgiqiw20FBKYeopu857l0jzD9PGvVmYhz+DO
	 +besw9Nk657sSe2ukqL7LmEUAatptX0BPRyIdDbeXaJ+cDUHIfS0wVd7nZKnILXw34
	 /fDgnWthtjv3IAA7URNKBXuuLEVt6AJe1+6Mcl100gn5opZbUWDDigJv+ztn0fpR1I
	 CLjQbhAK1b7sPtVMsIoM4sIutqDAQeJf5TNVuPlmmLOGlIBlk/mDQXc3mkhQ1JLh1c
	 mjfE4x94HKUIntlOZCo3903F0bdDo1Pz4DgNZuzLpNJLfJ/aO1brkpvlO/dkgruqW7
	 kD5AQQzbscHCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 7/8] rust: Add `OwnableRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-unique-ref-v20-7-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-7-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:28:19 +0000
Message-Id: <20260824112820.3EB9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D7

