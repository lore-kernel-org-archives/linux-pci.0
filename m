Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269456;
	b=bTfqS3Jvg8Ng5sMcNtsxR+w86aQZQJKS25R7Vw8xPk6rD27zMegJ6dSTpF/VvD60RGCM
	 KeKpHLyjVKc4r86rawdyOpMhZcmgspDXFD2VWY/nd8E4GLhW337B8hoPY5mY4KcftqQP7
	 eIBzBr7iD4jHXGQR0YPkIjrb+5F/VwiKlP48qixnnIK1uP04hgKORxolFOc+/F+xQoUHj
	 6QkaATePMLkLuZQPpmtVf00AjGanaoCfpTeZDRN94rC0Y5eSkaGhKDFFfyGONlhPmTnxq
	 /nXz+MgMaNWrQXrfhZoYZg3/HNYb3SXwTgAxjIyusJLSC8WRQdK3bTDMwJ72eYRQC/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cFiM1oioX1cDt+17yO11GfmxosJYiK97NRBcG+SoOC8=;
	b=XCdc4KnLp7jRnZAvSnzmgztohSqioClCX3VwgF+/YupOKx0jny6MZGqP91Rio9ongu7P
	 qhl5+8ykWmCwKG8J0fHqf9uunqNCdpHcEZtvthkNobxxGLSN3s/Wrw09IAVefXwWEWDAg
	 AJYcY2hc2zim8ZFazGBMjnDQ/U8/pXkOIk446yyKq//PeCISXPy/EKBr3+PuF/fx0nQGi
	 WP5kLOGoeY3ocVoPHwYzqnmfFp7BrcWfhBsG8Z+ba+/qv2T3A38Lguk2bagMgVPrW5lY6
	 Ln0ARX+hHFK1+Jkz9XO1FJMaazQAKT8ocbMR78tWWgXiiQeH55m4qVIkB+vDLscUYoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHyHwhcL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC3606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHyHwhcL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305CB1F031EE;
	Thu, 29 Oct 2026 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269455;
	bh=cFiM1oioX1cDt+17yO11GfmxosJYiK97NRBcG+SoOC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHyHwhcLN+QxfPxy3fPGcTkf6qk2cqkBibW1dK6HUCw8mQ7Xpgu6dp9+rwq4HSB6S
	 uljvEidlNOU17IjzWkaUzHmGpID+rdwU4n0uq+mWbAlNPqYG+pg9M6ZBf9iKds3xhU
	 hyiZuZ0HLn8MCY26bz8ORtVJd3i7e8KEDHrzgqG5RDgmlt2LNs5LVbZN6GKmbE8GfJ
	 +Jjq200WJ7RSuaPVfpDdOGBbvSwN2kWcCQ+zO2hyS/hqj57d3XTJQzAmTslNLrXgUO
	 HFAPoELJCbasuDOoOeCyxDqJ6R6KGcPFROmsHP8Dp97xMLF8d5zWxdbhCJrxD27bgL
	 j1sdh65rJHneA==
Message-ID: <sashiko-outbox-189124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa
 Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-q8b-dts-v4-4-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-4-e8e7438f5545@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:24:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
> efivars and uefi bootloader.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v4=
-0-e8e7438f5545@radxa.com?part=3D4

