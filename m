Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649036;
	b=hdXsF+qgo4xrggvZuNkZ9IvbeyGplHpjQ7ja8Q5b5ZIf0R7eA+6B3G8FA6HIwZ7m5DxY
	 vf3m1nSuCeEx1msKHe5oiSYFxsrXVEIc04Wt9y6J83mcje3YTMH827LJMr/8ybFNTl8Vw
	 CiLgQ0Rxn2ASB3E4b8JbFgl/sadSGq+05BzC2vNNwmnTWFXk+S5MBUi0tAvO0a1BxWz1n
	 PWUbksBn5sSUi17raFrUjboBvQOf+SJd4ZTeGRsXGnrHl+b4Ju8n95ARsrkpwCet/K33x
	 fHmLR1UtBOckwueyZwq8pYZRSUw8rUjbYF2nr9I2CPWJojzayJeQS/2fNYOdV/NquyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qn+mF7j6SNhe03UpvtivWPJCsPiEFo+bpLK0/0sIAmM=;
	b=YbBz0c4kGLe8VneDP6xVqS2r9ORPkEahcUL02SpMSO5v9l34ONAJHtAEk99Oq4j3MXB5
	 U6dltUpOwOltTJAhgQy9QS1HgnuudC5pARRtasj6EUZ4dWT9FIr6jRY+M6RVEEDFOnK7l
	 6pnYpv6aX4z1Pt0LycVklsW+yyaGZSS83XBoQMHDH2e3cpv6PbvwHrg6EfoJ8ulkyc+yH
	 ZF9C59eN2xnhUEPgzEk9wJDC9zY/bdIdfwpCJHCPuVrUOqnJIG8nAfqiqX0o+OUCId/s7
	 hh6D7xRSVkf+eeUVNTRUCV5VhWeABb1K2frGIes4ZIKVim2mTeY379SHeyPCUyloGbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIwg1lNn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB1606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIwg1lNn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4832C1F000C6;
	Wed, 25 Nov 2026 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795649036;
	bh=qn+mF7j6SNhe03UpvtivWPJCsPiEFo+bpLK0/0sIAmM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RIwg1lNn5igQUznMtLiVLWXaohScAIdhn/ySnbrq4nQTr+YYniYrLVgYovLnguh0K
	 prjQZCIxgLfIHBXCS9GB7jfGBjlTLS5pEB9GLE5+Ec7pOycr9BTcO6AIo8208hEYss
	 qCrHy5navg8IkHbxK7DLZBHC6gY8gMdoBborE3QcNctTXqeWHoxm25AgWcqXD5Bcx5
	 Q3iqIeSY5gE9mqw+LTF/KsXLCyobvqcGdjGvaO8Jl2vOmDZRZwiTRbnp2PZaW7Z/+u
	 OaFguEHp/Lwp7MneJfSKMrobTV+PKzXk0ULmHUwQ/6jWdTuqNqtMvHLScI+xdODZAH
	 jLbJ/DBtK95EQ==
Message-ID: <sashiko-outbox-234388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 00/17] PCI: Serialize bridge window sizing and
 resource assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 23:23:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 17-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125230925.2441=
-1-ilpo.jarvinen@linux.intel.com
