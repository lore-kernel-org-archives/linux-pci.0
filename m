Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A44A386D
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273509; cv=none; b=qt0e/hlTVATqgbdUK0v8s91SnStaUEenXd83WTQ8yVSAXaMWcg4SyPiqmAE2c13woF/81WqlcHJcn9I7mbHF3tWobDPH+N/p9k+RQHl/7iYEZwq3FOhOPPh8LMAlYqQvwO6xXaDpIMu/f83t87FlcrrVOTFp0V+TisgAWVBsjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273509; c=relaxed/simple;
	bh=1esyCjj0yr5ZEmjUoz3dZJFtbyCbBo4hJQ9w/t0x4j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LArztpFYNymrrsEv3c3S86JzRPjn7s7ZDTIOxQVfWq75jwORd3Ef/yFG+837CI4o71xz05FuzvfuR1e6Wr5Rn1WSNhDgoZX3G1qPCKSddH+TdZaw5YcyR7BUw2KtvQQkCkLnnHzBKVf+ucn1FAj6rKuJPxYvm7QxlpngblWaYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fwa4W3TK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fwa4W3TK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2571F000FF;
	Thu, 24 Sep 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273507;
	bh=1esyCjj0yr5ZEmjUoz3dZJFtbyCbBo4hJQ9w/t0x4j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fwa4W3TKPfJ9sHVrIiCtmLfQKxLwXMelUrn0faT5Oyn9/8EqQO+WNG/ZaSef9iRDC
	 h5i+qdzEfy29Lo2qoNF4m1BuDWgAHRxAusnigVlSwGSVcwb/NqsuOTeJym7S3U4QHo
	 0jxxNabu5xnFGaU9Lx6f0aurJc50eX+2gqegcLnylxaI8HftbIJzTyzMQtLGlBTSQa
	 sbrnQ6XOPpjTid7h30YmDRzhXXndGz/vbtelc3+1vXWnNtd4H1cG9VglxB6gFzhi6X
	 /DNPG9B6kWxue0MBwnSVSivtCFMrCCg8YYO+3RWtg8y48xDQTrUIOYCK3C2pv1+5jf
	 EnJ/AI29e13zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] PCI: Save PCI-X state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-6-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:11:47 +0000
Message-Id: <20260924181147.9F2571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the PCI-X Command register through the per-device saved
> capability store instead of a private pci_cap_saved_state buffer.
>=20
> Reserve the register by its configuration space offset during device setup
> so that the save and restore paths no longer have to locate a buffer, and
> so that the saved value can be found without knowing how the PCI core
> happens to lay its buffers out.
>=20
> While here, make pci_save_pcix_state() void now that it cannot fail.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D5

