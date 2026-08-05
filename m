Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB342A79A;
	Wed,  5 Aug 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962537; cv=none; b=SIwERjKk0Muc5se7NBGUNV6Ohvk+/0Y5H0tSgWsJyY+SaDG46oR8zHUiA6Rpmz2ZgO1fVJOtGUNjUXcsr8VWA3BI3tPjo3mbYL+6GzYyydXZ1HDe1S1AhymGWB/1MM3QvH44hZvwxVhMQsh6i4ILo7QrvSvLD36iuPPhkD2YQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962537; c=relaxed/simple;
	bh=pMglBsO27tl/im/s+wouK+k61OLjkZqOVdkG23kBsOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaFGGKspvcHJKRpZh2eYTzGOEBNSODbtHuSUxU0LA0syYWLoXKuOGbTm5b3kQqryGWI8OQ87m4CRtS40MdD8yAlhOTO+aB/wqhXhrmzuKSt8Ty8lLwCTl6NLlJhcMYxGhsKx3NUJu0UxboQKH1DEZAQXyscYtX8LZPZOJGB26ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6dRUva8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6dRUva8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5D31F000E9;
	Wed,  5 Aug 2026 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962534;
	bh=pMglBsO27tl/im/s+wouK+k61OLjkZqOVdkG23kBsOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6dRUva8BQMPrmkdrRVc889uzZL8RyoHDNWsa0KmxXq2z7thfYAzNJsvGIG4f5lIB
	 qbg3TLtDY0IgA6sd+kG7FznMGn0rk+Ylh3iIvdTK3C5EesLbjUVqXg86tDDMSB5iwz
	 lkqGtR1X+ahCpwcHnyVRxRT4XDasMxZaYUxR0+LMR055jkvduo194G8uLNTBZ1QA67
	 3wrdGVZ9lBQ2L3pdEm49wvokCVPRzIaEnZuT9ql700n/yhxSQ7lTeMeTOGx0FfR9pl
	 12dTCWQk4Ayp1PhXkcQdK0W/MshBJ3u8hzXUr55enPla0MWtFOFSI9I6bAH6gpAkd6
	 n24aCxHBVUt8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-rust_leds-v23-2-b2fea4290ee6@posteo.de>
References: <20260805-rust_leds-v23-0-b2fea4290ee6@posteo.de>
 <20260805-rust_leds-v23-2-b2fea4290ee6@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:42:13 +0000
Message-Id: <20260805204214.4D5D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message violates the LED subsystem prefix and capitaliza=
tion rules.
--

--- Patch [2]: [PATCH RESEND v23 2/3] rust: leds: add Mode trait ---
commit 94544731940c399095bac43bd359750434035486
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit adds the led::Mode trait to allow for other types of led class
devices in led::LedOps.

> rust: leds: add Mode trait

[Severity: Low]
This isn't a bug, but does this commit subject follow the LED subsystem
formatting conventions? The subsystem guidelines specify capitalizing the
description after the subsystem prefix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rust_leds-=
v23-0-b2fea4290ee6@posteo.de?part=3D2
