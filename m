Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2E47140C;
	Fri,  9 Oct 2026 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531234; cv=none; b=Nep7cpNrfqbs+tx/jYPQIlt/PyrcN0IbKHo9rZ+W5Ijn99BkEO/GFF20kWVTHrfG2F66mM2bHM7WZ01mgD1uWfsqc2fwGXnmk/6cFXrJlclSCuLD6NeVZcNpJaggvegfOJe9ODRPTHX5OJ1yhyzL0xA2Pr7INdtyBu3l6bvO50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531234; c=relaxed/simple;
	bh=1WXTQ9ZxVaYyZuDgfL7CKr4uu13H/OKfPUt9cZ7+qik=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YrvszJNP4Vi13I+PEAJ97mrXptj0jda2a9vkx0kqMMRV162U8P3zFq3eP5n+PiUMqrajtmCOh56t5wwvnqBVjYHyLp2jXVuarbVtJXlxn2RtoHoiB38zv9pVwfFb2rvB3rrFwxAAu9eNcsEWFECbHW+Pkyb/ArQT8FdaqAoOkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGwrjur6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGwrjur6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423DE1F000FF;
	Fri,  9 Oct 2026 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531233;
	bh=1WXTQ9ZxVaYyZuDgfL7CKr4uu13H/OKfPUt9cZ7+qik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGwrjur6akTThFC5EdJEzrwefdtyeE7QJ5Xxqf1D91eexy1DpBSLIJXAaT9zG0x7e
	 2G6oTvOF9jjyuH61sE1+bWCkpM8adUOkgwC9v+ga9XXbjEBR3ENWV+Jvr/p19b7ckP
	 GWUBTNDqi0REeqhIoIfurN6cg3PH4CBa16Mgk8lAe3B7YFwCMpljzy7htkmR4exi6t
	 InVWTGWFM1gWtf2viVY0TzIB3UYX6aq6hmfrm+wdOCOIVYIDwjyLTiZxCbup8zEbNY
	 7N1jkwpBbKKaO9fW3NPHfqwprNdF//ypLurkaxHyyngchF+FZSk+HjOQlame4olyQ9
	 1AjZuoQBxF2Fw==
Message-ID: <sashiko-outbox-165008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: of: Correct pci_set_of_node() return value
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261009-pci-of-disabled-bridges-v1-1-08708f9e1802@radxa.com>
References: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
 <20261009-pci-of-disabled-bridges-v1-1-08708f9e1802@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:33:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 1a8c251cff20 ("PCI: move OF status =3D "disabled" detection to
> dev->match_driver") removed the availability check from pci_set_of_node().
> The function now returns 0 even when the device is disabled in the device
> tree, but its kernel-doc still says that it can return -ENODEV.
>=20
> Remove the stale -ENODEV description and use the kernel-doc Return:
> heading for the return value.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-pci-of-dis=
abled-bridges-v1-0-08708f9e1802@radxa.com?part=3D1

