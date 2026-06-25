Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD243CF97E
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382905; cv=none; b=iSLcLcaMpCowp/OzhTOvEJBmH6JeJtpmL9dabtc+OpiLTyE0z2wHb00kluUtII/5lww73942cX6W3J+ane/okrW6NfKhevBB5Z+LXbX0H5bjloujyvRhH65ELEe0CE9PzJHudj8MCf7Hjw6HoeNSPPSu3Fnnlpg5kKNqjRmpJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382905; c=relaxed/simple;
	bh=074e0TgLmJQfzaqTBszKxclwp3fTaS/OFFpWZxEGbwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCWB3q50hn0bxN77G2j0vSVfQdVZqU4doevPz0PxRmI3HA8wQzWSljIbIxXmQ+o231BTEAz8u+9TTq01p19Dd1Zcgv7IfetcJoHUlvj7yDSWFZlIIWaLLVADfP76zySM+pYGd9p3T3fHp+rWao0Yskd5rzQmmZNc8LCHt44niYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS85pXB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS85pXB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962E61F000E9;
	Thu, 25 Jun 2026 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382903;
	bh=074e0TgLmJQfzaqTBszKxclwp3fTaS/OFFpWZxEGbwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YS85pXB5q7B4dCmOJiycqAkGhIgPpRgDLOhv+MekWF6RaCBSneLAMoIDn4zYDnkhO
	 VhBFLiAFKX1X55YSV1UBAztu5YngDni1UieKSowNroLhk+Q2hXKGNuZs3bYWUhhAtT
	 S8syEs5Hq7JRo3LZPvipJo3PP3QcZvnD5IP5c7nl0xQmdohLXEa8iiO1dFGlXnqaZZ
	 zAxuYYBjsjO6U2IviLzh7yLGkyf9hZdRFdpJEJREhlkG0EOwHDEJN4Fc4BST30EFvX
	 E2zde+CEpioBeDF0ysu0xq7dNDkl/P9Qf9fZ94PUtImX2w/e0yueX71eGcoMsLjfYx
	 jxmhYb5P0CQJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-6-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-6-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:21:43 +0000
Message-Id: <20260625102143.962E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D6

