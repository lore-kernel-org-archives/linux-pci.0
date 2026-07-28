Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29D12F585
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277200; cv=none; b=tzm2rGUFGcg4pH+xb0MYShfta5fgbFdY4G8ROmhej7HL8dPnFFQRGaFGhW28ihuqK+LaGrtm76jMzSBb39U3vrWz6hyPo+JEpjJl9KRddrlpHVM/YWcKcprMG6B7iJV75LrfRGb3NT9aFIzDM5+8CGfvmrn1O5MK8agG7FxhVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277200; c=relaxed/simple;
	bh=WBlQ8KX1RsTZXmskGFhT9E6l8EE856U9iaOq8bCdBCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgDXro0HxAA/jqQRz//0t1gI14hbPk6ErxVd521izXM+ITZFvoCkYTVxcLldsyKI0A9E0OJq64BO2koJ/cSSndFdTNYCtu8DhOlYtxdZWBfLiCx3bjPVPLYJ5v2QsmArQgBOIgpzv/ZGa+9cPBYz8hjKxnpwx+HR3nC8CUQMGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGfJUy0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGfJUy0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8391F00A3A;
	Tue, 28 Jul 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277199;
	bh=WBlQ8KX1RsTZXmskGFhT9E6l8EE856U9iaOq8bCdBCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IGfJUy0sSAJ/7nVSDDH8Zq3Ch434p9ChBcCz6lMmnncF2lwoVa6W2ENqAqWCzGzp4
	 JEkc+1OwuURkPIJuTgJfsYo5IXsLV5QGqb2IH/W1FSdwCJkSRhDhxMRr4ZD4hCvhdy
	 TKMorD1AwU0iRrPWDetsNqXi8ohZ9+5hwFSXNTttKiISCCIyktAoQOwUEKirBebWQ1
	 eh+7VrDjQZ+BqvbVyMzRQtGXfeMCc2tV5fZMVt5gIdVZrAc1caXxi9fpP5dpJyJmz9
	 1qNQGdSEAKnXr+lifJ4uLjXkMdoyIDXlxpJgts0jBjNDm5e0v7jN41MLv7wh/fqg9p
	 2vqN4MonsqyZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-10-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:19:58 +0000
Message-Id: <20260728221959.3D8391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D9

