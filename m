Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578833;
	b=SMijttJ1w8BSSiC6YYwkP9FkiSBoETU/YtSKGIwwjvYSUnxmuVMyZECAXBj9ZR8Ss757
	 2yPEuP0J+FfwZZrwcfLFDTE9GWjh0VJ0ErAcxOZppcmsaw0+nei2E4ys3+aXlh1CqM5G1
	 oh7B9y65qIv5j4Vd1t5CWHo1/g0mokpZyRThlA0dn38OdBA1Y1CjAQ96gTpzLztLUwDwx
	 xkExuXE6vRzOQxqThk+yqnS5CgqHA2fijPcEDiqoGFn+YZ0pH2ohOoEwp/aqS/AA3Xj2g
	 GUmLaEVrg3qK6Lr/Eq6sUlTFUajnXd/i+JOY/x/nhTqOsMuqdMQqJNMEzN8WvuJMaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578833;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9XYeCUzk14ZW7VjeAzVP7qBIYfqyCTUZR6h5hhXVv2A=;
	b=3GZbQ2G7CrJfjyJAEc5P6iqYaR6syp/+iZwB5K6bzJCe3p5Ll6QYUYlPI7BoaLlq2whq
	 muSQbUi4N2DYUL8VL+zLVC7y+VWclPzbHEyLgXfEysrMTtQ73okWA7kDd5HLSECjsOR2l
	 Ydk18khGQuy2Ic5s+Db6xsVFb3GI6PfrJvabcdDAK959oSmCE+3afd8tGkmYGHHwsmVR3
	 Q3u841aH30f4E33iJC3U4cZ1/lRBRnXXpJMR26ibS7DKLAvHQ937YRvKrav9/cOel4Tg0
	 TVSPPtGXBdmYw4fhhyk4caxEE9l9fjqDSlisaM6UdaK0Sim/rfG9Vfq/6WvEYf6/5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7MNDzM6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0197606A333
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7MNDzM6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E951F000C4;
	Fri, 13 Nov 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578833;
	bh=9XYeCUzk14ZW7VjeAzVP7qBIYfqyCTUZR6h5hhXVv2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7MNDzM6VmjuApfuBTxVXXD5b+UosKEbtMe24z5COT1r8xLS2RwG16D3zfHIWlcYt
	 zpttle0b8W2qUCCMnh8LfYCYdU5vFaH4vrdaamQjSv1zugjorfZa7UlvrACXX3wDdE
	 1JCPjswBo2qcWnEjvJ83juUEXi9O7PXqheZaK96EAeEhzzKvr93iBg3XTbuDKN0G+8
	 rH9qsJ7zav00trHCjnmQYofj1sIYAE4l0PlVD2wD3WcxDvtisB+N5T7vrcc41Puhzr
	 TR+BUAF2MRSUMlYRtz8FyJVyQs23ku55ItnaNDxvp92FQQ1WAjYlWM5Z8wLxIx40ic
	 Bmiw3WMnfp7jQ==
Message-ID: <sashiko-outbox-212958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/10] NTB: ntb_hw_epf: Use the shared NTB control
 layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-9-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:07:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, ntb_hw_epf.c duplicates the endpoint control layout with
> hard-coded register offsets.
>=20
> Use the shared struct and macros in pci-epf-ntb.h and derive offsets
> with offsetof().
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D8

