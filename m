Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812046;
	b=xjNjkbmIqRB0aU0G/ApPI2vmvAbOB8awtW1Bd/nmXEVxfSuQJ99y5c7mW53Pcqn8x8NY
	 nCDmYBznSlThqsIBuM59nQPxB9yeQlHEV4gP+67EJg/DpacWfa8goVzByjujrB7AElUrA
	 h4iep2hdUOTOcrtGdeXNuJxLqDYRkgFLf0QmKD1OUIckPHKjNznShY2dk/br47HZTq8KA
	 nDppgv53mApXZILl94T4eXw/tCEZy3OM0lUmwmwBx/dP7M6DZ5OW/haEfiDoF8JiijeMW
	 PZC0pwQDfpT8puL92S2Kk3yj9f2pcMFKmcKC/K651JWH2f3duTytb/DM9oOYQPFCWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i0DU4mPu9hEmeqnwKvIctf/21LFeGXiiM6ltiQna18E=;
	b=Rbv58qhl5FCSrrgRcI/1QWR+HnODrcx8HlTKMy4+DJCIgc23paMKkJO1fdNC0lUI7hJP
	 DofrOXtQ5nZNIaQ9kcNmtMGSJ3yt8iz4bn3jvYuRUPhIjcnHq0HNAlDTrLHK0n+c3OE7N
	 OnexduT84VXiXQDvxGQl2B+7oFNKZ+PF1HlleZ3U1QHSQmwWqULgDZqHfGRgSVVfRPsd+
	 SSBZd2y0SuJZBl6PoujVd9wvZucEIA6JcLGXzRp1UhIRa1cSr4le1TBony0eY1S8n8pmj
	 wUSvE8FdUbR9OgyjQfLONqh9+3DMF4hnxH9gGnSoZrcrJWG0Urz1GUFlPq2rl4fbSCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V0/f4twi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB9606A32D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0/f4twi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA0B1F000C1;
	Wed,  4 Nov 2026 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812045;
	bh=i0DU4mPu9hEmeqnwKvIctf/21LFeGXiiM6ltiQna18E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0/f4twiPTHNjcwhYaeTlCTdjF8pnmQpqhx8nmk1HcIowphAlOmRA4Dw9XhZSw0kf
	 UPUNjQIrhqj5KZN9jz1ipqNa/tL0A5yX6LFxhAhYdNrbfzrLHVjQnPbOjUlaWLiiSL
	 XPEVfAhlzn9nR8ZvwBseqRz+3AziBxcmDeGA/bphOLVYyklt+CW7bznex/BQiAdoDL
	 C/pQd7bDgIjyTYGoYaCmntanoUB2ObUqW2bz8TjMlOzhfTPqEXxxewdfWDJsFxBIfe
	 8JpAVtz8UERx0x4DNOm+p474Z9/Fhy9/mJqo0N0v/IuS0tWBE5Ung9a1TznX6q+zpY
	 dnlFUuPyC8sWQ==
Message-ID: <sashiko-outbox-197713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/15] PCI/TSM: Add vIOMMU-bound device contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-11-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-11-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:07:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> An IOMMUFD vDEVICE represents a physical device within a virtual IOMMU
> (vIOMMU) for a guest. It must use the same TEE Security Manager as its
> vIOMMU. Pinning the vIOMMU backend keeps its tsm_dev registered, but
> does not preserve the connection between the physical function 0 (PF0)
> PCI device and that TSM.
>=20
> Add a per-vDEVICE PCI TSM context. Verify that the PCI device and the
> vIOMMU use the same tsm_dev, and account active contexts on PF0. Reject
> disconnect with -EBUSY until all dependent vDEVICEs release their
> contexts.
>=20
> With vDEVICE binding handled by the backend, PCI/TSM no longer has
> generic bind state to report. Remove the legacy bind and unbind
> interface. The sysfs "bound" attribute reported the state maintained by
> that interface. Remove the attribute and its ABI documentation as well.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D10

