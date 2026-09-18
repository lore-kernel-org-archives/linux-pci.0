Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF147DD42;
	Fri, 18 Sep 2026 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762413; cv=none; b=nseYyzzuOX9WikMgbMqIrpsXoK5UUhIZc+K13JqZKeCJsexOIRIx1PA2SkWR/P4iQEyEOqb3Efn/4JPKxdH8wzbx42JTnZSaBR/JV46iNYsDwtoPb5XAKB6Jk971d3DHIGCZa+2px1Q/Qg+yg+wCPCxaDpcXOxeZ3+Ktkw4MGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762413; c=relaxed/simple;
	bh=IdDvdVBUP9dI0We8t/DLRSXpGyJGcqmjaxTczi9FQIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9QETtDRt7DHojfRETjYu4+DV4KdypRGUoo/AEHeEzYu+eukKDth9t/vWKHjJTotkGJMwBnfu9YEME5/CkSTiPKI7VDNlq9lz233Hr0cbGHtlMZqHARk00uI8LLmlBIVVghyZNZFJX3Fm6QxRjte4TWac3oZTH8fzFrKEqeJZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAw5Ulvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAw5Ulvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56931F00898;
	Fri, 18 Sep 2026 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762412;
	bh=IdDvdVBUP9dI0We8t/DLRSXpGyJGcqmjaxTczi9FQIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAw5UlvuSYKxbaxLCoAdn3B+ntHZiwR/3D2Ji+Fn0ZYKJwHYM8ZnlI2lT9lc6eb7A
	 JjVJDX7cv5qlgm8kMuylieYao30s6Af5TxWMQiJEToD9w/W8doPLT49tEFpV5faalO
	 e4dd4qJ/t0EnNhNTBjNF7Z7pkYdEurfIwnCwwR1jh/5z1uu5TJiV6qV2CDbJtowFRi
	 y4OCFgD/LrEhJJBx7yNMbEypfKALMLRBMdGc30aUkMmy+IZSKcFV14ouvIQE6Xn0cM
	 D5TpUnHhBJeSt1EhOMj9QrfXH2NLa+MBO+9DwxRHNR0liwtuGRHjPBQq/FYnwYAxIh
	 nxHv56C4VlqWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-mm@kvack.org
Cc: kexec@lists.infradead.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Parav
 Pandit" <parav@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Alex Williamson" <alex@shazbot.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Josh Hilke" <jrhilke@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin
 Sharma" <vipinsh@google.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, linux-pci@vger.kernel.org, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-8-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:30 +0000
Message-Id: <20260918201330.A56931F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D7

