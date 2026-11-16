Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848700;
	b=pAUgUvPaINVPx1XaJGcE3EFO8ew97+XVkQgKgRLLzvwFrvf4glZxy4h6Wuc2gKIuB7ao
	 c8x6u5/sH5s/qIRjIfjdGhKfQRrZXm03GIYBifJKnYNQNgfo993rUtVgJZSTIJ09roSFE
	 YrxtlKNvjVlzUoCmdx4Ag8hKBKtHRsJCR7Y/CcpYI1srw3eI2dS/ycMghLvTnlaRc6VJV
	 8z1BhVnhR/QPKJK0wY/YbZMs2+Ie1v1Th9kTW4S2v03XWSiRBuvEvAprNowcFvxlQ5voj
	 6SmZx6VbnMXtHSfiw1bjqAW5fIEXd/LXkvRerHPGuMmWp4b4GYrP/25JMlDDgmRc50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ArJCFi/i5w8l6GpmE2Fbp2Dsb4JCyuvG6l/yt1gmIhY=;
	b=45kzml5rq/LYDrQKzyXV7ZUAErqDumShZHbhwzfhYG48AEkp0a6dG/+3z0oU/vLntk/j
	 ZMmoXdZQ4oAG9ZiPkwKHd9CfUa20gjfgNQywefX+VqND/DivuAqU4hABVa7286deqrzBh
	 gHrC+RyzBu325WiEspPjqM7Fybv7qf/bK5xNPCDFR0WTD9sYb5Pju4sVcchDE7R7W83EN
	 jslPgSbnqiauELXKONfPRW8/gxQsRuTGHMSfXWdeDWAA88W6YPEQP7ZECuldezHDwSzlr
	 6Cl8VsZ1NTLYeykpCWCF8HNgkmCfCm5lslvIa1I3BDGFU3ywbFsT0tuEXh3kfCd+dfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezYI1wQj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA6606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezYI1wQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F871F000C4;
	Mon, 16 Nov 2026 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848700;
	bh=ArJCFi/i5w8l6GpmE2Fbp2Dsb4JCyuvG6l/yt1gmIhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezYI1wQjheZU547PNO618pmHWHceuykdQgR0Lnsd6xGZECZ5IlVmw/uT9zCpudoBQ
	 oY4Stf979o7OwYm4L9DN5D4Zfw4keb1okqBExA+emcyk3x1H7XiZ+IrYqd3csSizSz
	 YerhSLhnPpxkGVVYWSUKzGxv+3UGp+ZLHfFr5V8vfOPJ0/5V7p1M56avxpirl9Qyww
	 lzsRFbLTb5yUaKMYR6hXBusPHwcN4O7IC5mphizV0yhIHbRg4s3TlZ3HXUrNyda1fY
	 HPs7rGquu7gVxhfH4qhoAY6u8qEYPf3l7eo3gi9PYwYcYByYjC2Dsirz3q6Logx/qy
	 t7ECRrQ4PK93Q==
Message-ID: <sashiko-outbox-217406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI/PM: Keep hotplug ports out of D3 if they
 can't signal PME from D3hot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116165110.2773301-4-avivb@amazon.com>
References: <20261116165110.2773301-1-avivb@amazon.com>
 <20261116165110.2773301-4-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:04:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI/PM: missing Fixes trailer for commit d4c79b63d82d in commit
  message
--

commit 70281f514dfa84e338f2e7558fdf02d6a96db4d6
Author: Aviv Bakal <avivb@amazon.com>

> PCI/PM: Keep hotplug ports out of D3 if they can't signal PME from D3hot
>
> On runtime suspend pciehp masks the hotplug interrupt and relies on
> PME to resume the port on a slot event. pci_bridge_d3_possible() does
> not check whether the port can signal PME from D3hot, so a port that
> cannot is not resumed by slot events.
>
> Return false from pci_bridge_d3_possible() for such native hotplug
> ports. pci_pm_init() computes bridge_d3 before it reads PME_Support,
> so move that assignment after dev->pme_support is set.
>
> Co-developed-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

[Severity: Low]
This fixes a regression on non-x86 native hotplug ports that cannot
signal PME from D3hot, which were allowed into D3 by commit d4c79b63d82d
("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86
platforms").  Should this include:

  Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports=
 on non-x86 platforms")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165110.2773=
301-1-avivb@amazon.com?part=3D3
