Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AD53FD4E;
	Tue, 29 Sep 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703719; cv=none; b=mubKOzB8qDW7/pdCQgEcAWduaKCjGk4+XITNY6g0Pe+RLVb2HPkiRisxkIPoaPPH779JY7O8kevCUQfsLEArEdlK7dVoSPbL2t20aVNdIgzNl2YmuHvWScO2BCeYnuBZtgkagXcrWMJxbY/1iR1O2ADtBYTDk2fNIsiWn7At00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703719; c=relaxed/simple;
	bh=7E7wCh7LZz60Wn+p3y8AVyjIKmhvr3wnUwtb4D9KZ7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rk/SMPnrEkoI720fv0jxuFolOtt4kvX9V4B1asmcNlT0nOSHkfc33XF1yt23TtM8dr43D/d26s56IF+SLyffOKC2D0xJLIL1XrrqwJ5h787J61YOdQstcJiGoeIHp8uBb5Db1RiFkBxLFGQTaWSjr8tA9osyEKdbXGFUwaptsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGy/kMbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGy/kMbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C533F1F000FF;
	Tue, 29 Sep 2026 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703718;
	bh=7E7wCh7LZz60Wn+p3y8AVyjIKmhvr3wnUwtb4D9KZ7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGy/kMbzalZb5NZ3bTuSj5PujbdF9Ow5qkCh+XEcWME/s7vAWVrdzjC081r2GLMCA
	 XMuxlQ9cb4aOny1ZerSN/aNU0gJqQJtr7NnNXkrDpBVGgBeZkqlDi1evSjXcBnjfDp
	 a9jwmf0X9RAAMARznlxSqqIvciY+oRazsfFSaWiJbp3ztXwfb7ls5x6s/EZZdAhm/N
	 FHZhXVSZViZg/pbSvAgtBTYdoK3/HEjB5YyMp4O5lDZ+c3FR+LxoxeXohx32dNJoXm
	 4bo1iQuHRzbknbcms9z0PKE3CVcuDPmeFTK/UvfY5ZM/kehIoIAhCQxXvPQtcuq6df
	 0xRSkxBA+sG7w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/16] vfio/pci: Gate BAR and ROM access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-5-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:41:57 +0000
Message-Id: <20260929174157.C533F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Protect the common I/O accessors used for BAR, VGA, port I/O and ioeventfd
> accesses with access_srcu. Recovery can then block new accesses and wait
> for admitted accesses to finish. Keep user copies outside SRCU so a
> userspace fault cannot stall recovery.
>=20
> Return -EIO before runtime resume if region access is already blocked.
> This check avoids waking the device unnecessarily; it does not serialize
> runtime resume against recovery. The I/O accessors check the gate again
> under SRCU before touching hardware.
>=20
> Hold one SRCU section across ROM mapping, the buffered hardware read and
> unmapping. Copy the snapshot to userspace afterward, so recovery cannot
> disable ROM decoding between read chunks or wait for a userspace fault.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D4

