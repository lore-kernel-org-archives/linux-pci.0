Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F903126D6
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723081; cv=none; b=kOztQzh7C5m+eEPJXQ2HLbyHQ9QoMUqE3yKJ94sGNoWPmOqVPUv5+sp7uN9k4gkQmz3GNwF/PRscn94jxxBFMYOVW6gfDTVg7g7ixA0XtKC21efuOumANkj1AAL0NsMU+CF1AOVjPvHbgCG+FmHismCijXfoFgfKk6c53o401KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723081; c=relaxed/simple;
	bh=DO428TfBviWZ9pG0kDjRGOT3fG5KkrE/AudzS1R1DbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NV8e/ZueH0rmr8FKOHc2wrfKWnh5yiXFVlKuQ5ilhX31o7pTuvlXUIqRunflNeQHde7MwPgyCzBZWID5jydGCYYmXZYwazAUBePEudaZ/fCB7vcwAsEb2jF4KDE899soqdPaSmYOvl7sksoKakfVPK8T7KOZG2CC2Vmo8s3d6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmHJLz++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmHJLz++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6D51F000FF;
	Fri, 18 Sep 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723079;
	bh=DO428TfBviWZ9pG0kDjRGOT3fG5KkrE/AudzS1R1DbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmHJLz++fe/oB+CwSou78wIEVF9AOiVa1GSQ7FqSe5eo/L2LxDZbg3HNvTgu+RebF
	 30NOhqjxrUtR8VhgvXkrPEbu/b88CvOXfydUDk8HzXo+B6VwcziHypTSrhVJmCkxMT
	 x0g+hszl8OJWYBQ4598rl+c9vyjnHTU4LSZcQ0ythYaHPNSm26Oz3Wx0W1ASSUVkUk
	 rC1D0gvZ0F+1ZEdUjKhEPaxgiViGHV031apPRLGw4s1NU/eM9Ko82WRVxXdktA4d1r
	 a9QScjChuNNGMIGNhl/jRIE4kd8PqjsdOGsFl6bfTaF6Y/0DE7jW2OFJb60y88ECsB
	 dGKSM1UsGhqLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260918091052.2825315-1-fuad.tabba@linux.dev>
References: <20260918091052.2825315-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:17:58 +0000
Message-Id: <20260918091758.ED6D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> rcar_gen4_pcie_host_msi_addr() calls of_msi_xlate() with *msi_np NULL,
> so it receives the MSI controller node with a reference held, and every
> return past the NULL check leaks that reference, the success path
> included. Declare msi_node with __free(device_node) so it's put on
> every return.
>=20
> Fixes: 8d6af27c0a73 ("PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not=
 used")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260905213855.8D6671F00A3D@smt=
p.kernel.org/
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918091052.2825=
315-1-fuad.tabba@linux.dev?part=3D1

