Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823DA456E1F
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247693; cv=none; b=HC2sVhFC9m05H/gCZeEFahH7Yiz2XAHSUoxPN949vnm8qPV9zjrOH+xJY1ExUyLFsACEulS9xQ7b0/zXSZyRDAYtdVFuVRL5P3VgmFXPN5gXHzTiDcNS/M7K+vfdX4kY9jlGQW6KgniV78hzJn2xio9x24eBGC402GJ8axQyV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247693; c=relaxed/simple;
	bh=zNgpdsMuZZHWRvJexdwkUojyoIlHjTxTGj4lJaM6KlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAgkjEDNEusm1reo3NIJ5dEYokGmQXfvXY0JBeRRs/mBI9aGcsqajBSBALEbZEiTI6VSP0UkywHx9xkR/nd9Nk1ZeiBm1Vu4LBRHZ7CMQIXM/CvpJTrawPQTvijqYjYDZ0iItGMPlOmmSvWOziWEJMTUnUuDBddAaTtBMQobzlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJn8DBiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJn8DBiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBD31F000E9;
	Tue,  1 Sep 2026 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247692;
	bh=zNgpdsMuZZHWRvJexdwkUojyoIlHjTxTGj4lJaM6KlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJn8DBiZw8Si6LCJpb6kpEq7gTTL9lSGm469p0OgtUx0zyO3DGq2aQ419D4nRDWa8
	 /I4qauj4v3iHg2S/R3Za1lxIxd2RfAc6tLh4f3tg+iUbvzAGf1KAHBRZGynhJRt0Gz
	 39jb7I83TQzS4LfdA9wuyjX0xn6NhKdRs+tkDAA9gm1cT3emM6mJoIg+ABRjUNOo9q
	 WpqgdBYpwCN1433iVdEqXhNGlwQrL4du7xwdsZkMdCeqB15FlE5j5VNgNMYZChf8qQ
	 e2brNywV+QIyn9fq7PYXc4LStHQ0ce6Df3kB6173GtQipwrefj1UUpZjcgexp+JeaI
	 GnJFe7g7ZkUOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] x86/hygon: Add Family 0x18 SMN access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lin Wang" <wanglin@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901071700.3255382-6-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-6-wanglin@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:28:11 +0000
Message-Id: <20260901072812.3CBD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hygon Family 0x18 DF nodes in a socket share an SMN ingress. The root
> groups therefore need to be associated with sockets before they can be
> expanded to the dense DF node indices.
>=20
> Build the node-to-root map after DF enumeration and expose Hygon SMN
> read and write helpers. Hold a reference and reserve PCI config space
> for every root used by the built-in node layer. SMN remains unavailable
> if root discovery or mapping fails.
>=20
> Signed-off-by: Lin Wang <wanglin@open-hieco.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901071700.3255=
382-1-wanglin@open-hieco.net?part=3D5

