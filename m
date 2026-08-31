Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F53C9EF0;
	Mon, 31 Aug 2026 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218384; cv=none; b=Jyd/+H2xQkAIu2BkZ5dSikSEe5YDO0WfbjcQfmBY/aQlWNQkw77iRF2+6/1hOCsMfhvPMcl2UTrj+HHVO+lqJhUG7hD4oMU/WIgcJ6LuMNWpiGU/yTh1f0/YRL9ki4dYawrjnz/YcFjg9jAwvQrT3u0CvN/rXQinPnB7DrEIyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218384; c=relaxed/simple;
	bh=FqTLYZBMllQHrcycpmi3bDOz3FQ6H/Kr3SYcQoi4ZHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JvkcI3wZYVb6MabDTIG3HRfHGdsqWY5SW49neT980OApgE1aLsxL4NWigLkcbBqSUWHOLfPipIX9N8asQadNz/d7yK/aGqbIFwpI2GLEc2p902yQoOak75sydUVUgG4WSsU+wl/FUFGhImXYJ9Xut8rKpfHbbHOxFkgDEwIygIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqazvRBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqazvRBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E6B1F000E9;
	Mon, 31 Aug 2026 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218382;
	bh=FqTLYZBMllQHrcycpmi3bDOz3FQ6H/Kr3SYcQoi4ZHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqazvRBjt3IdzPIvvmwoEcrN0cASTd83CPhpGz+SRogiRKhJYOYjvfCEfojgrAIlr
	 sctg8iSXeaIhIB7pL3VMV861xNPemJxPUQ06cm/QI1e22IMwhXkFvYOd5jFolQXyT0
	 3RNH0rRzE+OiXKxKhe6M/4wmdzQRZuN61aa1WK92MeKkqRAqhnjt0bFfyDEoNnwmQG
	 scktc40IZrMFGBHpWIY1c7t713u1KbE82/e82OvlJ8lsSyxaLF6iMw2Uw8fGniYG5B
	 15/vBljazJVHsENBuskifR0kXCi/NDf99Db8SqU3gx8ui8nK7VDehEm2RLPOvRcGep
	 K/y0P5pD+NKmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260831191403.207631-12-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:19:42 +0000
Message-Id: <20260831231942.87E6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>=20
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D11

