Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C63BD653
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352353; cv=none; b=MRX3fHIRY3+9MhIbpX1vTWp5DoIgYbv7pXPGav3PYRlfpruBFT+RBG8IKuFPtkufd8HCjW+V/xjiRp0pWBxDRJnh6iqZ9e9hFOIEQr/HijVM197OuD/YelxSDuRBaWAGe4pPBJHA+2YiYJqUz9NvZjf+xXrT4b4rvQb0kZQCzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352353; c=relaxed/simple;
	bh=s9w6sx7muf0GS/BffL8hapGMzyWrZoXO6tyYpHdRnZs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kFsoGzbHx3RcyznOVL1BSb6HJFx4pQ5WiR2KCcJIzoV9pPUeyNPuTHQkKwGX9QQRr/BMFPH2ja/zbHkPiquF7ES5vVMXgsv3t+GFMEVkhafn9yoDIAFmFFmRTC2JbHVzZrMm4FHp8wnBbb2YvEmpRApiYcjve/0Jx3ETU/GyA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcbQvYT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcbQvYT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BE11F0089B;
	Wed,  7 Oct 2026 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352352;
	bh=s9w6sx7muf0GS/BffL8hapGMzyWrZoXO6tyYpHdRnZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DcbQvYT883w6ZpUaueT4/C/Bnif1S8al+cC8e32YBKxaGnSfrrxq4yg1VcDZ5srCm
	 ZWcE4b3GoqMU9PjhnZa5Y1HOeJSCDOOhvEf3kGLCnHue4ZmaRkJ/2fCxNIppzYafKH
	 NEo2HQbj0B0IEV2VMKn+becce5srvsLZ1GFbdnhLdPI/fqN7G7khwvFGSazFl6nu6+
	 8t+hUwSWe92f46uxYth2APXjW/H2TQ+Xy+KGP1Vtt+sRmvYrnpnt/Lwc8py4KfQeFC
	 5fQuiqRxI3CIAiB4drssZkZuaSEOz+Q5V8LwRr7k9ogAL8rbapRw57R0Z36on0dGKp
	 Nse6GChLNCfMg==
Message-ID: <sashiko-outbox-162651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] PCI: rzg3s-host: Move suspend/resume code into
 dedicated functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261007053645.1391545-6-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-6-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:52:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> In preparation for implementing hotplug using
> pci_host_bridge::reset_root_port(), move the suspend/resume code into
> rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
> will later be reused by the hotplug implementation through
> pci_host_bridge::reset_root_port().
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D5

