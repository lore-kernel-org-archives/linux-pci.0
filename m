Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3639792C
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212988; cv=none; b=aJyfTJI96ZfGFd2MGZo7Fkf3+xEHlqtSL3ZMG0BmA9a9oYM2HPGCRyzcZ1FNlLD9L0qXVhF3MvjgQWdT596GOwCxH0D1RQk9yvdOofdDc1m+5JhY/MaA+K7VolVGn5vnQ/6O5LYJXlxyp8q55iaTMm09dFgLkdXuCBIGiuJlTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212988; c=relaxed/simple;
	bh=lOj692evscth8h2tovwaq0zogvx1I4kCH/vyZiaanWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PjHG05lj1MnXrnxpB0Vk7nG7Zq25EQ0Q6IfIuPdEOC85CqE0hLs6ZxpHgYeojk0NOFF8r06pV70qHOkMXseD5IVTjdxtAtc+hACNqBg2ZMV9BQTKgSeFlLtAUkjWkKeY7oc+34UtRqfIAazVBRu5eBUvb+nENnFUEnuuLnLV2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efUelbV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efUelbV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9501F000E9;
	Mon, 31 Aug 2026 21:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212984;
	bh=SLHueRQMFYE7Dt0uYiQp2wuveliBuz9f4U/IpzzcTUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efUelbV3AvzPVHNugXqQDEdHN7+Q7iOloUqrWQtc2TApdn+zMLZ9KiCopyWre7Wvr
	 vH6FDUm8QqtDp+X6hVwvAIW3bYB+ZmBNmyzFVBke/xTnQ1EkjMqA+HmsuBM4cX3dq8
	 bORGzjGYY1xIrwIcHYMRrm445cPBgRpYuCeumHi5rXo0qHrWIRZEBOGAhO8cWk//1/
	 Fve09kOsQubp8GH75ZevRFaB0nM3xigugzA0H8l2khRQ7kgQq4Kt/Lgbar85yLCevB
	 l503DpSlPg2NbXldldxyFHdMNhoiyop7Q30+IxcBPiyvDt3tgVcCszOYjd0gj7ANQh
	 dVOVTtwMPI14g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] PCI/PM: Split out code from
 pci_pm_suspend_noirq() into helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831205533.2325747-2-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:49:43 +0000
Message-Id: <20260831214944.3D9501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>=20
> In order to unify suspend and hibernate codepaths without code duplication
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
>=20
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831205533.2325=
747-1-mario.limonciello@amd.com?part=3D1

