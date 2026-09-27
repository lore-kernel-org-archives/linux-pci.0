Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05631AF4E9
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531963; cv=none; b=utblSEgOiqGZGC8OiFqydDikJsUkVTSfnVEQXD6wQY5VpuGZUq04KanIP4rhy4AmFLeKneEtP2dGSDRgH1Fg7CY6dIWBrJ8qevAqvGJgjOhwS1EGQxKRfKue0AaWbsGtf/lOtNX17jrC3GCdN3qjh8v827bEc3BRnqtcEFIHB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531963; c=relaxed/simple;
	bh=F+n/SpHtPv0GpFjLLAe9K3PYafU27JeLdF87Ws/AswA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gi31v1YgmGw4eUGmIExXBLTw6Yzm3n6PYFWig88GZ2AOePOCzEo6Y8wnkntnTqO6dQPSDfwBvmMrxPU4YOmICvzz26s7p1bSJiqjqVu3tDzrBJ6s5ILabvsz85un8T5dWUzdAtp/8l8iiHfH6IZWQsFNy4v9+DtywpMrSEzUF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3+sMbIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3+sMbIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA01F000FF;
	Sun, 27 Sep 2026 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531962;
	bh=F+n/SpHtPv0GpFjLLAe9K3PYafU27JeLdF87Ws/AswA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3+sMbIRvguo4MeCCfZ9WhK2bc2ZHN02geXnRIrTFb+7fdc3EG3Slfv3GjnyVu22j
	 C9Kgqh+tOLuKOXanNUpVAMojPWM3iCikChtm2v/ek4yTfQ+t6mbCydnkjxDYN8UNLS
	 6fFA730B9zwUtz9IAzzwFAXBXf77HF1r5GA/QCQXL3HxXuJQZvNXpBG7f8EqBVbQ8Y
	 9MHBzOvYxMwb9SDBMAJa3cqZX5vL89nvg6Yn8Cl0V+/6jr9j+7pSbB9hp3RSzeZWAx
	 Y+8YqNF3PKeu4jJ3o1foabqewSEiYBqSS6R0XelFFuzC6byW2sZCw/y22Fek65WXMw
	 FvgySdtaIGYmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 4/5] PCI: pciehp: Report surprise removal from
 pciehp_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927175203.928270-5-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
 <20260927175203.928270-5-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:59:21 +0000
Message-Id: <20260927175922.3CDA01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175203.9282=
70-1-abhinjoses@gmail.com?part=3D4

