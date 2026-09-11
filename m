Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBE3CB547
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170177; cv=none; b=ekjXFxd+i12ALg73tpHSsZar0luSPIM6+Yp69HpT3JbHYG6+kIBjZ1fo44PoJGClc4k7ezbnRwnMl4ocj/HX+fM5mmUH32yBTINS7YdysBj625Kk+KabUzrscJR+un0T8wi8dagTVExAWbCoHmMppLEJztGfLgvd6csj2PxtA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170177; c=relaxed/simple;
	bh=6zE2JbGUojfJiR8hmcL3+KFzNEzabAxueuMOlX3ODJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+DL6+m4AH4X5T3ysKAm1NfqyPG9vuJwPF9TJFFZafcMdzr/HznP1Je6L2wAeO0Ddh091NJb/rhNfYhFXFb9c4fmE9PqwUfYRs6JfypPvSHFLfEoHviSf0gE+/1vNXnG8yeJffkCQXWnvBfzGkYUBa8kNUY+mJ6JUcFCameJAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjrabq+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjrabq+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73141F000FF;
	Fri, 11 Sep 2026 23:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170175;
	bh=6zE2JbGUojfJiR8hmcL3+KFzNEzabAxueuMOlX3ODJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bjrabq+dxKEVPyD/b4PIa5/3/WXePkhCiB8Si3OHXl8f+tUanH+AtuInI08PwJEWM
	 qKcqI9Nu1rWIxg8DqH76f8x5gN1SDY4gaSN6dJORDGMM4B3c/nMjAjEnlmc1JWWBWA
	 GrMr0Fj7u1EPYAc9BQJhieA+1PN4DEJBVeqnvjFmwWO2+HHMTOmc9C0RzL3o1m5Z31
	 zjE+Jcfh0ohdImzKdizk4IWocTXZMKuVimpViskipbPWYZqqK64AzK36TOzbjNwzjX
	 RYgKM8n0MIHNthtmmM6I2UrveYiWnlDv/BFx99hCY83Nu8vHfnF6WCtP9p4vy6PR6L
	 82qLDOx3EukoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] PCI: brcmstb: Declare and assign quirk
 OB_WIN_32BIT_ADDR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-5-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:42:55 +0000
Message-Id: <20260911234255.B73141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Even though only BMIPs chips have this quirk, it is more uniform and
> readable to define this specific quirk in which the outbound region must
> reside in the lower 4GB region.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D4

