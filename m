Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA353EF642;
	Tue,  4 Aug 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872683; cv=none; b=ddQZOzX7CmmG3XA8o3Fe+eGzMsYWT4vvD2C9KuINvGRLowwlihIy/yL1orNG13PdiVfsjtN+awq6LIqeVK/Fjij8IA0iUR7L56j7Y1J9BzNj3zwJCRTHDXQOM0zL9hWF8PIkm4u6NNi3KmY8Py6OeRfyanGgZ96fpIyN5acFO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872683; c=relaxed/simple;
	bh=FHCGYgwM5duWEB/7hrlxca37cAVD/2UxCfmzsA+rs/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qy7Q6FRIRUh5/L6kCyJMCoUNkQRqWAhaT1BIO+tDFfzfU2y98ioRP05KIUzM2br8L9AsW4o1jHFmJD2Y8FggKvYMa2Rv8gXfJYWjDAI+SdEJIbW8rcvFMxlA/KbpfLMyaYcYUnhfLbfxxD4l/4Fk2xdKjfC1ZR9yNuZ3xdozSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfS7KvTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfS7KvTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCF1F000E9;
	Tue,  4 Aug 2026 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872681;
	bh=FHCGYgwM5duWEB/7hrlxca37cAVD/2UxCfmzsA+rs/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfS7KvTgWJ/KdKfciHqDLEx0fO3v95PX2gAslmsZTkxBt1CamBAdmur2e8udx/ioh
	 a8A+Zd/ZhrQEceLX/a0CjVfw/cF/Fg6GBLPLr8OK0Um2PiDcbi9bUqqBGKp4qHZ1td
	 lv40NMzBI9mmgWkQ3fsbgMD6Xy2XnFbAO3xWI5obVq2ToX4p7y1Dn0eKy5EBzvZ+en
	 QGjw/9cmn/WPHBtZA2Ltk8ePu0rRUgc8EcghuCGZjdqwIUkuujsa47OObK9Rbj3rf2
	 kOe40tIM4Lp3fMjA63D2eCef51mGw81NWzVbuC7dmLR0BApfbxzq6zucM6MlHFtqdw
	 ZR/ASaOhnFU/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/12] cxl: Restore CXL HDM state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-10-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:44:40 +0000
Message-Id: <20260804194441.96BCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
>=20
> Keep the target IOMMU reset block active until HDM restore completes so
> Bus Master Enable cannot reopen DMA before decoder state is valid.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D9

