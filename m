Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451212;
	b=VEcrRLGB8SzfFSofhtPWUmpUz/2BreK6IIXzhDJDMiYdbhKjkx7Aa35arEXut/HAod7P
	 2Rig15N7TX69vdusOzJ4Jc4QzAU8xkCBCOPzuh/6zI7vHPL0v3OyYAmqTtaNZvdMRi+17
	 GGFo6xboW6CXRIyHaglQKeLMza2j5msEg8WmZWt+tOsfVAaS57BUF7MZPdAXN2LBsuD63
	 gw9DlLNvOzWpIEmiZnjGxsVTlQOvt9ejaztqBTF0+q2y0uijm4eQtCv92fLFKjAe83e/O
	 PNgFk6t3ayoxKpLM9zUkRsyOZqZcMyj9RiepIRcyj3XObrGhoNfdZsdGIWkjMtXfy3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lWSldW+3Jdfj+lh9y98r4LOXzqN/C+SFqhMgD6E25Sg=;
	b=tmJbmUt5rDXBSfqk1gf18kTusNYI3/5jBOaMrJA1S4GLfzkIfgKzsxgdTnD+VYY+DQ5j
	 o23Bx0OwmjTT9TgIrznXzvcvRZSuYnKTPhGY5kyfoRijpaCRaKXGX9z04iPik56DLakH1
	 OVyDud2FPfIEnBBmr8aX8nJhLYZ+MDaVZTn6W3bMDMVLr7+eAiBvvtVn9SYxScMbaWBMy
	 S1KtH4N2OH84TOOdnRKKZ5zENqa+Y0TDN3IgpzFrYCqBsUTM03rSO6TxhDX6gMnuVuUig
	 rCs4pWiiyZYcuu1i70DniZYB+Tg+v4m1ibddpg/Mnw8TnSoUXGsYxURCsJxpzjRTWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAbc0JTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73C606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAbc0JTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918821F000C6;
	Mon, 23 Nov 2026 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451211;
	bh=lWSldW+3Jdfj+lh9y98r4LOXzqN/C+SFqhMgD6E25Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAbc0JTebh4CdDOyRyeDt7e4TOvaUAnEhzCzUdmPucNLMwxiZyYYcRzcaWG2sc7St
	 nz7k7m+PzAPpC6JLrWMd26j9sE5U4dnvzEaTvnd/IZsQgQPslLqwWXlC3vO7p2TXcJ
	 At2dqJHa5Qlk4NlSYa1n//e1ElfZm7wmYQl5/uVfXnTnt7mpB3FhkTdUJ3Tx3D0oC8
	 BtOn5J8lq/iHCQ+LLKxwSUqcAsR//EoOW6sRFC7SDSkU/LYO/Fs6OanZYot694+C4C
	 rObwXcVNwG9h6W1Qq9G+Om2juChcsl/Z5p+ZgYk5c4W1E9/u03GLznHE7OXk2QReHB
	 DOH7xeWIdMInw==
Message-ID: <sashiko-outbox-229656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Skip the CXL state update for a VF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Machauer" <machaujo@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123162035.79133-1-machaujo@amazon.de>
References: <20261123162035.79133-1-machaujo@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:26:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_cxl() runs for every added device. It first refreshes the CXL
> state of the upstream bridge, which walks that bridge's extended
> capabilities and recurses up to the Root Port, and then searches the
> device's own extended capabilities for the Flex Bus Port DVSEC.
>=20
> For a VF neither step changes anything. A CXL device exposes its Flex
> Bus Port DVSEC through Function 0 (CXL r4.0, sec 8.1.8), so the search
> in a VF finds nothing and the VF's is_cxl stays false. The bridges
> above a VF are the ones above its PF, which were already refreshed when
> the PF was added. Because enabling SR-IOV adds the VFs one after
> another, each add repeats both walks without effect.
>=20
> Return early for a VF. Every device keeps the is_cxl value it has
> today, and the bridges above the PF are no longer refreshed during a
> VF add.
>=20
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123162035.7913=
3-1-machaujo@amazon.de?part=3D1
