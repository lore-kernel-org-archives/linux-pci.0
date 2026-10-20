Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488470;
	b=Dreba1f78Wx69Z7girQh67bh0sEF7dQlpaacqtJdMK0Enqe3ROHAPw/J/JxL8bN9uYij
	 haSSm4VioaiyKOiPNev6Ub5akoql3OXdzG8ddfvgsdk3lYP3CgI/Al+A5xcJIRwklOfz5
	 jZz+5n8UkvasT6/ebVj31SDFyCQuS0g3KPLlEm5ZTLEwQA1jTc9G7HHTB/ZA+ZwdywS1v
	 6YrXo6i/4sgHEggKBaq/HYzWYXBwKPAwwf18CmIh9XAxYVX8PZ1cMpHV/bxqjr7YSErfz
	 hcS+K89e7Bcka3SRgBjrN4dqa34y07j3ZotVNUAw7j2mFTGCBgypzKZ+gvwnrrMIVYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vOQqTAZ8Nr+K8hXUye/MG+tI4naEYJSkEia/vR4Q+Ao=;
	b=EDSG8VIHLjQgWkvZqYG2zNtNBvuzkWVC/TXfclX2MTzEmm6j7PasYfHzQFy8VSsATfZY
	 tJwxDH6i23F6w9Pq1OnEA81LP9EE9SnfImqI6JW9qp/43PNmim6PvWvBtCmlKan5C3woc
	 Xzc3DP+g9fAg82HcHWfhcZkmx3GMM/ywNqG8ZJw42+E8kbhAtCFxYTwnf9lB431vu76wW
	 j9Xtk3jwD2Pj7cZcGDyrzXefQ1FkhN7I7jspGTjvZBH3ARQRt5HsWkn3SM7cL155Zuafq
	 /9N1kYoB56iF8KMMEj74s3zN+4DdzdMhkX+s60XZ77wUfPRHO/Oy3f+6crBGe1WF0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPeHENCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B4606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPeHENCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0191F000C4;
	Tue, 20 Oct 2026 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488469;
	bh=vOQqTAZ8Nr+K8hXUye/MG+tI4naEYJSkEia/vR4Q+Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPeHENCh86SLdge6geEPw51g07L91tKbVu914o2gBtw1V9XhhnaWrBALOA+oZ3Qi5
	 o0P6kLIbObQBiHVbJwvqgrzseo5wREZvrskuj3KTNn2m/oqjZ76zwISmmFcUT4Qo4X
	 5GZf5+xIyKa/2PDm4/AA1+Vmty5Ct58aysPpMxHihOPNzn1Yr40EupkARMWnrooRCx
	 aj3d2OEm78dlWzE2Zo6syopbtcjmLbVtTnZsnmAtciuO6XXN4CVXPxg19WkIpWqI8X
	 bO11dysdzYoOkU9Cl7Nnu6fS0MgyjMJJ4ov8wac8xlEM+tvXpT7T9QMe+sbb9hTmA1
	 P34pBeomgQ5WA==
Message-ID: <sashiko-outbox-178735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] PCI: rcar-gen4: Recover the Root Port on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-13-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:27:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

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
> suspend and re-arm them in .post_init() after resume has set up the
> link, so taking the link down for suspend does not start recovery.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D12

