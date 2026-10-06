Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560E3BB9E3;
	Tue,  6 Oct 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277134; cv=none; b=GcP5Vz1mBfm+lg4ZKDjy2Kr3xqGJP66Bzehje+LuRgxvheeFOFoEq8aQX0m+oAzICkMiLBIYtjiuGI7w+KAK283yEgC6jCOeFRVrjwwD057skbYQa1tfhlv3q0M0gGRA1gdrMbogY1uivj6QuAR42lmdSP0oTCzvinhjT9ICvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277134; c=relaxed/simple;
	bh=TBOXPMydgROGKPxhMF8ywz4V1bnt5IzXQaiUr3/oBCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyi/dy2s4747grp+zzxY2LFnZlc9/PDKxJcGHLGaAmgT4nCekOMAoBjQNLaBQ5zoUoq89G9FUUT2LtEglD8+kZ/uUl0Q0gf1ZYBucvWzdtQuyfKmzZm9Jtbnq8dqOFVW0/n6ftZwKS4Y6czkgDoebA25JXQv+diUW8Cc5D5ZlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj3j2LR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj3j2LR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B4F1F000FF;
	Tue,  6 Oct 2026 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277133;
	bh=TBOXPMydgROGKPxhMF8ywz4V1bnt5IzXQaiUr3/oBCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uj3j2LR5Mn2lPSBpIYHiP/irRNAQn0KVNZBwm/BWQy5+H50p3Z8ZHpt/cKNOI0Abi
	 1NGFGMjfKETiADkkj+aZhqN4b0K6EKjOG9QeHOHKBo0ua02uxOGUNimkl1LmZcG8p9
	 xlem0znXSh0leX+rCkansRMZHL4JWsETTbqzXWelbqi1t5wNGqQ/d+F/ewsG5j/tww
	 fbi63PzGzwd9A3PSP6CS432HiLLpaHLxt+J9ovLArGNBjJB9rIj7LBl6Bt9K+W7A1m
	 axKVLXjkWq7xDefhW/5/0UHjxp9XhL2CIPYAUYMSn8A+wvTD7kLqBkZTN3YtHbLDFl
	 ZrVTEKqdLbrqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/18] PCI: rcar-gen4: Recover the Root Port on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261006084638.3821710-13-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:58:52 +0000
Message-Id: <20261006085852.C7B4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On R-Car, the controller's reset requests (smlh_req_rst_not,
> link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
> demultiplexed from, so DBI is read as soon as the link goes down. On
> R-Car S4 that is a hazard: DBI accesses issued within a few hundred
> microseconds of an unexpected link down do not complete and hang the
> host. In testing, the first Root Port config read after powering off
> the link partner hung unless delayed by ~300 us.
>=20
> Check the APP reset status in the interrupt handler before DBI is
> touched. When a reset request is latched, flag the controller as
> needing reinitialization, which masks the sources, ack the request and
> schedule recovery work. The work calls pci_host_handle_link_down() on
> the Root Port, which runs the AER-style recovery and resets the
> controller through reset_root_port(), holding a reference on the port.
> If the Root Port is absent when the work runs, reset the controller
> [ ... ]
> recovery can run once the system thaws. Disarm Root Port events during
> suspend and re-arm them in .post_init() after resume has set up the
> link, so taking the link down for suspend does not start recovery.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D12

