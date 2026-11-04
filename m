Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814105;
	b=SJSuqOThTkyIzw05zdAO6twzgVc5Kxz47k9uGohzCxptqKb6+y9dq0sGIygUbxOevfN4
	 MmNoqsgHXtiaH2hw1GH9Zx1wykNSfvmwfOHsSqlwGaMBbX4YzD/uilJPCOlYiaLUvGaf9
	 plNrlYY3tFd+kcdf4gKQfQ3tBJnUvau4PnAOX2MH71owANGOcB2TfbBwFOuCkhiB0zuu1
	 nlxiVdCWfPcj6o6l5BjOqx8Em3Ava3QwUsgfbY167s1bvMjXV4bSasx4Rb9iREqbZVOK6
	 HTosHvfz6Yx/0Q2TMj4ehh0rdcLjp/Zh41sL7L0BxWFDmT22G/QkSmz1mOjTSy50jpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bfkzb2QuKzglkiohPmrIKmTHjGdvFugnKxuxzBL/4oA=;
	b=XcOONXEIoTy4fDd9oZIqfOjRDdHr3lX616t9oVmw43GBjrmTNMvdC0H5MXg9Jma62uTv
	 +EiBpuMXvz6AtiGdDKKHpC0uCSlXCSM/GmhDgf6/s7C+EMmEDHPIkJV446IUgDpFQacXo
	 +YmCxD0JNQ2wtqpPNJ/vSPXrEAZxBZBtXQaF6A2RQkzIOm44jztEUF6IBee1y3wqi98zA
	 8LibaAmQAb/1RJCvcISHjXvx1sAxE+U6n0Vz1KV9dotNyKVTVvmxLE+rqVx1u+BBcDfh4
	 tg/52S9Bx4m9DltN2JDMBuf8Le2bwgjGxqOJL5mVsz2N49l+MF3nfN6UAu0jGS/0KWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACEaC+lP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F2606A32E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACEaC+lP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3491F000C1;
	Wed,  4 Nov 2026 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814104;
	bh=bfkzb2QuKzglkiohPmrIKmTHjGdvFugnKxuxzBL/4oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACEaC+lP8pZkUgBynxGZHmS/LojRBEXL1IP9bmwN5+w+u+zBj/VbKNgeLvMBsiPdx
	 8OK3l1NBI4GqQMAqD/3jC/3p6EvwfmhmS8YrUAk35JIB/hsIFe4POSfCZmbIRikQ7W
	 WHoONp7ijW5GtHq/z810dI9gq2Zp+eg5xSFqvFqJvE0fuXwA0w9lo5mbk/vbJBIkou
	 E2BCsEfGEK0P70jRE/cBD4eD44CBv+4jTzQdIdvvsTSHzjJf2nEpoZdWl1HQgC9HfY
	 3+vPz86K/PiK8AmtITzaMV3gRZeXyTykIHT+dSdGoZOx8xEiswIfBMgsG9t15tWIt2
	 7mUczi4JGwjzA==
Message-ID: <sashiko-outbox-197778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] PCI/TSM: Wait for device contexts before
 removing a DSM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-15-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-15-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:41:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A PCI Device Security Manager (DSM) on physical function 0 (PF0) can be
> removed while a sibling function still has an IOMMUFD vDEVICE object.
> A vDEVICE represents a physical device within a virtual IOMMU for a guest
> and holds a PCI/TSM context for its lifetime.
>=20
> The context holds PCI device references to both the assigned function and
> its DSM, but these references do not keep the PF0 Data Object Exchange
> (DOE) mailbox alive. Ignoring -EBUSY from link disconnect allows removal
> to reach pci_doe_destroy() while the context can still use the mailbox.
>=20
> Reject new contexts and subfunction attachments once DSM removal starts.
> Wait for existing contexts to be released before disconnecting the link
> and allowing PCI removal to destroy the mailbox.
>=20
> As with VFIO PCI removal, removal waits for userspace to release the
> device. This patch does not provide an eventfd notification to request
> that release.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D14

