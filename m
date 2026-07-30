Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB321CC5A
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375666; cv=none; b=Q4oKXt0zAicyhuQprGsK2SzHNKz1p3sv1XVmOlbhRdNfclCTomPOIMDzeS6fbV48uq44+w3UkHOQkSBAFWu+9ZD3uQL5bs51i+u+JKwaxL9c5nDalY235CfxPrLdew2BYHQJ72myfCcqHVbpQaT6uOLez2Q7EFfegyaH3uuykeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375666; c=relaxed/simple;
	bh=Z6zW9WC/m1VyVjNv4vtC61VzjNCBCFVu4+LBja7I7yI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leX+C2frh9q+9fbzbEhWoFGeT9FZWpK6U7Qa5eHVWolwawgzebJSOGFttaZHG4TvJcmmpSdBQnM/aSFJFP6jIexeyx8/3K8jLoShTwu5vPSGc4il1IYQyjrQC2snsc3ds87F878d5ITWu//as4aZGWPHVvLToAan7K0hl7rX838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcDOX728; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcDOX728"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E951F000E9;
	Thu, 30 Jul 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785375665;
	bh=Z6zW9WC/m1VyVjNv4vtC61VzjNCBCFVu4+LBja7I7yI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CcDOX728hk3pbr8LGgLmkhewmwipqBWfBM5q1S60y71oEMwGKRTbIco5R9CsSV94V
	 UP6OgGdxrdWh0yRXBU6aQD2TYUyVWG5Khq/RoxHGqs+zq6AUBwOfbuqKmOq62x+s6m
	 RiKzJNUUFQ3f1Y7PGnInk4NsZlz5k63FkJ4sjjzbVHyak/TFIBpmNQNgK07FoTKAwa
	 bzyVPzT8UaOnDBqsmruHjSQe4YcYDOvruawRww0CH++hkTsUBMX1z5tlf2p2aaQS40
	 +m0QTNXe4ahENCebsFHBN4y5HwinPuYowbMXjzDJeXiaIqRViavD0CkvuNgFNozHY8
	 djepc9nHtv5lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix coding style in pci_sort_bf_cmp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiwon Kang" <kkjiwon04@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730013820.20147-1-kkjiwon04@gmail.com>
References: <20260730013820.20147-1-kkjiwon04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:41:04 +0000
Message-Id: <20260730014105.06E951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split single-line if/else statements with trailing
> return into separate lines
>=20
> Signed-off-by: Jiwon Kang <kkjiwon04@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013820.2014=
7-1-kkjiwon04@gmail.com?part=3D1

