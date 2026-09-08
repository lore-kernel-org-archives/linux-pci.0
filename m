Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594349AA2D;
	Tue,  8 Sep 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903518; cv=none; b=J+SM12ItOPGEEfS8n+JIfGO3ypzUG0kWIj2JnsXcau9KBHkQYyjOmy3MwNvfWAMMIC2zDtGU+HG9+R0be5vKjex6kijei89JeFx/YdBGn+KKJY3xm0Jph1UCGhDKGNxSNoGkWs7gNRnQdDJRkAu2rg3GsySA72vfYAMgwqmsIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903518; c=relaxed/simple;
	bh=8R9/OB/ssFDOg3ZX39CkO70NLKa0lMJ4SzuXwCQWH14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nnxCD69BI8lXaK9NY+YPba/X8syTUbh2lpc5EJ0olgIDvO1WSfw7VRx1dX57QlaBJmlmuHvpjbzOSca5gNeLC/nAhMX5o0r1aXzhcWcgxjf2MQ0kOEZHcE+3eN8Je2XIFbvpcZ4Jdtcpkry/0BgCzWR+E4KqQDUCzCC+86f7B/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXfe0Ajq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXfe0Ajq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B271F00A3A;
	Tue,  8 Sep 2026 21:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903517;
	bh=ZQdO8GZ7VUhMX0RbGNJEoAnepeAYMBC3QoHXRFpWqzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXfe0Ajq/J4R8eVKTdcsk2LMrIkNf67CDlTWPbvNk3I1BXX3KB81yEUDJgUWVc63O
	 puvxd2M/u7eKKuy3slsjwYQQxaEDjDyi5QGD30JDjaiZ+vqx10JOfBQLexkJv0cjYK
	 CD4+6YtO3r3TKEbVy++Uy8Do3zV4XQkvzaJ6IVkiG6jIWGQZSJSaxCsQFfIRGQ46q4
	 LoYzf+cVSn79nu2h4NG0E6q33HzDs3hvYwIW160pNbQrHR78WOMJON37mn40764kRh
	 UJY0GmZvW2QC7hdzrGrXqRYT7cpovHc0UYdb4i4aDoSvx1ChvDAENHRK5IA/8oj3j5
	 QpshZNs66UR8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908213459.2519059-4-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
 <20260908213459.2519059-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:38:36 +0000
Message-Id: <20260908213836.B0B271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908213459.2519=
059-1-elder@riscstar.com?part=3D3

