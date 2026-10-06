Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299A3B6C15;
	Tue,  6 Oct 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276901; cv=none; b=KsmWujqY+qg0UYLO+0jdTJbdLS4H4adlHfryF0d+GgnSyFiuDYtRUJoinFaHs/J4FZFrkaE0z67hyP3kkCnzOvtgbwWwoEpsj0rIR60/jVvOMwqrlKu4z9PDHPQ7X+rL0S41+prmZSq7bEEeE87Etdvfxprma/GkSrosdW8ICJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276901; c=relaxed/simple;
	bh=0+yPCto0u6ZJfv4u6eH5fQRnNGVrWl5sD4kDhCbe9Ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QMYLVFJxY73hMxkeYss7DMUaGZsrp+tZbUObNsp+k0vIaPgmXwpDe81+Vwt9uMzoLfTS6D5oFi86QYbV81AXYNswiY4hSUh1qJJMm4+HUzfwO2IAXHLJG9oc4EF2TQJmtsNg1qh0aSEGFbmgbUTlrIK0X7bsCGBuuaLBeFhlFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnkeSZ7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnkeSZ7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4411F000FF;
	Tue,  6 Oct 2026 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276900;
	bh=0+yPCto0u6ZJfv4u6eH5fQRnNGVrWl5sD4kDhCbe9Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnkeSZ7mF+oir1caF/+iq+k+7IzoqoqiB3ZqE9vVeXogcoDHrRnXjyqDE5pGVjfK+
	 LFiV5ZHv52JAbUe3Jmf10kRN12S4TbVxKD2F2AuxG3vBtOAfpnDOnhjXyQxu6+DIL6
	 CreLdwlus8Kbs6ijtnY5ZN9b773IucIVqw24qbPx1MP/fI8WY1WMqzKcFLwl3H+uZr
	 8Sh+QxTNsX2XnfQeJE30E0J6EzJFqFWDNJol6o5idsmC0T8LU4EjfA8t90edierwjV
	 bH7lzqBXASaKJliNkdP6YzTwtvUuxIsOKnp+b0txC3IkEAwL1LCDEyrIgxYuQAAVWd
	 fCDzUOVPNi1Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/18] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261006084638.3821710-16-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-16-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:54:59 +0000
Message-Id: <20261006085459.9D4411F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D15

