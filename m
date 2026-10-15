Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21154707F
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035856; cv=none; b=rsANkmzkHq72XgtNqk8txQwBNdhAFsoBfuBF/RPblK7rbIy1AavghKTudO2d6fTv429zZP3AZit5t56ZHUznX/L/WFDiv6YZgQjTGuSwrNpMU7b+NL1I8PeRAhEE0vgufpsadl8t1dzroYWoRMmj1yKLjPU1jnz9jf+RKKAWI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035856; c=relaxed/simple;
	bh=WNVpL14Sm6EnE4aQ2LKponZWn32Oj8SvpJh7qR285y8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bJdUHIrjirMxVPgF+3AncLKkmuww9yZnAHNCPJYhH4PAGFcrduFcuzFVxPJh3OxE4/QdUNu2pHLvWOmSQz9gaX92iQsIja/qZUe4VfPqgYvLTy6PiWZKNnSc39zQPl3jeP+Culw15HiZVI34R4UlBhjK4hTnx7qkNJDZlkqC87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqXl1ZPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqXl1ZPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7AE1F000C5;
	Thu, 15 Oct 2026 03:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035855;
	bh=WNVpL14Sm6EnE4aQ2LKponZWn32Oj8SvpJh7qR285y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqXl1ZPxbhMwumK5NhkECa4UKCbYfWYBWTKSSEP72jtS946k6Z09Hu3IFlxZLHP13
	 oLhcKweG417fDHA+0ahbSQ9GEU88jAcfrsmR3/CkMRR5ot0eEGUD674WRtB2zzGxHG
	 9Sdjbi3RLkRvjy+5AflQaL1iogLd8YLeOoABkWmwWFNJT+raTcP/E8Z04liGQweQGm
	 T2BwAsqvFypaBLQW+LtRwKpram177JoGLkjYXP9VEV+WDUhqfLEHjLilEs93KHoV+p
	 Eb3VnAWrP6YM5jtbi6RIP9gJQcHr4cCoQIfCoLZdmitLuJcGdRcNnpn6QzqTWNlktq
	 8o6KSEWX8KXoQ==
Message-ID: <sashiko-outbox-172222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/18] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-16-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-16-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:44:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D15

