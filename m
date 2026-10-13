Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4445187FF
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909693; cv=none; b=uVSE1G9XnsbFFp7CsH5r976nlr1XpLYTASn2MlNbuRRxix1f4Rba5Ldh6XDOqx38ItW7pyBRySvirgLXD03M4N9cwOVjtciNiTAi+m4XfkBjMEfaR3c7wgUuMpamn5kLc3htUa1hkWdcJygB31B3TdOam9PT26DgfIq3vDSUzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909693; c=relaxed/simple;
	bh=gvPKHDZ9PXmqAfRqRoBQE5C1e2Kg8stYE+1iBXMRupg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FS1HROoRf/R1cCLOq81hIFA8NszYKv3c1GrcUYKWLiHA4qrSGwDBH3g3Z75cWk+TWzKwfALOwbcsyJpbTxGtR/vjB6z6YsPRaXdXjSGtNP9shauaNig1zQGmGhhqUqtm2A4SzvtL7GkBqQXjaIVxsOmaPIFtyGDABCtqoDDksH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGtD6FS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGtD6FS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B41F000FF;
	Tue, 13 Oct 2026 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909692;
	bh=gvPKHDZ9PXmqAfRqRoBQE5C1e2Kg8stYE+1iBXMRupg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGtD6FS2Z0u2Iz2gXS/7rWoxt7Y92I+e9s6jHrwSrB68GEzWkxaDgRt/Jn6poQPqL
	 APIvg2tJGphgf1wmaE4IGKqWSw8JjBU2jNU5rIl5hvjwQTa7T6B2RMcm+CNqE+/IYO
	 TXSJ8vYplnPF6UWmOwRewK93sQ1R06O/ygIRAJn2jgV5JQuecxROzszbPu7W2jAheZ
	 e3coj81KRh9LUnCTQn9XUYWj/ZlITAGeVn4Hgm36dodOYxrjEGur6R5WPdt9dTprT1
	 ysrUACReRQUVQmypoMkjz5ug2jiv+HcxDpkscOXr2+WIGc/AGllHu47ZW5ewoiOejx
	 jUeURDmOYOvSg==
Message-ID: <sashiko-outbox-170138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
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
In-Reply-To: <20261013162529.1928093-6-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:41:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
>=20
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
>=20
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D5

