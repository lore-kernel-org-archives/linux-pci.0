Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127925;
	b=cQj3BhNYHyrZ3zyFMrvbua8G2iNePpgeLTuT9QbNalJqpjcudynTkeZoDx7J+hdfar9K
	 0z97ObndQE8op+5NvA8Q0vInrx0E7L1h2qQ00QhL4GP1Hqq9gKWM+2uDoTQznwO1YG0BF
	 jIi9hQWtNSMHmx4YJ9Cw5vXWjwoJ27rt+iCPLODQrUdWUUeoVjwevT70mK1Yp02VoZuwJ
	 VbwnahxjhGmq2znz0ek0x//oxa5owDwZY8uMbSCt2bhbMV3G01/D9rMOkclwyClaB809s
	 jVSA+kq1dFl/EUm8M0zczv5uXZr/OtPvytGIeO3wnqbV17a1Mj0FPEocOYZAqiTvncA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oub/Ol/8+MHQZEeLyeMANUxv5ii8PId82e+apI4K+qk=;
	b=jER6hrizVFPT2BWu6j7V0r03RxgD0R6+rWHId1pFQ7iL6S/oLpbJDKwWoXkuOnjPAxjw
	 st82wJZqoT/eK7BA7t7y7EVMvf5RNku+W4sort259mKSNws2mnCpQC2qRYEWBaAUv1q80
	 12CQ+/+bN/PuM0HFdCKC4YHiEWeZRc9tyyGf8H1ZUfLNclNtLIkS/8hymLDe904xey0DM
	 NIhdZri6DfsnQUZEhBIuFSBdRYALRH2PZVGyvD6tBxZXWnQCZ9WXPB6U+sD9qlpnpdaWo
	 hek94BDDDhF89ADCzOpHNU9HYcnqezckjnRUAJawvdZo64Aptp+qJ+cbMVJoPND48ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K84lAhix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58443606A32A
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K84lAhix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7FB1F000C6;
	Thu, 19 Nov 2026 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127925;
	bh=Oub/Ol/8+MHQZEeLyeMANUxv5ii8PId82e+apI4K+qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K84lAhix8cpsbsDJfvQeFZGr+Kk8Lz8wqX8LsgOt1bVOP+kEieFCct6YVOzjhHp7x
	 OpyQVrxppkAYDnQubFP54zWqkFntRE+SzwrlCoyTrb6gIfcBHRgyAl9fNELbzT9wIP
	 6f9ZdkqZ6lOgxy7x4VJM1SJ1d4POd7ZESTcYetGoupVdU2w1on2fb0QaqmkLBOqhtC
	 TKbTLWHkGCIcLv8A0bmo4qecQBFq9m10SQYtCJ3KEVvJEMkjG4sq8l96fdqwsvGenS
	 Y6q1K78HFEyAwsZkjf+8XUozb1Vkb18oCul+Cu3Ve0N4JuLuM2KR6sZBu2CYgu1gIv
	 JK4CKeGZzvC5A==
Message-ID: <sashiko-outbox-224146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
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
In-Reply-To: <20261118223704.3286085-12-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] pci: liveupdate: panic on session teardown after
  pci_liveupdate_freeze()
--

commit a3120ec70b92ea26f3e1d92d3bd0d1531b5a73b6
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Freeze preservation status during shutdown

This commit freezes a PCI device's outgoing live update preservation
status in pci_device_shutdown() so that devices cannot be preserved or
unpreserved once shutdown begins.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a45ad86370d5d..e26d2f5c2338c 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -520,6 +523,11 @@ static int pci_liveupdate_unpreserve_device(struct p=
ci_flb_outgoing *outgoing,
>  {
>  	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
> =20
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Can rejecting pci_liveupdate_unpreserve_device() on a frozen device trigger=
 a
panic in pci_check_all_devices_released() when a Live Update session is
closed during a non-kexec shutdown?

Unlike kernel_kexec(), which calls liveupdate_reboot() to serialize sessions
before device_shutdown(), non-kexec shutdown paths (kernel_restart(),
kernel_halt(), and kernel_power_off()) call device_shutdown() ->
pci_device_shutdown() -> pci_liveupdate_freeze() without serializing Live
Update sessions.

If a task closes an open session FD with a preserved PCI device during or
after pci_device_shutdown(), luo_file_unpreserve_files() invokes the file
handler's .unpreserve() callback and then unconditionally drops the outgoing
FLB reference:

kernel/liveupdate/luo_file.c:luo_file_unpreserve_files() {
    ...
		luo_file->fh->ops->unpreserve(&args);
		luo_flb_file_unpreserve(luo_file->fh);
    ...
}

Because dev->liveupdate.frozen is set, pci_liveupdate_unpreserve_device()
returns -EINVAL without decrementing dev_ser->refcount or
outgoing->ser->nr_devices.  When luo_flb_file_unpreserve() drops the final
FLB reference, pci_flb_unpreserve() calls pci_check_all_devices_released(),
which panics because outgoing->ser->nr_devices is still non-zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D11
