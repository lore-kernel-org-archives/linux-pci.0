Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108753368A2
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653253; cv=none; b=NxXmiBYKiSnBLqGwIvD/HOEGvPaOAhGFtgP8Lm5kujr2zwbLXgVNatNP3Mwnl69XwZFx9UyyA27apSxB+hu9wgiLUJ2BLYOgGSPD4m6VVFrcMZhPCNuCYyFlw9PEQc/bUxYpwtLj3BJ1HScWqwlpU26tEmwvncaDGhkzHge/vzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653253; c=relaxed/simple;
	bh=f5RhMaiynjAvAswxGqKq77iW9AMfWLHK1GP6dW7cAOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B+Xfwu+Xu5erpVZwnFzo10c3a1YZVgNiM/LuFVgSQhj6bhIG/zoh+t9HhJfhQ/ggN8g/XUV/eNwDGwUq/iqC2zOXHBke/de3lc5nooH23o5c17PKtebZxTJGDRMzVXP8lEnG54dM0LC05fAeRKMGNXaPHtEMITNS8E6zsrOCDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6Js3W+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6Js3W+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467BA1F000E9;
	Tue, 21 Jul 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653251;
	bh=f5RhMaiynjAvAswxGqKq77iW9AMfWLHK1GP6dW7cAOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6Js3W+4iesf/d6+1Xd+umyZUNTNmLs0bVPFRgpcll9vbyvfuBSYnPw0yIN00MoS5
	 i8KoQ5UuSTYkK3Kc5/zo39hIA6j11qMeY3Q6T9EgslfunX6debFtuYFLu8mm89mRHw
	 sr/F174aA8BO0ZKLiDoRFBJSMGgINCHKPrtszFNbHC7myrVCPJFUsZKVu9CMy3YdE3
	 hnpYTdDa5hdxttujuGahyk1EHWhbLWQQeKSa2OzBrWFldvW9b97FMBaynENK81skdj
	 DHQOzrzT8U5lNxOBVU7PDDWqGLn9m+uXrCxw3dAdkI1zpBTiS7k6RJ0OCY+9OV/OkT
	 Ht6O5AR/2TMCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] rust: io: register: make register have a typed
 base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-5-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-5-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:00:50 +0000
Message-Id: <20260721170051.467BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D5

