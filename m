Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A03C3F49;
	Wed, 15 Jul 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138497; cv=none; b=Rf38o+QltRUtuxlIQQDYJjWg+yHTpP5cEPcf1ttQzMpLPJS/c/twW7CWWLQkPYLhXBL9yhp0MZdgnL1HXWScoZSOEQ4WsdJbk2wKhwLr7KD45vt3G543jhxmugUqQOkaw14ioMkoigx68KBbLCATU70HkaPOGXPVlF4X6E4OX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138497; c=relaxed/simple;
	bh=fdE70EAdRHhtAUpJdVx33OumCfNiaYfsSJ7WMO6RdV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EGLw1rQOPWr7//zXK0gxuXkAyVohV7RQxDwR5pP0xrSycuewdk0KkDAKw+yLvzW6HHxAgTc90fHK+NccsquDG/mCDgXFq3akLCiFBl3RqZDLKks9Mxo6uXzvhmwJNS10GJmiiZGOyEUJ1e1dtf61egQ7PJmiQlWhcUOsQcmRwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK0eSJpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK0eSJpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD9A1F00A3A;
	Wed, 15 Jul 2026 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138485;
	bh=dp9YY2Z2mvKIeuvrp9uZXt7NbkRfiOtNxQLNn6A9MdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZK0eSJpUPToOXhCY8/Rpz7wEn32k7qxiUE91xyhp9bpqKZtf/VmI8LoC3CKk/KGM1
	 pph8gdGB4MoXrzQfw0dSEfA0rirvW1aCHVw+RNZC7xAuuzL2ynsiOunHnMFuZeudMH
	 SsMU7UOJ9XDnVGqKcU+PxRj4sVK1NhV8FIlmfSNiytDEC0HLZ6am9YIiZe6MGWJOdY
	 CDrVIPbx4+XnNtTbgzsDgoP82v8fGktbLsu+sEYBgL6g1hSXkEQO5ivebtKUGBDsUT
	 m4oZJVtn+F3c9qB2hRFRP6eS9eTXSAetqJhTMyW4t+KH2Mm2gc9604XfH7D478raCe
	 FSEEw0861KD6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260715174737.15287-7-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-7-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:01:24 +0000
Message-Id: <20260715180125.0AD9A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>=20
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D6

