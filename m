Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277B3F39FA;
	Tue, 30 Jun 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816331; cv=none; b=Kz1i+/lijz8iuWQa/PpFaFUP8KSuVxqba9j03L97lxtiN7I+YpV07xl4u509Q9QJUMcmJ1rCLIHaKDKQBQ9VfXyiTLK0soe21ZY9qK1QSCKw3pY1anlQ1z3tC0GauwnDNxQDnJePXjTDxZn9TRmjlqDlC6mveGCFUUzwayZ+sMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816331; c=relaxed/simple;
	bh=1qzLgeayJRlHALMs6tH2nrzX4c0/URqfvtlEkVZTWAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eX1QrPU9cs3sfNxI5L5ZCVC9JYKXCKHCljaYVW7AwRwleIF1wkhNtgh6aLrekjP+eyvqys2P4MXYVT2h2hMg1/QBAIiGknBXk75YSjWvBJuauF1wiQKETudutCkdErLwTsrf3XYqXv8KI4tp+Q/kJvy8oSNWEgTk5FjZd65Ijbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTDf7Jfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTDf7Jfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B541F000E9;
	Tue, 30 Jun 2026 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816327;
	bh=1qzLgeayJRlHALMs6tH2nrzX4c0/URqfvtlEkVZTWAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTDf7JfiaCt+uFpLISyuRucJJD7CdbOeuNj90btEGdyByMwqzFvKGygRwaTtT4fif
	 79sy4lnV5bZkmR7XR9d4opcgSSGWWjx2UG1sqQ9EDeWugviMobxaufOEnRM/MnecOQ
	 eHvvIlzOmWJgIKtbNfGyVgYyFXVlzdJhrG6WWAb6d/oGzRlSzs5LwWcHfozt0FbEgI
	 3uYiYkU52fOCnS5aifN/f+cIQcCT3eENW7PEdT1CkZr6LpOkIIjhJRPWkOlz2oXMkt
	 YjKjp77WuGlxyjF1e9J5gpchM/jotkLmWUcB1DzGR9NPtgNF+p/yOjuE1PXspVrAhd
	 pabWohGaTBdag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-3-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:45:26 +0000
Message-Id: <20260630104526.D0B541F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D2

