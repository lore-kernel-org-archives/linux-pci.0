Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398C48EC8B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144151; cv=none; b=YzKAOW4p2spgF/c6a6X+20kigl0kt/itdDNkZPgRvUoedqNo9giBJXFV5uG0oINGUg4scZWvmT+Jd06l1GBUfOC/ABQRB8a+UoPQ2GnmMwndIZEn5pAWeknT/oqW7uTnee+Zndy5siKB1xKR6GpFdVvuzx319YBZWjmvDrissoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144151; c=relaxed/simple;
	bh=fKmaBdY8OSqzfqEnGsQjZMnWLeoiE+GPg0lr7YXYIWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNCm59JF05A1NZfm5B7OiSTegcgeMg3kiDvSrsPG+2sAU6Yp1m9MCi4tS/HBjBxgMMw03eUrBKGyVza6QcB2zojIke9A/h5DkERej0ip7A96IjQhIlS/BlLUWdTHC/83geVmqzId+K0wmVPD7mtRNRvnFmFd1Wpsc7FNZFPWQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noGNArv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noGNArv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD28E1F000FF;
	Fri, 11 Sep 2026 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144150;
	bh=5QQfCVr5sAbq3BQySpY68Q7+FGcwKUaHgftfuUIc+mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noGNArv94Zi7YUWh3EbR65wQokHZFHPNzIo3kekZ20AXWx6iPuo2PS4XpxOwft6Tp
	 4b+U2KerwKcJQTCF2DJC990LllIuzLGxt7k2VrKzdvrcVcnUcBw0R4WKKK8fA5QK/l
	 JXx+TDelzVc/UqDw/Ngozs0blZ6UqeiOX9o5n2F+ha1N1O4v4fda6t6pfADmYCpRsD
	 7U18A5N1l03VZqMpGOdtqjW06WSXUJSeuQfligp8St+0Z0ogz1aCy0oPSwVwIQEUgo
	 8eQPOSeoz20bau/aEf8OsNDbPuQs5hoRDBrSOT04c2AiKvrSWvK2Oj0LATTJlPCfF+
	 8+8DNfKLF7WOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: Remove unused PCIE_ATU_UNR_* register
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260911162537.469018-3-18255117159@163.com>
References: <20260911162537.469018-1-18255117159@163.com>
 <20260911162537.469018-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:29:09 +0000
Message-Id: <20260911162909.BD28E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIE_ATU_UNR_* macros are not used anywhere in the kernel.  They
> were presumably intended for unrolled iATU register access, but the
> driver now uses the ATU_* macros and computes unrolled offsets via
> ATU_UNROLL_BASE().
>=20
> Remove these unused definitions. No functional change intended.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911162537.4690=
18-1-18255117159@163.com?part=3D2

