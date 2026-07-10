Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60763BFE5D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719340; cv=none; b=f0+rxmzYDCrYYMcJ0JHmVrbeZFxegZx4OFKdaedPX9TtMnFkAw93I0W6TBp3NIDxavbqVXh3jxFmGd9NHeQo+117MzvX6E16JcxeEK7U9Xt6DVei4JRdxJdpIP5FX6hpmVJMpf88jkqUndYEqO+yNSmE+QEWZLjwFVn5jWY5fZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719340; c=relaxed/simple;
	bh=bCXIlcF0ACZ9I1oSJT+lQ0op17khNiZa2tBKBKUUJE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PvFd3AY19A+eG0Ihuh26vs5PNAs2N0Zrg83xzP8RQTpcMFMqnavEFlovBoOBGZ4NVu/YmjhYnEKBcP63HMDWdlqfHHpVq4L8GnKQpSxEEU2/9sw5HXxlQT0gsMZltXFuRwiL8r6tZc3U/drp6t8mVgNPyVFqW4MZ894nLkh0c9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StJIGXAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StJIGXAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695D51F00A3A;
	Fri, 10 Jul 2026 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719339;
	bh=bCXIlcF0ACZ9I1oSJT+lQ0op17khNiZa2tBKBKUUJE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StJIGXAQjHyxXVNprojStMbOtVHRd0myRrgpoWs4BMFmTSM14+oTQ9xa+ZRBamucU
	 yQxF4BMK3DHyCCKW8TDPjM1b88+g1z0DHiQ1vpuWUzs2qCLgQCyP/PfNIgwJzh8/Sq
	 Py3Oq3IIvmpT0x9AWHKMS1uWdMkadXmfCgbSYU7ijqtdemHUZwuMjIO/88t9cg+55m
	 7vLC/nTBU//fngJVSHKE0b8MKlhrCx1qvdKDPbsU/iYC+rf+NcZ/f2X8AFg1k7zkJy
	 8JySf1wU1QExbnXtaDiAcAgMehNtcze5LNUnoFPZGzBLJdBtC3w/Q8Ef3M3Q5WXV+U
	 /WzSq07cWikog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-11-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:35:39 +0000
Message-Id: <20260710213539.695D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
>=20
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D10

