Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780918;
	b=iQuuszgw+CCLPPpwmvY1u/VhH810zYTs3ZIyggNwNCxMdtWRrtuSDsE2ZTj75fxyGkxV
	 XxyDYNCcP+cIc/qvzDy6zoGPQLQyW5o/rYGihUIk44C0qVpvM5zrSoUFi7yEhpEOhVImZ
	 7jcVfyQTUzrNDGc1gGs8EgL2QxaZrGavcj7z+UZAF3siBanqkuc3RNNHJqtth4LFqnVGV
	 agysujfVLsvA/qL8Z2i3GRynO8As8XfV96HcV8dhtHlH0Lf2N/Bs6NYZGC1FDK+4Gi8w1
	 BHq/MoRa9Z6dcdFKqpO8mBj6d+qdpHGwK5JPP+st2xrINPOpcSNpMTXo6Jr6jvuX9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ienYAtGkbvWV9f8IUYDhg3KUztdIq77axURXwCnNHaw=;
	b=LbAJxc2bz1zOy8OZ14AeHdoMfIuYaTPb/UYHhxTswrLUwZTZyyQ6eWEjFiplsX9QZLlo
	 +wsnEk1QYBnQyic/Z2HowR0gN99PwrKceNCeg1KTa4r/7P4RBkaSXJqmdMkDRLR6FFyFM
	 YPvBY1V7bu4usY9Z3Jo26yHcpDCrUvovt48F3XdhkKuUKk0BAyems//TuXF1CqMh9fXxp
	 k7hnP7Iu/SMJUOaSz88RDhoox68w2V8TyPL87dXplb4TeKdYfL8UOhOsxLqk3Q5twTXFv
	 BrTAbjpF8kUq5+gVOiN8EtumpN/D7Ilhbjh3/jpoCrXSe1d5/ig4JAgVd84kC4WLvUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohua2UK9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD868606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohua2UK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4890B1F000C1;
	Wed,  4 Nov 2026 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780917;
	bh=ienYAtGkbvWV9f8IUYDhg3KUztdIq77axURXwCnNHaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohua2UK9NUH3gf8fkQGwR6N5PThlF8fjJ3wE2eXGJOJR+UK+ndOveEVQeoOvpMCDO
	 4VB+pY3G8inUtUXhl2aVsoC/McDleE5PAMcZECNLBvzoWEJ+8QpwHj0VxXrdTdIpYP
	 0Ea1IJmzJRy33PI8vgo8RS5QXMQnXOr5y1XEs9sr6WfGQJtCUmFwn2UlMN8J/gQnv8
	 aJX0OwRj3TIT2EpBktov/4fpHP++JANyrBAeuymCLFx2Aj6xXCpqrvEEVpSJIkcVNC
	 duokExe4GsK5bjpQmTGOyFGYVAnLxGnrbCAiLQmnFmHH8hdvtenjPo117p9Sd88EMs
	 L0Lu3G92PRdEw==
Message-ID: <sashiko-outbox-196878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v3 1/2] dmaengine: dw-edma: Sort Register Field
 Macros by Bit Position
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104082302.3819409-2-devverma@amd.com>
References: <20261104082302.3819409-1-devverma@amd.com>
 <20261104082302.3819409-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:28:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Sort register field macros by bit position to improve readability.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104082302.3819=
409-1-devverma@amd.com?part=3D1

