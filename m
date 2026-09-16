Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8B443A84
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592546; cv=none; b=Cnix8xPqGdUG8/2hUPK9BGYL55me69HSGfGG+t+ioThN5D//Z/3a4+l10OgAtjSC9fhKC+2TR7paumvhCDOiyh7tW5d0ZZc/7UXTY1P+8tuC9c/ueaHYAPYVYZr+h6ckhx6OZRtNWLzISCYzZzI6YrehdMsmWB1ZbZff8Kuhq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592546; c=relaxed/simple;
	bh=vfxLalZ4fep68guBMu+4V3d22G8A4++0Jkpvcm6y494=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PvY5/q9Uvml0sxsgiQgbSeQtypUGQEQWHg8OGwtk6k0yy32r+imp8YmhV0g6J76lD+JWPaQ6uVMEhl/dgJ5YrOwAasGEC80A30GudxzeGTzjlStzLqgQX0VPxfj0JzTKlPjaqrMnTPRiEY9+fFOotdxMQdSxGkElW6esgWuV/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibn+mfF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibn+mfF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520E71F000FF;
	Wed, 16 Sep 2026 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592527;
	bh=4nZrvBRusy2jauvCJH2NW2gL+WbrmfhZ4xEi5uPXdtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibn+mfF/M2gYO25so9eAa4VWz+cnl3mpaKKosO+XiDjHpaQxIS0frJjQeesg+2gxG
	 yOY4dJyzdsufDhR9wN4YramKKA5pa8IWaPibcLOAZua9TP6CAuFDo9+wM+nyL5q0SN
	 Il7C74QaOQqE7+HjGkXqmxVF9SYty/NamrZe0QlbVoDyXmCP5eoEtrTHC0/ol3yzWM
	 YdQcrCLMdhPRlPG+zePnMqUYp12FEKH887lwU0mDbjiQC03kSR6NVgos9mBdFt+7gR
	 rwIk/vGDZ+PUO198m+bOFQBttqJl2fNi9A85+gvjP6uhfHJcU0HsoM2k0mPtLTtK7e
	 bso7xlbfA+SOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] PCI/PM: Split out code from
 pci_pm_suspend_noirq() into helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916205340.2466679-2-mario.limonciello@amd.com>
References: <20260916205340.2466679-1-mario.limonciello@amd.com>
 <20260916205340.2466679-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:02:06 +0000
Message-Id: <20260916210207.520E71F000FF@smtp.kernel.org>
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
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205340.2466=
679-1-mario.limonciello@amd.com?part=3D1

