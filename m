Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C2493635
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341842; cv=none; b=mHEdRGN/5HMbiw1aVx48b3nH3yudWJ4LeVmN6lrSqbn74BH5FlKoGZxcA3vA+3MAQcqwhisn2PuPz6yHeBS0lwYemkqcR2IDi+aDFhRb//FpXGJHgjep/fpH3Jk9eh9UeBe7gy05FwNnkaazsAOL87ObmukMOsjyVWgiz84XeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341842; c=relaxed/simple;
	bh=//p3oJuMesgFM5Oaer5oRFxbq95ZPWvuzSfwHD34dJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i76n8086PJBITNnhncc8WdFDxWDx3IS7qRcoenW1OlEG342acaNcnmbgJW+JVqObSA9HHLjbyYSxqStn3A/LyfmSOsHLTAWWrLkqFUTyMQ3UkWO2v3QvQxch66R6e29sYg5ts/Jps/ix3iVJsrsDlP00weh7OYexIk8oH1nsLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJvpx8WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJvpx8WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26E91F000E9;
	Fri, 21 Aug 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341839;
	bh=//p3oJuMesgFM5Oaer5oRFxbq95ZPWvuzSfwHD34dJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJvpx8WUwC5gQes/9RFOgnFdmoli/bd3ns0CyuNquIix2uCWWgOUQNFqnIbNRjZp9
	 /VkP8p2aJ8ju/C8GA34tJ+gRZzT2r9nd70OzmmeSJZGTzW9z7mXlkWLZK3yf4Hg7XR
	 LuZ7fKTtuddWWTxSit6ptrN7NWTqNDLFgyAlTGR4F+Flye2ic4zP/2MIuBagTIBON/
	 REt4+zYJpjmC9DHvto/v9r+URI3S1O2P3qhi9e0jA730kYA5tAPHj3n8RPdBsPol7S
	 Htm6SAhsd8pA0uLWRtKwtm4ZIZpFcgpG1fTS82HNahvDzRz5GL5sLzAJxTt6z6UPo4
	 aHCILw1B6EhcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/18] PCI: Add ACS egress control vector accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-9-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-9-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:50:39 +0000
Message-Id: <20260821195039.C26E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Whether ACS P2P Egress Control routes, redirects, or blocks a peer-to-peer
> request depends on the Egress Control Vector bit for the target port, not
> on the enable bit alone (PCIe r7.0, sec 6.12.3).
>=20
> Provide a helper to read that bit for a peer Root or Switch Downstream
> Port. Report an unreadable or uncovered vector as an error rather than as
> a clear bit, so callers do not mistake it for permission to route
> directly.
>=20
> Each bit corresponds to a Port Number within one Switch or Root Complex
> (sec 7.7.12.4), so both ports have to number their ports in the same
> place. Downstream Ports of one Switch share its internal bus, and Root
> Ports of one Root Complex share a root bus, so require a shared bus and
> reject anything else. A target numbered elsewhere has no bit in this
> vector and would select an unrelated one.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D9

