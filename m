Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB182EEE75
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116115; cv=none; b=posXoLt8AAmYER9j2gG2n25cyK5JOOhIQlx6C6bDo6E9YBfwzSVsOeD430JRNlt5yb7OopYmTHI6iXt8U6Zr1DgqtYTNYVFrNgidv2mcIB6YrW42i/1o6J5TaiQbqH9UThx2HXIWkaLQAJ90T0d8KnKv1BE/6mMqJvRJBjUwCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116115; c=relaxed/simple;
	bh=a8ZKoBNiEpEZJdZ7+clwJzr+tE3NjNrhq3hlgQrFgt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ib2T99c0pkuieNJRpDLlHFrjD1hRLwHmXUD/RY8ipclBNmdRn0pNHHNP/OZEtKXMFyLpAHvxVrgrp5arnoW7rbnF/jO3mZMjme8nnLKCyn3hJgqpVKLe1rFeUU/5uLaKu5kl2pSeWpNnJRe0wp4y5SzGrG/7vt/CIlXAXd6xjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev72oKcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev72oKcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A3D1F000FF;
	Sun,  4 Oct 2026 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116113;
	bh=a8ZKoBNiEpEZJdZ7+clwJzr+tE3NjNrhq3hlgQrFgt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ev72oKcyTL9FxVs4FCekTBuU5Sc/A2tyK8KcHRXTcfCgWC1ftBbKAEyqhKy/QHdgh
	 yMz/09jPIdCmehI82ok2kTHgFw03UsDZtFEdG/5ui+gL3zdFsaq2Oaif5z30xQTX6e
	 LFrmxWhrkC4xb45ZZb6CEsyhAmBSKRqUc20GptT7cYMKWclwUHsMTTUfEl/KGgneDA
	 76SE9gKXGDU4cohplO/UnQVvBD/Fi30/h8Fxr5wldCqFRg8Uyyae/giaoHkmLdKdsf
	 o6PUqAZjgZK3YyV2kNhmczkG9mkXYsSCHe5DiXEYDQvcvBUvRYBqLwAO7yOcJjZaXj
	 TY1ezjLEavK7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] rust: pci: drop driver data before remove
 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20261004120732.1045629-6-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-6-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:15:12 +0000
Message-Id: <20261004121512.C7A3D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>=20
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D5

