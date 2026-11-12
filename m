Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445558;
	b=nOTp6KqLQp6JPj71McIxDXdRPEaSIW6LqzXRAJ6b06CwQ5HBNo3cFrezvQucM2cvIMvj
	 WArY9X3SnjlcneTCKDvUpdcs78za6/AKDKHVZtx+krUREgFKx5pGFTuYxsv8WV9IrZj5O
	 FIjQsyn5Hd776ogc/l0mk+UUUijy1jOGIlHvDbcYK4xzYm7aGuIwb6O6cbXKyWOdFIFTo
	 3FOomAbvJWiccYGkr/qBmu+++VSYAMRmefSgjyW+d2Y8Xc1+YIR5YCzybUHtHixqVT9+z
	 eT4N/gMe+5ez6LoPAS3JQxQuVUm/g2F1kGqEVxjbHgJN9KBQGKNGTrZvhZdi6IKnrNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Ad88Jzmpee0M4BHPGE44Z0ravDYeEYVqEIY475fdKw=;
	b=0Jj6wJZydozr9NXAKMz4UWnw1RZpBqUNG7/qCs5cLVXrtEJqs/J+kTCyq2BzafwjJh1/
	 qCNmtnp2thR1CUSdutOGhqSjoSJy0vniX3jSteDlMPofLbiYi7hoLnj6XiszEGli4YwuL
	 K86IsfWykzibGMmKZLIUAPp0oS5cMm8/UPQtzqymsLq2JCoeAnJRJJ0ChzwI/V9W8T6Eo
	 YgFg2scd6PrLtK3n8AKVc87XFmvlLpZ3RmzEZifdzS4rP0LYAtk9EY1a1ZNji7N5eRjFq
	 XNGAz2XXHnfmTHHt7WhaoEYypMAGhh+5dJ68HKD/2zZR3hDowWp1QpUd2tAjeNBboTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWpzXdpY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0479606A885;
	Thu, 12 Nov 2026 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWpzXdpY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD691F00A14;
	Thu, 12 Nov 2026 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445557;
	bh=+Ad88Jzmpee0M4BHPGE44Z0ravDYeEYVqEIY475fdKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lWpzXdpYpISyJXTwPKmll1a3hf3fQp0p8qeHhscG3WZU+9930g/dT/nWplS+eEId1
	 5wUNlTqFftrK4jqbDwdWpL4w30DW9NJFxj0hpayrqrYjnCFYGhJi2RB41bo4fiJZnI
	 NVWCi7B15lBeQzj5qoKhX6JWDjVRnAcqT2RckykPh0gCLcZ5i19XKWiF+wjqplnahB
	 /dG2XtBMNbZ4IElKUrtymV0TtDrIUUHlrysBqczvPAjdEuZhPvkuZIVdszbPgifkrq
	 fOVf+ImSe+UbSjJ2UvAgWWWsSJndBEPxW52TQ990ZlMcrP2zkLOKOE9gxKQw9QUwg/
	 YHXODuGF39NoA==
Message-ID: <sashiko-outbox-210036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] rust: auxiliary: remove the unbind() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261112005455.1224352-4-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:05:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The driver model uses native Rust lifetimes to let driver data retain
> device resources and a Device<Bound> reference for the duration of the
> binding. Both remain accessible from the destructor, so a separate
> unbind() callback is no longer needed.
>=20
> Remove auxiliary::Driver::unbind() and the adapter's remove callback and
> document that device teardown belongs in Drop or PinnedDrop.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D3

