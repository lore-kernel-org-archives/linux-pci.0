Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03523E49F6
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035722; cv=none; b=HQFacCxniuLH35ZkKcItdmAquXltcwTQbvA/0SaR4e6NstvRNR+CYHuMwI7ntNXEwrVj9t09gRAUyyajsl4vuA7vImpv2ZRO63yvECAQolZuxTq1a87KoSrXbYw/jNT636ht3YTx4lA34ShhJWyb3u4wuCVxXMfq0gQiGGhb3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035722; c=relaxed/simple;
	bh=ATK3x0JN+dWnQiJE31nVuM1oU70qs1/Ikaq4Rgofm3U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BGkj1FxxqhT8fmy/y6faua8XLoeCf+XOAUCzKL2qsDdu1fUE34rwtwly60JsVt0NCIpozHlh733SR5/Q+LdVNFrSwgPnfJ33RDWe1EYiY/Hen0IdJclTeaQJ73Uc6QW7NBfVv109ZxgXqNTEaDE/v48f13nMv6aY/p9yyoveaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcTppQfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcTppQfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FD51F000C4;
	Thu, 15 Oct 2026 03:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035718;
	bh=ATK3x0JN+dWnQiJE31nVuM1oU70qs1/Ikaq4Rgofm3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcTppQfhWsz+U51PbkbQe/+OnfmquHc05BkiOONXhs0GcLHzH9xEIgO9VYhePE4g5
	 8PolPU1rBlfNBCCQqvkHjG84sH8MGSYN3pPBCFXFH7IESnAJvsC5wbKM8dYcYvwNy1
	 aXkGyXfaTJ1GXFYzc8MLyhHMCCQUApTq5TLwqBn5f2VEaAPRzhG6LjXkjy0Ez6ibwa
	 Ednt/4Ty41Zk/F2sEYlrTmV2XreSJs25HQDXg8NWu4zIrSepVaq7cZO66sEKI9FiKI
	 79x1XliOTe+OtH4MWrA3nzo4za2S35E13f6z4hGquz12p+N/BHFNbIRbabhMlHoPyr
	 PGsQed0rhAn8w==
Message-ID: <sashiko-outbox-172213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/18] PCI: rcar-gen4: Recover the Root Port on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-13-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:41:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D12

