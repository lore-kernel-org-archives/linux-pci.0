Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3E421254;
	Thu, 13 Aug 2026 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603280; cv=none; b=Rqnty0iity/ni2Wfwb4fiPQ4wNT6ofgiZw8G6P4nDNXGY0vc0d53FL/0HuieSeckUQyNPCE4YPEFrUq0NMNJkLbzH82vaEheoMQc9Jv7qkCpi2ZxIpVvTyJl9o/rwxQrLMsF0gAkDZOQugv3bbGX0b+G67wETdnF8ojlU95Aqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603280; c=relaxed/simple;
	bh=RvuR2qlOoDFEPSwyFMA7vo39M2x3tpVe6EI3yWSAQEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGEjycld0UD944FKRRPUEGkdgGd2o4nszPhwpsLeedmKdmGsk/2UMYaupixRWaG0otL3zRREnFV5yisrMobCXwQv42+DVmRhPaGLFldFEsvW/d0JoKwiHDxh00tDas5g34dhFaUGzXtckAX2HVo3LhbgGJTNOEB18OL+ESQHDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW7O4MVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW7O4MVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA91F00A3A;
	Thu, 13 Aug 2026 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603273;
	bh=RvuR2qlOoDFEPSwyFMA7vo39M2x3tpVe6EI3yWSAQEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kW7O4MVnWHk4dkqEA8ttMuIwrzlmqv4yTJYUHXAomv5Xk7wKIgCYMwjHV1oC+S1sK
	 WeMV8viWDJfXFp9/bvgAx49yt9M/zv0jqSqbDND2Xg5I5xQ+bkrJ6rCBdcc+a04bxV
	 iIe4oGuIvDLe1M9vtiR4+wuA+djp6ewzH6/FNwRuV/bKVVwL0TMcEXuEwuPAaxJrIF
	 q+Yt+GlKkatJVdNbtzHS6qC8PauhmT8SupJRdKO8TBqbDf5UH0LHyPQLhcxU0vqz2M
	 YqvWzaXP7uVONFcKta+S7LJM2y0qH+0D6KDjGCGx6Th61UEuIkHJGHBx8K7P4/YgCk
	 GDEeS5kNJQxNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260813063757.3131865-4-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:41:12 +0000
Message-Id: <20260813064113.1CBA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>=20
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers, identify their corresponding local DMA engine device and static
> channel ID, and refer to descriptor memory by ID. Descriptor memory is
> identified separately so one memory resource can be shared by multiple
> channels.
>=20
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D3

