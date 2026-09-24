Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FD309EE9
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 04:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223361; cv=none; b=M0mKmlLMZhL01jWeHLfcxv1w09nw185e0lUZh7qYwdtX8ytKdur+p0rfAlgoccOHiAsYdDSBzWnt1FhSVvsjvtwNc64Kfm/s4vUYfrSeNHg1s1ycKl68x5VyFRKcwN2nTJlWK9aoSHGBoeB26tmG0DvRaYmAaJME020VoFo2NWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223361; c=relaxed/simple;
	bh=T7zeIgiLsJOG8AUxBviS1nLqzz1fDEa1Ucdelw9m0vY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SodK7sUuy3LUkTWvSBvdrNkiS9kgEz4oWpzZBJSgJHcB4+r7cpMSi3LkfilZr616HubtS94vgKvsv5UqGLQAYuAsduMnnE3Yp/iKG++Kb/tLIeH+nGMD/p2SG18K4MSG5AqjZjY1Lj6kgpejjH+6NsGzk6zRD8MAQL7x8qDTkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYtzdA7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYtzdA7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708831F000FF;
	Thu, 24 Sep 2026 04:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790223359;
	bh=T7zeIgiLsJOG8AUxBviS1nLqzz1fDEa1Ucdelw9m0vY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYtzdA7EwS6GKYxaaXsMyWdSXeIHgycxd629VdAZB4pSC4ncyF/4Hbs6H7w8vJaRM
	 jLQjpu1wFkmG/m9r7ERjPQgAGQU9iOmsJdOU9mJcDN5hM0jcNFcctwdSLK4bIfCitV
	 UTu4uS32QFj9MdKas9i+A3t6+t15kfDwJIyzZkNkJFOn5gXgMGL05ztqCnFsNYrpdv
	 dts26TMgliB66fHZVt20mwL9E0dcDl/NS+r1oMugTYNYrrOjGK5oEsei9jmlm3YQRA
	 xxbp4KrjDublUBxLQ4mkF8ce4M427LKuntFjv+TeRYCT1og6kqf3hnfwdmdh8Pztpr
	 HlH3guxWKDUHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: dw-rockchip: Move the INTx irq setup to probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 04:15:59 +0000
Message-Id: <20260924041559.708831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
> and use for link down"), .reset_root_port() re-runs the host ops .init()
> callback to reprogram the Root Complex after a controller reset. That
> works for the register programming, but .init() is not re-entrant: it
> also creates the INTx irq domain and installs the chained INTx handler.
> Every root port reset therefore ends up with a second irq domain
> registered for the same fwnode: the previous one is leaked, as it is
> never removed, and worse, the INTx virqs of the downstream PCI devices
> were allocated in the previous irq domain and are never re-mapped, while
> the chained handler now looks up virqs in the new, empty domain. After a
> link down recovery, INTx interrupts are silently lost.
>=20
> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
> creation and the chained handler installation out of .init() and into
> rockchip_pcie_configure_rc(), just before dw_pcie_host_init(). The
> lookup has to happen before the host is initialized, because
> dw_pcie_host_init() enumerates the bus and probes the downstream
> devices, and pci_assign_irq() maps their INTx interrupts at that point:
> if the domain does not exist yet, the mapping fails and the devices end
> up without a usable INTx. This also mirrors how the qcom driver requests
> its global IRQ, and leaves .init() with nothing but idempotent register
> programming, so both .reset_root_port() and dw_pcie_resume_noirq() can
> safely re-run it. Re-running of_irq_get_byname() on every resume is also
> gone.
>=20
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and =
use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790222793-77182-1-=
git-send-email-shawn.lin@rock-chips.com?part=3D1

