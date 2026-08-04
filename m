Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7419D065
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853101; cv=none; b=AZMqxyGDFZaNF2krQGOlld19c23irOTAtZrfScK/8pfPCTvt8ojeRo47613ORelY4ta9t859PSpdxNcMYIm3yAV8W3KQstXDYkv/e1f7iSiHYaflNs5+Q9W9J5CAmzFuXuFCIxDrXBjh8FZTjB4RO2UUG6nhNojsDr+G87M2rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853101; c=relaxed/simple;
	bh=2MD0zkQq+/qhCh35jAizf0rhLVN9xjg0GD0GBO9whxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mChO6jKpAia0zbXtbKFvRhJQBbeSEuLGdvunqfvKpS2KrhgJdg1UaAIe+GF0p0icE41f124Eu69jcDj9tZW49qbTFzNMkZblHM84C+9T2WBcMSthutuR4KAzg1qRgU+Jr/IIZCcxr6pisIaIPyjQMkarzEU9oiHYkbHmE0N9i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyIwH5qN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyIwH5qN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74951F00A3A;
	Tue,  4 Aug 2026 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853094;
	bh=2MD0zkQq+/qhCh35jAizf0rhLVN9xjg0GD0GBO9whxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyIwH5qNrEUFgXo6YsRTgAlMIsftwXEeRu/D4L75BLOgE8QIYiL86BUpBx3KMh3Ni
	 eujOSeSEALJ2oEwXwvmHjbr8HDmuhd6ik3rATD4MFQIaEcolimpYz1fcqMp9ybv670
	 j7UFVvcxJTMjYuhbr9KScs5xDmZx5fYgQFhR9AHDMofaeVeowkvbJkMwJHUPr8fIfP
	 4TwW4OJWZmEgUSQw2sNLNu1rt4FYwXTlWGTkd2STxy9b/JDWipFJFXYQLpdoxeN8r5
	 Bu51HjNDby/IjnEsDYzJ/AQ5GZri28Q9K4s/Yrtb9O9Ym12B2vJroicDK2jUurEuCr
	 zwHUXI4HRt5Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 05/14] i3c: Make dev->desc locking assumptions
 explicit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260804133810.184905-6-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:18:13 +0000
Message-Id: <20260804141813.A74951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_device_get_info() takes the bus normal-use lock before accessing
> dev->desc. Under that lock, the descriptor pointer is guaranteed to be
> valid for the duration of the access.
>=20
> Remove the unnecessary NULL check on dev->desc so the code more clearly
> reflects the locking rules and expected descriptor lifetime.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D5

