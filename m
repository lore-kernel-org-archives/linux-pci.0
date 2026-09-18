Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB6522EF2;
	Fri, 18 Sep 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762425; cv=none; b=k5xS2guYf0XDoqHcuZ7yWDrnPRTizYme4sUAwAe6kR7wVBTcNT3um2YrcnWdNN2Du9KeLpdopRo7wRPgUE7n392grdIIyrgi/tyLF3AJp7XKMAd4TMBqLkRMErJY7fQTjb3fYEq0YwcMKKCzlEYxLvJKDdpVwxEMuDfIABPk/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762425; c=relaxed/simple;
	bh=4BHzfgU7NlhiaeoyLw4QIVrcWHr6+Q91E2JaLOkHxcc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNKspS4N11BajcYanIPXBEpLF87fwvN8C7sA8R1d5wWl9K8peYh3208OSFvV9COrv/56Tpiv7kvzP33PhZXALr4F812pzkT4LFgZHzlsWk3SHos10LUMQzMmNxRObJ4lstoRWZ91IWdT5ub4IKdswugujSXIoa/T9dqjFhkls84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyCzK9W1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyCzK9W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F81F000FF;
	Fri, 18 Sep 2026 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762424;
	bh=4BHzfgU7NlhiaeoyLw4QIVrcWHr6+Q91E2JaLOkHxcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyCzK9W1dXl+/YzMV88nR47sMs1YSKPOm7r206nkfEqmpQfxEqtGNi3uGia1CiCBy
	 58AvHvwaIQ+5VvMMIpang4tGjgDjDjJJHMlILNjF+5dHsU7BoGwhL8u0ThDISYllWa
	 7jwOzqBUcYKmKJocF1NyOwvZClXirVEzLYh7xCASXkO0Xc7ZYgKO/LgUzZj6HR1apQ
	 fEFmh0X2YOQQ+ddXCNBoH92KvaJYaS0WTY5IpHpB67cYD40enYMIXjOOGUAXE3Qvr/
	 zo/uC4l4oyXj/Kr40at8aj+ZgiYbrX4n5HubEsVEjViWcJitj/xiMzVDD9pJJoNy+4
	 om2D0s+D1QSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Alex Williamson" <alex@shazbot.org>, linux-pci@vger.kernel.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>, "Josh Hilke" <jrhilke@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, kexec@lists.infradead.org, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Chris
 Li" <chrisl@kernel.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "William Tu" <witu@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <bhelgaas@google.com>, "David
 Rientjes" <rientjes@google.com>
In-Reply-To: <20260918200640.887030-10-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:42 +0000
Message-Id: <20260918201342.916F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
>=20
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D9

