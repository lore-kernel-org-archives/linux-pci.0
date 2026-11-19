Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127904;
	b=RuEs6FwZ/HgeWqSX3Gs3iDWXVcYtyujDCbXnUIN4JfYkehk+jfKYYUM3K+bJBPNT2q4v
	 ud0VB2IC7VC5G3+Do25qoxUwG9UdNI3/QDhOrr4ACKQNNZc31kROS85owvijR/adQQJii
	 8Np44EakVnNdI8k4D3BLFeVMCwIF8w1/10ZFaWEkI31Z8JA1pQUtrISHqI5ifJBTKQ9yP
	 a/INQvVoEfvzwhxf1g/zjvMRS9akCTYF6UrGtRGDfUVhKRfDiigdhmyEgbc+M7vpJJUD1
	 qiCb7+6GnezWF42Yk1ZzwoobbJqkguWpBcMeT6l/HnZurP9uSVrqoj/Ye8t92Mvgv9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1+RNy9oxoDsxpp6WXRjzlfZE3yU9o9x54If3QAxT2VI=;
	b=sTjCTmOZLV8MCLgpN1z2nRtT0snTZOzkju93fPQmqCBW1gG3O15honhM62yPXtBONYv9
	 I/FDoMYZjjyOhw6YChslCfoW0rCah9DKn5HkRNbTadZU4/1myvyfJxZ49WT/dKUGlkRQT
	 m+8by54IM9XA1+8cOm31siwxlvD0ZhiLV0HJ7YNi1PEzbGVeQ5UAhqoT1PX5l1Dor6ubX
	 2KRR+vKveKTmxvnwjOpBtTkakjNLHyga/+g/7WcYTLkD7JZmHkBEr2IGNNsPBr1pTk2q0
	 41wIR6yRWP9TEobkeMSrOe7Vh1dgUI0kL3k69jS0HitFDCMZ1t6EoPiYJeVPtk4H8QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq3rUd03;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D9606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq3rUd03
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363CB1F000D1;
	Thu, 19 Nov 2026 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127903;
	bh=1+RNy9oxoDsxpp6WXRjzlfZE3yU9o9x54If3QAxT2VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq3rUd03WXo5+Sc1+LxYuw14FftGuhT2AYRIxmIuvn21cysfkuX4yo2/308fLikBJ
	 wYQmaKAAQ96FcJcjkwUYXuSSKcjjAT9YJ+fSW2V2HbS8nWvhIcLLacvVCUgH5J8WnQ
	 nh1UNrCLW4BpZVH2dvUV0XTSQ18NfttT5FRkgILBvbmOxrEVB5acDGDYNREoCnBBB1
	 jshDQejYCneh7jlpaguxFgpBjZTwewaLb21YHygZ2fcegIF3bAxrS1C+5FJSmXiufH
	 jTZEmphQ7cd7/vI+VZebqt/w2vr7gtbSsKewoSJtnVOdWJaDzAmeLf5pftxHrjLOry
	 JbL9XG3BdwK8A==
Message-ID: <sashiko-outbox-224137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/13] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-3-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

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
> Later patches use this to leave preserved devices running during
> shutdown and kexec, and the list of preserved devices is handed off to
> the next kernel.
>=20
> Warn if a device is released while it is still preserved.
>=20
> Panic if any device is still preserved when the outgoing FLB is freed,
> i.e. some driver failed to call pci_liveupdate_unpreserve(). Freeing the
> outgoing state would otherwise leave dangling dev->liveupdate.outgoing
> pointers behind.
>=20
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind a PCI-to-PCI bridge).
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D2

