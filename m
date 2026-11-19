Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127912;
	b=g9tr6lQg19BPKaAhY92j9KHjvcBA0rFkY/OLmH/YwSf1qkNXqbHLNKSQi05onmlkxncV
	 nXcFZ5uu2EguJ69IGP+ZM+eLUhCRUoJNNWQSeeWHW3RpQPveJpN0/e1lHJdRNBk2ncPt2
	 yNjTdsFMrAFUvOWDDMGr4GPgralGwk4SM14fjhtmF2z8qMn7IZ+Y7azd5IArKrmLtYM8J
	 ++/KBE+y9SuSGCvgEVOLv3lWE9HXEGzdLGm0u7Gaw5LJW3XUndGQLOMleumngH+UCMX3+
	 Td1TxrBYviGr9rcAXpfuz7mm9XjdRZWJUStezcuMKnaZljhX1NGuYp9os9SGsp32TMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eWJNfm9GtGG5Ubanl3qk25zMJ042O5sWVEAKnjQLJPY=;
	b=pl70+XC+Iow9Mvw3CyEVTRGjDsUVF/v5mqMi6/UOhylyjSTi4ioRsvxeMUMhL85alP9a
	 yY0VcKbupQ8tC3IUSHkTGuoFBoshKHvzR6cng0WClz1knVrpGNuH8t+TvpiapA8x5tFk+
	 kcQT31psCvIdP5HlRt2GqE8kv93fncj68lv1nCCiwJ/RGo8u81DjIl9xer8UliS9U1ZKe
	 u7cr/mtZXdQErCfdGezEwOF1tIdAx/5IG0i5qDMJAsnVjpVivAEU5aBoAY7fDRcV6V6d2
	 Wjfh5vzkPVdpJOKaPxdPPNyzFdPFKHiFekDv4BcxFSyRcSEpZAPBLi2iawR1YRRgCYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBCXgTzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC21606A325
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBCXgTzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EB01F000C4;
	Thu, 19 Nov 2026 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127911;
	bh=eWJNfm9GtGG5Ubanl3qk25zMJ042O5sWVEAKnjQLJPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBCXgTzdXOi/7DOeX1CsqbC6s08zU0plDgVxTJCBLg5OOqYF701jlXIfu3xyeqrtR
	 /XbYvyEwX4oJ1ZuGw0y3FDlJgHpfBC/MDy2mVQJhLvFYyvA8kNpcB1Rjd7eyNImyij
	 Cm8HDiOQTIt88OCKXtzBCJiHfEgdu5e0Khuj9UaSsvoSg+BnBtDNxCIBcUU6kX/MIJ
	 dDppknI5UtdlK9CvjjmUNhfh4em92yMtJtqOnzOD1Zu3oDzcEBX5b4yPqOAH8IidpO
	 oDGHKq4YUdcH+2Yd3w/ElsGWahoqAWO3Whd+07LmUByZ18rxvat8Le6AlIJDZp0ulx
	 w0at2sll7flYw==
Message-ID: <sashiko-outbox-224141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
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
In-Reply-To: <20261118223704.3286085-7-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even when
> pcibios_assign_all_busses() is true, e.g. with pci=3Dassign-busses.
>=20
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> Requester IDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
>=20
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> global policy matches the scope of pcibios_assign_all_busses(), and
> [ ... ]
>=20
> Make PCI_LIVEUPDATE depend on !CARDBUS, since preserving bus numbers on
> CardBus bridges is not implemented.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D6

