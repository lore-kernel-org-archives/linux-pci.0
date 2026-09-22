Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766B437130;
	Tue, 22 Sep 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066937; cv=none; b=rSl827tZNseWILlCF8dnLzC2b6heshlPkErAHcvhwhd2vET+MwawI7u0rqc3WE/lGPrSqMTs/6AlHz2dlzuKZ2XyvrKIUnlkFoBJ95ZJbN7d04WkMob20bf7fIKxR5mYmK+MNhoZfUtASS8caALnCAhp5DNr0x+dZtrBN3rsoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066937; c=relaxed/simple;
	bh=fV+C1UNGjvkrAq4YU0ki95IzKAdzRPxJkuTZNmI//wQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/2BuDaCaMJD/v5qCeAoGwgdlth9Daz7CKiBmw67Goc0uYCkGrhgTse1kDJF7XbvFvf5CDJgdiPQMkL5Z8K9QnCtdZ494ImhVxlNc1t+jL7Luai4q0qTVOV/9hvoAXarvJmlZVKYXMzgReY4tNKtVk83HxrjNhKoE+gkJ07mreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqLw6tNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqLw6tNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713E81F000FF;
	Tue, 22 Sep 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066935;
	bh=fV+C1UNGjvkrAq4YU0ki95IzKAdzRPxJkuTZNmI//wQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqLw6tNXXuZAjsYz9jChL3ahK1jHB355ZWUdrbnNB2e9UGnWuBTePTQuzv+DKrpqb
	 xRkbl0yC3lUzasmerNmAU8cinvVWdn5LRyhc/eSWlZ/6U30bvoPll8C5dHlVGm8nKy
	 L2f/c8yYtJ9bvd9s+XrdjgEnmjyw/W3u44bFdU8Yx15V0bx5F8P3wjR4qJygrNxhmG
	 P+jg/P53xo2wF2illo0CJi5IfBzdd8ynHkI34w1e2yvTTJOg05ExqevbYJ/inXhEHx
	 71/OmUvryJyrp4eGfVQFxjwWSk/Z1YjbQmHXFrwEjW9F8achCc3lWigdKN+qTp/0+f
	 JhGOZ/t5rbasw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/15] cxl: Move decoder declarations to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-5-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:48:55 +0000
Message-Id: <20260922084855.713E81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D4

