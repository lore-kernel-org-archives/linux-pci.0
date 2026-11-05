Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894239;
	b=GMoxfsZB5IzuZIl40yePjC5s1DesifhHnqiqGmN4sHaUEyqRD1GZMpAia1ogxVvwJcws
	 Q5I2J5i+1lb17TaRPJ0Ejumz3BNH4qhll5VA3qVzFasm06NhOSEXaRNgWdiISJPfdoVDa
	 99Ntv/UhQP/wb5D8J8sHenjaD59yiKnxZvP0YENzSJtZGuRz20sbAinm/ybJZGOVl+iv6
	 4TAmHDqpohiVSLNH81ow5SH+QrlMOE6x0RocaloQAwCPOEaHuyS/bzvVx48D4f9LfpFad
	 zk5u5tz5mXWikcZRbz9Rx/lt7ikcOeqYRb54beXZqBBw9g7T3gODVQ6ucx1ylIStRQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ztw+L/787WlkkvQliS9loRwdV938JmM3x/5rdPKgWqY=;
	b=a9/tlLkUq1T9V+w0PLWEpsUct2MGaTrPtrgFTjSHiQLNsLE893/NQZIiE7D0qaVVulyz
	 6fpgXtWYDItMS6zxIDN3Ze4EkK1O4r3hEP2+JxAlc5VHKdLZhXg31bCB2oJpben3sqrZm
	 QzyAiVhgbFCBpOlyc6TMkXBqxvKGS8vJgAL8ZCZcDc1+yNU04qa1Tlz+P/u6QjXExWpZo
	 X0kybOqxdiNvtGR0axg7zk4Gwg75X3G3kziPHvNXM4xvr2yyV3rjTcNMeS+oAAVWL6KIw
	 kDnh1bZ66xqoG2WKfDDIvnkzNHGaTav0qkqhWbAG7igw7FlBqgyuMk44+tYlvcNrp9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y69jJVGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EB60726B3
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y69jJVGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38BC1F000C1;
	Thu,  5 Nov 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894239;
	bh=ztw+L/787WlkkvQliS9loRwdV938JmM3x/5rdPKgWqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y69jJVGZMUmxyddM4DPgebc9JEMm+VHdU9NdJLE9epEh6/UCWxSxvSjyBpcVKNBXQ
	 xNWHk5Q2AkOWjGu78Hk28MQvbpliew23P1qTcXt8xp8ojNCSS9fZMhbhizTl0kPipa
	 Q55fUIIDQaB/ZXgF6FZyOiEfmf0ckpGm/tTylGCj1aHbrgK9Z8nzFM1QzqceQQi7IX
	 JCCCvlwn5oCT6kiRZXJiZ92oh6p3bBEqA4LsYyaT0eoANe48+BCy9YNSMcyJXA97ap
	 q4uBtmGCRt665Xev7YJWQaR0V8aU122l7eWWq87fOs5VLoi5rUxJBahhV5l42suf1i
	 yONVLT9x1UWHA==
Message-ID: <sashiko-outbox-199384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/10] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-5-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:57:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D4

