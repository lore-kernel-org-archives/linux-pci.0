Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792268;
	b=xVRbRG/n6NUnhUyBrCRaH7L1wPHqLy/rzLXtQTiMA7Wq2Ha5Ip6QV34nU6Dv5BQv+z1x
	 oGgptG8ZSuvPk1qVupipLHX/WalLRRNwhrzop87a+pxG9A9Tjy1wo3a6AVtLOxpyr8Jll
	 87Wk4wqZo0/z1wge/xWOwc/lB+SG38BqWl/YDgSsMOSQYznMt4qyY9buLt8xMf6BsFJ9B
	 wv7GusffHyombNAVixpYFuxMcJm0/CF0NE15OFjkUVlaWC7cAKbO5/JAeFeMiwJJcvU7x
	 loegvU6HHNvJr9fofjSqq+2zu5VsubTYlFajiIDYkKW9PIocyej0xNoEEsgOTDkbWIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lFYn1lH1Cfyt/tjTkL/gzc4De+1k0vcS+wIdUcqaoJI=;
	b=XnRrmWZ6tjUo2DHNhb26xn1WmoEZXJYrjl6GPz9nY9fmgrLDH5KQNn+pZZJatiPbENG0
	 qXD8C97Wo7UltyO4eY5W9D8kZKOUK0Sq3HYvLZ+ch42wCvFq0dQrGtRupciWMVGINqkeA
	 7q0pG3Lj1i5sykGzfX8qNXjhbcv03ACym1RMgB1G6OKyM9Fpx77Cgh9L6ZEzN6VnIkO8d
	 yoKlZEy9TY/l7HSRJHdi/a9hUXc+Q9h5PFb6eEK0stmhoAQ7fdpvcJdVfI4TUw7rNi61/
	 9ZI0pY3VQa7O7L6cu6Y6jfUsc6vibQYc1NjDB4QRhqo69lMP2ryYLCJ6AujF90gJ5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkDTTG0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B3606A32C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkDTTG0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28F71F000C4;
	Mon, 16 Nov 2026 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792268;
	bh=lFYn1lH1Cfyt/tjTkL/gzc4De+1k0vcS+wIdUcqaoJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkDTTG0sRHkZ1huSS9M/yt7K0GoqOtQ+QJ/7N+/4qBW/vA1KLIjhtQSHtcbHgkjMv
	 wwSa2bH49JgYE0oSnlgsSiwzXgwa1iPW3U2Cfo+ab3ZyaSoubxIqaNmLZPgH+o8sOQ
	 ZzPmcECAgxEafqwKeQzHWs+LCJisbe2JjatOWIE4wdWZx8WaFH/DUVbwyk82tk73bX
	 0E5Nb/PCx5gnVtGILJ4pWz3izceGaSPdWR1zJzab56HKDYM52ocW6psoeddFYTSfkS
	 vmTQGkS5H3U6RP4Qu6FsE4SU+ueOvlJBKi+EwUDL1H0D0N1Zzyo8gbX2oiyFOtDyYj
	 vlvWTZPqxAZ+w==
Message-ID: <sashiko-outbox-215990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add quirk to mask ACSViol on XHCI on iMac20,1 And
 iMac20,2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116010835.1191-1-atharvatiwarilinuxdev@gmail.com>
References: <20261116010835.1191-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:24:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On iMac20,1 and iMac20,2 the Thunderbolt xHCI (8086:15ec) triggers an ACS
> Violation on its upstream port whenever it is runtime-resumed from D3hot,
> e.g. on suspend and shutdown:
>=20
>   [  141.535310] pcieport 0000:00:1c.4: AER: Uncorrectable (Non-Fatal) Er=
ror message received from 0000:08:02.0
>   [  141.535325] pcieport 0000:08:02.0: PCIe Bus Error: severity=3DUncorr=
ectable (Non-Fatal)
>   [  141.535325] pcieport 0000:08:02.0:   device [8086:15ea] error status=
/mask=3D00200000/00000000
>   [  141.535327] pcieport 0000:08:02.0:   [21] ACSViol           | Receiv=
er    | Transaction Layer (First)
>   [  141.535328] pcieport 0000:08:02.0: AER:   TLP Header: 0x34000000 0x0=
0000010 0x00000000 0x00000000
>   [  141.551637] xhci_hcd 0000:0a:00.0: AER: can't recover (no error_dete=
cted callback)
>   [  141.551655] pcieport 0000:08:02.0: AER: device recovery failed
>=20
> The violation is raised inside the 10 ms D3hot->D0 recovery window: the
> port's AER status is still clean right after the PM_CTRL write
> and set once the delay has elapsed,
> before any config space has been restored.
> The kernel cannot run anything in that window.
> The ACPI _PS0 and _PS3 methods were also checked and have no effect on it.
>=20
> This is most likely a hardware defect: the port correctly drops the
> message, and the same controller on MacBookPro16,1 is not affected. The
> error is unrecoverable noise, so mask ACSViol on the upstream port on the=
se
> models. ACS stays enabled.
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116010835.1191=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1

