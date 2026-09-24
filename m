Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF749E5F4;
	Thu, 24 Sep 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262440; cv=none; b=LZcW1sgM40MDHqEfP517BoDKi//qKBV47QO2/Z1djfTzMSzBDhSmQBgExs+g+HumzgsayPXv69HaXnhbltYDb83gbc6UzJHf2rr8KXxFv2H7kR/m6iGRJzvnGePClXfH7H9aTRDbT7VicRlBrBRrFZOGw3jxk462C9aZ3iD/1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262440; c=relaxed/simple;
	bh=638KZsts/EnjSXEsopg6omDDcwB8YVrNYu8PPgMsUao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhPz2SHudwkZYuiCAoosrc+B2z29fyrb1YkLzPR2t+nS1+Sut7BXS2QB5JlyAzqyriQRThCJWjxSLyJhTwlxJ6XqBPsvqHnMQNYJrw4aF6JWVnGWp9+Zv6AyJdZbsqqF7WI5GBloet97k66frmUgjVP+tEwsageuNvvwoHP7n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbzXevEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbzXevEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5012B1F000FF;
	Thu, 24 Sep 2026 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262437;
	bh=nfHH4P9ftHDIqNLe5rmUK8ivO7QxB0dY9kdIfw57pDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbzXevEnW3jiATGW2FyUnou2iKSdzidIeVU4IVi5Fzx8WjoSzNcvxpbIr+Biko7yM
	 q/nkiw5K9ufjsDZ3lgnAwKYMhdWjA1YFKOU86hlKkOG7F7zUkmXpVv2u6Iqp7RMAnG
	 bvMiR7000McjYBpg2Jm353aXKA1P5hdi74rS1u6YonCY4sgrtSRqijPnZ7cwXTByD6
	 XupnRcRKqSUDv/dhGBCSzYmHI39nq8eRzYlXURvvsEAJna0LA21lBvfTb4k3z8+y+a
	 dORmJ/S537tVjxn1zYumtNwDBg/w5TGeBDHgcSXAJLTAOqFD+I5qNXkKtjND4Kl77h
	 P0+s7U9KZkDYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260924150222.1179235-4-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
 <20260924150222.1179235-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:07:16 +0000
Message-Id: <20260924150717.5012B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924150222.1179=
235-1-elder@riscstar.com?part=3D3

