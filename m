Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377816;
	b=vTORS882LjSM/8Br4rgT2zX1B4MUyj7a1vtRsfCIaxuiMVEmKEh5fWZeMip2OhmxNUNV
	 qNDu0uKmVZSbkhCV/UMYnqJ6k2mzmjNsGlDfi/WRL7d1e55vCAHERLTi7GWgM1r3ZAn8D
	 7//2dOjrv99lBThZ4L11s3JyoIoG/BqxYdoxw1pUi20NefITpgNbeK9Ga6R0T1l4yNKOt
	 2XiQTuvN76u6i48TzZK72HRURcbXAw62CVFeIt9w8l9k0SuAUjlRuYExxdpkErnsSpUfs
	 98YkqDwNEhbVxGSwz4y1wuLusOTq1mBYhEWW/4joE5pJM3RIuFyluqDftO7CK8Fol4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4nr81m0CCFrnfCaTw7d50pdtubR+mAckvrNfL7LXRKM=;
	b=5o09aJgiqdZdPnLmiJQ3ufxTVM2CTpakt4i8s3X7lm1eyO1HIaJY2RY3tzL5Gmq77TW/
	 vq7m31V3q4oCDWs7obrH04JMrlSG8QN0GppfSQe/hzVHFO9OCTVOSdemZwd3dj46n6IiU
	 +ga+QLkIARsL4UESVhM2Cnl/AlkheMndrgI+HINlwmgQoIPyv0UKQsKuc1WQRsS9EpdzR
	 8UsQ6Un09VMJKaNDcaglUV+FSsafglNF84oEG4vxQilTfEXkGA+0rkdHl+1KFO4GbSGqD
	 xBtgEEf3nOpvtNgVtkRo4b2xg1acKU9Vax4aUaXGFOI+40VMDijomL0PHinJAsKu9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXIEbjBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB11606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXIEbjBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910FF1F00A08;
	Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377815;
	bh=4nr81m0CCFrnfCaTw7d50pdtubR+mAckvrNfL7LXRKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KXIEbjBog1T5YpCgXgR8ETE7qQbc2q4ji9x8A00gQ2kpcAXvPFEzTKX+H4jRCjCwV
	 E/Y2lX2Fi3lp0By2dogZ1KUTqqEQA9yHYFBwEpctpXduk0zczYo7LGaNxBJ40V38DW
	 9pVTN1nwtK2Y2yyCtMyiVQ60PMR2aMz+d+aXs9klalrn6O1yJV80OYxErFDhFPgHYd
	 l56OZjdRHCJAKsstpXLrlJmyf8cCk94rBcmIJKEIyjcVVQmMsh+KSmgt5tpcNLe/D/
	 D/724RXGgwQNNhaO9WPWPe2/KxS3aHxEHaXo55jefaa6ZaJiXaBk937fJYW20mWLky
	 MPr2vmehoii5Q==
Message-ID: <sashiko-outbox-208419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct
 pci_dev_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-17-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-17-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Precede each serialized PCI device entry in the PCI Live Update KHO block
> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
> Live Update features can append fields to struct pci_dev_ser without
> breaking compatibility between adjacent kernels.
>=20
> Mark struct pci_dev_ser as 8-byte aligned since its largest member is u32,
> initialize the device block sets with kho_ser_size(pci_dev_ser),
> initialize each entry feature header in pci_flb_alloc_dev_ser(), and
> validate incoming device feature headers in pci_flb_retrieve() before
> accessing the struct pci_dev_ser payload.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D16

