Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104534;
	b=oJGHZFkNKtOWWaF3pli2XMNCIioXugRsdO8Xl0LssTnXkm9jFO9KelusvzUUrw8GXHB6
	 gqeajC1mhufxaZgRyga4ZCg7SPt1mmbh8LyQt6AraD2Q8ZEQSwdX+n99mepteRR3mZzrT
	 eBzJLCC1rHX8/zgE2JHmts7GcNdxeHl7+YMfiuL2X+ZwpXK5p0YkWUaW9VRtftpf4ArBB
	 ZWRe4T2/w/4p/qMmrOi55GqDpUSN9wLbTGaaoJP3UzK2DsKh0BFJ0ERSV31FifUO4wTDc
	 hfpO9qcp0hte8HsCNU80HpXkzgXIVLur5cW1B54R2ZO6qdXtfpacEz7HYYBw2NW8/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pf9j93W82Il83HzQGd+ghrKEa6rfc0DY1Oe6lHxezVs=;
	b=dBVu1KbJExIBBn/3n8EWtX4h2AfH81oEkCWSBdv19YIdkawHNoENjVa3x8wS9N+eY1xD
	 9Rsqizswb8s/eeRgGbhWgaWfPABltarzRMW7hxFgu7cMJnQIg9nfAxUFDRXINiSm9k94s
	 pX4eRz0zOo9JjtrsSldeZ4jggL7GR1Ejhxs5biaQTIPx0J9OOlEdO24oXhea40TwBE+v0
	 kyNbk+sHzxEzf23A4KeiR6Uj27bVs+UtDzppA4i2UallrZq7dcv2VLG8ZjdTFWMjQcLC6
	 IZXni+TGqBflMvU+q1T9d45mz5leJg54/XXWHO38sPUpomCJ781Ap6pS3FyCggsQtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsyZNsnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34F60A2620
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsyZNsnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02D31F031E4;
	Tue, 27 Oct 2026 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104533;
	bh=Pf9j93W82Il83HzQGd+ghrKEa6rfc0DY1Oe6lHxezVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsyZNsnvlobs6yBShGRirMMidxro4yeE5mbkoMf118a6EHil/Ks4OKdXJg8M2qRqR
	 pyi0YHimtiO/yC3r3UkLkgbRFwX0TavDzBpQW6H7UduVNfY1OXiFMdqWIlKW9trtCL
	 Jf/RKpT1Srx6i8ahtauKq2XRqEYtdTjHNo7AofEjO9FEV/c15vLwahPAdYE45TxXjH
	 ilPDxaxfJhCe1bMqeXWHsZft8UyBAsiEzqUMK3KANRkRNXDVWunPZgfdXQxx3SDOab
	 tH+IZwY+N+5COvCbe4mO9xv3VQtsKj7pK+41Vzab3iRG0ovJfgygLq4Et6iU28+PSb
	 UlR383mr2jhcw==
Message-ID: <sashiko-outbox-186567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/16] PCI: dwc: layerscape-ep: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-5-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:35:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> ls_pcie_ep_probe() and ls_pcie_ep_event_handler() with
> dw_pcie_get_pcie_cap().
>=20
> The probe reads the Link Capabilities register to save the values
> configured by the Reset Configuration Word anyway, so the offset is
> cached there. The link down event handler runs in hardirq context and
> can then simply reuse the cached value instead of walking the
> capability list every time the link goes down.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D4

