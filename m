Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB87352016
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528540; cv=none; b=gGzKiwHBNZuLYwlyTOIRle+AgS3IhpMYPZH98O+US3wUZrUI7G7U0HRSan+Kjyf2seyqPQ5SbAyIjnhMwgJgpGbo6H0mYFrQrJzi2RP2wdakUvIM0Tym8Elj9gE6ULZY/Z61SC8zuatMBByY9Lr7StlMUstGsqsLZBpkEXOHoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528540; c=relaxed/simple;
	bh=qun09C1Z4yt5ub7DcqpexvSfSYUOqDvo0v8BUm7WqJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AI+tRzkSsIwxt9TlGKfVYJ1XOrgpfrwecMFcxb8/91DBqAgdvCOZ4k9qK0ti5w3fv9NvJuIhhSKj4hz93bNgtL0DG66mzT/8iJPxtpJQYSNgAQpywOLMBsdTDpTnHKXzDpxDmFl7ynIXx1rKTWoM5YN8EgpHY1GaP965HogKRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYe0tDNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYe0tDNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382041F000FF;
	Sun, 27 Sep 2026 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528539;
	bh=qun09C1Z4yt5ub7DcqpexvSfSYUOqDvo0v8BUm7WqJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYe0tDNBqyGqEmJ71WEJ7RfdGDt9VoLzKHku2uw+Z6+dljdYv3vMDIEf0QgUA2T4q
	 Swc10heIzs2j7h57OGUWNYu8axQFChoEQLnV1jgLM7kmQWHgz5R5mS/Fd+0Mhk3tFi
	 onOFj4GH9IKajp4W21yn1/euJpMBkJAKorJzKGWqIkbmWgC/5Pr8OaH7JZtkhSEPs0
	 wRG76dGIQRV+Ur6qHaEhefr/Hkkvk3QKyHhYQiFfTTG7OdPwvblGpU7khsP7nXkWLs
	 8FW2pCn6FJhbcdFq9PVAQE+sd4cRGupJWAhpMILF6HdLDmZZpV5iLNsQEJKd5yIb4P
	 iDpDvy3xFxqOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/5] PCI: pciehp: Report surprise removal from
 pciehp_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927165459.829900-5-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
 <20260927165459.829900-5-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:02:18 +0000
Message-Id: <20260927170219.382041F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927165459.8299=
00-1-abhinjoses@gmail.com?part=3D4

