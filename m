Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484D44AB6B;
	Fri, 18 Sep 2026 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762770; cv=none; b=ZPzeJquoZVqsJT1yozLjKKeqkMN7xgz7docdZ2N2mBKonHWC4gp3/uMJK0fPOUF2mwMUGmsbCL6wzc1+cVLUDY4e7aMPq9T9QlrBPr1mj/vqJ92SUU2HV1JXtxeaQpFTqanY+3pRvT0NP4dwSOSUgr2Zhn4rWNNMq1eR3e2d7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762770; c=relaxed/simple;
	bh=1/IMZi7laPDns0FaC9FTXouqX/JlqimdYvbBnru5FUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ATxm4gkvX8qdwIC08IaSuy10d5sc99+nvDfYO8WaspDsQhYPjzGWlTpE+wzVON1R/vPa8ck676lQkCvoIoA1Sz9ZieEFX3+M7DpilbmIfvR2Cp+Du9AnBRLdGlc67gTwedMyYsKpdzrqcVFKlYsLD/yAt+InkRL2c6m04svFKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9mBKbI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9mBKbI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A171F000FF;
	Fri, 18 Sep 2026 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762768;
	bh=1/IMZi7laPDns0FaC9FTXouqX/JlqimdYvbBnru5FUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9mBKbI2ruUGsdiORjKJXRAMUctal6GC2xh6t5MhA9SvK3NDBwBwl8I4JyL/0ye/z
	 9OEAVgB/L/WqfaE8kynPhemr1MuJO7enoO89rgbb3pvIpr55acD7B8fNsTO4j2F8v3
	 aHCYiGbWHT2iP5oDnCcZ8P6zn1n48MyjIoJ/NC9haWSbi7xdkST33Hsu+2UaAET1iy
	 mDp6FW2aVh68L9ahWiFizjOl120e9rfmVU4OHPZYJCCYtV9VEh02AfAZUH/w85mjEU
	 lpEwUrV5JjxGQYjT2ffoYT8c3LlWBKmPyhYilZqdEO7woOLZ66acluO2S8ENI5WpQt
	 xsPrTN8jLQ5LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, linux-pci@vger.kernel.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Lukas Wunner" <lukas@wunner.de>, "Parav Pandit" <parav@nvidia.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "William
 Tu" <witu@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Alexander Graf" <graf@amazon.com>, kexec@lists.infradead.org, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Alex Williamson" <alex@shazbot.org>, "Josh
 Hilke" <jrhilke@google.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Chris
 Li" <chrisl@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-12-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:19:26 +0000
Message-Id: <20260918201926.E4A171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
>=20
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D11

