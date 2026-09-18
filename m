Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D665237BA;
	Fri, 18 Sep 2026 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762406; cv=none; b=k6MRFPHZM2dDCsnZ5PUJoVkUXJr8szcpCdfnSFfCvK2MUP6RGZibYdFSnroV+gFNqbG2ivuj9oTwCrIiF9sqHnoknLhENY0gF198f09zBdT7cfWgfi1w6SNKCaXwWL+J5yXgrOZftHC1Xhj9ShMPGMTG+wNfSycrYU3siHAh95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762406; c=relaxed/simple;
	bh=VhfaDetL1Tv74VraH8efY7aPfmn2/awy9/2560eVmv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fcy/S9uWm80+ZZtGO3EmEXNlwWYCzPe3xbxPfCNnp1PHEM62N//oV80KTeCaX6TEHW5sft4tLvFhysT2Y8B1swBTgiysK1XvFxXBS3SbUJYtCl28ygccA+8hcjTixFrG6//S+sDtEmkU+6RHTmbA+D1vNGJvHDkCXPr4q5RxOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2D0ixt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2D0ixt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987D31F000FF;
	Fri, 18 Sep 2026 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762405;
	bh=VhfaDetL1Tv74VraH8efY7aPfmn2/awy9/2560eVmv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2D0ixt7SdY2SGgfpEcGVOwKxPpgIgHPNI6fJUCb1pwoHY5HHE8zoEEH0BZ6gZ0Sr
	 /BLYVOhP6Rgc384qGqrFpI9J1eWiexKj9FFFE7OOVaVWGuXSfLzlcx6GiRyNGvcPKy
	 4pTmnFOtkzelPFI9uucqmthqaSz7i2vUFGBPExR8B3P314nvDmm0hPoV60RfbRZiq/
	 KVrhnvBPKXgTEYUxEALxM16oKhGb0Pvs2LZsnAlVm8xYb//HYPpgD5Wj+q4YgO0uiS
	 RUWCaziVH6ZMq/xt+twk84Kj4GNYrMoeQB7P4Z1wYTTCOjeai8ePTMey+f6kRDkETh
	 7EbFfaX3KZr+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-doc@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "David Rientjes" <rientjes@google.com>, kexec@lists.infradead.org, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Chris Li" <chrisl@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Parav Pandit" <parav@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, "Alex Williamson" <alex@shazbot.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Josh Hilke" <jrhilke@google.com>, linux-pci@vger.kernel.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
In-Reply-To: <20260918200640.887030-7-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:23 +0000
Message-Id: <20260918201323.987D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even on
> architectures that would otherwise always assign bus numbers themselves,
> e.g. when pci=3Dassign-busses is passed.
>=20
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> RequesterIDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
>=20
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> [ ... ]
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D6

