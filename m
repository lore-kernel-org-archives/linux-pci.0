Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64233F927B;
	Sun, 18 Oct 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341965; cv=none; b=lwKyOv9xim+Ujn0Di1ksi8teUdW5w3wemfwYs4ekCX9vl66gDBc9Fq4/8ZLduRSTp3VQH6kfcD63/bNvSXGkFi6xNx2GbvYyl5sKG7Y5KFlTQboPqAYDmTZB1Ux4LBHhA0wTpM4b11ga6IhXv7XNlQn2y57B+eVCyJ1tJ4UowHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341965; c=relaxed/simple;
	bh=8l8//CCQnTFe5UMcwC4wmxjdbCS6zXkcL/xUHA7gqeY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Q84PsxVfQR5w4o7c+Ai2jP74/V8RbXmyg4l4QVcCPs65QvykNagtoq0rl+ihB9H3K2Lh2gsGDB8n2WgAjW0il//6mxmmsvMUehzAF5ZZcy9/WdI6ctlsHnSMrk4+c5WCk6H4ia0FzvJs478YYXADV+nZQN27T6B7wT8VaBU39Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCKU2Dih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCKU2Dih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA1A1F000C4;
	Sun, 18 Oct 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341959;
	bh=+vM4Se0anLQr1YB4ILyOf7hv1ONUyczoMSJyi6qst0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCKU2DihG8v7Vw5uVjWVLxQTy/TdYEmUbVPqxfMydvPnoJFBnm7sKrduSny1qungB
	 GhBMQhMzLYfWF3kwryKYUBvnwLqFsfW49uGNlZ9T0kCDG5dmFO/eM20zhFgPU7Xqow
	 xVFw2YlFcIaCcJb28XV42Cx6zp3Yxtdo91uJj3XzyCivG+ZarKfqriewda+VpZ5hpa
	 NUNfA7mGW+TwhHRmuKxUg3DThIMO80fJvuiKku7/XncwWJsosFsLEn2Ky2F5QT91y1
	 IywN166yUx3eUAxCHeKogHInxh4QVoXsBzR99hZSvtx4m1JWOgyCuedxA29PuJoJTl
	 oSwQ3b5yOE6Hw==
Message-ID: <sashiko-outbox-176291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Don't resume the software CM if the
 host controller is gone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cole Leavitt" <cole@unwrap.rs>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261018163910.132231-2-cole@unwrap.rs>
References: <20261018163750.130470-1-cole@unwrap.rs>
 <20261018163910.132231-1-cole@unwrap.rs>
 <20261018163910.132231-2-cole@unwrap.rs>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:45:58 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> nhi_resume_noirq() sets nhi->going_away when the host controller is not
> present anymore on resume (commit bdccf295d7cd ("thunderbolt: Do not
> touch the hardware if the NHI is gone on resume")). With going_away set
> tb_ring_start() refuses to start the control channel rings, but the
> software connection manager's tb_resume_noirq() still goes through the
> whole resume sequence. Every control channel request then fails with
> -ESHUTDOWN from __tb_ring_enqueue(), and tb_cfg_read()/tb_cfg_write()
> WARN for each one:
>=20
>   tb_cfg_write: -108
>   WARNING: drivers/thunderbolt/ctl.c:1157 at tb_cfg_write+0x94/0xf0 [thun=
derbolt]
>   Call Trace:
>    tb_switch_configure+0x8f/0x1d0 [thunderbolt]
>    tb_switch_resume+0xb9/0x3d0 [thunderbolt]
>    tb_resume_noirq+0x5d/0x2e0 [thunderbolt]
> [ ... ]
> no events are processed in the meantime.
>=20
> Fixes: bdccf295d7cd ("thunderbolt: Do not touch the hardware if the NHI i=
s gone on resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cole Leavitt <cole@unwrap.rs>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163910.1322=
31-1-cole@unwrap.rs?part=3D2

