Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285509;
	b=eE+/aGKuzVQxSO/gHd5rqljwVGgdBYNvPOdbsW373uXC+FWk6+dLuEyyQNbPv4RGGi8X
	 fnM+Brll8/JPP5VWu87QdMAuvsLLQLzn9sZUaHK1exnjgKJWBx6gHNbfaHyZ284yfyNP8
	 ev53UHABsDAUijCEmoum9V3yLq+ZMfzSA7U9qAFyPzXZxNci/eEG2IUZ9/jxCBRldDMTJ
	 wBkxeGERGuhJi5E2r8q3G/+EcnBfzyNX/xGk9woJRFjxqry1dy7Czh+MmHKyLwz3f0Sj+
	 ry0O9Fu7LGHYq0JFU1rF87tfZyZk98wVkxGtFk5VwGoXSLHAVqTqWJgUQvdC4Vm00Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285509;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eQt0GOezJ1sFMyBQTlK5Wrxt/KxMWBrr5NLfXNAq65I=;
	b=J0zpsiHXet6pabPat8p4eay4cJtpAzi08htMFJlzFlSYsNmClSc4fS9KLsdogGqIGPw6
	 I+8wzAbN9GemQEqbqZanbl5R5mnz9p6a2ZaQ2gShyHY0+Ll/cP8RQ/Y4LNFKjH42uYEkY
	 8Vhqg1BwoNX02JQtzJfgx5UWJlHnp0GxTbG+8T6+/EQd8tWHUHoH3t9/S5VHkHyQ+Dvkv
	 XKXtqA+pa3LWrUCpNT8msp+MiYexq9UNmsCRUTEctsPjfox1WOPbWSzGNIPZfa+JN/sfI
	 02rFAhwxKpAHbuCkCEKH+FgDzIyyDFlC8mdg7vMdHuKS8qMEL4RgTCGKorsJCoIfORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeJ8NJrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A8606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeJ8NJrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475931F0089F;
	Tue, 10 Nov 2026 04:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285509;
	bh=eQt0GOezJ1sFMyBQTlK5Wrxt/KxMWBrr5NLfXNAq65I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QeJ8NJrk7jfPrLS3iDjX3xHxe2padkgNmgSGU/ZFcPPnNdzoBSp6KbsHfcDTQSL0k
	 kUvOvwcx9OVCaa+S+IwbV6/lWivnv3YZia6QCgW5D/7irLr9jadyEA2EswRB/lUSdp
	 +eyBNx8Q8AgiZHEtbogKdSYWYzAc1Ulor+V8kOkQwFX0afLOZksc5uv7xtil9QdoAC
	 ImX5yGGDsrnGO9ucS1IHuP/Kt2fMcbIVwBZMnWwK33yS5kAfBg2NhbXvS63tsOm709
	 XeHoGqmCBL6QuiHKXnu/LD1Sb4i93iz/+nrd4Zzyi5ETJutNHLNpPMPCjoOj4QPNjq
	 iKO5a/xkgVdyQ==
Message-ID: <sashiko-outbox-206220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/25] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-16-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:38:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Support the GET_CAPABILITIES SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D15

