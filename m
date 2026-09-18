Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FE3AE6E6;
	Fri, 18 Sep 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762531; cv=none; b=QhnhwXn+B5rdUAirdQ3+CjkFAPfaXa5PwF6uggseYAIWXOZikmDMDHtZtQLfKGvEsiV26RwkHp4zyIgMgC7ZJ51j7FsPxT1So9JdYET2yINa1vn70edpHyFsIselWNgSijfyP9eLQK5NLTuJbpr1guH8OKGNF1U4WQFlQJCx4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762531; c=relaxed/simple;
	bh=sauI9pjdBREvP/vMfRp7KC8aNj/xOe+ac8jj3HOclT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+Z6c8MaLxJA5I7hsMho5Ng3XnJ3vfM25WFytBcey2G5ox7yRAn7qgpuJvjvgJgssoFV9nMhcP9x6NXgobLmUy36pLMRqJzQUPbge7XnVpw4m5/xQyAajOG1cEp+UASMqyEWDbw2xi9fM818tsHF+lyKkg0LbfqOH0X4FoX0lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGWq4Z8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGWq4Z8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEA1F000FF;
	Fri, 18 Sep 2026 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762529;
	bh=InHfte711M8GWjBqV1si8bv5IIZHkN2SnYlxIl1Cx7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGWq4Z8JIom2PSUBkh/EdMZIVDCCXYBM5UAkjo5ZctKxb/oTXclDf7lE4G5qGvanR
	 /seeSAzwKF+/GbobcB7qjEPxRcBPDNZUtdo7qo2Ujl5LYFG5HLUE32ss3ITpM5L9a1
	 1jons1f2KLhHlieiUlBapS9kly4rU3gDNWzYLRyAfZ2LAeKxxqjET+fV8mY/4bx4Tm
	 6q/3KM6sJlbE3qec2mMfH68MXMY4rVEmA/OWGmc5QOynTmO0FKYYzUyb8KjkRjgCYc
	 wTI2W4XlokzHkgzzhpQb6m4+BN2cSIRaQI6Czxh694MwqEBCUB+okYa9sdkCFDxnzk
	 l7eE5QrTxx1bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, "Josh Hilke" <jrhilke@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Parav
 Pandit" <parav@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Chris Li" <chrisl@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "William Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>, kexec@lists.infradead.org, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Alex
 Williamson" <alex@shazbot.org>, "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org, "David
 Rientjes" <rientjes@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Saeed
 Mahameed" <saeedm@nvidia.com>
In-Reply-To: <20260918200640.887030-2-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:15:27 +0000
Message-Id: <20260918201528.29AEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
> preserve its own state across a Live Update kexec.
>=20
> Preserving a PCI device across kexec requires preserving two independent
> sets of state:
>=20
>  - Driver state, e.g. everything vfio-pci needs so that userspace can
>    keep using the device in the new kernel. The driver preserves this
>    itself and the PCI core is not involved.
>=20
>  - PCI core state, e.g. which devices are preserved, so that the new
>    kernel knows not to disturb them while they are still running and
>    doing DMA. That is what this commit adds, serialized into struct
>    pci_ser.
>=20
> [ ... ]
> not be enabled and these routines would never run.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D1

