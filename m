Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C247ACE4
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068388; cv=none; b=eI5oFZXjj47181xzVWQxyuZE2FoU/L1tJoJ372JRIfGw4CApHTjS1Jz2l05MJL9usQ9GSrcFpb1KIRXJi1EzirBYo+lhpUf07KrPaqj3mC+Wm4WeYskSM2+/6TkOfRYre4EFN5zqWVM2u7IMhmzh6SaIyO1u/lPDfgMivdMeJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068388; c=relaxed/simple;
	bh=oYyQCiE1J/htJDNK3zd66GWur3qyc4ugKYtSmvBQpC8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nCAcnCxRumXfwfvoiKvJaktqA39oD1ZJUkB0yPk1FT7+q/b4TchvACgn1Avxl6+j6Ub8Jfgpnut8ynOwMzLzOl2idBqubdd8l7CFrjldVkDdSUHYhKhSclRsd8/GEByIbeY4F+FOowlAdNLXgPibNHsevDcEPEpVUlhTYCM58Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZhPqGO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZhPqGO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADBC1F000C4;
	Thu, 15 Oct 2026 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068386;
	bh=oYyQCiE1J/htJDNK3zd66GWur3qyc4ugKYtSmvBQpC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZhPqGO+wfrh4UHpLd3ccz6XYxsJaIn8jz03Tv07irhgfRclPR0tz966pJ3D+2Y0e
	 /Eh9XvC7xUyhkJV9QVY9QCksBCvmp40blnOkgcruyKBD8t8KRsMeVpouWjGm4MIvWp
	 hRwC8ODBwAAO4dgBS7EGMrqKeBOi8/dwKiz3UfjT8tAZpUE8vomFgxtpCm6vJ7S7+H
	 emTtZZWPsfxnDwbXmn3x/BqTGr1Wsop5Mwhx4PjG0Ielc9O6dnZjzyRSlI1kYxQ+Rf
	 tIgBesVHCqgV82Y3sZvlfXPjMZIVy2aApiz2DwRCBbj5RnJ4YAUtXBwC5rPd0I+/wH
	 XDnfoIC+uoLlg==
Message-ID: <sashiko-outbox-172859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] rust: io: split IoCapable into IoReadable and
 IoWritable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:46:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `IoCapable<T>` provides both `io_read` and `io_write`, so a backend that
> supports accesses of type `T` supports them in both directions, and every
> (non-copy) `Io` method that reads or writes a value requires both. There
> is no way to express a backend, or a view, that can only be read or only
> be written.
>=20
> Thus, replace `IoCapable<T>` with an `IoReadable<T>` trait holding
> `io_read` and an `IoWritable<T>` trait holding `io_write`, and implement
> both for all existing backends. The non-copy `Io` methods that read a
> value now require `IoReadable` and those that write one require
> `IoWritable`. `update` and `try_update` read and then write, so they
> require both.
>=20
> The copy methods use `IoCopyable` and are not changed here.
>=20
> No functional change intended. This prepares for read-only and write-only
> views, added in a following patch.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D1

