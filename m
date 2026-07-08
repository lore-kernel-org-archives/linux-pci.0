Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB441A6822;
	Wed,  8 Jul 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520309; cv=none; b=ZapSwJCmyEZl8LE6NSUlf4BgmByszAn1QWgC5u7PvCfetw242HiolnrRkEDhtDRqQxMzjhp+3isl4NpDYxTsWMVmnEzckyrPtNjjcAFjJ08iuqzpTGjZxIa7qkEffdlnPj8ZSWMcAoprk3QgAdkDk5JbjDdD+DaTpvuzIYNa61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520309; c=relaxed/simple;
	bh=eQSNEY71hP0uIjOga+Q4h7FqRxWEjoFD5SLiKJJUUN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PyFzhmVN7TrdG/5sM9nL4luxqN2ssA4URI1t0HLLrNQv4WPkZxK0x3RO5ZOiAbZueOVCtPhSYkCEkV5ntFWu8xyUEapRCFN9WBhXIJOJAYTjVtQOtdQ+Te1g/6Zc/2GtvIRP7nWgKoeJYhLKFiUAagrCTlZI4dahcLwekIheORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfejp4Db; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfejp4Db"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDF61F000E9;
	Wed,  8 Jul 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520308;
	bh=BBwTfe3mtserabrJ4Uvf+Lg5B1k6V5Vwa5nwi5JOQxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kfejp4DbF2pkWN6TmNJtdL3BAg4yhmmEwq8H7PgralHE/nBwCJZIw/8p5RP+UmCR9
	 f2d10vgazxMx2gpAS+D0fHSUISP4llDiJ5YJueQp67uARq5F4pATf57/Fr3er+IWDq
	 v0OoNpAuiJ0GyDA/GHcPH5ch59lCUumKmRSKN5ufbr3ni/pHygBJhOinUzKHCVcYPh
	 grYNNGyULihWPZJblya8Zow0CuMPRzT6tHUapy/l4ZFWWi//rSHB3CoiCfgg8vnkgi
	 1udlDsWTdTcdB6I/Oi4V5XII97tR3YtNNIMxLtE2qKUxmBk83DPVjonYfTCdMEnh6y
	 +8pbdgNcJ4U4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: robh@kernel.org, linux-cxl@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-3-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-3-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:18:26 +0000
Message-Id: <20260708141827.BFDF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The EDAC driver initializes and exits by iterating over the `ghes_=
devs` linked list using `list_for_each_entry_safe()`, but fails to acquire =
the protective `ghes_devs_mutex`. Concurrent modification of this list by `=
ghes_probe()` or `ghes_remove()` (e.g., triggered via sysfs bind/unbind) wi=
ll cause list corruption and use-after-free. This problem wasn't introduced=
 by this patch, but pre-existed in the codebase.
--

--- Patch [3]: [PATCH v7 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc=
 helpers ---
commit bf19da8163cfc99677668eb5a9ba4a2f8cc72b57
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: move GHESv2 ack and alloc helpers

This commit moves the GHESv2 acknowledgment and error-source allocation
helpers from ghes.c into ghes_cper.c. The logic is kept unchanged while
making the helpers reusable.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f74fd5de34cc5..bda535224422d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the GHES
codebase, I noticed a potential locking omission involving the ghes_devs
list.

Does the EDAC driver need to hold ghes_devs_mutex during initialization
and teardown?

Looking at drivers/edac/ghes_edac.c, ghes_edac_init() and ghes_edac_exit()
traverse the ghes_devs list locklessly:

drivers/edac/ghes_edac.c:ghes_edac_init() {
    ...
    list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
        ghes_edac_register(g->dev);
    }
    ...
}

However, in drivers/acpi/apei/ghes.c, ghes_remove() deletes entries from
this list under the mutex:

drivers/acpi/apei/ghes.c:ghes_remove() {
    ...
    mutex_lock(&ghes_devs_mutex);
    list_del(&ghes->elist);
    mutex_unlock(&ghes_devs_mutex);
    ...
}

Could concurrent execution of module loading/unloading (e.g., modprobe
ghes_edac) and GHES platform device bind/unbind via sysfs cause linked
list corruption or a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D3
