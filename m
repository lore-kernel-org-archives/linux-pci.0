Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FD41F5C2;
	Wed, 15 Jul 2026 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138931; cv=none; b=XFPc0IQCaMDufwjriLGBGAzNYB9+PnzVWhgNi274WbaaX3B/kskznLz1dHhc3gQqqVkf+oI4JI5tQtdo5WkTn9Do5nS5neYO9oYwl2eCUIRBNu2CF6lmOA0U6pvEdP3K0UBgsZNrb8ruU6nlPGlOHLFLm5u+UWSIU7LJDMA1UYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138931; c=relaxed/simple;
	bh=l1y7113DF7l7Rs+6OfnVn7EnwfjFDeiAFOCdHirTt2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7mC159nDDHkOPDRLz8h/qcozpqhHfC8sGXnWwJLIS1ow+qPNJMwANlZ7g/Nb4CiOkwhuHwuJR0MvmETvK5OufCBfwKnVMhrFsmO04Rpijrjj34gl23PIhnN3/E3v+lDpQScZZslKXdTmSIMuUAJCq90QdSdy0qK7c5s43yQmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zec8rbCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zec8rbCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39101F000E9;
	Wed, 15 Jul 2026 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138928;
	bh=l1y7113DF7l7Rs+6OfnVn7EnwfjFDeiAFOCdHirTt2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zec8rbCoOHApi2RccjN0vTTzhHo5qLIHO+6AClHp+0G6So8V1aqxBj1IkpZrozx1O
	 QIE4NVk8pHFZefDk6Ly3wkZRQdH8sLDpEDrBlzors7XIJc5sWTnjEdl9ATidct8Mcx
	 covCjY6+jpOhgFpMMt6zKJWYymEyO8mHJOC8dcxpw4L9n4n8VyFr0FcukzxOo0haKJ
	 yNsti/88xw+kg4DLpoXWc3Jq1/HNshOeaZGlKPjZI+gg9u7m5EW8pHe+IkCLeWiOwj
	 l5gQ4Dg9N4lJ7aX1eZtqudY+fVZETTU2SpRMEUBkJse8IpzVhO/fGUZ2oWVHLyJNfN
	 WZNeNh5tzF8BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:08:47 +0000
Message-Id: <20260715180847.E39101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
>=20
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
>=20
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D3

