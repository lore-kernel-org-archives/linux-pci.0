Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674223;
	b=okSGwq51PSR8BvexHZHVaJoOBt8vORWf1T8cVOlqn++bOs7RF97fBqpVGyWClhcFwOhw
	 oAgdK/khvnbqsv/jH5aAcNybyXFUlfsgp+zCjRkA/qGQMYzgqwE+tOCo3XQHLitTGnPQz
	 1Kvm4SKLRBGXfouzYxEu+XTQjzje6xy3SHSb8FFOeJ2mufEwG28Dk877tvo1EBkWDHU4C
	 HM65Xp3Z3G+xxPndFEENVH4hYsjURobcmlb2xnkL7HYH7O/vw/0TgLmdqbDYflYBPQJRj
	 F8P2gCyFR3NysDnqx327TvIF3fTdVU7b/i1hyBr9In0rs5rr15/uPZrhtUiErZ2/I8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cB/z21hLHJSsd98hcTr9GRIQpbZLaxsESBPvsHYwnzI=;
	b=4js1U0/jgZNYMi30jD6zdR7SfFiJYZN2n0SbdfjWDGneL6yGg6CIu2N2yNkWKXPwQYCz
	 NoeqbXUtX2700BdjHfkMmf3RU4dLz+l1kzTgn1rqjNNLKdxAZprbLsPMMcIZBq33PkxL9
	 Z+ykmDnwTCOKfREF8htvncCkF55YlrhLoSDzSq51aXDnQkSKrmaRTXPrvpQjToNOp9U94
	 vqaPugCYZoWsI3Aon2AsQo7iwQ1rnWAmKcEKU0UE9Fx1UJZrMt76i2niToB9n5JuovMh1
	 jBcUmXX/6DTd04wnHUK/xmbEdTafzUPNzq8mBgYtLdeQ6hblPILk0nWQRMwAqtYHxdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkcsK+ES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E0606A32D
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkcsK+ES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8ED1F000C4;
	Sat, 14 Nov 2026 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674222;
	bh=cB/z21hLHJSsd98hcTr9GRIQpbZLaxsESBPvsHYwnzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkcsK+ESt17VKXujBH2Dfor2I+Fuq7fbMELuv1bsjbr49cy1tfg6IGyBbrW7Ss+qL
	 nUDXyLfkrQwGJUjz4aW19htPVP+Go4qHKoqSo1/uUmB4uTs4y5uzOxS6ANfKsyB+4B
	 Nv37+JPp6pljxO1w7eJGANm809euE5/a/hENe1A9xMb0Xu+s2ozyUupdzD4DT41g1W
	 2hHUTqfpO+roVMKaQilBZzLKXo3AOHeUnP+/Dod8QpBOjrU/W4SoeWGD5Xkn6+w4o5
	 KXs6XFWOjcvWadCgT+i3aLDjoDVX3SOiBtPDMUmbodd+70DnyDrzo10WfYak29moWY
	 z2HBUUZlTHMaA==
Message-ID: <sashiko-outbox-214760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] drm/amd/display: Skip panel power savings on
 eDP links without a panel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261114160731.3756-13-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-13-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:37:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Andre Eikmeyer <dev@deq.rocks>
>=20
> When GMUX routes the internal panel to the integrated GPU, the eDP link
> of the AMD GPU has no sink. It still exposed panel_power_savings, and
> tuned writes it on every switch between AC and battery. Each write sends
> a hotplug event and the following connector probe runtime resumes the
> GPU that GMUX had powered off. Only create the attribute when the link
> has a panel.
>=20
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D12

