Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9552C21F1;
	Fri, 17 Jul 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300349; cv=none; b=BRUIFzndSrg6kDad55uxmXqiAsX1ooexH+a8ALkHi4VsRsr1oYK+bVNViBh90ybmcJX7mWch0M7FIeU2wZ8IRl9c9keCOxmSFioMXa9RTR9fjhicJfV2wEciDOeyuddiklyxUsEKVZcUnmhxT21LzqnfR2CwMWlT3Sn/KiV4eHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300349; c=relaxed/simple;
	bh=iBFikk4J54rK553YN2gfNZgLFhLXQDc6Z5zpd8f8nxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsMcCuavcbm1LV5djRCPCoWkI8898RteK1OEfbhxj46j1NNdY2gGwCzNGX1Kd6KRwFczVt+NS5oGjxQmrRJ2Tav0Kdet6DVhFVESsn8rEEEvZoG+awvVSrJFwoqqrsNcj2s3XucBD7tH0X5KiqlFGzAI71w5sq63bZ8sdVdSiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnlxLB+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnlxLB+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ACB1F00A3A;
	Fri, 17 Jul 2026 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300346;
	bh=iBFikk4J54rK553YN2gfNZgLFhLXQDc6Z5zpd8f8nxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnlxLB+0+cB+2kpiOjcAc+3g0fZ/Wp9k5YVEN03qb0BKfNazUPI9RMqH9cv/+tdel
	 zwjEsGJC+LurmbAly16yDmlQ2tgc9aVmBAkB3Y5LIqGnwLQqtu8xAYsLc1WYe7nm9k
	 To30nEBgxKF3MQAWdShvc0OWfqw7PKbPXHGXutDP1K2y0zDTlFX3BGEXHnXoufznWe
	 2N0CUpj2hCi8fGmjmEuP15SCBFNqN1oWZ7a0UA5UyAjpb0RKJhilYlV4+QMccqbEQX
	 fV8ei7yRjNTUK6qGJXrD6c2ouGdk4tsmIlqJpQZUAqAc33ZZO3a1FzE8e2PXrC8XVL
	 gvVEyz88gzUpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/10] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717145147.823749-5-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:59:05 +0000
Message-Id: <20260717145905.D6ACB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D4

