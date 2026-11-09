Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794258467;
	b=gZkiXcXilitjHsxRutoyRj8FCnl1i+Ky2Lnk1kNbI/kiwDk4XFhezgkJyyaTZvQE6jtl
	 8j4Ha3jSWoqUBkV5VXj1YYDRy3XkeXVGP77tJG9QhWCgxf29B67FX31u2Kpcd4/3i8qze
	 uLPXAl09360krSoE45Rl7Yfln2PHJtRDjVA2OctQmN5OMKGCY0nAbuSGAPNdCGcuvAyZI
	 +Cv9kxRZiIemd0ZsPtSl51/JnfFWdosnQEEdctDzwL8wNtUGNd4nmkpaykm3wYXFJTvPq
	 fp2HSVwQvOKXRNxpLcYgmn+LmygcfotdTv0oIhziTA4/J32p3q/eMyBMAogB7ZGrghg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258467;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b9nkg0bUgrEInPraZfEB6T4z0np0Vi/eCDyRJD4LyDU=;
	b=WaA78P4+nd8mv5OnjKeW1PpfnFbCj/rnf/zaFsP0WN/snDjIqfg/Tl09feulSbLwJkOd
	 zRfNx1tmV8lVb7c1UD+YsphPK5fVhhAz0RFAGg2cPnL5fQ55ire/9GOAolp7iAs3/G5+2
	 AqKZGoOJOxgtRPZNHbAwcfwFsphO06cxRghHc0gk1wNg1cXehbWVdzQI7uPH6FUimidjh
	 xJAR6GvygeoTy95gasxvGN9IJicGtEqdCzDqSuY17QxQm63UemIbM5OiNVeZSpmZRGZNw
	 +3deATWk4d89cpmTATWRym9CfEKJyijtaPWOK8PRK+HiAnHNJQ8ZCxJk4H3r+tgv68Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Fu4LFQih;
	arc=fail smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36444606A321;
	Mon,  9 Nov 2026 21:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36444606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Fu4LFQih
ARC-Seal: i=1; a=rsa-sha256; t=1794258449; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jz2EsnWewn02NaUWxMIIzv828qC5NmQF/a2pqF9dSuaxddqeIKD/4RwjQk1/dM4/VC0lJnVWV13dIoUXcnt3l5w7dSWKjJ0O0AsMFmXuw7IQoHl7RE8RkYK+FzuBRejjkX6hKR3Ho2UN4bPKKPVy411FJRJHZNnVcKJ/pyOBEtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794258449; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b9nkg0bUgrEInPraZfEB6T4z0np0Vi/eCDyRJD4LyDU=; 
	b=G9aE4h3l/2wbrIFodBIzxz2en43ztWTrsGsATJTLYJfStp9Eb+yVqztWXk0X6M1RL2eaImEUXszjnHCjT25CCUsRv3zRwniR2nuLRBS8UqgSO4ZLewdROsXJMs7dCYKlslBcNTRAOpFG9VOyW2TueyFF54IJFJNfptKKc6QL6lA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Fu4LFQihBYem2cDlZ7W70Wp7j+nPLzwfZ/1NsdCJZtStypacGZSEjrXauIIvlMpdmXQax/DbjmAsokRpC2SPkDBpmn6hWmp9xWQXD32+DCxav/lVABVjXTaLar3ojHTNzndmPh091NJB1P2I5AE4+JXZPWcDE5X8xT2eriAKMHc=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=b9nkg0bUgrEInPraZfEB6T4z0np0Vi/eCDyRJD4LyDU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794258448226804.6244202787284;
	Mon, 9 Nov 2026 22:07:28 +0100 (CET)
Date: Mon, 09 Nov 2026 23:07:27 +0200
From: Igor Velkov <iav@iav.lv>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Message-ID: <20261109210800.async-probe-reply-2@iav.lv>
In-Reply-To: <20261109205911.GA292554@bhelgaas>
References: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
 <20261109202202.GA265423@bhelgaas>
 <20261109204122.async-probe-reply@iav.lv>
 <20261109205911.GA292554@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 02:59:11PM -0600, Bjorn Helgaas wrote:
> Mani's already applied it, so I think it's fine.  I'm just trying to
> understand the commit message and figure out what the merge commit log
> and the eventual pull request should say.  It sounds like "this makes
> SD cards work better" is somehow part of it, but it just feels kind of
> hand-wavey.

For the merge log, maybe: "Probe rockchip-host asynchronously so link
training on an empty slot doesn't stall other drivers' probes for
~0.7 s". The SD card is just where we noticed the stall.

--
Igor Velkov
