Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21F42AF9B;
	Tue,  4 Aug 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879575; cv=none; b=E4CVzvqqH8wqMvpxS5edV9ypp6j3P8gnaPjo/3pQrhTPC6p6m0/X8HNmjIrwV3PcZNg3UxSHu5NAMr5c2mzx/edn2FkQen2RnGs5Fa+tXoTTiodK9kgJ0FYYwXfhuYxlwIx6Ke8p/0eCt8BkgYkIqZyBZslMX+PPeXjDmD9dpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879575; c=relaxed/simple;
	bh=zp1fLwWCJ6LNSOrwZWOzElY5hBEEUV4U5GqD2qYs8Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmblH73bqk2gF1DXD+0jy57uRn3Sf1xmRUNfOoLNavLJBOXq9FW6w2mtbjjQGkbD6LPsQp+a+FBiqB3IQCiLYF2JAWVcEZ+ignJ+ZnkONXa4fPjh/hakiQy6mBr1V6z+5OTVQUJgvTiPwNBrMQUKMqoJoF2mr4gW8tLEGi9XAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bppwne7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bppwne7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D61F000E9;
	Tue,  4 Aug 2026 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785879574;
	bh=T0suM6UH5omDWTHGSbQmtey3p4lq91BG7bOsmDfbIyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bppwne7xQQZwr7TThnswEzpERjk/8JMDlvyQbeA75aneml9dBULglzSnzxEO1D5JS
	 i5+MwOSjGqSBMJrThH6TM7uCI5x65/j9s7bKDn0ra+KZEx6MzONVz2pwgtZSRLT1KT
	 szU7igR3aIxS3ADMViuiBS7LSV1Eq/dpCXoZSjOhxbF5V2QZp1JfJd9tngfmkbWahr
	 H8UBo0a4nEy2JnWzEe7aUOl+VGJi3ZtmAswCOmUBcm1wXEGaV/Nj7gNn4oToovRLYY
	 6nh567y5d3760qAPpdlCNYD4DdPgzolWpaYZkFYpRCdH9lQMe7YrI4SLQ/KffM+Qth
	 Bm5RyLqtDGisg==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mhi@mailbox.org,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with lifetime-bound drivers
Date: Tue,  4 Aug 2026 23:39:16 +0200
Message-ID: <20260804213915.788349-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
References: <20260719153631.559341-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Jul 2026 17:36:05 +0200, Danilo Krummrich wrote:=0D
> [PATCH v2] rust: irq: make Registration compatible with lifetime-bound dr=
ivers=0D
=0D
Applied, thanks!=0D
=0D
  Branch: driver-core-testing=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/1] rust: irq: make Registration compatible with lifetime-bound drivers=0D
      commit: 98c63ce4d760=0D
=0D
The patch will appear in the next linux-next integration (typically within =
24=0D
hours on weekdays).=0D
=0D
The patch is in the driver-core-testing branch and will be promoted to=0D
driver-core-next after validation.=0D
