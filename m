Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660021B142D;
	Sun, 11 Oct 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685149; cv=none; b=aJJ6URM3A7xZLlRuETL11trdF3q2d8g2ZzDF4GoXUvHnnMSC23kHJDBiBXXnMbjyR6eARjvfHj4MVdtEqvNPUS+o+V2/2xzVnXfLjuwqUBJgQPnQGC6AupeUxeDwr7ch6a8pbQpBxsqVlAEOT6mzekqH0t6aPoqaEiqHWmDkWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685149; c=relaxed/simple;
	bh=dF+WhnU2Z2JbB9j1nfEczIQMV8iwhNtogxy4CGWC/dQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IYhISWCk6bVbvWtq/XNWBF5Yk8KQa7bwq5FURRXaJXtp/FHEo1ERl/kXwpmdNCiBqgLY5gBwRIlTpynVJwkjvXTF0+TSRCq/rdw6NkZ1Y3Fa4Rnv+oAvuenwn+ng3qJbKbTASMp/Jyo8+pzldm/yNxw/Xu07YrMLdy9ndrYvfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb5a5yZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb5a5yZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F371F000FF;
	Sun, 11 Oct 2026 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685147;
	bh=dF+WhnU2Z2JbB9j1nfEczIQMV8iwhNtogxy4CGWC/dQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qb5a5yZiEJd3u7Wvk74HBUtTsZBsJc8cwNjmeZwfLq+rP0xBmeIB58sLyon7M7qiM
	 EVLoMmPYwKd18lMbxg9PrEPhYFqjYAUX/s4gEEpwoDXMc7N1AipH/AcOZtQN4zSXBK
	 Rqv9TLY1P4Yv1Ku+YM0ueLtSIZYdT/SwbX+Hr9YdgLp+9YLScIb5B9oWKWNZkRVA87
	 cCLnFR8bNDtJvumXzvAuLZWheD+7sU7MB4Z6PrrB2cswuqO3oensKGAxYGAjZUYMye
	 D0CLyhJ7fj5GfSxBpnbRkg4rybob+EqREyOFE51NaZsjhinbyL2vNXOFegX++sce/9
	 FIIU60X/eGkbw==
Message-ID: <sashiko-outbox-166968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/16] cxl: Move decoder declarations to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-4-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:19:07 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D3

