Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306E4A43E8;
	Thu,  1 Oct 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847056; cv=none; b=kSR4jt4nbBnf+dUYpV7gUimsjNeBsxGI3qG3HFEQNIbSJ1+kEDfFq8TM0KCuk2m81AK9aoWuLenGKVbmonUaCTiKeCUM3a3PeTaSk0Kbb263REmWlVFYplWIgZiM2KJXvS2ZGKhujCFQK+9Xy7K6AhyQWPz/TPIbrhuOsJTs9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847056; c=relaxed/simple;
	bh=/zDcHKtgnJnFN1Igs04l/4Q484yWHoZE7MIPou7q1Zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQTGCf8edMRbc7TudVIS9N4m3YpaIDmth3heIBH1abjuwi7E5g9tYf1YcMpoSl5I5l+g58W+XLZVrLUT8WsjQBvKu0SVGGFEilq/111iIjlda3mzoSInaZ+vere81uGeambPzPnpXp+ZdsZIPE8tD3BjtHXgBms/WJs6TJlbOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUeURI1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUeURI1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0981F1F000FF;
	Thu,  1 Oct 2026 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847054;
	bh=/zDcHKtgnJnFN1Igs04l/4Q484yWHoZE7MIPou7q1Zw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUeURI1AXvo3zAHyX2bgcriGgtp4LvWHMBrAmo+eg+O7o0QjwpnIdyGwbAaM4sw81
	 2wmLl2gpkOwZa+A6hTBfqKAv7kFrfbKlReTWg0tZBVnZsMkhU3DwYMxtkULDER7QLh
	 H4MYgfwxcjpnrluPuZs/iZcL7oylNAz9+U7C1a8rQ1AHiKFCOSxfM+0HVk/tCvloMd
	 XVDriTiEg7ZJ+P9ATyIY4EDfMmNRB6mW6eFG26fMd1KB7hPRsUg9Nd79j9NOvt2pwZ
	 R9jvRBW4bx7/tyLgfjoU50SXnBuaUjUycoLFghhW6srouCXRVSVQJ6PyQE7Jw+bjdo
	 zjnMlDedvqcwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/16] cxl: Move decoder declarations to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-4-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:30:53 +0000
Message-Id: <20261001093054.0981F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D3

