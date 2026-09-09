Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AA46EF72;
	Wed,  9 Sep 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941161; cv=none; b=GGXmqa4RMZJELgNAVYMZ9uDZvuBX0kwSbqq9AT4FBqZ7/87B+frVqBq7CF47pcUNkkAfwzkOrd6LHc5h7QHgAb383EIuUT4Qjcj1spFqtPnbFR1simWWGw0wf1q76NokGFn5B256g26V2utamVYWN2geUpDNLbZB0fCz2WKy6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941161; c=relaxed/simple;
	bh=bGqvr/99vx6+OksmWQUfEDg41gO9AmDt4zTFnrRY1Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/UXutREDZZVorv6UxhbOgtZhcto4lOrzS8Qvls5vKe05ZdvvcQ+E1XjIG7SYSuI9V9thG5bO/kisG3ZNR19kr3cAozZ7nVKuNmTdoq/xpH8o8RtQFse7acYl8crZTqRcv2gIaa5PWRflJ5ATCNabrBhV8bTmhs1IGXKlhWbONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShDXRusI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShDXRusI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC341F00A3A;
	Wed,  9 Sep 2026 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941159;
	bh=bGqvr/99vx6+OksmWQUfEDg41gO9AmDt4zTFnrRY1Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ShDXRusIcD4nuWtK5H9maPMZ7/rkJO55XQR4tqytBTqsYepAhLTOZ6vRht1O5a5Ww
	 Pm1bALkxX6Uam9s37qokPoqC5im2JeDXj/1Wq7LFRBV24AA8fFFlrsLCmyASuQEMTf
	 tN7hSe3Y670gENt1IgzHxtDFFrwOLNQCflDHjTD/3+y/oDZ8VgvgqUAsf6H3nw2vzx
	 VhB8s42qfnKF7U1dUkk0IrTxnqEWxnlphBQ0ayAQe2NHPVtBTIWPR/kPb9wLVun3VS
	 DiJb2pYlfMqPnBaSRe9xt34NyXEbFary7fwpO6Z4qzdSGSg8jFwTQuRM0F6U42DjCm
	 O7leLxEEEvKYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260909080114.591938-4-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:05:58 +0000
Message-Id: <20260909080559.4FC341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D3

