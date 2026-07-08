Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAD348C5E;
	Wed,  8 Jul 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505570; cv=none; b=qmDVANaYbeddQS+W8LwQkOiKtuNaFgaCbtYLw9AXyNDS4ejOvxF+AUmediQEy3RLUGMIwiiF5hgciGvaPJGQGUTdBj85JSI37XTQq98HKnSHJ8mTMEdav9Ws5Vhxf6CntISvI83vWjh84dlmS5sehp+Epc1CtWRHO67atNYEiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505570; c=relaxed/simple;
	bh=fUo9e0umj0B5RhQlFuWA6FlI+/RXxmUDePWIYIarEo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dBCE0fIUaF9qEATnioUKrq384zHRjLFMlJ+0eurOADK+W0cr3xw5DEYIthS7RuxGAM8QKtb59tKrcKyT1LA7Wzr09p/foDhBEuScFthxzlpQ8tpcllo/WI5+GYQe+nDFhu2y3OPr8y09/FTiaBPg8Dw90pEY1tYua0beHXcfank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmG6r3tC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmG6r3tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FBF1F00A3A;
	Wed,  8 Jul 2026 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505569;
	bh=fUo9e0umj0B5RhQlFuWA6FlI+/RXxmUDePWIYIarEo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmG6r3tCQs+3wbhaaP6G1p9Gm+W+O8mLsavUnwZWUISl1xlEqLZasIJfbfNLWErzV
	 n+9GsnPEI1JpwV/ZBIOD6U8ruvzLGMy6NosFtt3sIK232SNLL63ThvVviriMl8lLCA
	 i8u5MrDYDaU7TjNa+onT0xpR5IYL+u3XQxTUJ5zdpp+VzIJGDF7K7enQcbWNE3yKN6
	 miWyYYBE15/Y/XdtV6XpA+TRcN1ySa2EgWay7Wuq/vqqS6JbDcy7hjcjIElz6ElyLy
	 b6X96kxvl0KkkcWaqsM0yQwI59rRDlA+ulZVWRGiC3tEJ77wUpFFibzVM4xrcB/j1E
	 RfzPTVHk7BCrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/9] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-3-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:12:48 +0000
Message-Id: <20260708101248.D4FBF1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D2

