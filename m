Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24B39E185;
	Tue,  1 Sep 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225365; cv=none; b=akCKz7UbP01b1VZlpMzcer4AF4tRdOmO/P6L0W/YlzvDtD8HqKa1/PXN6FqOkglxk9DCINjYZJ6N30CiX+slwrtD/pBVAtgY+eW373Hzr12ShekaNYWOkykYA01k0zQw99AXYxuoVvHI0+BhX+ovuk323u4hyY3XK2p3GQsDYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225365; c=relaxed/simple;
	bh=Gy3+JNd3kQJ13sM1QvGLtKQ6z/Vv+bTGzbZ7K5iVjAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3PTUKJWi7lDe1d5N78jDH7QgkxqZKoJ/61RCAoMAuiRxRo2yRvA6ms5HanXW5ku15xtJEuJpYP6xBZUqz1CfxW2rfqVCFKJhKwKemvh/c8kfROfrppx6BSxV4g59WPcRuinx+5+lB7LVEgntiSyR5iWFWax3thQlTFxy0WX6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEYL3i7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEYL3i7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069321F000E9;
	Tue,  1 Sep 2026 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225357;
	bh=Gy3+JNd3kQJ13sM1QvGLtKQ6z/Vv+bTGzbZ7K5iVjAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEYL3i7s6n9rg4kmQNmWTjtPOhWtELUG99l+NrH4nHjtLdufht9wKkXmkNyTCuk4d
	 JrtdIW6yUr7s6kbLnJ67Q/mp2JIhyW/qxHnDiYF/U/ylaTeLmSjwGEp6ILpkZe6eFJ
	 lAWLIBWbczC6RDEt6INfbyYFZ4jLg7jRX22dJqQeryXvSDE8buO3Rxdgmg+W+Qr+bN
	 qeF0hhKAi2cAteb0J1qIu/jDKrzcJ0E4uBfihkedOuHhTRx8tvm1ShmlrIHqTObPhc
	 gFAd89QNDQ2DVP+4fW1Rzj81a8UvhiOSVPc+KlR4j9zgH+h98v5QtkUZuvZ9jZRdbh
	 ZAHboHdXFUdmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/21] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-16-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:15:56 +0000
Message-Id: <20260901011557.069321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support the GET_CAPABILITIES SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D15

