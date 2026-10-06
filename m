Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0E25B0BD;
	Tue,  6 Oct 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315950; cv=none; b=p0uf9gF1s0cZR5qpFVcpU3Te0/J5H97ccf7rAtxl/F++TnNuzg1llRLLRhKmd/0fDJ/94E1YLf648JrkCXzXxEzGzGYVnnKYJ0AEXG7npVeqcH9RSKbls2yI57xj+vn4JnZ6rWqEPTAdXhEUSWpBOcrse7eNuCglUFgid/ZdBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315950; c=relaxed/simple;
	bh=ciYOT+zr5zS2pzXoXjTgZzNbWEmLCg6C2Olumsg/j8c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C1uLFUhzKf6d9BC5qCWCRF+jx41UdmzihaqSPSe84n6eZWee3W8/jeSow7ddV/SMurSkEzoG9fCENMuUPW+8Ds8wOvfKJneCSCxO19AljAbDSqC6tahZGgRnxvkF4vPXvLwQeyC9gHuUOiyEy7By9VKDC+9GoKARXZP2IzqQDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLUwSEiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLUwSEiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C3F1F0089B;
	Tue,  6 Oct 2026 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315949;
	bh=0661RnsWRH8/eKZEMOCrA6mRAS/L40yAyutfVcaJQt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLUwSEiJTy/IVDPhpfMSdYRvT53pPhN6fCGosLf9iNpWa9oXDDon6JLyoJdL88JDa
	 KNefEzFN1cTVFGxBAJX4kNUkqufPO71uKu0gcO+6q6FIftXUy5ZHvAppkgUsXiG3O2
	 oEHan7EJ90nLLt4jWc4WDk0CT4OVt5Uy+rpT5O3p34mu35k94HrS8WLDaXzOn9ijAh
	 n8bCa2+rCJqwglGdJpJFQtURDcYJCgOHiSKTM4dRpjwMPrCVj+i4GQIA2Y2LYTDxZK
	 A4jw5ywI63A1aP0F3mlqC/eJ00pwZDbMc2sx+Ji9t25O1BGtQJfZNlF87tCyy5UwRq
	 Czv3IXjUzUYTA==
Message-ID: <sashiko-outbox-162410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] vfio/pci: Revoke a DMABUF on request from
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-10-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-10-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:45:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace the VFIO exporter's priv->revoked flag with a status enum of
> OK, REVOKED, and DEAD.  OK and REVOKED are equivalent to the existing
> flag, which tracks whether invalidate_mappings & unmap has occurred
> and whether attach/map are permitted.
>=20
> The DMABUF is marked DEAD in response to a new VFIO feature
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.  This passes a DMABUF by fd and
> requests that the DMABUF is immediately revoked.  On success, it's
> guaranteed that PTEs are zapped, imports have been cleanly unmapped,
> and that the buffer can never be mapped/attached or mmap()ed anymore.
> Existing VFIO move semantics could permit a buffer to be mapped again
> in future (e.g. revoke/unrevoke around a reset), but the DEAD state
> can never become OK again.
>=20
> This enables a userspace driver process to securely reclaim VFIO PCI
> BAR resources previously delegated to a subordinate process.  Using
> the new ioctl, the userspace driver process can ensure that resources
> are inaccessible when the subordinate is deemed "done".  The
> originally-exported DMABUF becomes unusable, and BAR resources can
> then be safely re-exported for use elsewhere.
>=20
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  This
> function calls dma_buf_invalidate_mappings() and
> dma_resv_wait_timeout() only on the revoke path
> (vfio_pci_dma_buf_move() originally called them for both revoke and,
> unnecessarily, for un-revoke).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D9

