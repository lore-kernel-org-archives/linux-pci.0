Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4C54774;
	Tue, 23 Jun 2026 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191434; cv=none; b=C3hj524n5aIJf8DWepbPfsCCsPeReMTKBeartsv5Qxcok/pcrb8o+DJcnG2sxEs9NNJOWs4kFrpNVkaxwA1ttuWQwFxcBvrODIYI+cUsn7LlaAcAPtYpxTCiPPLIwhGYTWdR5/81zPrf4SLL1u3CbmpG5YU8GQu0tvmf1R+x+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191434; c=relaxed/simple;
	bh=GhdxSCVo9es9xbrjJuUxPpViX4hvz5AxeIFMPJtNmnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFHZHqFtRdMj/m8ajgMZNOqVdAhpzfaKBKRptp6VLEcdwvXyUL1EwAbqJADHY6uTOg5I+IV/ZrbUo+ntqswE/tar7NKB0AEt7Mj+dtHqRCZhebp0AqPG1i7bH0s/okCzQdAnd+Zp2WM5RtN1tUIq/GiaRDI6HjNgkXmNWV3uq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHUAgVfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHUAgVfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE41F000E9;
	Tue, 23 Jun 2026 05:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191433;
	bh=GhdxSCVo9es9xbrjJuUxPpViX4hvz5AxeIFMPJtNmnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHUAgVfVvzLK60jflTtMooS7mRtc1TyuWx4Nm3B/nHStBIOYrapOp1O7kiFaOLoov
	 WXaYROkummcMhBiYFETDSyfc2YiTdIZ+BaKKGlMJo632HuV+TojFiaWajMRsF0hHbJ
	 SkddIb9PqQJQT2oOjR7b96ST5SFgYxgwQXwZKavOLqQbQllJvQD94VimZ6FaIKTdD2
	 vb5t5nJeJlnYBHJZLBCaQLuGZhiGCJfJu8Q5IfxwpcdKHG28wt5taGGSPwYVys9pr5
	 bDKpQxUjTG7BbBdLZ9j2KkV+LlBzfDAWuu2obchmmyAVNHasN0fUFfO5WxGo7lcmZN
	 VSB/6ZX18Cmnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/21] lib: rspdm: Support SPDM get_version
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-15-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:10:33 +0000
Message-Id: <20260623051033.58DE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support the GET_VERSION SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D14

