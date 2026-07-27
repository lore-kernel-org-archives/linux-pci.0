Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3D42900E;
	Mon, 27 Jul 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183204; cv=none; b=GgJrFaZbmK51+d4nRRdl6uWtspbuN/MQzb3U17mCM/xvEy8KEz4jjij3rlkKqzx/43hk7qwU8AB5O5VYDSfOMsQQfSRRbgQ1vlYinUWBKy9Gh8lukVWx53frvi5ljYZGnWqt7QXMmVOSU3GmxsmTJK4LBnM3/zUIlBX5h112Jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183204; c=relaxed/simple;
	bh=oVuQ8JKZ2UKzchTuXDYL2Nh48mAjYsInjeHRZx4vrCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vDXvCppI0i7gqk884R9hTUTBwKXsHcM5Waz3Li2YmM78tnLdY9/T0HNbbPQgB/q+FeU0nM2s3J+KHc3MAb900Qdi4sGY2V9j4gqxiO52EnGmePEIOVSGfy7K0I5Ng5SDN2w7COEt/8AKclOFh03JAmNwgrdZPHXIoyrqzHiWaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUxMRtqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUxMRtqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A261F000E9;
	Mon, 27 Jul 2026 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183203;
	bh=oVuQ8JKZ2UKzchTuXDYL2Nh48mAjYsInjeHRZx4vrCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUxMRtqxDOVdGt1QvKs5j10zcsF4SGlfjz0/zZFjTncsZAtxSANoU7S83ufSC0+g/
	 I8d4Oegr+D/lKzuxeOZo4ByXYCyiTT3TCVTTfp8IMEMysHIynsRD/785iWoMklx6rx
	 IgDJikgv6PKd06W+Qc2UzgekWW9XKj/tdP4qbsrHw4CDAGxEFNt3KUPFbRdiQPLDOh
	 UGpmURzwNRfYYd7AMukKvz/IaeF9XcC3WnhdjZuQnuLCBN027UhpHf0h5CWvdJq8C6
	 IpI7JuYuoeqR8Z3sIWdd0h48Ih1mz5PQ3jEkfXT+PDEB96H8FoGHCJ4he8TmGQeSGK
	 PVK10VRO+Nx6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/11] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727181526.9672-11-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:13:22 +0000
Message-Id: <20260727201322.B6A261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>=20
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D10

