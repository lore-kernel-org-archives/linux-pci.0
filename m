Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C7316905
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023572; cv=none; b=P6Dr9wQ4iB4ZT3bKKAPpUd2b7tnrSKYmj5GDr9PxjNA3Yo4kmKwGPNG99Zc8OgQN61yZjS8Rp9mk+0PwksfT6p91joQxxzFw/XLbyveZprDvgwzszyZHZRGV7JR3YgXlopEuNh8mcLN6j53o9mG5iyxOjtwXim9jIuaLYZ7b+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023572; c=relaxed/simple;
	bh=lFcYc+EDIIqhq+J3iCxHdeyfQX2bDGbZnEolQbCRwLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJtFqkKUjvL2kU3/XsMFwwGGzCPpo0hub2f//GyfJfTVUhuiE+q/R1o61QDcU9r7sHYEp3QHPS6/3vSjkJlqT6fezxpGyt58aqQ3RKt+4V1F7u/v5JZ1HFnsJPbgaCBuZy2pkrN88/dtmiCfZ0hzV5+qhc9B5hHVfUO/NsHXAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndBi8efR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndBi8efR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3B51F000E9;
	Thu,  6 Aug 2026 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023566;
	bh=lFcYc+EDIIqhq+J3iCxHdeyfQX2bDGbZnEolQbCRwLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndBi8efR9v9yGn3SPd7lbUu30HlnZsZdK5gWS0EhHZtuNtP5ca1Yj5qLUKNpCfdSt
	 AjwPl7X+6XYnr7yHtxc3gfWcWg8oRFrrZT9UqzULTg0T4OzyqoRz82Di+cp13C2OZN
	 Lkbd4d9b3+glvKVfrSgKRU9ksHXD1xK+slq/r2iot29NlkGYEc7VuLgzcbkspYlJ6a
	 iO2NKP1dhCjOc35TpOAyB6ndpvKb4X7mH/Cef3dIEgiStojrz8rV82jX/PSIGj858n
	 hOUAF1h42nK6PuylVBVdkju7Sjm+Rv/qk5ZcNjDbtw60r+EoqwHFduzp08cB94B+kM
	 PVEAAiktdir6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 05/14] i3c: Make dev->desc locking assumptions
 explicit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260806131857.119830-6-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:39:25 +0000
Message-Id: <20260806133926.5B3B51F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D5

