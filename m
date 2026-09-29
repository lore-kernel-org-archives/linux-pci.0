Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49293D649C;
	Tue, 29 Sep 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703955; cv=none; b=HhO6SrLy9ytAdikT3pLXku/YyvPzTqYfH7mUvHlwOWtDtnkcPAFYml/t04GMADBwJOgvLY5sODoMbVz9AtKS/ZNkj6sv8BQMebo1bQDwDgBYsFJF0f79t4cnFTB/EFKURg80vZ0N2wNCyy1iKLxvPAM8npJS+phhpv3/GB6G0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703955; c=relaxed/simple;
	bh=NtPy2jKZFg4Hyd6ovSeH00d1dv+qY2tC5wQpgl+MEFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ngdShJTtCmABfqHRQLO+Erna0ZnB8Ely6VrS8lZ5w0qcRm3f9nNsrFhWaSQWbXoLGtKB61hbHsHfBPEopnLYlp6QoZvBYO/32YHSgSNjG/aIzCgTXPlmWx2pMGHKbeY86sJ6mk3P3Hba2Qw5AKduv8FLy0SpTg3Pa9G1ARatPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8JwBuSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8JwBuSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D81F000FF;
	Tue, 29 Sep 2026 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703954;
	bh=NtPy2jKZFg4Hyd6ovSeH00d1dv+qY2tC5wQpgl+MEFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8JwBuSzFw+fgpUtMA+t8JFTUJ5G5RY5HFCQsXaL8lkn/zp8bF48HdRqLxd/c6O8i
	 7wRX17rGTonp0OdxGpPUekaEgmZG94QtzUof6Vtb5b1S41e5sItZNdrgYbZ0o5njkD
	 21U5X0a1XDBYrooDObuLApuK1gsdi8oGrlyhgAuwWDFLgoa/0dzzrJ1f+14S7nRrkG
	 NugmqZEV/fVr7jdyIBiHbN2IbI3qryDPt0anRFWSaUjMGtBd5DWc8QXaXqzfowonQ1
	 wC0X1DrTf6Tu3XIsCJjMj0OuU5fa7oO03raxxhtxB3fGml1wjL7R7yZmt5r2dd5YYA
	 TObAnZ0uF5g0g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/16] vfio/pci: Quiesce INTx while access is
 blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-11-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:45:53 +0000
Message-Id: <20260929174553.D33D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The INTx handler and unmask virqfd can access PCI_COMMAND without taking
> access_srcu. Check the recovery state in these paths under irqlock.
>=20
> Mask pending INTx while access is blocked to prevent an interrupt storm.
> For shared lines, claim only interrupts identified by
> pci_check_and_mask_intx(). Record unmask requests for replay when recovery
> completes.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D10

