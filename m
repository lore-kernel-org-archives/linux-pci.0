Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BB3B42D7
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533712; cv=none; b=neWFL7N9rJPAWZAz5hhqjRTRNXvY7dVjP3GSrSKTI4PSg4QoXNUUgPvuv6c5gHMGIihbkuk7VMPvnLvQNs/7A7bK80CNeoX6tnuaY+pTAu4s2lPdp7NfM4D+bwMcrTzWaOaQKhhyAfAVyZqkvbF6tfoL8QTWt6TmwSvPY8yYXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533712; c=relaxed/simple;
	bh=1uNtCGF65stc3r8cvvIr48Yler24up+Bv+CTKYA3B5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsPa9eHAt65rpKXpd8DQAtH6IO+0DdA/FyE1swaiWEme9nROpQ7+zO+kJQ7JsAQYD2ErxvPNuNcXafqfyyST8s+/EgHY7QqgcL/qBKUiyOUkf8RwdYOq0ecPI5lVzWgAprC1USPK0DwzphM4Z92td4UVQDkvMvbFTDvDWWpafvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brK8cZAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brK8cZAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BCB1F000FF;
	Sun, 27 Sep 2026 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533710;
	bh=1uNtCGF65stc3r8cvvIr48Yler24up+Bv+CTKYA3B5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brK8cZAB+kV9R9SIidwUjYVXzExCzaxtYLyM50m0dJvZNWmQghcLq0CbEyHCmmQot
	 mH32Wzy3gGN1F2D730m9PR5cLJwwE2GDQ1v+QfCNiARbP4xEW04XbPWE1JJVaCzc4E
	 lYwH+kGBCgIqs3cDm88cltwq4AGmR65jdipra8GofGIr0NGAFjZ5uQE9A5p83sFsN7
	 EQTSlq+jzzKy+QpGxzLJm66ccDtCwfaUEJEk/7tG4bsKz7WbRqPcGORwuRmwQqEpWi
	 wX4asTJ6oe16LLo1i+U0rq2xU5izlZ8QIepyg+Zn/LgE7Mi+8KUMXB2VZUZmSW2qiG
	 hrFJi1iY0MeYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 4/5] PCI: pciehp: Report surprise removal from
 pciehp_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927182017.938565-5-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <20260927182017.938565-5-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:28:29 +0000
Message-Id: <20260927182830.71BCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A surprise removal during a safe removal cannot be reported: the
> removal blocks waiting on a device interrupt or status read, and the
> single-threaded IRQ thread is itself executing that removal, so it
> cannot report that the device is gone. The removal hangs.
>=20
> The hardirq handler pciehp_isr() still runs while the IRQ thread is
> blocked, so it can report the disconnect. However, pciehp_ist()
> deliberately ignores link and presence changes caused by a Secondary
> Bus Reset or Downstream Port Containment, where the device is only
> temporarily inaccessible. Distinguishing those normally requires
> waiting for the SBR or DPC to conclude, which takes seconds and is not
> possible in hardirq context.
>=20
> Schedule a work item from pciehp_isr() when a PDC or DLLSC event
> arrives and neither Presence Detect State nor Data Link Layer Link
> Active indicates that a card is present.
> This provides us a pathway to wait/block/sleep as we will not be
> in pciehp_isr().
>=20
> In pciehp_disconnect_work(), wait for the DPC recovery or SBR to complete
> before checking presence and not consume the link change flags, so that
> pciehp_ist() can still see them and ignore the link change if it was
> caused by a DPC or SBR. Even after the DPC or SBR has completed, if the
> device is really gone then pciehp_disconnect_work() will see that and
> report the surprise removal. Like pciehp_ist(), it holds a runtime PM
> reference on the port and checks presence under reset_lock, since a
> slot reset may make Presence Detect State and Link Active flap.
>=20
> Link: https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182017.9385=
65-1-abhinjoses@gmail.com?part=3D4

