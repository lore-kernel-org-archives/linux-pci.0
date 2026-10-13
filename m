Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EF51B178
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908903; cv=none; b=IJOvL1lc22FKjayyb5/Is5JuVt7Von0MdOkVtLZtj4Dz//l+9DIU48GST0IYx2Bn1T8191TcWeHjfoc+hbE9sKTTkPilLKJWKPXvuanaE5oYo/nZvtoOc4ZcLwzyWx6nqtEUMECLlbA7reGUD+sLnS0DNc5D0Xp0D6SxsOIpGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908903; c=relaxed/simple;
	bh=HoODgCJzXTqjjh7wAFdyCzkCbxOfO9p0npLXBlbsnmU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mvQngeiInTW7zyF/bBVTbi7tXhSfN06qritsniWoPrysJN8hgpqCkwd44L1GUxQ2WCWFzj+1NFbLlpskCZRxjDf1LcPxq1D9H5KeIivJ3Xoqa4xpb7P6+G5LF4o8nQWrgYBWsQhAVcya+dz1U/6ia4Zbw+ToTXN71Ih9i7frboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeNnihRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeNnihRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FBC1F000FF;
	Tue, 13 Oct 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908902;
	bh=HoODgCJzXTqjjh7wAFdyCzkCbxOfO9p0npLXBlbsnmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HeNnihRlFwiXHrr5YoMqeQWCimJM54roT275liKqHD0MVnrmZuomrUIuBIcDKYJkE
	 W5SpppvO30YUpwNAFpwkYcni0LnJqwtZFMkp4Bu1RK7iBqq71Of5C+6ranqD5H/3my
	 5JRQFgtQvwecju1otxVtvwXsvPzfWgMxwWnrszep7HYm1ea1XHX13UEam3crD77/fz
	 OvUKaYh1jfn53vAGVgJ/8eEK4cnSCGEmjaIDg9FhZRNpzmhYRIGIqScwIlTwdQJF+M
	 nbn8XA8nwjh+HtvbYl60DhjuDXgZFNtlVums5tdR7DDhofFGj5xhKGkihuk5vg7Rjn
	 GPlQqfc9f+LnQ==
Message-ID: <sashiko-outbox-170110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/13] PCI: liveupdate: Document driver binding
 responsibilities
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
In-Reply-To: <20261013162529.1928093-5-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:28:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D4

