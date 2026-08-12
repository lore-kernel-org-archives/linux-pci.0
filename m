Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DE386C31;
	Wed, 12 Aug 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510781; cv=none; b=D9JGaDzK+mx4WBtBbetDECHO1o11SlP+p5Edho8jvZcdT5bkpksmQ+XITjpDoYFzrtHf/WgpP9pySF7KaNwulRHJt97idb87EhjajcvGj3gwk/6eXa+aKW9ZorY3UTrGTU+fOwNB32X75im9+vWNmODeN4rwqfo003g4b6AUoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510781; c=relaxed/simple;
	bh=lMDU/gPpelUSfXISSk6xNlgzEQUFi6Kfw1FLRi+updg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W66ygWdzea2yra2MrX3zEI1tsqFzRkRI2D2TWSDnl7E/ALWLyUTBR2eV89TQNGMfhDyZKSJTe5EP4+eNPIishMv1UFl/CRJuLDDOv88/Bws5vRX3DJ1hKq84FQsJD+6n9TC0TVV4dOhgjmYZDjnPEBN4R/3EuFARin6J8Hq9JgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=druqKw3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="druqKw3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD901F000E9;
	Wed, 12 Aug 2026 04:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510779;
	bh=tMDtGzo+49EYbRaCpOAtAoS6IwYARIzSX80GxNB1UeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=druqKw3NsnzgOtN191pVMUlBSgXqarY8xVvUFWz9OPZ9ja5AAtT3FM4pqsuQDy0ZK
	 ppVGZK/ef1j9yA/GU0o5ijsiwC7fF6ac62fIU1GFUUSaBbZGvskp423RwLQsDGu8Bt
	 GCd0YDf7rvrhdzG5uvbVoj+pfAjsO6z+P3odimdhNSVjvOIVefe8j6a7l1VY1HKXGS
	 VyM6yVmwpxjX7lKrMzqnp+lelzOtcXW1UHb7epFMZ5jHYCBgeBDOt9SqKa5TTTOgOU
	 jKX41rA3r4aKZ2t5/mt5MW5dujRzB3x6Cfd03uJnbDFmiWnad0Gtz4KsZyemTRytgR
	 F2KsLXCNh+o+w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] PCI: Export pci_reset_supported()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260812045325.2733631-5-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-5-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 04:59:38 +0000
Message-Id: <20260812045939.6CD901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The success or failure of pci_reset_function() is conditional on the
> state of the device, ex. VFs enabled on an SR-IOV PF.  Therefore a
> driver can no longer infer through executing pci_reset_function()
> whether a device has supported reset methods.  The reset_methods
> array indicates whether the device has any available reset mechanisms
> and is not gated on dynamic blockers, like SR-IOV enablement.
>=20
> Export pci_reset_supported() for drivers to use for an instant
> snapshot of reset support.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812045325.2733=
631-1-alex.williamson@nvidia.com?part=3D4

