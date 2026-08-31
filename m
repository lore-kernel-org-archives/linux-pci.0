Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7543806AF;
	Mon, 31 Aug 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208460; cv=none; b=b0vQxbh4uvQXCtTQsVxqYFe1WcPcWG1bZAaFbGrIfdJdk2OsmwvNx4qVR5OsQq6RlYI62bors3gEOiGlaQWXuhHFx2MMKgsKV/kEP1vXn+GflAbf+dB/T5zzFys96twmbTmRPCQUMth6YfUTGT/lSy1CSB3oeUsyxqCERk/l5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208460; c=relaxed/simple;
	bh=yjqHghsN7BoaJeovVjB0fA0dFrDSZDFn9q9fb1uJ9Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nq0lf/QhlPwQN9wLWSImsK4vJFyfzt4WcH/K19UyJQyQqgLyxj3CKUuyh8PZdIidS8lj+D3kYJmxi3w9+leoH+zfDB0bud1pqPLuAtiYMURZVtzSe34MBTRSxvLsuaiJ8kQEO+kI5R59rpedYtigDvnmoB7x7zEBtLMVO6SnlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr9CDHlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr9CDHlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E21F000E9;
	Mon, 31 Aug 2026 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788208458;
	bh=yjqHghsN7BoaJeovVjB0fA0dFrDSZDFn9q9fb1uJ9Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr9CDHltSWbVKyKr2sVHq83JEI8oTgnfrgkVEpLxAnoT9Yh4cFldNqKExS01O+0xU
	 3Qk0d10atZBYcQUxiMkPGvad7sp/h6aydLLN12NbEtNN9EyIsB8U/eE93MSWTilYTH
	 6wMgCQVLtr+967ut5FyaURR7NBoxpphBbvOAjS6uh+YF4SwHAydd/rJiBtO6BmeZXb
	 wIErQjDzpuf1Cov9vWY3p8m9bpvTEL3SSh0DaMNRvqDKZCwMf7Gg6XnlCd/PU79fUY
	 Bue1nkBOj1dMMtZjdeZS5McTiFz3dcZZqZpylj2MAO4fWS5CS01beUqepb+f5Dh/gp
	 nmFEuHDWrD/ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-3-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:34:17 +0000
Message-Id: <20260831203418.4F1E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose the endpoint-integrated eDMA register window and linked-list memory
> through the EPC auxiliary resource API. Endpoint functions can then choose
> which channels to export and map the required windows.
>=20
> Associate each linked-list region with the direction-flattened static
> channel ID used by the local dw-edma device. Report these resources only
> after that device is registered and only for channels with linked-list
> memory.
>=20
> When the register window is already part of a reserved BAR, report its BAR
> and offset. Otherwise report its CPU physical address.
>=20
> While at it, harden the existing doorbell resource query. Report it
> only after the local dw-edma device is registered, and reject VF
> queries because DWC cannot assign DMA/HDMA registers to VFs.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D2

