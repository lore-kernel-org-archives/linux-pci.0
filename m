Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D88538D73
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879794; cv=none; b=m05j7+XwbL5eMU6LZxctdHzrxWNXuRqctstMKdniFFk4mWasOef4Gl/UtRscvYo0iS/eEiRC8hSy1L60YVfP7MMFaQh3tnd6EqsCepx5AZHaUSFhHZcO5EfbwRJHGUixDXcR/n5xZeWxUxTOPU4UrOycsOBVYlLnxCpHxsjVyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879794; c=relaxed/simple;
	bh=RZhcEisow24fJQ7pwTdvL50QG7IvDF4wClBUzhC4SS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dnpuXZCVDOMyV9T1r7gMjRsn9FaPv1nO8lhvoprbVu3Zs5vfU9oJ6UeRL2iJHg9FfNYksIs70gYAgoshshHLDmcihgDzfeySaVW2nqKRG0svFJD76ZMDHw2Af4YSyrqsovu0lXPlXqpwzfvA3TOJ3fjv0YtEOqIj2yJJWjfreVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB391F00A3A;
	Tue,  8 Sep 2026 15:03:05 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] PCI: dw-rockchip: Add helper function for
 controller mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-5-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-5-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:03:04 +0000
Message-Id: <20260908150305.1BB391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove code duplication and improve readability by introducing a new
> function to setup the controller mode.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D5

