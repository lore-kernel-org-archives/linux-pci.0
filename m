Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A642AF9C
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197319; cv=none; b=nIgJT6IeBc5tk6nzfmO6qNoAzEAqFvhRV/X7cYOCuCwRzuljr7VoUnoOjrEzjKYS5C3YS3SibP8axkD+cq5wLkhdWNtPouGeAYlGHRvyb6JeJLcEJqCCimoJUqjb+eA2w1SHATiZ4/aRqyxPmaCIfUx2+iL5HCSxVARYzSS6BSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197319; c=relaxed/simple;
	bh=QWlQXqeOY2ChbBvWCt8Jmy2NuXeSNrjSIrdFbLyi9kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4oGPlORSwX1g6RiK26ogx71mpgnfYwlVc72bJIDke/yQZontJFyXX59LtQQWot6RsY2c1hpYn6v/VLU6Va9SZXTwZrqsqXoFl6OgCmLdOdR6faNl+IkZMGdupKlSSuJFEqpZJXI+2+cxsuGujynozRAEFaSqfA9RAzymhOlejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYWMr9Wo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYWMr9Wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D91F000E9;
	Mon, 31 Aug 2026 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197317;
	bh=l7KBsgrBZ9NBO0K4XWHxv4xN/J4BGa+Pi/RXnDD12ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYWMr9WocKuurfOMr4iqS0MBqY71O4ffbBifMWGPF10Z0F+nyIU5iBnBK1ptrVksL
	 t93+0Ruq79TvWfv55uF64/kCOllEj4mJEpemyRUhHQrglbjDxGoxoSIHcb/Y5zKdXv
	 WI9IOtGu2LGb6gFwPzJ/WCFlXZOHeREBtP/uQqYe1xmT7koA7Z397ZJygtEc2xRhw7
	 aIY9+9wRAo05JR/85DBGS3bKeijYszL8NMyk7euVvtGLUtgwKVe37hThc37Xt+yqnY
	 hI9u7O1Wb1xilgZ5QwFVSWLEBfR148PGPUb9CD8ZudsiTEdgilU+KJ9RoFrQlCpcLT
	 wU0eaZk2Jny8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: Stop setting cached power state
 to 'unknown' on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-634-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-634-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:28:37 +0000
Message-Id: <20260831172837.826D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> [ Upstream commit d462c8e89e84bfb6417e6b4c88e0cb7cc747ba41 ]
>=20
> When a PCI device is unbound from its driver, pci_device_remove() sets the
> cached power state in pci_dev->current_state to PCI_UNKNOWN.  This was
> introduced by commit 2449e06a5696 ("PCI: reset pci device state to unknown
> state for resume") to invalidate the cached power state in case the system
> is subsequently put to sleep.
>=20
> For bound devices, the cached power state is set to PCI_UNKNOWN in
> pci_pm_suspend_noirq(), immediately before entering system sleep.
>=20
> Extend to unbound devices for consistency.
>=20
> This obviates the need to change the cached power state on unbind, so stop
> doing so.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Link: https://patch.msgid.link/af7d11d3ceb231acc90829f7a5c8400c2446744f.1=
776415510.git.lukas@wunner.de
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-634-sashal@kernel.org?part=3D1

