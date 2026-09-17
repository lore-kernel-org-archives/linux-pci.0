Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095B32E13B
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630014; cv=none; b=R3ZUrUumcn6MADm5UO7K7FOQRcx7/HzSX26PbMv5S1NQ35SQr9XaW4A9Fk1aELWUr1fi5ncWchT0wQ6rrIzcKcjfTXRu5hFbCz9F2mcrB/wh965J6lmTmfALwuy0qsTdtYC6m3f1Tf8ySkwx9VGLCQLVMrbHlFI5UQJYDQzm9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630014; c=relaxed/simple;
	bh=M0GTvpQeZgz34AGUsKKq84VJfbgoczq3q1FWfcvYkyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BkoGXPnIxdDGkbkWZpBhTMbE2QAhbu51pn7B/Opz1WKEePumXvort+/yOk0BLlNxSauQ6ccNTbVecHlwu3ZVPQh/ojBgn2/CmVpx5Jskc/pQLU5e40l9EL3nWM7R/u9DjqZVVKRJz896ozaNkBDTSK2xdlljDljZfKJflqzvJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+elyGze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+elyGze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B081F000FF;
	Thu, 17 Sep 2026 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789630013;
	bh=M0GTvpQeZgz34AGUsKKq84VJfbgoczq3q1FWfcvYkyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+elyGzemY2flK2YwuG8mEOWmtvbDTc5zYX9ingezPFDU1Nii0JHSFQJ3MUcJUlgW
	 qGTpglQjPm71pgvA5m4jlTwg8wWQhNXwANDhE4Ee3740pBLcZZl3DeHQOBB0zXx3yp
	 dk1Ccka4A00BdzCDXXUjb6mK6vXosg+Qiu2u31kEbeYED5WH+/lbaj6JqQLpG+NYtB
	 kZedl0/jev2VUqLibeDvARm5zbDeBSqfMSddv+bkJsWhk4ON4M3Y4Lrdil21nxWfa0
	 FAtDox75YtAYViHAWUV0yRGN4ZWpqzNb1ucXBFB4A59lE0ah58I1lJzBfefUMYoQeg
	 x3ccUlg4L7Vew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/2] PCI: Add device-specific reset for Qualcomm
 WCN6855/WCN7850 WLAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917071651.14174-3-jtornosm@redhat.com>
References: <20260917071651.14174-1-jtornosm@redhat.com>
 <20260917071651.14174-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:26:52 +0000
Message-Id: <20260917072653.26B081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Qualcomm WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WLAN devices lack
> working reset methods for VFIO passthrough scenarios. These devices have =
no
> FLR capability, advertise NoSoftRst+ (blocking PM reset), and have broken
> bus reset (addressed by quirk_no_bus_reset, merged for v7.2).
>=20
> VFIO attempts to reset devices on every reassignment. Without a working
> reset method, the attempt fails. On clean VM shutdown, the guest driver
> properly deinitializes the device via .shutdown/.remove callbacks, leaving
> it in a usable state despite the failed reset. However, on unclean VM
> termination (crash, force-off), the guest driver callbacks are not
> triggered, the device remains in an undefined state (DMA active, interrup=
ts
> enabled, etc.), and without a working reset it cannot be reused.
>=20
> Add a device-specific reset method using BAR-space hardware reset registe=
rs
> that exist in these devices.
> [ ... ]
> to previous approaches that failed after ~30 cycles. Device-specific reset
> is position #1 in the reset hierarchy, so these Qualcomm devices will use
> hardware reset as their primary reset method.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917071651.1417=
4-1-jtornosm@redhat.com?part=3D2

