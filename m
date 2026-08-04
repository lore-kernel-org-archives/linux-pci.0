Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8036729A
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856117; cv=none; b=cSR1QPlV2iDWiw6RG7kFQqEM3zAwKz+M9zTYXlG9MUIvKiQ/+pr82jpKaT2i/Ng5SyHzPSy4PCYz/7MrRX31CNj9o9EKBP6SbKs+cft/kOb3SJzE9a/W5KGoea0c7IiSrcsWwHXHqzeF+3CMmaTmwaMQmpS4kPeBGnzCBdXETQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856117; c=relaxed/simple;
	bh=KHjBCvRYRcjQ11n8H66PPsyVPLdCNKkjEXCzUrejbeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FWPttCKe0luf10ohqEVA+6H8TG0kRMvmHa3/8qZm99yQGl6A/bfovKIgyPlw1gm0zHtBuV1PtEIm53Xye+GuzounD/7WVTWwjhg4XO1BbEtlBNDK21o3L+7HbUA6JkjhMbJiYCNL248CyjXXwd0fXCM/VjCYEd3epJ6x8ZEfMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBJk3g18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBJk3g18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360251F000E9;
	Tue,  4 Aug 2026 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856115;
	bh=8jPyyIz75LTYLVO8IYLY2uPs1TjsKgJglknHvfkxIqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBJk3g18KmPmrgO/7sfIvemZbl5tJpHVoZ3jPETmmajsNFjBDHclz3V6XSqDkTBMA
	 K1ZC88+5HH0m1icy9u6GcQ2DFHrRXQSPhgq4NziKlGMBGV0QBNVC5VmWsXzjLm0BiX
	 BGLsdr5xba23isKRhYwc/4LkFmlQi9rqzhpQ9PpMrSXX6d9fCI6AfZzqX4ikKCCiGd
	 b1wXzQOg2cIZxWqvLq1/Qbq/7l6qCWdpMHJDPzOq6Z1FjLE/+CXUzqtvgJAGsH3IKA
	 hb2WCUz4X5IbNy5FTEVUaNlTteg+rrUco/2PWiXA4d6mDaJMhyP4aYKHLqylgCCzk4
	 42By/5OSscAqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-7-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:08:34 +0000
Message-Id: <20260804150835.360251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
>=20
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
>=20
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
>=20
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
>=20
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_=
device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking=
 during device registration"
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D6

