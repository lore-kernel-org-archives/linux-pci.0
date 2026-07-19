Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC528373
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484723; cv=none; b=H6IanPrQ6I4DFhz+KTTZ5yEWa4XcC1jkQ5C0m/mbUr63SIOkGLPx8BwHyX9L/YqR2/eanVJCYNyNExpc89UrSS5EFF8sPnHS4ljP9pI89t8wyflYMOYXAWuJBu7s3pU9SdE2xEJI7BePv71gtBQhZII8TJo05pcIG7bwv28e12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484723; c=relaxed/simple;
	bh=Q1SKd/wXzvqEWardcTuXc51TPSk1ArS9RPcNtltvFq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a0OzQiKL2Gx7Ejh8ZDNnCglY6Dmjehi54bjnvWxx1cebbpT/jdt6TDIzDxteXwf52eMrkja4PZnz+5IsK+QoICf3LxbfBxvM/6agF7MZjgo4eqUk1oXQAH/Dqgyun9qwHJ/oqc++cazCN3nAI9ReewBAoCj3Tr0wqBief6QoYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4YTm8cK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4YTm8cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C265A1F000E9;
	Sun, 19 Jul 2026 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784484720;
	bh=Q1SKd/wXzvqEWardcTuXc51TPSk1ArS9RPcNtltvFq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4YTm8cKU4d7mW6ayNQe6xy8HIwdRdNsxCMsHZTQIz0Yt6Muv5NBGW2yoFn263szC
	 5lGcHcv8XZG1cR8oucxSySDDvUDj2kNDZ3xzktHSS9wdSVcMGbTAUlcBF8/DRWYq6E
	 +mQdvrjgNP1eJ91LH7yygnIIyGshaJ5BtDBs0v+3ubNYhjvPkGiuCOTbKrAbmTLfLt
	 2gEl+FXBsw1Tg1jLPDzpvMNHLJKJlNizRQhVEmz5ttbE/pn7TJHvdyneI6ngIdOEVm
	 b8VIZhP470J2+ZxpPN6kv8tteR5HCVe1slj1MUVRDpM8+PV1hTtX/aLUPx5NHToSEy
	 1ZewuGbFalFQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Add device links for Apple T2 NHI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260719180308.1398-3-atharvatiwarilinuxdev@gmail.com>
References: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
 <20260719180308.1398-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 18:12:00 +0000
Message-Id: <20260719181200.C265A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The boolean variable `ret` is returned uninitialized when `has_t2_=
chip` is true and no device links are successfully created.
--

--- Patch [2]: [PATCH 2/2] thunderbolt: Add device links for Apple T2 NHI -=
--
Note: The format of this report has been altered to provide a free-form sum=
mary
of the findings rather than inline diff quoting, due to recitation restrict=
ions
on the original patch code.

commit 02f82ba0cab274de03252dcd3722c98f27a73abf
Author: Andre Eikmeyer <andre@negmaster.com>
thunderbolt: Add device links for Apple T2 NHI

This commit adds support for Thunderbolt NHI on T2 Macs by searching for ro=
ot
ports in ACPI named TRP0, TRP1, etc. It creates device links back to the NHI
so that PCIe tunnels can be re-established after sleep.

[Severity: High]
Could this return an uninitialized value?

In tb_apple_add_links(), the boolean variable ret is declared without an
initial value. If the system has a T2 chip, the code enters a nested loop
searching for PCIe root ports to link. If no root ports match the required
ACPI prefix, or if device link creation fails for all found ports, the loops
complete and the function returns ret without ever having assigned it.

If the uninitialized stack value evaluates to true, might this cause the
caller to incorrectly assume device links were successfully established,
potentially skipping necessary fallback paths like tb_acpi_add_links?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719180308.1398=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2
