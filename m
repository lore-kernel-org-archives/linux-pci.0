Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441371;
	b=B2ixnGPy/tRFLmLnKmoKQPtNaDLGpsEzwUyT8WKXdY4vhIKOiwFKvA5GtoZ/17Q0wqcI
	 XbSDw1Qy//7KP+MLEBcWL7vRpm92EmXo4omSezfCvGPqFoA425UoSEcjez71B6oTI2DPf
	 Ad7ZUGnf4KhCTK3aaL2V3sl9aTKAyDgYEIyrk6mZvsslsGr/bHQmEsSYOYSk7wLBOjrAF
	 swvHhVn1oq4GMW3L8GFYaiTrM453jK2LAi+Uem9/OqtdBIoVoVjsSy8GoxxWzTUBeJqld
	 sT6RVBPq9SxfyIhOkwy4S/8tPuT4HpRS7qrSP4PGxMJ+aoIlQ23N4TBlk3ewjnw+Dnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O/r4avUd/LY6cENhcxpc9kw6fWzoPEi5dIjFeMSKMws=;
	b=Fk42zXLJnDDMWLt6QVNc+WeBZWRQRnXRytB/PLM40UetzkBB7hIm1fOemZUeCZx0CE0U
	 8E5Y5d/cWwVw01F9djyJPN97s+SUG62C80c+Mu6ya5H8i+/Ok/Q8M5FYn3Fgo2AMvYlh7
	 urAVqBweG5PGODM9s8uFm1l9EhNK8/Of8jsLT+sxLfhWAk/NGldYuarQIcmEF+O13LWut
	 JD3ultO+YsuKdXu2Cb7IEsMbEZiEO9ka9Y9pCH5P6V0MK36It024nMjI1pux7Jz0xKJeC
	 dQDQvFSG/rZW2ntytfcQbEfGARrRBazCohTK/txzIg0t9Sa171C9L6/g9/fC7sXl2JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoQa4hdm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67761606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoQa4hdm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2111F00A05;
	Wed, 11 Nov 2026 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441371;
	bh=O/r4avUd/LY6cENhcxpc9kw6fWzoPEi5dIjFeMSKMws=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IoQa4hdmaPPFzPkvi1lQzfq5yGaHoOiUoIBFXH1L6e2eZQu7hQ8vz2rSnWHmwITtX
	 HO623sheNeTYwqYDzGl+B896Jg8sx8+nnAVmsAQ5k+xXBvnmIrstsckkqQA1jNq1DE
	 lTGDBptNlRm8oSPQK7A+GC2sTWhrqoShqRxQchwko37uvMW5gRiHNHaJ8eDZEuxRuL
	 8wlMtj4wa3tonRsZAKMySiLxtD8kv6rLpicamGqvQ0iPWCoWceM8NNywLDJswnv1o4
	 nUlt0hfFdUSQcJ30wC1SQScj7m247+GOVQhxrNvtaYgg/i2xdqolLzQI7MKZyv8AOb
	 2gT2of+ZFROHw==
Message-ID: <sashiko-outbox-209870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/11] rust: pci: add is_virtfn(), to check for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-4-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-4-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:56:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: John Hubbard <jhubbard@nvidia.com>
>=20
> Add a method to check if a PCI device is a Virtual Function (VF) created
> through Single Root I/O Virtualization (SR-IOV).
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D3

