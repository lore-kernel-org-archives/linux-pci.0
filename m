Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C51C84DC;
	Fri,  9 Oct 2026 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522163; cv=none; b=pqEUWabtwe8vMMbBnr3fe6j2XLa7tvL7B7pHXbFkMv/0C5FxBBRr8vkQse8x7ywBn1CvwhvS6eETFT9rNbvUg/Bu11D7khXR4YZv/9A4UjuRa6nHAKQ/zvtZV8AQkxjDKhFYqRK8FsdW9j0sbJpYvzaUdq8pxWosnDepcgDOsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522163; c=relaxed/simple;
	bh=iu5jL9Ayhqjz5X0lco3OYg8rOGYGxCYuCz43MDbSJjA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Qugj20yBtngkahbPApzssXHxdsvtjY2Mb0gJNeBL08iJGkYMxfZqPHhRcW0QwHwkGmTcS0EaeuIarf+7qKrp5IpqULj0kpVD86XimoKPMaeRw/16k/7uAwdENFQlFyxye3N5iP3aBDAXwXCbHg/9wLy/OMeol7zI2DErn+Crauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5bGriQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5bGriQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1A11F000FF;
	Fri,  9 Oct 2026 05:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522162;
	bh=iu5jL9Ayhqjz5X0lco3OYg8rOGYGxCYuCz43MDbSJjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5bGriQFnC4sIvE/tdY3fJL6z86BI8sh3Q9VASBpAQiyJwPNF26Tfm72yDWcVGjDb
	 7oJHdGjfC3d10YNgsbVX4v/Y3prLQu6g3GUpVvxJTvkM6XP5XmFBcPGGoQISWEYRw5
	 3Kr8wdJ4MnqhSznzVMsl7arVcoJIyfLO2JTdSTQFWpZi90yR6HLE8uaD7nra3tfFOX
	 avf0bx1EW80EhS02kQCkrX9l3YrX66+vVHBZV45/SkLJNqAxcMAYyO5ELlGN5Un9M8
	 ginSRDU/8qdIShLMFl0To1m5R9AfFlUsE/WNTGGdROLYJb7Jw5o6f79SvJcEu9rE92
	 VGJvyuwzVhYLQ==
Message-ID: <sashiko-outbox-164863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] cxl/port: Convert PCIe link latency to nanoseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261009045452.1107921-2-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:02:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
> converted CDAT latencies to nanoseconds and removed the conversion in
> cxl_region_perf_data_calculate(), but left PCIe link latencies in
> picoseconds.
>=20
> This inflates the FlitLatency contribution to region and node latencies
> by a factor of 1000, exposing incorrect values in sysfs. The resulting
> abstract distances can incorrectly reverse the memory tier ordering of
> nodes.
>=20
> Convert the FlitLatency contribution to nanoseconds before adding it to
> the access coordinates, rounding up as cdat_normalize() does.
>=20
> Fixes: 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045452.1107=
921-1-den@valinux.co.jp?part=3D1

