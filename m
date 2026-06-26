Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192A303CAE
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503773; cv=none; b=PRXS1oa+Hv5k7oNud8OOIptyDGAUU1JtQBguWmA7j4FI+ALUnfx3jlJUTHm+Yr6aktDwx0Ss7p84cYHI4DguL2iuwYg96hRLtOfZTFloAiVca76Ys/EJjnkri7Wko7fu4D9RXB5uPIpnUwttLj/uT9Yulyt607InA6+AYUwWRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503773; c=relaxed/simple;
	bh=FsbKAdzpwCJP6Sguq8CKN7WO0aBMoDrFWGQgzHXzPS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kjk7Vo8o3rEDn7GHin0iR/dc7QJU2xS1SaoqjcBBvOJSkI26l0RnBExNipwPcnxFOeDHmWBV9ganl3Lz7ZdaYf0VhZuNaZXAsUZwnMLiBF5ajt/E4XMW+BpSEeTjO4t/sfNqnen7w88KhyroGTPZVPqIYVwiZPcyO1NsHGc9V8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFHcGNPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFHcGNPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3051F000E9;
	Fri, 26 Jun 2026 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782503772;
	bh=FsbKAdzpwCJP6Sguq8CKN7WO0aBMoDrFWGQgzHXzPS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFHcGNPrOEJBPrwSZ3R3+ELgmqc80l4FWi5QafPULP4xsnxua/ZB2cKsaWoDcK7qq
	 Lig74g0OYcg1iHVPBvvZmUadQFd+i1weOQIAFhByJ4d9ZD6Q9VHzwyvY3AoOXiCWxb
	 7YYQ554bPffXYUOahTiCy29GwBFMkiVBm9ZdreGuPmKoE1V9LH+QOmvC5KJyikMfoK
	 +8igm5ORKsMV1XQ9zNsK5Pn1bOAUqSavlYePg6foM2UCd1DNFqc5/2Ek6vbvffLIxh
	 5JY2Mq1CC6UevFP3lGs9dW+BpBUq8FmX9of/PGlzYWUYaihsjTyhJbs+6l7GHMEp+j
	 UA/nz1JCMApPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] pci: make pci_match_one_device match on ID instead
 of device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626-pci_id_fix-v1-1-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
 <20260626-pci_id_fix-v1-1-a35c803f1b95@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 19:56:11 +0000
Message-Id: <20260626195612.4B3051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> There is a need to match just IDs instead of against devices. Thus rename
> this function to pci_match_one_id, and add a pci_id_from_device helper to
> make it easy to convert users.
>=20
> Similar convert pci_match_id to do_pci_match_id, however the existing API
> is kept due to quite a few users.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-pci_id_fix=
-v1-0-a35c803f1b95@garyguo.net?part=3D1

