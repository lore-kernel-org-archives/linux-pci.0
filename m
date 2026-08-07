Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F993D76
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075649; cv=none; b=uRL8+1AnR7sbhIoGtbMPE9pFFm8k+K48rbVSTb7WNnUBOpf/8JiKf8K4Wj5kxaMXUnvDtaQfHXbpc0FSoG2116UygJ4wTmko3YeCb+1yNAiHeJioYC3TooMDh0ezcB5ZdX7mOxjP8yvL9JqrTIGPgbPAULBkhx+sOk18oyVGrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075649; c=relaxed/simple;
	bh=wtj4so6hd+K7xrHoJ1JPtjFbw/vuVKeAoQT3yNE8Ccw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdFkYv5Gfrlh6U3lwReqWD7Y9P57IHLZrODGVzHArFKOsbYhS/TUj+3zZ3j6G1uV/bUd1COr8boUCJaP+a6KugO8Xom17gZjHw3fVYE/+vI4gwe1yCfKFpdB8OjTQqvZREVHCVoBESHc7inpFX5BykK97ordsnCJmQ79peDT5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK4earYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK4earYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980991F000E9;
	Fri,  7 Aug 2026 04:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786075647;
	bh=wtj4so6hd+K7xrHoJ1JPtjFbw/vuVKeAoQT3yNE8Ccw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK4earYKSa4NMXWa2KFFqtdrShfocZsDau+rubmGnZg63C0mQdCbEzwgKEDQ+2mKs
	 PMyHBfs4/dJkD0/CS3ySrO52TJGjJsOBj1mcYmA+YUmGHcWLpBcfgIugWilNPC2BqX
	 q//JrE4Ce9Wi2SpmHJ5QMmyB/ulafU7c5KzEbr7seNuUNAxOpbJ6nbEhKoAETLPky0
	 Jsbvy0DrZB9S4sMNGNLsDnhL459hQRkYYmuINuloqP3pqeYPlLNpXO3aC+N8WHwM/I
	 kFJc3D0yNY5BqowgQeTNR3ciMJMIR920ZbLiC37K2xtgW0W1eyFvIQTJybrfcr+qbO
	 GkxmMHjzvEC5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: iproc: Use the EROM outbound window on BCMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260807035726.387-1-strst.gs@gmail.com>
References: <20260807035726.387-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 04:07:26 +0000
Message-Id: <20260807040727.980991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
>=20
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
>=20
> With that property present, two things go wrong with this driver:
>=20
> devm_pci_alloc_host_bridge() parses those ranges and requests them, then
> this driver adds its own window and requests the whole list a second
> [ ... ]
>=20
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully=
")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807035726.387-=
1-strst.gs@gmail.com?part=3D1

