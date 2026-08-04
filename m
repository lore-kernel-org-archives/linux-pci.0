Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503338E100
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851624; cv=none; b=TnLcJwV/qSLJXXJgL6rG2xksn9bRVI/7Ta2DIZjY/2XSPLlshW5oaQOF/mY8VQf7hnBo4o4tewNTDH4zYPgQoyDuvIefcB4FGzLW6ZSG6EYO255g4QQ2Kd43Nh+i2OeRqya+x5fL7mbvJYG05bdvShf+fpWW5Cfdc0ODbhP3pEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851624; c=relaxed/simple;
	bh=x4PQVs4XOHErmYmftuQgFrIbGKM+Li97RwpTz/Vkfcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wwcwdvl3z5rPWDKgkPKPkeB2psIBNsSYGCK6X4iMM6cohKIqmrRgUrsYgEOs7CW4fYh3h3tXur23kD1Ut7qZYbM0xxPEMMzprxuF7QPszdipSkqJb2qSJ7p0MEVsURgTdzF2rVLi2paqSp88Z1smX1u+UvFwoh7+H530fQMwkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmFRdMEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmFRdMEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0B31F000E9;
	Tue,  4 Aug 2026 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851623;
	bh=x4PQVs4XOHErmYmftuQgFrIbGKM+Li97RwpTz/Vkfcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HmFRdMEg+Av6gL2xj+f1MdGeR9lgSDq2hZMgrkRn1wgN52K2382UoglWgeXgcOBq/
	 NqGSVX1t1yN4YqExHgYBdtfW1EoeK7rbC5XO8QxoKzsBu/CIOQPccal7s8oROomuzT
	 nOH++oR8Ql8ZBOraDH94LIcw6IRD4FpbG7yClJ3VleNhneOQPXqjnhEZdxDID9gXt3
	 Zi/mMGqgvit3WW3NRW2vFEdL6wn6s8l9c5pIFcoZi7xV+KiMTe64HYAVEpEWsulKrY
	 AY79GSivxDbS8lFNhw/jA+D1r8iN5+SNopmRFylkwpNZQ1yC/Yz1QKMYrewI9q/VVx
	 +Pn7ea8CH23cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 10/14] i3c: master: Add helper to query bus wakeup
 requirements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org
In-Reply-To: <20260804133810.184905-11-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:53:42 +0000
Message-Id: <20260804135343.4A0B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
> an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
>=20
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D10

