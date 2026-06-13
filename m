Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D6352036
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781386718; cv=none; b=RpH7GBKuwzDFtceJ6/ndckZPXCtUL34almui6kEaBboa3hpBwEWOu1s0P/xYY0hw1B8YZL9MdIIGgvK3DaUEUm+0v1nys3UDSxMjpPYQvdntQx22T5jS0AlvGeYexD7Tojrbm+t7/2bK+VoiVZJq5Kz/XiMbs3LBfj2rbJB7650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781386718; c=relaxed/simple;
	bh=fbCfFjZqK3tvCPz1ZnZHUC/E1+lcywvSb6P/dKQ9ays=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C2v9wiqBAIfwLyMRbX89SMowGp5FUC3TBqdwxjhQbzV0YORkdJ6/mP1i1H586Tueh/OoELLc5wDBzusi5OMAEsP+Loec4Zvfu/g4N4pNgZ6MJ1yLv5dVqKW90jzU8txeflgO2rZC7sBtW2oOZ9dfOYUDoZA8kbUPXwoOJuggSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2RyGlQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2RyGlQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9611F000E9;
	Sat, 13 Jun 2026 21:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781386716;
	bh=fbCfFjZqK3tvCPz1ZnZHUC/E1+lcywvSb6P/dKQ9ays=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2RyGlQ6p+ah/AT2DYWsQDzsoaqyTAs99Vos7DbGzA7eSzxBDzui/jKxMzxxqu4Y6
	 L5KyVvG7rLTHS2C1FMnUjjJzqhGbo2IhoplMwBrRra5rH+US5sIP3TEBEx+MR5ZWss
	 Cj4yyuZx/WCQAWicwm1x4evaWpyxQ3v76fzAFf1zX+oGoVadSj07QLbZ14W0ZeFMob
	 qOUdsNPAci23eWhgrjiQV6Cocd5nhDdN3EeSkXlasRYmO4HBth5bgiDjEbjDZvuhT1
	 /NXDhVxrd4AcZA4yK7uw8QunW4inQrCBsR6sjG1BGFWDQUXhUvGs2oretpeaqeJpE2
	 /9qMfa+yxxKJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] genirq/msi: correct CONFIG_PCI_MSI_ARCH_FALLBACKS macro
 name in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260613213544.90613-1-enelsonmoore@gmail.com>
References: <20260613213544.90613-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 21:38:36 +0000
Message-Id: <20260613213836.BF9611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A comment in kernel/irq/msi.c incorrectly refers to
> CONFIG_PCI_MSI_ARCH_FALLBACK instead of CONFIG_PCI_MSI_ARCH_FALLBACKS.
> Correct it.
>=20
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613213544.9061=
3-1-enelsonmoore@gmail.com?part=3D1

