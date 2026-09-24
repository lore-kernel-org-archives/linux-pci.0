Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E448551B
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275383; cv=none; b=C6b+68BlDnDT5+AeRlG/Y3hUJwS3QSl5igq2eGjYtnohzEV9up8s3bRTmKivoW2y0Q1XTLTwi/Es5R6PDwMUWKsyaLbADMCQfjJs4EWxjor8daYcR4wOu3KGc5eKIuPTx5n3EQoEf+PXWgiuvPpPJujUHIwmj6Pe9AhYPn5idD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275383; c=relaxed/simple;
	bh=r6NLO0wijt5RKE6g4SmbW/NuuuseVfSLqSSVgzqVgOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmuoOJ9hhbh+MkcX223VNu/p2nVoUp6T7IIpxWTNbGwaf9XlWe23TqJXd8++4tjGBfltTL5BDr7M4ttGhFWRIN/8gVIubgjnbJgbNzO7ODemrWz5MrJlEd1kQ3q7/GM0ZXvQy6GU+Ih3H9WbzV/nhZF0EJv2rsJJpsGdBuf+Syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtMVhK6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtMVhK6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EA01F000FF;
	Thu, 24 Sep 2026 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275377;
	bh=r6NLO0wijt5RKE6g4SmbW/NuuuseVfSLqSSVgzqVgOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtMVhK6SK6DVNpSf353reAXDtG+6pycXkVqY4FKd/5eIuiP7oH08enDs3RpLFq+XO
	 POteUI8A4yvn73I4QYN/djMqIrHoZQUvhKY2sarIrVs57wXTZvA9LxLR8u2eFZcbcY
	 1JfDYUonHg4LP59ZuQF1WWTkp9rDgpF+87E880yVg+z3ipqdHAh4GDRRlIe/fLQQs9
	 so4z5iK/rmdd3WYym5kUx7+vj9VGEjI0/3CYiDBUYIwZQJ/iJhUWX25TvPpgSddNaP
	 OhGYmEEEgBcENOOMk0+13DzGH47jgLDnqrDAH5fp0Re1E0qrsghHA3FvTZWvmVVrnx
	 O/1HgYcn5sbUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] PCI/VC: Split the VC Resource Control restore
 into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-13-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:42:56 +0000
Message-Id: <20260924184256.D2EA01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the restore of the VC Resource Control register out of
> pci_vc_do_save_buffer() and into pci_vc_restore_res_ctrl().
>=20
> Restoring this register is more involved than the rest of the walk: the
> enable bit has to be preserved across the write, the port arbitration
> table may have to be reloaded, and the VC may have to be re-enabled
> afterwards. Inlined in the middle of a loop that is already sizing,
> saving and restoring three kinds of register, it is hard to see where
> that sequence begins and ends.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D12

