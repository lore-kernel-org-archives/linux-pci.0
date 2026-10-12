Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F21306D2A;
	Mon, 12 Oct 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815645; cv=none; b=iNQJ1zQCcqjVVk0RprduTJbvd7it1rxBcIDO5eK9WKHYpYV/ocyLZ20ypNePRfzyMZK1I7ktiTRTCCE/YCBq+rM0sO5kkNzBAzydOgpEio0b4qoa5Uri/aNEcZ7Qe/aJjEvwTtqO56SvQ8of7WaFqn3ixUz/VmhqICQpuCh/AxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815645; c=relaxed/simple;
	bh=oRK44az5Ry09pTwkwNY9YrM2mYDebyciGJxhxGiv+SM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m6165IXvH5HX3AlE6IVdbNgK8fBUWZlR38fRtpLF0ORNTjEe0HWLzBSN+HQvCNrTSPDyrfVFDQ3Q7WUG+9rLDalu2GIIEwjZnrrJyfm2GjsaX1arCChNdH2NCrk3Te6ZXKXEEs0rvFgaKWRujJ1D3KKdM4m07FgcBI3W3Run3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLHEKrtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLHEKrtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322641F0089B;
	Mon, 12 Oct 2026 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815644;
	bh=oRK44az5Ry09pTwkwNY9YrM2mYDebyciGJxhxGiv+SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLHEKrtJMRFq7QMVq2Bq1Nzg+d35sKVsM6UpwET2WciNfYoqMKWbapNymR21/rVFK
	 hU+mqnG3j6nUVSJP88SoH6hzVx9GHSgetteH5w1qwNA1LWhVw1JbzgEQij0ejO112Q
	 HFoo3EIH7dzlmeWm1gOQXMjDwb4v1l/KJ6HKp/AiGXQgAyJTl8M6qeysqPbRrFbVIc
	 68LukZJ9t8DV/0GJslarYXWSKHScWvxWiH6BFCSrxZ8XEHmLp/dqs2Sw6HxAUck/VR
	 icOAcR857arRntbWPzEgrunbskFXhR7pehdyXJ38rAIcky7R9J6Q4ZU021zSdZxLIf
	 QyW3xruLaGqjQ==
Message-ID: <sashiko-outbox-168269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/10] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261012142826.159178-5-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:34:03 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D4

