Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1941A23A4;
	Mon, 20 Jul 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512878; cv=none; b=l5IMDuhT/GQVg27O982lcp2LhAvXy01l+Xz3+Bu0dgehuvXjH6GcUCbDuhKcG2AhXt8COobsfAskfIuekzuGLLzNqeQMTJSEp0rnCappum7RSQE80ynaGwVHBiHs4LracHSEK8MgVK/GlWUH8Ra6pL8N6RL1ERcTYsd7zcaRQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512878; c=relaxed/simple;
	bh=vBKTW4aIL0J30W7MfXvoaDvcqWhEGAa2Ua+3rqSNSt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PeFsRCIq16ZON0rjlIci2a7EzLjUQqEKmPXEqZTrhiIICZgBEDfpvvCw84wNXtG7PcLReGJC8CSM7Rs0URUs5cBVGiJyi0w2hRO7XyO87wNaF/LNhkDKQa6LH48Bp/xKccS3ygN4C7zKT5U6b1iw02NXrjYUwRyitt5KIy0hXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCinUDQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCinUDQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE81F000E9;
	Mon, 20 Jul 2026 02:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784512877;
	bh=vBKTW4aIL0J30W7MfXvoaDvcqWhEGAa2Ua+3rqSNSt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCinUDQkPVTO1KBcg/4EWE+x9Hvkz2yWe8nzPOxqf8RQ7oA8CLUM3W2VLh9623JSa
	 2VpzDrH4fjVHpu0UdHs66y6WRXtrNkUqeNvKq/BOMdYmesk701mTxc1XTMBzoJiZQD
	 0HoVAk7RttpfOWePcVZXG/K8mmyWiYSl8QhM1ylTDeRVLtrvJwKZn1Sd/kcWcUo7Q1
	 lW28woKbWXjHf0sq5puX8FaNr0HwSx2GGCZ9sRQ1vGcOedw3IrFOjEAdUc3aIvYqkO
	 d0Mxmxov7ei8vwu+aJXdGmbcRiDEJpIK1YObM+YdOPIcsdUgaUQG4HY1EC1FupCz4G
	 n2KQa9quUT8KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Document optional
 msi-parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
References: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:01:15 +0000
Message-Id: <20260720020116.6AAE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen4 PCIe controller can optionally use GIC ITS as an
> MSI controller. This configuration is described in DT by setting
> msi-parent DT property in the PCIe controller node. Document this
> configuration.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720015505.3149=
57-1-marek.vasut+renesas@mailbox.org?part=3D1

