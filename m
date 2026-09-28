Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBBD531;
	Mon, 28 Sep 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559336; cv=none; b=X5i3/y2+P/zXjgaRPXGiGGZHLlXJiwFl5/EQzNp30lVr9r29fQY8WE+ZYqKN0Dm5VjCl28rDTBSnkvBPtcuyUEctTXWJ9AYvSH6V4SXayKr0Fx9HK98zZ8fwcC6WPHSAwLT7ZX5Yje/0vAi4mLcj1nOTB5KvuRmz9MUKF6Ia5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559336; c=relaxed/simple;
	bh=33QkE2rrgmkWtDalm3thxaPxNZdqGxFYtDOUVubK4Ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Idw/iSmw7/iRCakmz2yGfXIA06h0GCZvRidrIJAQgmkdA10u2QXFFD7Z07EfNyvhIVMHR52kGLWS7FaXPIblKj2eb0HPFvsz6vJC6030JJtC8g/rc6io/hdbDp1XEh+l361W405KHz/Vhr3+SD+ggNYmltgsiICws7BYQjB4DhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N66Bi1oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N66Bi1oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACD1F000FF;
	Mon, 28 Sep 2026 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559334;
	bh=33QkE2rrgmkWtDalm3thxaPxNZdqGxFYtDOUVubK4Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N66Bi1oeTYV/7LVp00VhrXdDH01w7YgCC3X6mgi6+cbcjVs71MH+OFjY3Ors7RJuo
	 p109NT//sTrQaeEH5xlM3PfZXGBGJtB/ULbMcHfbNQC1JAPVZbEJWjibbPZ2IeNuSN
	 Xqhn5UW42rqMhHma7Hi1ekKLOEoIB9dDfAGEi1Abv8xJNeG6xE2dOw8diwr8qan5f0
	 Lp9pGC+PP/fBTmieS4XXLTu0bG4a9t/xPsGM5jV/B4LCINjOfeA+PXiiJpQn9Xlp9m
	 IcEmBOappWuvowQ+oS7IUw7I9X/GOGS//YHgT741i4k/uWB7JStkFtgdNKkT9tGOhk
	 dcQK5HuKm1vrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/22] rust: transmute: add `cast_slice[_mut]`
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-3-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:35:33 +0000
Message-Id: <20260928013534.6EACD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Benno Lossin <benno.lossin@proton.me>
>=20
> Add functions to make casting slices only one `unsafe` block.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Message-ID: <20250814124424.516191-2-lossin@kernel.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D2

