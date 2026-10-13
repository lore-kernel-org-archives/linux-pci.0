Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4151CF48
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909319; cv=none; b=s8u0L4xqj4e+oNZyk6QCycM5pxPgKjA/DwUi69cEVQRPP66djulQkdmbOU4m8ESZFOyVzC3C96hlnO8nGWZmDAN3/I2emHT9TJgtGbDRFyEiPAYVbM/SLD9POnqtCyGV20XMSf7mhN85B6Fee9+FFNfjS13Uv51qlsEcwRt8qFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909319; c=relaxed/simple;
	bh=R7gj9m/FD1mgTkDzBdhndXdlIsFcIw/1hHYIcldmcrY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jNAR+aE4TyW3X6eMBVqAHlh4ZAyiYHu1FBx4K+xzOkWMB0Wtz9qStoqLRObCtNC9vzlF8xzbY692zDQ2gKzfYexyp/yw3deRrNbeJcSIBtil9no5EqRAtlfrwZKSNYkJ4H7kBubH72nj31uEFWUvsWcCclyI7vMNguwmqf8KPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrMPQS+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrMPQS+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889F1F000FF;
	Tue, 13 Oct 2026 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909318;
	bh=Mca5pzhulPTOJF1qTtDVM/rwKG3e1fXxRzAruQlixIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrMPQS+dkKJNGtNNp46iaPbj3wmoiRvQMd5tprm3pfWR6BW1QbGhyKAdKqjbMBChP
	 qxKqowID10XpBQopeg5UezBGf8VASwroS+RMkLL5o8ce49+my48nYiqCGlUIMZ/yLv
	 EBfYyHJugGWrB/dqoANIs4tMPBm90PkBwJNYnnyZkujh8Ofj6sFgyfIVlYICAMpEZx
	 xF3TnreY1CiJ87Z1W1/2gqy1jmGvLj0w4RMcK3pL2C6ZhDMSZHCcSCfVYT6/CAhUSY
	 hyKbmYIiaIVnNmefWz4P4yobbq0/rtUPuzX/E1ZHnHOFtp7otJtmIpczqxVRKtp+2q
	 zlTxWMEd4qB5Q==
Message-ID: <sashiko-outbox-170123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-13-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:35:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D12

