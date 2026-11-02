Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647786;
	b=jyBf7Jdo6ZEQ+9k0nS+JbGomdXkgFezTe8FN1YajiO4oG0Beod7KUILbgKi2+wiPYyDK
	 diZPrwyRs3X73HbqoGivmcNQeDFlenwC22tdOtuY3aXFsQ9CsqmqieCjgO+L0efDmGaQT
	 YH9TMi/2iCsZqQinl/c91OqpFzO7QmRIVyuCbbgO+fI00hN72M53TSCiEuq2WTP4xksw/
	 pQ5dUgQxkjah3oJfEweY2GjJ6+c5M9HR2B94iyNpDFfQzzHBtNKi3NXYb6SYOWvBXWtdz
	 fYR+2f+P+/Nuh1BA6eOhUtJAUX5jtTppujAfWN/nvb4ABEjKz87HUtbLl3XCeH9W+Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t4NjpzUuP+qEu0SbJv0NNA9nk6HeOAjjjuFLjSEtVRI=;
	b=c0goven84toTvLwofj7wVOeG5Elv6j+HdNZYLxtm6oMC4/FMiOUQJEUpgJZotDPFnCin
	 mAI2Q5QBumrFYYvmPtlSfwXGy2Cpj6seEZW++QMSGWEFYyUuOrLAJDuPY+v3XiNT90nwM
	 cojPj74VldNC40lw/tEYeZtG+GBp3LuFpH7LrcsxYsoQU2LYeIhSAO9unnQv+Di4noYiY
	 pWJzeKpGV5UOTRemIK7mdnc26Wk55vabqNvOETrVsXhbNsAEGb20MPrBdTLZyCaU0A7fb
	 paVk7YntKLFzw9sXc5I/EuJZKbueSIIpw4Zw43zLl/H+Qf1kUxLXeByBhwjGwF199GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKvfxQSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4666606A324
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKvfxQSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EFE1F00A17;
	Mon,  2 Nov 2026 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793647785;
	bh=t4NjpzUuP+qEu0SbJv0NNA9nk6HeOAjjjuFLjSEtVRI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dKvfxQSRpLt12X/tZvVK0N/UAhZK8DnrQ3X/xIHSwIvkNQ2Hl4x6qWdpTkjS7Gqtu
	 YFpONRiFqhngnvSqOBlpnW28gMevpTo84aeRBeNjMtKNASKSbHJZeR8hkbt6En+XMk
	 i8quefs1VUcAkI6cnh043bRFSGJIQMc/nsYjc3fuMc/dJ/aUSLTF6t5GusAW005vmG
	 UP5FhGrKxhpDp4aOjrRddXz+k28iBsvs1s34TnOI/gvc/rIk/k58PhUEPitQ6IbArS
	 wIDBIVjYW78B+jRV8nx7b/uKNM+fKGNfzvI8RGOvtfy2L5pDNHW415EqYmlKqnfUma
	 rqHz0+/cu38Iw==
Message-ID: <sashiko-outbox-194006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: endpoint: pci-epf-test: use
 dmaengine_desc_set_callback()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJT?=
 =?utf-8?b?WVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261102192722.4051764-1-Frank.Li@oss.nxp.com>
References: <20261102192722.4051764-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:29:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
>=20
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102192722.4051=
764-1-Frank.Li@oss.nxp.com?part=3D1

