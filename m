Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D531F99E
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510664; cv=none; b=Xi+se5/6pzMDpK26eONMSIkkdhC4WvTBtL+uHh0go6pmVrQxScZ482v+zjs+/rLeVb5FhhZ8R/f7Nw36I31lG9Tf/vczLj5PD5s/AXTw/XW2/+e6P33ONO+QJ71vIRxGTv1zZ7aO5AoymB20hrVnBPGIZq3zQbzjKnSbwdFaC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510664; c=relaxed/simple;
	bh=hr+rA41nbgPqOOfVJoYrnNOR7IaXBWfMnkBHUikprWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hB+apYH0xTvitFZbHvXgIGta6nNfdbte19K1CxVLwnTd9ASiV5yFWGYtXS+d71eJSInLUP+J8M/4hi6jbtWfcDnnlAVisXekhf9aCXFBs+Cue2PQFWb7IB0AN2Sp2b1LHRgN7vazmhtXL+9CIG7IUGUGbUN2eFoJxatXtFdIA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsRA38uE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsRA38uE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069511F000E9;
	Sun, 23 Aug 2026 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510663;
	bh=hr+rA41nbgPqOOfVJoYrnNOR7IaXBWfMnkBHUikprWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsRA38uElq52n+0gUZ4GV8E5fPaje1U8CMwiM4dqQQeb7TByM3plr7PkZIM2YL3rd
	 XzNz/fyCIYoK7uVba9dBECWls1I+Ab2orgQY6pAOUo6kGrMFy1jNybmm7uuGX7KC7y
	 rGh1cYJQRLyozOGAzzvP+HzLkJrDeL0HnN0yk6glteIrTAl1nhFDzHEiUy6qhBwrGB
	 gtO/iaPEvfTQF1/+hOEa6sVOjjLZNqwQxpnery1GNcOqWduDchQ6MQyr53zefoBLii
	 vHuSsd7CVhc7dwnLLHUjgOtYYGzoRxdAhwNmpt3X48bBr8ZaNoV2tLp5HtZh81hWjY
	 cTvTY1knmGBrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] pciehp: add disconnect_work work_struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260823183458.982699-3-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
 <20260823183458.982699-3-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 18:44:22 +0000
Message-Id: <20260823184423.069511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> - This work_struct is used to dispatch disconnect events directly from th=
e pciehp_isr, as we cannot wait in pciehp_isr
>=20
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823183458.9826=
99-1-abhinjoses@gmail.com?part=3D2

