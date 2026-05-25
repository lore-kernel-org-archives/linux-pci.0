Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013525392C
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743544; cv=none; b=MEMx6aQvYUpoyvgoyNgmloxDw+S6D7VnYQ98vI3XCgC0N5o4zOaKFubwdm5X/djj3E2zSpyViIDMGqDH2XCXqNVdXju+7ckFISEB/BYOpbX9sOnaA+LnMmbeyI3LzNcYpKX4xanZpY4G5J/qDiInxJzjlCWVsZr2FT3wMs+wSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743544; c=relaxed/simple;
	bh=OVE4edSYIzvxgN7xlSFqTrm/IdrSFZcEExAVXZhs70o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozFwnPtsZd9XXsXvLxRLH57d+QW9wu5ieckWWcTsnYjHmPd2ForImfndDoEP1ZpJH3tce4O8xq6wI0SDV7aTzM8Hp8lzxKhMGJgqGrrLEfdhPfwjQ8oFIjhVR1JT4Ne9XP3OETaVePlKBh7WId6OpowV0mdqiF3ubrKHbcOf0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBZ58lEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBZ58lEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698E71F000E9;
	Mon, 25 May 2026 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743542;
	bh=/JwuThyiCye2j3xAC86KIzuXrZ1lRIrRdi2UOtd+HsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBZ58lEu0RA+w4CkwewW2GJt0QQTQmKZHp5cX/rt2HWH99b60U/m4ss16KAJFGvTF
	 6HOxCF6ou0mnprkE3Qz0OKCl/NsjdU2Om5XQ+jvyPcZ56ZlY/mLtjO47z0pTd06U4H
	 tNoAewM8lUeWHO2tOpgxbt3bPCWHvBxxS/SOYqxq5NQWQFOEvGsXO5/YS6h8xs5JTt
	 469Dq6xHAn4+m41pEu23sFab6s/tMn5c4A7yN/Wpff26sMx/5va+GiYIpNP05RwLwg
	 qTq6xxkRc8sr+hfvrdLV63LbTScwsWYLjDxoJ6WN+YEdc8d00Ygltshv7wyou0g8zV
	 Z52YTr2h+mHaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/24] rust: i2c: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260525202921.124698-17-dakr@kernel.org>
References: <20260525202921.124698-17-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:12:21 +0000
Message-Id: <20260525211222.698E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding a `'bound` lifetime parameter to the driver's `Data` associ=
ated type causes unsound lifetime transmutation during driver lifecycle cal=
lbacks, leading to potential use-after-free vulnerabilities.
--

commit 9a3d76f725cb591e4d7bb2fd07852884f495a892
Author: Danilo Krummrich <dakr@kernel.org>

rust: i2c: make Driver trait lifetime-parameterized

This commit adds a 'bound lifetime to the associated Data type in the I2C
Driver trait. This allows the bus device private data to store references
to device resources directly instead of requiring Devres.

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 50feade0fb58c..6094d32652e38 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
[ ... ]
> @@ -176,8 +176,8 @@ extern "C" fn remove_callback(idev: *mut bindings::i2=
c_client) {
> =20
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `I2cClient::set_=
drvdata()` has been called
> -        // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> +        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };

[Severity: High]
Does this type inference violate the safety contract of drvdata_borrow()?

During probe(), the data is stored with the lifetime of the probe call's
reference to idev, creating a T::Data<'probe>. However, here in
remove_callback(), drvdata_borrow::<T::Data<'_>>() infers a new lifetime
based on the local remove_callback() reference, resulting in
T::Data<'remove>.

Since drvdata_borrow() requires the types to match exactly, changing the
inferred lifetime seems to cause an unsound transmutation. If T::Data<'boun=
d>
is invariant over the lifetime (for example, if it contains a Mutex holding
an Option<&'bound I2cClient>), could safe Rust driver code stash the short
lived 'remove reference inside the Data struct during unbind?

When remove_callback() returns, the 'remove reference would be invalidated.
If the driver data is subsequently dropped later on, could the Drop
implementation read the stashed, now-dangling reference and cause a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D16
