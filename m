Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A377E0E4;
	Sun, 12 Jul 2026 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783877726; cv=none; b=EQZJ/sn6i4cYlPVr+KZpJ6f0nzM++Eypt7T+lT8QGhm0q4AIbOIr8cfgepnldlVjAGwKFAVbaJsmWUcKQ/rPe0ypY2uynmjj+zZ4f+nuI+wOtn4FuoCaTxGCPqpBb7nPUOH/Zyy5wbGd95HBFEY07HWCiPhci2mTujXWnvL3tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783877726; c=relaxed/simple;
	bh=12x75EuerNeVlxa9H7QvEy2R1LUov5i361ra4hEiR9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XiZ8UguofOvhzurZ9O3Bkg9leaai+WqAjjRuwtQLPaYpOg4SUOyVI+ytGGOh7wmbnYsQkuW6hC4NNLIDPxiTQHTolrv8sLrU14u3fqq0mkCsWhflxKnF0VV6/CXtrTmtkilHHStihWQB/oePOvWMqySR0w21LUKe0rwMG3bdukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6va7+Ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6va7+Ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54C61F000E9;
	Sun, 12 Jul 2026 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783877725;
	bh=12x75EuerNeVlxa9H7QvEy2R1LUov5i361ra4hEiR9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6va7+Ct0qHPiKnDQTnya9XmhiWfMB4Y8QKdHirY/sg/2W9mtJlkBQG8PlnmojkAy
	 tgXXhP9kUYrfOO9Cgn8wFuyirGr7tUo2a2w7rOcQQdK1DS0fpTlqT5/8yiNgWV/nAM
	 F0SEIfhsYZuAddbrQVLqyOhWRU3sHZRcBiQho7NVfSoD/05DDL3l1gNT5F7fcQmRO5
	 SsvvnJeQVdApSKipKMcFIDZzCO4hOW2z3QozFNLy8jaF6wBD1GQF956zosmU/vdx7k
	 nwth3DgSynlX9AHxT6OIhG31E6RaAcjADrkIQZZOD78PztbcH74s8FF336o1KhEqOY
	 7m5+Yx3Yr+rqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260712-rust_leds-v22-2-055b0459a079@posteo.de>
References: <20260712-rust_leds-v22-0-055b0459a079@posteo.de>
 <20260712-rust_leds-v22-2-055b0459a079@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 17:35:24 +0000
Message-Id: <20260712173524.A54C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message description is not capitalized, violating the LE=
D subsystem guidelines.
--

--- Patch [2]: [PATCH v22 2/3] rust: leds: add Mode trait ---
commit 8d85f0f9ab1eee7120f30390efbe81778a293e33
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit adds the led::Mode trait to allow for other types of led class
devices in led::LedOps.

> rust: leds: add Mode trait

[Severity: Low]
This isn't a bug, but the LED subsystem guidelines require the commit messa=
ge
description to be capitalized after the subsystem prefix. Could the subject
line be updated to "rust: leds: Add Mode trait"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-rust_leds-=
v22-0-055b0459a079@posteo.de?part=3D2
