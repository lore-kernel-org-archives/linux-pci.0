Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EF3C0A08;
	Sat,  5 Sep 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613895; cv=none; b=WqHXyGlsL4gS/E2wPVjc6OsEOIrMTErIGflmp6XU+3FG70dbxV9Ky7lPm72tYzgziohiVBLjX4lIy//hZQmbA0lcH7w0Dc3pnIgPyQpGTag2fkeufCpySfZ7XlbvjFjuC+nJOHR+LUDIKy0LFz7MgTFbZyzqnnHLP1VG7OaleM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613895; c=relaxed/simple;
	bh=CJcqCmu6J+I02IAOwUS9uF0m41wad/9H3YTsqKjgY7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fkLgAt/vKf41UilJCWjxx+KWL7yC7ccEO8PmpX7T0J50/h44YNh9oHOCuKpGXnSJTDdhMIPawZ4Q2xXUJtZ5LUgVTWW/XeXNeHpEbXsSg+ykJJUxfsPcybVX8rSeU4+XtTllpqP0S455fTs/g9kcerfriyR3KZ73vYZqn/E6svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFmCkQUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFmCkQUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE081F00A3D;
	Sat,  5 Sep 2026 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613893;
	bh=CJcqCmu6J+I02IAOwUS9uF0m41wad/9H3YTsqKjgY7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFmCkQUf1PTOqTL1/HsuRv75jcfgrkDTMUxxroh9dJqQ67R2OY2JX+nqD1o0xncfg
	 IfBQDA4E0LyRMTxaDRXXIN7NMtPeOj3IEHw71M4EEeyR3W/Q4jKJVt8ge9yVQ/kwn5
	 SUefTAAWY8Dyw6WdS/OgzBoors9gBs6a+EoZbDznLq8fo+b+uU0fZpQCmuT3kOqD9+
	 QVVMmJ5xjO4MOIRfS1VmqowzqNPwHEc0JCmg/ZZYhVfcaB5EAc7HE5dIehIc8hMii1
	 ixZ1dnATFSoA7nQ5Ci8/LzzcKk7CLvRqASbzOA2vywgJkyJRUbYlSDsM2+MvpQ+8hr
	 7nmB9qmLPjpZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] regulator: mtk-spmi: fix Makefile typo for
 mt6316
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, media-ci@linuxtv.org, linux-input@vger.kernel.org
In-Reply-To: <20260905130925.7115-2-breno3011alves@gmail.com>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
 <20260905130925.7115-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:11:32 +0000
Message-Id: <20260905131133.3BE081F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix a Makefile typo that incorrectly placed the mt6316-regulator object
> under the old CONFIG_REGULATOR_MT6315 configuration flag.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905130925.7115=
-1-breno3011alves@gmail.com?part=3D2

