Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC02D47F1
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170038; cv=none; b=OUicWj7o67imdWD/AKuAj9vE+FHHCWNXG2ZelBB5FjRJdBaEDZnur+JBsLiswL9hqRGb12d4IJxreVpgXxD+t5LajN5Y4p/asrd4xFfZ44l4njUT395K4k9LBGMsGhodfyBnwAWr1L1RD6uLj5f5L5VL8vFF7qeFJ1SaG+uMrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170038; c=relaxed/simple;
	bh=hRI6R5Ls3K1esrdcHDJLyNugKtM69l8mEzFMCOsUt4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Op/dZjlBF0LyLfi4nVN6QmtzcnS5XOysR+1lme1gVYD+H9wOMCC4CMvGGygHLGpCUH9/vVJq2/nF6xL+tm2oUmqKduQyimECbJbSOSLut7DogSzFkqwkwer+opJDhZ6eGX1qowRomMJpFnViH12Tu8AjOYStom8A9Diu2SjUUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+S1QgFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+S1QgFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FCD1F000FF;
	Fri, 11 Sep 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170036;
	bh=hRI6R5Ls3K1esrdcHDJLyNugKtM69l8mEzFMCOsUt4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+S1QgFYR7gFiulRO8bzK6Ixy3J9ObLbw9UntIaungwKGEDNZ0PQqEJG856Hmizih
	 z6PSqwonYPB4EBHQGloG0YbIGvHnd9cy7482BWQ/hr7K240A/bk3qKEiuqvuDcl52G
	 fUYRDAr25qiyopvOYo0iiC+o27NkCR+h1LcEt0iM0yoQx/P+3hO+MxYbhDl/KaZQwU
	 aG6/DrRa8nYCULzL8xf53Lzy/NkEC2sVviOxPvaVdBHxbhHabjIfHMluk705PSSPtS
	 Td1ILl7yXR0rJc7GSfu0nLgk8AXqEU7P4McDkxPkmlUzRVuphp4x+qsZhzyCdZUUMH
	 hl1BkzYU34obw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] PCI: brcmstb: Add Broadcom quirks macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-4-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:40:36 +0000
Message-Id: <20260911234036.71FCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce a 'BQUIRK()' macro to shorten the calculation of a specific
> quirk's value.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D3

