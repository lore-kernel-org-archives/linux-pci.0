Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602240;
	b=somtR2f+6Pc9+DVUH600QqoKa0tlqDeWdFBdUa805nr8ZOovpvjpkoG30UH4BeeW6XyW
	 g5Or1SGieNgw9pr+DJ4PZJQqF+k3GWyidLSwJYhJ3vJOA3vNrl5EPn/DERVVLQGXOV+C1
	 S930CoI4zk5YWdsUFGiRCQWV4dcT9Ni9iMyeM4W10u4dz6UAILvw+ZWszkA71Mni7Negg
	 ej4+k72HRETZPjZEkjaqF7hl5pWuXlyvhTRliNCfHl+ZttX1PNPyQang+tqAuIIHjSS90
	 Jg6z2JCCzvC9kJ/lrfXo/aDJquXsrNPvn6ZrHmjx2AoOOGpJzxBjkBslqRQsXKXXNSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qXt+kxnUHIycgid49wATHVmR96BCWe5jrE/Ay7tmCcg=;
	b=yQDs2oXP5dkbtww1CWtO1hLQZd+IVUkIB7HKefP96AzoKAwZhxNUQ0ZpyWWPmnRHHmYP
	 3V1juVYJU2fZwYhb04vYH+7yNMlW0R3QodWAfAlLmwmP/JYh/UUs4cDKybfaVv7FVHY6g
	 7MLFXK/qoliQ/7WUahik1p4o8PeeTyGRa+/mEjsv1csJ4mg+Y5AnVviUS3EFgRwNYi8Ug
	 mvPfVUIUOqM3lL+GAjuGN6CxY3KoKDMAk2iJ75Tu8f4NkOWazM0Ki3bAOZPQ9nuNQCdif
	 7nqgOzOfOvURkU+0qcXnOX9TFyq2TGG/NpkdkhWsf0Wj4IKQM6Gb0tUWUPW8Vv79EqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkOqpe4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F8606A330
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkOqpe4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B91F000C1;
	Mon,  2 Nov 2026 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602239;
	bh=qXt+kxnUHIycgid49wATHVmR96BCWe5jrE/Ay7tmCcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkOqpe4X8YQtGHpewProCYxUIxB+L+15+US8MN2i+bEF1hyJ+pD0trxnVh681nZkP
	 5Itciu5k+gYWVlbkzp4+xQsmfno2oMtX3RfodK0qPqZlavBkjqjdDBGCFZAZnToTTA
	 di4bYy3SFy5Gp2CaGiz1Ov0ZNdGS2Wp6NuoHESCtpM+L5/yTGlgjpvjIwF8O6r1MQd
	 XA1lDDNhsk7AOoTrGAi+XsStx/4qUCDS3Ri2rwfoSWDHNN8JemYX7XnOAEtp8FVxU/
	 VAKCTt3o69qE23Lkdi3YyT6L/yezHAC6Y883LiNPZSBRQN7OcJnvepmxrCa+75vzTD
	 7xTE8sPoV3pFA==
Message-ID: <sashiko-outbox-192969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix pci_alloc_child_bus() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261102064035.3833574-1-18255117159@163.com>
References: <20261102064035.3833574-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 06:50:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> If device_register() fails in pci_alloc_child_bus(), put_device()
> frees the child bus, but bridge->subordinate and the bridge resource
> names still point into the freed child.  Subsequent rescans can then
> dereference dangling pointers.
>=20
> Also, WARN_ON(ret < 0) reports device_register() failures as a kernel
> bug even when they are caused by normal runtime resource exhaustion,
> such as fault-injected -ENOMEM.
>=20
> Defer assigning bridge->subordinate and the bridge resource names until
> after device_register() succeeds, and handle the error without WARN_ON().
>=20
> Reported-by: syzbot+ea7278bdcb20a491495b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dea7278bdcb20a491495b
> Fixes: 4f535093cf8f6 ("PCI: Put pci_dev in device tree as early as possib=
le")
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102064035.3833=
574-1-18255117159@163.com?part=3D1

