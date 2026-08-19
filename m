Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30483093D8
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143946; cv=none; b=rQSols3Ecsw/ta8hF8KYR8E0Glihw3eiyZ2vKI083YnDJ+CvNAWScYYlmeKv88fLJsEeJULpe3TL2R0QKaVAnTv7Z6V93z87S9e9jgfRORq0eNpgNSElPOYawNK6UmV05qrNJAaK2zPudUEoCcQytyGB7s1NjEF+xkHPtAL1WQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143946; c=relaxed/simple;
	bh=BjJKIYYFxoq3CtgFW8UUQL3BcquKcr3CqP1T0B1g5aU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3UMbhtwnIXUuqegqT13fsCoFpdSHA5aSkfvhkPfF+BuK/Qd2nrd5hYIwYqEZ54svdSDPbSVJDMwXKCY4a5wqdS8s0GV7ciw6S62/OLoafU3nqT3REFWTgHSYQD0u5ABeW5VI8b/8vqNMAzH4AZKtsBThabZbsF7HIZjGGubOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJgC9BCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJgC9BCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D64C1F000E9;
	Wed, 19 Aug 2026 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143944;
	bh=BjJKIYYFxoq3CtgFW8UUQL3BcquKcr3CqP1T0B1g5aU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJgC9BCD9jbeBI98vXhVGFyB8SuU/uJZQaxwu27TN998zhcWsM8rOvzren8ZspFnA
	 gmhBtfxCcS178FCxgBGMXqHUvlIJnCwtyzVtjog9++CSneZpSI6+jPVKWbcm4l+1qj
	 RGXHpm2WAYaOSRrJRWlOq/1leD9jf7LthXYxb1aenBav6kcKuegxd2dltN4IU1RK0p
	 EXCs1Tg/Tkj8uxBwEmJ3WdzrXRPETDlztpGc2qA0ZhCGJN3EjvKlemf2pMghRPyTz+
	 hc0ZzpRtHvplXOXRTZhiODD836j3C/MpeN/TS0R3CCSv9S9zSsoX4fJUpLefH/fDf+
	 JHYIaIJjT59Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] genirq: Implement core GSIM moderation logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-4-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-4-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:52:23 +0000
Message-Id: <20260819125224.3D64C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce the core GSIM moderation logic, including full documentation
> of the architecture, per-CPU state tracking, basic list-draining
> functions and hooks for the interrupt handlers.
>=20
> Note: The architecture documentation describes how GSIM integrates with
> the interrupt flow handlers (e.g. handle_edge_irq, handle_fasteoi_irq).
> These handlers are modified and GSIM is integrated in subsequent commits.
>=20
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D3

