Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FE1A3A80
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031297; cv=none; b=lZfF205eshlFniXUorH6QSikXZ4Z+9JVcQI4tiq8loTQvzZ7qfMhRFpiYWyUgVdoEUCuPm6RDNPSM8775EvDtQz+scjzO6k+u53dETPK4EyvT6uz3N/1r9cwixIQcc9ZOeSrSYd7WXTGU+6VsoIzmYuipRH94dAS/OX/wYVV2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031297; c=relaxed/simple;
	bh=L0XS7NLfJCOacJULPOxAmXcuhZuRx9g5eebZR+Y1oro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bezVNjn59XVgcTucO2qRi6VbIF/umSxOJJh/NxGCvxQimWDhqk20KCnWyEpLd714bH/tdZCs1hJByVMWDGq705XaZ7IQA+lnNvn+E21ueULkNt3OzDYg5QccuOx1uUqP5cr2vkDMAxp+qtnl/JJ5TgUboiyAyJKenMB2MSUn42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+8gmVZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+8gmVZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77E71F000FF;
	Thu, 10 Sep 2026 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031296;
	bh=L0XS7NLfJCOacJULPOxAmXcuhZuRx9g5eebZR+Y1oro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+8gmVZ1B1nV3IPvpIjXB5U1tP8oc4lRY6hJFyEbw6hdTYqr4mCAH20sYHFWkOXba
	 8N8SuhQ4ZaoB5IsgWBxHsIcq6e1eWbXyFtrIrPl8w+i6EsOLt3yOumSuwor29Qgxrd
	 ceWxLX8y1WtLX2viKXfv6VdZ2g9uQlQ1/nZlKizR2Wp7xncWTDtkQeOcFkQd6+ZPhz
	 HOTWQrafeb4EhZhATthV0gngn0Ww1CDvX7OK2OcUvtIVdaj/4PmSbKoWwXUAGOKrMk
	 +3V3R3YcuY3u7dPkC7NY5vByk67tC173ns6GUoSXkQXMQb1p7j6oMluj93dtoH74wt
	 FJatZ9B5HLMeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 3/9] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910-unique-ref-v21-3-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-3-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:08:15 +0000
Message-Id: <20260910090815.E77E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Assisted-by: LLM
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D3

