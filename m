Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D76522EE0;
	Fri, 18 Sep 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762681; cv=none; b=H5f1rdLLDQSwMcrd9Yj0z3HEuq2eJwTOTpGucbPUeeGbNlbQ4Bq7QLO0HMEE2XfNAOZtKpC24tFPRXDcTM9U7B4+YvSKkLvqrzP9NT5ViF9fZlKlaykNy0OsZ1X47aUVnK2z+vpoO2cL5p8j3rAZkE1LNPbixlqQkmu899U1VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762681; c=relaxed/simple;
	bh=hCHuqGhapwzls8VgL6M7Vaq+lyoIyqiT5iyUONWBCY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPJm/XdwBo0B3A7ucg5uf7qjuHAWxFK27ukpkAVkzAER+xEg8tSR2RpTTvaaZ2DRGT2Xx3q4HS273QCYsubEmjWzKKeK2qpD9zfl7GkpxvTa6tABBJOae3WbH4gPz5NQyA9CjdU727KoLJAOUJSYc4sehuBJczGjbtyF4RwBWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic40wAoF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic40wAoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3871F000FF;
	Fri, 18 Sep 2026 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762679;
	bh=Rj26d3aL2UpD/OsbufCpnz9ZaAuE0EUthnpJ0sXROVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ic40wAoFb5QI4S4AZtHCuYo7DpiDWYXy+Vg66oKsiZCf0vKs7mFaybs+eEkI2Ca0p
	 LsvOzLbUd20yb6EfzbjtdXMW6+daSuF3ys9c3jtzvaWzy1+r+5mGc1fW74XF/5xHyW
	 b8HuWqEy60y7RoYviDGVFDKJPsAyD0qU/Ws/i7DJ/dd3yXFha6vfyubXF5yueTE+jX
	 ziihUo2gPcptS36xC6q1uUCmQUnVk+m3aIeKFzuZWUeN22ifPM8TEtaL7Iv1Dkxwc7
	 Isj2sKpT1v3z952iVZ8xaJorgYZQ0GT0fOo9V0X8cIwBEDMIzs0NEPjHoY3bSChifJ
	 /+vGQ/ZG08ZDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-mm@kvack.org
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Mike
 Rapoport" <rppt@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Chris Li" <chrisl@kernel.org>, "Josh Hilke" <jrhilke@google.com>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Pranjal Shrivastava" <praan@google.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Alex
 Williamson" <alex@shazbot.org>, "Parav Pandit" <parav@nvidia.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-13-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:17:57 +0000
Message-Id: <20260918201757.CA3871F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D12

