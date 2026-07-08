Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE938B148;
	Wed,  8 Jul 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505725; cv=none; b=r+cG7u1Az2a+tnTw1NXU+K4xxEs3ylzAqJECKauDdq66Xw9fK58sEBlhT/aRJt9KBIkqikCJLlNRPJ9lo+wNWCoeDP2heUj7gVOjtdojMgaqpRGdOIYrXe+hXBwua+tqF3njowwLWT5mLO81iwk7J+oLbq5EZ3KywklohcMVYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505725; c=relaxed/simple;
	bh=44NFp2Fh0KyEIHl+MMvPNrfYocMdEmO5kGfkuwA7S7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JiSjQV4lZ4GbzBtf7hIcV46DA1oIAkHPXC956wwn8Y96sbgHz/7PDAd68LQCjDNMIJEGV3HXaNBj0t2USpRTB3LwOU4qnOZGN3jcQ/2SR6So8nOF5F2eqni/EbGbfiTUQKSDAvRY3//BHo1Wl2xT5HA7tLS9qM7RHQGij311ixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imxL8XYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imxL8XYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB281F000E9;
	Wed,  8 Jul 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505723;
	bh=44NFp2Fh0KyEIHl+MMvPNrfYocMdEmO5kGfkuwA7S7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imxL8XYmc/8CTN16W65pFT8V8eshDWHuxkXWsYfCB+9GgIwe/RsCY+ZA1J6Ly2Dre
	 UgWWOV//WQahFJHy/hm4DkqkIiimQt1Z5Km9FW4IrPs2ZYidslFu/k677WUxXonJi9
	 FxfnpXp0JidspzipB1itlbPVYG23ToQIuFlX/kQCf8y1C1X7zARlb/+j/s0JSDpMKr
	 omEcWIYmLjYuvQ5vi37zDUbympXFVwpDF6MZ6BQbryWHRnBftdVl3GtWN8oYuqSCId
	 qWJEY5NP5BCaQhBVeY8tp74NJtGsxzS+T8DcL4AgIQrRc/VaqzDfD6D5hHaHEVT9dZ
	 tahxd+gd2ub+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260708100302.517792-5-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:15:23 +0000
Message-Id: <20260708101523.ABB281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D4

