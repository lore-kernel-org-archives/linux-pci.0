Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305660;
	b=AMSh+7Xs+9oAWfs+NRpdmrf1fg5v5xUB/Ko6HdRAo29cMThKbCOlJXtSURobprs533ng
	 rCNpkaM1yF4V6KJy8G2kGwc017fXSXuQlRlUu+Mg9EA7VD6douJsaI8rjMRM+8bvrvb64
	 S7ix0JViHZs+PL/dMIeKec/YkASZv9LA8cy5xxxqFTViVCs1dHb+gJOtjFVbIX6GERyBH
	 PurX2xjeRyC6pcks9skGYr37FdnbiTuALXwwHDCBY9fawU0GMDbQ0Ul6+nJgIXXUwMAIx
	 +WBifkhKxXQ8MPd1xW6OzJkrbYdJmdwVDyCd8S/si2vbqMAwnLN60bMBWoANl0gnjvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KMew/2HL8su61YsQxFTN4FlzslT9EavsQHfkYgMuKnQ=;
	b=tDHzxOPY5wIZZR1MNMEIgA+sYjUtPcUM4Bpf9sMDocuWL5gcskSO5UlnKY0HNtyRDbwt
	 a4UNXAc44w+ylyqedBq7VHXJYuX6PvbnIeYfDq5GhD9Eb/rfmJ3zSglwKjXKhdmTyucNP
	 5Mi1Kjg3r0fC8ONb6oKJ+zG+WmDBL01wRndHL02HUplrQ4JAO0MORcUGzKXtNSSeGbI3c
	 uFo3rZX+P6Lyg5SMZq+E+QqErjGqxzMZFM8e/OZn2qi1EGaGhxQvA2pidnRMW133k/WmH
	 FukUZJCpHp02Ls3G+cBn3sGuLhXO26pCb0mfg2KmxiAev1JystkWl9K1NDvzSxvVRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4L8J0Vg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F3606A330
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4L8J0Vg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF311F008A5;
	Tue, 10 Nov 2026 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305660;
	bh=KMew/2HL8su61YsQxFTN4FlzslT9EavsQHfkYgMuKnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4L8J0VgZm5zIUdMz1dd+2eWAkt+St3gfADRGThFSoSJrVFlBklpEw6shdqhbEKYM
	 3LcZx43/XKMgSb7CeKzWoVNMGREBDFsOnHVNe3/Rol5C+H3kw8bkZ3E+iy/0IQJ/dX
	 iwiUY3uac6ZmDpqtUoShP2xh6unoyNezjrjNh14aEpdP5YEv2my4oz0d6/Xg4oACIq
	 PywMIalDG9BTx3wH2EHyoVsxbgBxgo0CUax9QmYawi2AlgqjdwiYItDcMTB7+c32jm
	 0fa09kW5DoYXOlJcU29MLYfj4stth799siaJlc3H/3rnAdVmBawyVb5nwa2dVxDks9
	 IvZFEsuLH+2ig==
Message-ID: <sashiko-outbox-206844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: keystone: Fix device node leak in
 ks_pcie_am654_set_mode()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110100955.1046-4-zhaofeng2@cmss.chinamobile.com>
References: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
 <20261110100955.1046-4-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:14:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
>=20
> ks_pcie_am654_set_mode() resolves the "ti,syscon-pcie-mode" phandle
> with of_parse_phandle_with_fixed_args() to obtain the mode register
> offset, which takes a reference on the syscon device node, but the
> reference is never dropped after the offset has been read from
> args.args[0], so the syscon node is leaked on every probe.
>=20
> Drop the reference with of_node_put() once the offset argument has
> been consumed.
>=20
> Fixes: 7dcf07ac8867 ("PCI: keystone: Use phandle argument from "ti,syscon=
-pcie-id"/"ti,syscon-pcie-mode"")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110100955.1046=
-1-zhaofeng2@cmss.chinamobile.com?part=3D3

