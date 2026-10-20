Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490204;
	b=LyzlcwpvSznmgEmqNRmDfPmNwCO6xPDQEgOhZSf5fupmymwfVpXyduF82NHGMO3gEz03
	 L0HBzgHoW7+VVo8blHYXNlEa7nowMxDgdKKyCJkX16emwoS08Kvh76uRMIiu/IfbeCc57
	 /I++KQGhUXrSfm2yzc3w4b4wylzMI6R3RR2puYGlVd+Kb9G9qIQ3I/BSRWBj7n18vUnwX
	 9NSB3jLil2WAskdjahXb/V+Lav+jiRcPypSULv6MuxM39RhIDsT/Ui4FT4YV8j81uaOZn
	 ikDx/+SkcSQgq73uc4ItFAz92j9k+1lI/sktxbGaYGutTz2z8/FgUmtENHsc1BncR/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yd2p7uQ1dCCzZi7Dub4/Yb4C94mgDTDe1xo+4n6yuig=;
	b=gk12WCfYiKrXsZUtQu6qjlEFZztZufZFM+3Ljb+SalX7nOu+EaXSm26Q30hO8ERjTqDz
	 PTY5sC4iIbCsn5faT2//HLqwtVUSbKLlsOeG/h7hkTzciNfRBzh+xLpObHKsWAwvL3WyT
	 4jZJ05TZ9G3nZSGgDnV+4r3o4dZ4StHAYBaIs6SMHgv8P59wS/axVJwXYmhdNDFYnJ6S/
	 tUO7nPiyHbsVzES1ygYW8XkBZxebGGluH6xib8uLxRAqBFW2bKdQ413ZOWTuR7Vkr/ky6
	 J9mUzx/cd6LMY3aFLiKl4m9PHa76Axc9n4qFKqAFrAPfyno8kjsXyjI22QVhZ9QUVZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2B1IeJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FD606A328
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2B1IeJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473531F000C7;
	Tue, 20 Oct 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490203;
	bh=yd2p7uQ1dCCzZi7Dub4/Yb4C94mgDTDe1xo+4n6yuig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2B1IeJMKKI3DHzC42VuVhjkumsB543h50q0rlHjqWQN8yurBfATJMgbLUagm1d4Z
	 KU3WLfz3b0L+Zc6oeJtmMujGJnttvdRV3vTAIGpuNcnPqQzrCPWKbiwY4RkbMgTE0z
	 82fXgr5ioO3YikgderwgLviqRUV3e4HVGyssTTOIPmwcI6wHT8iD01e9qxbkAwz+qq
	 jcWB0omiXDrTjOQ7iudle7PLAGt0ypQpHR/mD8OYOKogaloZdl8qV6UJp7WFCJaPDE
	 r4dOA4TEXaJ+vWavvo9SmVyCAd/sOBAApLDe4D01FgXKluRsMCHQe4xrRDLD+q8RYZ
	 4/UQT/biLSQ3Q==
Message-ID: <sashiko-outbox-178774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-15-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-15-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:56:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Root Port's PME and link bandwidth notifications are reported in
> PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
> integrated MSI receiver and the reset requests. Dispatch these
> notifications to the virtual Root Port IRQ from the "msi" IRQ handler
> after handling any pending iMSI-RX interrupts. This keeps Root Port
> service handling out of the path between the reset-request check and
> the iMSI-RX status reads. The existing dispatcher rechecks reset requests
> before invoking the port services.
>=20
> Enable the sources only while the Root Port IRQ is unmasked, and clear
> the MSI-form latches in irq_ack together with the AER one. On an R-Car
> S4 with the GIC ITS as MSI parent, a notification from a link retrain
> now reaches the bandwidth controller service, which clears LnkSta.LBMS.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D14

