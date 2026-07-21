Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31533EDE79
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654291; cv=none; b=XQpqy3i7UsGiev7By/iRM/TGk/3KgqAXJcaaH6z9hxdijH7USHixwkmM68xp8qJJkMn/jdsjZSItGdkv0PHCSqiMxp9vDlphWyb7/DQdZwUnKzYiDCGAvKR2gpCqdVNrYBF3iDj3edqjSd36MoXIQS7q6XjDAnha6cNoaposQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654291; c=relaxed/simple;
	bh=FACeUECK4C6pRaOivUkcVl8IRxh7h/CYdrEQk57f+Zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrF4jIdNtSGAGPts8ed5oeaHbkEn4i6jotCqDZPiJerM4uo0rUnrTyNk0GJQPOiIF9Pu29kzYMpxszKXeJkJ1aeRqrFDPPuU0dTrUy8yOwetJBsTonCw7deaI+KygAcSH92t/nJiwmvbyMA/BJ0ghXumpoz8GoErxN8EgM4snvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2iTPe14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2iTPe14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783851F000E9;
	Tue, 21 Jul 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654288;
	bh=FACeUECK4C6pRaOivUkcVl8IRxh7h/CYdrEQk57f+Zw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2iTPe14Job6+Hg93SIWKntUTxACO4bC0NRFpvWz1k5utoXpC2LDR1hUXttgLQDMg
	 xyVVMNjuQVD/8SDIqobnHnr4D3HNy23dbh5nfofDivK33lDumOHDDhlS8ycHdQo4DP
	 dag4PHEpSUgYnyYzfPYsRgXYs6ioh9ZEWOKxQ9R0kaux2zoYja4LAvCny34gYv9+M8
	 TEl4e1p8pTsG/COACyoRT0LE6B867Q5uVxu3HjBnh2Uri6+65x1Xak9XmL7Yd6VLEm
	 vnwbjDM+Jv8O1KJ7L8zyifdaQjMvBLJhrXVzQ4I7HKn58jhtxuffYUkKErm0CqkQwN
	 kWHh30CGQU4OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] gpu: nova-core: convert hshub0 from relative
 register to projection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-9-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-9-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:18:07 +0000
Message-Id: <20260721171807.783851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
> can also be achieved cleanly with projection and a new base.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D9

