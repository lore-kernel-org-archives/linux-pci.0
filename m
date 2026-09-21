Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C74E01E8
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010814; cv=none; b=r6J4SXsPin67Hg+SewahMQyBonzdOiLgKOpWN+uf8qjoE8/8oif7udKyf8I10UkVCb03J0xz0rBZKgqHQmWCCLMW+6uKAZFZGPPG3UNNPkTDM4cFqK0DrFXzh82TdYgCKAiSjQLtERqvjslSoxwSfcWcObg2P4UvBGntbPnmwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010814; c=relaxed/simple;
	bh=Jw+LsUgAX8AowRD5X+Ezas4DgPchjvlxPAJfmXSDklg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHHb/4UaHxg6cKT1jsgcpS9o0ZF2cJApgt1Pwi1gcRIB6ysQUZ+z9mfZ0lVMOOB0BSqCRe9J2QdIOecEm3K082+dolLU00DB5qxSUGKqhFgBYkRvsQXg0nuAY90OyLn2+dkYLl4N8NTVmkp3vem7KnXYRvlN3Otmfa04Ido8pts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC2ehqPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC2ehqPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EFC1F00893;
	Mon, 21 Sep 2026 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010813;
	bh=Jw+LsUgAX8AowRD5X+Ezas4DgPchjvlxPAJfmXSDklg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aC2ehqPBE1WCwXnbXFpJTvczK2AcW4nkynjdRDo3PMd8HPgd/FYnChmp/tJi6ksRC
	 aoNfdY8idYdw9Kyww8L2Gf4cJSZ+HWEzn01PaH+yLjrkkOjepaj40Y+5pRtylxUyOJ
	 YB5Z1h+oZ6cbTWTvd96xyedy/hH+pbpazv0GiqGpekUq6Fmrj15Zxik2JU9mB68DXn
	 0VHrXqqgoYLJ/3rKKNit2O9SToDDRc73z+q25iU9f2CwwKqATWczEVnDz4aduP6YlH
	 zFkTxLYTSpnDgWi2K1/cHZrVqRT5D1+TSyqpY71BrP4z7aZ3VQgktrILilUQRPPr7S
	 FGnIBqGH2Lvig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Stop waiting for link status after config read
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921170646.1201148-1-yurypm@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <20260921170646.1201148-1-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 17:13:32 +0000
Message-Id: <20260921171333.22EFC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With a nested PCIe topology with multiple layers of hotplug, a link can go
> down near the bottom of the topology shortly before a link above it goes
> down. In that case, pcie_wait_for_link_status() can wait for the full
> timeout while every read of the link status register fails because the
> device has disappeared.
>=20
> Return immediately when reading link status fails so event processing can
> continue.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921170646.1201=
148-1-yurypm@arista.com?part=3D1

