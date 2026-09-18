Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC23D3CEF;
	Fri, 18 Sep 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762995; cv=none; b=f/iIaMVASh32sq2P836Mg/xLAcwgSw7HreNCwGNMfhCBscvnuu1ryY1jHO1c/lsmG3/dbk0AOoEmqeQadiCiLzAT0LxplD8Uj54aknXYROeiUmfV1Cr3HkN70HBRfHUVMh3nby0JsB0f/mq3DN1QMPStrySjBJwJ1PCplepBBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762995; c=relaxed/simple;
	bh=aFG6NMPPSuorbIlqU27dxScbJKZhV+vI/vVxbxtvQPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJsB/Po6XoM1ddDID/RPd5++ANdooZbAIYuu2HbPNSA4EmLhGjKOwjeTwJgnS88h5RVJDfJDc4Zw7GBEbBlot0co8oUmZNOQPYPiN3MwtcmE033Xv4BbyUImoPa++JC8TBjJ349t82BJ7Z3GickHqcKMdLE6Q8IMF8AMMZE7jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8EevRzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8EevRzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483A1F00898;
	Fri, 18 Sep 2026 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762993;
	bh=aFG6NMPPSuorbIlqU27dxScbJKZhV+vI/vVxbxtvQPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8EevRzhuZz4nJEgD7WdIubGd5xCkXjojQLV1YgZ45BionFAmz9HLZIbms7CHK15M
	 qGVgkpcsiBOXYX5pbbHphFQYd4YZHAYMdRBoWtpud2Ej7+nwVjI9o3h0YlB5hyhjQ1
	 lxdR3U7SIH3gvr8sECbSpAAwQnXc0JHgxljXo5u9i6vonpDVyEWs5Q5tgfIlqvzDBU
	 +vFA8B2g28agSSRUW9EKOQQsY34hXUyiFvh6fgdJOToPZIj++uRa/MFKgEZzCJJ7oa
	 KgqJTzLXtH+VzfrilkfgyCInD9Y6a71qJLA0scREO7NAMaageYRCdHCAdw3QbKVOSd
	 kEO2Gr9EfF6Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/13] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Cc: "Saeed Mahameed" <saeedm@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "William
 Tu" <witu@nvidia.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Vipin
 Sharma" <vipinsh@google.com>, kexec@lists.infradead.org, "Parav Pandit" <parav@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Josh
 Hilke" <jrhilke@google.com>, "Yi Liu" <yi.l.liu@intel.com>, "Alex
 Williamson" <alex@shazbot.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260918200640.887030-3-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:23:11 +0000
Message-Id: <20260918202312.1483A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
>=20
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
>=20
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
>=20
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D2

