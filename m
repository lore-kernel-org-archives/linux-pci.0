Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1683B9601
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718914; cv=none; b=tnbUG88LrTzE2Tz6gxp+R3XvuGjPs8lK/+2lJVO/V3lVK3xCByiiMQmBNTZKhjZVKVat7lXkTV26Fofedp5DsrBJXeq/N04XsTa4xHhqivLHErb6I+KFwZDRmrpD5vPUe8MgeEr9rSr74dCdB+xmeD5DYmZYRuADZn4fyZ07pUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718914; c=relaxed/simple;
	bh=TorJeZGUm6luRQyiD8a+YS1pvVoDR5e8kDGIjtvnBB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iUsL0Cem5sQwm4c63C8dfvLLggiTikr69YsVeqfTTGE8CnaZrgNwneQyIG5d/YGGu9oHgCNaLCUbrK/AB6JoekbGioqm/dNEXajEF+ifToEQ++poMMLBYxMYQ2O1cs5OgJi0EOc7CcfM/NBcoRzMGI48gVLWPZoJGIMOll9abs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhD8L40v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhD8L40v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984031F00A3D;
	Fri, 10 Jul 2026 21:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718912;
	bh=TorJeZGUm6luRQyiD8a+YS1pvVoDR5e8kDGIjtvnBB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dhD8L40vmSrd3bN1E+br4cBHLXkjlNP7pIPD+8MD8Q48kc9PDOcGtagnBdrnleXaF
	 OxRqws3JdvEkEdeEQP9EUpPBz29uMFHh+tKpa3Qq0k68+ZxDQ2gI0sLMfkh8I5NTHx
	 AvluXzFKEVvz2XoZpUHtrSn5/LnPZ5lnkf1nOLVPnhj+sTO+3cDbiojgi/DO5wvSmI
	 QZ4vAM0fx9eFePrUBMX5qQpAieFOesv5llduJX5T/cqyXZ6fYBBU1YmstMm9L+cUpO
	 jl5+0rspxW2fDoYHLpAgc2vVm2i8wqDl38Gr/IRjCBtHZHkMgu34b3oX2fFdtV0PDp
	 sylqg8Zchj1YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-5-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:28:31 +0000
Message-Id: <20260710212832.984031F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D4

