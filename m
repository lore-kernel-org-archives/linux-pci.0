Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09208356767;
	Thu,  1 Oct 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848194; cv=none; b=VEfvh+JciRtRYzaNdAXpVN5D3h1TlFv8dFKjk3XmYjPf2AzRSNAmBg0+T152k3qyeEOB8uaKwgX6D648dri5NuZd1yfbdMgWcgaH5oFMZ4x7jBM3zrIdkBvUV5fbSCDDIr/Va7GkTBKvCowrd58cMv0roVePo052m2jw1GoOn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848194; c=relaxed/simple;
	bh=0+omoBzV+uW0ATpq0bVncSVdk9jA0k4SeAd6APlPyuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ql7chLEdzUR07cTDuwMG/j3/uNBHPF+ET/s+/UB4RKa2sb0KNy64r0d5owwRlq4SLUmcgE4tcH8zCY2U6bQn7rNyzinlIPipsgXdEnbA9RCIWgvpS38xx+hL4dGyowJ7zhGF8WxV8ptmNDlKSfBq7TxLbKWYR57cD5DTm3mSdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCu+gyvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCu+gyvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656F21F000FF;
	Thu,  1 Oct 2026 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848192;
	bh=0+omoBzV+uW0ATpq0bVncSVdk9jA0k4SeAd6APlPyuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCu+gyvDAvNg08mnW/cU1qILs5jaCEmVQLSsLEFBhH8tPeLAyLbOHjZEyaKQNPNgm
	 eAwljzdZVXXJZdqsL0EsPF4aS3elzo4Lky3oEQylxA8mR1Ah9Ud52hV4ZDTdtTq8Fl
	 oS8fukzFC7fIzNMoi6QsSI7jcsdu/bsKTk+AaCzRA5IkO2ZY0fel+NgcZbFu2VI0X1
	 boDQ0+367dOOi4z6RSA3TcDCD4kMcC0peic2mny1OVFSxuh+N+4tQWtwsbDlwu5DLF
	 4Ak2+3/U5EYdbqo0qPD30ATSOMyE5oBxkQbgrEqvfYsx4M4H/xwjkbEHHz9RUF7tMi
	 7NnjMI/Amc23A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/16] cxl: Embed decoder configuration in a
 standalone structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-5-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:49:51 +0000
Message-Id: <20261001094952.656F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define cxl_decoder_config independently and embed it in cxl_decoder. Upda=
te
> decoder field accesses without changing behavior, so reset snapshots can
> reuse the configuration type without struct_group_tagged().
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D4

