Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBF2C21C5;
	Wed, 12 Aug 2026 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510864; cv=none; b=l2HO8A7LieC9VjjQ/69g/jsQeELaPIrT8XjSYRFdnE45c+MVqp/Fn5okEBHxIH5990sJYfIRI4/NcWK1EJubyRkaKgl94/rA7z6nZf8USuKNY2Af8jBnSY0s03ITsbhw/UCFyBSKk3x5dfgXA7cs+kGYSoj5DnPAI6x7n5q1uJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510864; c=relaxed/simple;
	bh=ULrgRxotkV7qraicU9xSMgyOFyp5mYz+9UOwzpIJpm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXYeZUp4VfXwBv9Vxiqt7llUovtMQ+N7H5TK+P74hMS3kyw9orIvQOBq+Dc6ulx/tgoNvHeZOjNw9hZw5wkbb0zUaa6qBqFMbRdal/WuqJCS30+fssAfRIjyoyGxBrGZNkGkilZtuAUYy6tHqirhp/5GKpvURTKCOM7w0+UZCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3+z4DJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3+z4DJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350681F000E9;
	Wed, 12 Aug 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510862;
	bh=s/FGE2YV2zeq+TCiuvDAe6dwWDT76hbkVWDTQh1oYiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3+z4DJY7svBx8FIapXWzjsHDkvf9cem+6u1QKam2okTi7jbMnA7ZsvQR+eAQr8Ln
	 zSdQKFaUFQYxRQUYSn2SO8hwK1g8vM+XlmVqKK5lTSgJDUhQOf6ljKphKNWOyVQJO3
	 1n3kGkWjt/BDhR901VzQ+CMVLx60Fh0WBD/0KH4A1ASo70BN1B/Pz83XFVYb6nqAt2
	 /QTjI+sDtHmG/KIXBVMriANimIfKUAuvJnVK5r3Eo06tG56cDrB7hYU0DGd/USuYKq
	 bBe4Cpmg5iFb25m86ddjRgDW9ruLIXBSlToM1/ZCpDJkfYtLuMNVF6KfJTN1FWvFBx
	 R9j2kj0i3vMVA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260812045325.2733631-2-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:01:01 +0000
Message-Id: <20260812050102.350681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_reset_function() and its locked and try variants are intended to
> provide a function-scoped reset.  The bus and slot methods supporting
> this interface refuse when sibling or subordinate devices are present.
> SR-IOV VFs however, are not currently considered in this scope.
>=20
> Correct this oversight by testing for non-zero VF count in calls
> through the pci_reset_function() interfaces.  This test needs to occur
> under device_lock to avoid races with .sriov_configure.  It should
> also occur before pci_dev_save_and_disable() to avoid calling
> potentially destructive reset hooks.  Tests are therefore added
> to each of pci_reset_function(), pci_reset_function_locked(), and
> pci_try_reset_function().
>=20
> The __pci_reset_function_locked() interface remains a low-level
> primitive depending on the caller to perform such tests as necessary.
> The vfio_pci_core use case of __pci_reset_function_locked() is pulled
> through with this test.  Other use cases, such as xen-pciback, that
> don't obviously support or prevent binding to SR-IOV enabled PFs will
> need to decide whether VFs are possible and can be preserved.
> Additionally, direct callers of sriov_enable() that do not hold
> device_lock (lpfc) are considered a preexisting, non-compliance issue.
>=20
> Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812045325.2733=
631-1-alex.williamson@nvidia.com?part=3D1

