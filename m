Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445097;
	b=s2vKOLyGuFM+KvVu+c+ivaFwnjQ/bQK6ibiVew0TjjicYj3eD9bbpDP/+im+jWva/0NY
	 mAYeqWTapL/wLWG4ESNAnaUn+wab2JTJuNEfG0zxecFmuVQZGAILdTIGbF8ApYlF03Y5V
	 h9JKmOQuqfk9qxfVqRu0Aty9oaAC7V3rYjcl0WUWjXhnXlu5gkR0YsWwpMgOaCzwE7ZfW
	 yYGwu6r2gQenMzKSV5x1sByW0Q4w9YNg897Zg+0actsM9FVddNpW5kmgFcwFmgYlDTs4C
	 nUHRDJCcJWlDmxKkF4Q19XoosczQ3zK/ZgS5iROmQmbrIY8zlswhQMwfuKhYCSDWJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hHrQivxW5T3a7oRj7V0wGHKLLWWqowcM5Cnk8v+7W0w=;
	b=GjuHKPg6T/OKezs6RWoBQjGyCA9zu+WNHPlOGTvXKvjsrlNxNNPoi2AxM07E/mhO0iXm
	 KuuqDu8R0ktOzUGlrpuk8L5ZMzbeLamRFb1zIBn2DSr5nj0jckcGkGzY/NI4CxFVPaqm/
	 VbshfM0t0niV5sQ5ZYaTca4Pu1BzplPPr37l8fCqn308B7YsM603Z06pe9DlZfcXYVrUV
	 yqxW325rRI82aXmthG5xCtRxhQ2+dygMF6RzLFRDqDJH7NjzIUV1MC6g0XSva/Snh5xOm
	 e6UGoUqgKDgeAnHaY7bjN2PgsA9826+nq3k+TeYG1+KnOVfZ8q0RjnvtsMuTRhpvvZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYK8TyHX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF0606A321;
	Thu, 12 Nov 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYK8TyHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A492A1F00A05;
	Thu, 12 Nov 2026 00:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445096;
	bh=hHrQivxW5T3a7oRj7V0wGHKLLWWqowcM5Cnk8v+7W0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYK8TyHXz8WTPSuxa7BJr2GSOOoh5RGdQHrTAboAansFbS76FMtSHDKuxvdFhtpb5
	 MhmBsSyQgkbtcUQiGqP2lq5NnwctPyZyruAP6MjZQYT/MgY+BL3iT0JJZ3v92Feydc
	 bCB5shc09V0m4KC75kL9sacPuHk8UL/iY8fbgU0xgF6Omw6juk7LUG1UncY1c7vq+N
	 TP8NwXXFaTQAq/N3sukGn0m3nBivHQpVN3Fv76b3ekBekRzmyBTT8942H/iGCVadYK
	 Wp9pzL4khqY+h6hL3rUT5+ux2IIlxR5FpiDx5cuO+8NPUQfrWSi0oXCOcX9DB4xe8k
	 2PWGUummKMEkA==
Message-ID: <sashiko-outbox-210020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261111234439.4098-4-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-4-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:58:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. In Hyper-V guests, each passthrough
> device appears in a PCI domain of its own without a host bridge
> device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> against the host bridge whitelist, causing P2PDMA requests to fail
> regardless of host support.
>=20
> This affects discrete devices such as GPUs, NICs and NVMe drives.
>=20
> Add an explicit list of the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
>=20
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234439.4098=
-1-pavel.e.popov@intel.com?part=3D3

