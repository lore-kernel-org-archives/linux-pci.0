Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19714657C6
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676716; cv=none; b=XfVppC1FdL19smX5eceyl4zIQG2SId5r8YozvgZXOI/C741ZxX1HYGGtAgwtKyy+OVgV2TKbZLdhIvwW8s5OqHeIPob8P1vRz0mAbjYfKSHBMmnfxNG4E2h0DZRAKOSPPCGzCJFjzoSLlmhq3Jb56At/icRReX8DAUoqsZXOjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676716; c=relaxed/simple;
	bh=5OngZlIHEfjH7sXVQmDgGK7ccIWmE0mvLekBskkFJhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NA/LrUYXs2xGZVHQSTnAGXOikC22BcMjKh8P9kt5Z38/6uwfiBglGiUaSBNENA5U8R3ThaSKPAfuU3mWq5gifZTScFBTQfOzB9QMf4MZlFXEoErdrav4k5zREe3pV4o4FsSegWxs+XJmt00TfPzebnSN7dcfkCaZJ5HbqqTI2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPdKfemR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPdKfemR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B761F000FF;
	Tue, 29 Sep 2026 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676699;
	bh=5OngZlIHEfjH7sXVQmDgGK7ccIWmE0mvLekBskkFJhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPdKfemRHwlCcZuiz/OXSKgniRb4noeM3rCQvFFPRZYZDxlJutJBJscSmQlOR/ryC
	 Mv/sySIkwZNP/jD3ueGblAjmEdAviDmKg7zAc2QCC7q8Dgs3agDhhj7/NnW0e6ckKM
	 3IPRWoWs2TycQ/8oCxNzLCJhjxdQwesajCt4xOtH5lPIC9GNp/V5mdt7QK4LWXJZ95
	 YmXL3K89O+ZTWv7GNsa+Z/KJXF8ZpWEQwMxDvlGkHMQhYULxD3pjCbB/1/sSc2H0Dx
	 ML7kdwqPYFfG1Eb4i9ZTca8rrjS35H4JVvyTFfvpnL4VNBcw0LxE/f5XBBAYU4eCUv
	 NSi4snTTJoqLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] regulator: of: state who owns the array from
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929-regulator-get-all-v1-2-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
 <20260929-regulator-get-all-v1-2-e887c66a47f1@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:11:38 +0000
Message-Id: <20260929101138.D0B761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() allocates the consumer array and hands it to
> the caller, but never said so. Its own error path frees the array, while
> regulator_bulk_free() only puts the regulators, so both callers release
> the regulators and leak the array.
>=20
> Spell the contract out in the kerneldoc.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-regulator-=
get-all-v1-0-e887c66a47f1@flipper.net?part=3D2

