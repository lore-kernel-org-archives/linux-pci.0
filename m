Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95537E5C7;
	Tue,  6 Oct 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315934; cv=none; b=Bk+bbGCaLdYboUjHGWovu30fClSNpn1+H1usNkB9ZbopYOtCFng4ySq6XoUYW5oJz1C8oy7dbedsy/+mvgz90+y7S1GjHix4TzczmROjJFN+lErDD5m4O/Z+Qi+h1lguP2QOQIkqk2ds9rtd+veDcxPqoWOTabmKrRqPXdIzF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315934; c=relaxed/simple;
	bh=YNqn0gYaXsauRejyxLAcB61hYEhWLyZYOT0hsAMFQg4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=evmc4ovKLIvTzGoGM1vTjuq6yITSaY88QezTK4kB6XdxpUbn4ZgGI//LIeME32eCDozmvIvDozc32zUAgfvSdxOEmHlRFh/eNkzVSIGdhO+/l9EUjK+NPbeDZINbJnbh+dIAl+s9oR47JgW104OoQ49clC1BKAN5rhFwG6cw0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBVVRI6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBVVRI6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E71F0089B;
	Tue,  6 Oct 2026 19:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315932;
	bh=t8Lbn45G3cGCuNatD1kB2ZtQaalzcgI14SeHJRG/PWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBVVRI6bP5zGR3M1pEeCXNSrTMEZjtjTWSH9iv1mYtaJmfxM1LL3G2dubqQUIdSj6
	 kBhvzOWeJO+BLDx1q8Q1qYNp6SeA1234JxGjsCLEywqhqp0QLxUSmo+S5Cl9urjjVH
	 jXLkCQWdjtxEF8bgfG0RvnWeZ/kR2Ln8sDB6JYQIaZLYHGU7pgakV5ZkSemESxooCT
	 QMEJdRMthGrKSSDeoRg/R+Jqzai6VsWUpRA1kby2kf/d6LEGkPpleMnDRDxzZBHUP0
	 vacjRJmCENxX+gbjf5EZViroKP5LG7CxDiq+AqGk8FM95ZRYzM1FWdAsS8EZSusglo
	 xWsryaWaDJUqQ==
Message-ID: <sashiko-outbox-162408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] dma-buf: Provide dma_buf_set_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261006193643.76330-4-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-4-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:45:32 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
>=20
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D3

