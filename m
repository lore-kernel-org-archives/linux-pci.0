Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC151B16B
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909676; cv=none; b=Kxbc5mAc15Ql4nGnMAXr4aqu9cbhyxTByVmnMfwQorCL9OiD2Ue7CYEbNnlb57Tk/qCvS4ZPoDd+KPLE3gG2aWl347x5g7CxWnunx2mPzBrRXnqcTwTiBm98TsoJq7dMQhvwYpH9n8h73IU558/3LKSsQy1IjPrqqmNrClUBsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909676; c=relaxed/simple;
	bh=T2nnygMGiS+OTPVQ1KV9X8esySyXmHnUBkUStAXevB0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OnUylVqKz+M+3NWSxJMCxYK8LZ9q1nInXSfKR+AQpPXdY2mW/OAwd6fRpoUtpTI4j6+O+4mAyHj/YTR4Q54vnMEgIQh4kV+LAfIrFn3gaoeWA35cuXR9eMIk7FJ2irEQxxU3cuMryP4j92EX0bbSLJF0GPn3tTaJ1rJqGXoinbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnHEuHMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnHEuHMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435531F000FF;
	Tue, 13 Oct 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909675;
	bh=T2nnygMGiS+OTPVQ1KV9X8esySyXmHnUBkUStAXevB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnHEuHMqUqdQ1JCsl2TlxtUExzLRFfPdASmc7EytQYxnTWNR738e3jZYeMr84qMi7
	 ogetP/Wl/nw7h8WVRsNd11PItvz807Cg7cjYu3oflf0Rbb7T0AlZyc1nLpXXylNCNZ
	 C+KeevpAWQJuLv+oqWYeRfIWRVKq9/3TeQ7KbsEt9M7xsuWsBNm2ALgcy1TkGqI32Z
	 By/NftrthbT1MYTl7gzRHHTxghXdktkhhYSboxXF+0ORcuDmwtxiWnfQhUA4VEkzAh
	 cufqDVwIuMklPcemtZKYgQtEyum+P+MlIQkbgoYc9k3aPl7RNzpqxO2XeMDmJjpFeh
	 lJRHaIj9Y5/HA==
Message-ID: <sashiko-outbox-170136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/13] PCI: liveupdate: Track outgoing preserved PCI
 devices
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
In-Reply-To: <20261013162529.1928093-3-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:41:13 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D2

