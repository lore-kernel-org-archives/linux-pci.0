Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5843440B
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989235; cv=none; b=DJ142AAN/MD1djOuLr3gXMFRcX5N5QhSqsoEwnsPmViI2THO3Nl+j3yjKK0HMLpcw7wb5BYiXImY3tJdHsBJzWXbG/KuNnZWvoDL2r+956EBTUyCiUzkspkCqkHTYrBbeSEqLu/MjgIlWudK1G4mx862AIZIzkQSYveBtazdERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989235; c=relaxed/simple;
	bh=z0vu0kEnDB+8UBzPJgSwvFS7h1r+pMvYBif+BXXr4RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T7KSnK51gDir7b1V7HNv6lo+LtPrOB50DGTB0WEvGqcXKRLz9U9o0vgqpoB40/soz3APFQPwc3iPzeZNE2kg2m/yhhlnviVzsKEtoTCSW0+y1+ry4FO5601BhmEreBiL5ObdzVMjbzgkfjvSgDiAIR+MAc+m27x/V7/iDsXThqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcdDZ4dQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcdDZ4dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0848A1F000FF;
	Mon, 21 Sep 2026 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989233;
	bh=LX4oYrS8lYFIbr7adLnZHEASATvsdGjZX/xQPNzeBG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EcdDZ4dQ9Vmq0htPbfIzWwNzYQa+bcT+2V2mYr9/uYSUGUOzPz0NXtVQmAazM8al3
	 rHNu2bv83o99OWm2PbQMDG8nPOjqzzzYFiyG1MSFapy2IYxOFxwUmkMtDmfu5Q2SR8
	 UgkiPePA1Q6Own/RetcZf9dHui2JrUQYml8CpLpP7yDlvbETV8p8Z0NTenAz0lj3cQ
	 yUtrtIl9QYhm9vA8nxRrKKieelNnS0p3/sN9elO4TmGbkxg25Ay0Nr5gqP/4H5IHpo
	 rXGwxv+YEPn3WfOPMRiVdD5JGYydauv0rv/uLQHJ4ZUmy30YsOwohL4kBeyg+DYH0D
	 AxRFUxTfpXGYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: Accept AtomicOps already enabled by the
 hypervisor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikola Prica" <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921111903.978687-1-nikprica@amd.com>
References: <3f5fb659-c7a8-41cd-91dd-565cb46c0165@amd.com>
 <20260921111903.978687-1-nikprica@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:13:52 +0000
Message-Id: <20260921111353.0848A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Nikola Prica <nikola.prica@amd.com>
>=20
> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no Root
> Port above it.
>=20
> In those setups the hypervisor may already have enabled AtomicOp
> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.
>=20
> After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
> supports them"), pci_enable_atomic_ops_to_root() always fails if the
> Root Port is not visible.  On systems where the Root Port is not
> visible but *does* support AtomicOps, this is a regression: prior to
> 1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
> success.
>=20
> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports th=
em")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921111903.9786=
87-1-nikprica@amd.com?part=3D1

