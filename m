Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0ED3D7D69
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743379; cv=none; b=G/oUgbXWahtPFJMXWPezfnBTSVFI6JP1sfxG8PDbRB5WmpB7mRMGOrBIaWokCPTJVLUR8au9oG2CIxNiTt24gzq6Ata/vj3onrqodqeOO5ankY1y42K0gAbBCN8S2Ph+nSd5LFbgR38UHuRlcmCpbdzSEjEZUBs6FlxrI5BlueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743379; c=relaxed/simple;
	bh=CZ5sR0YW1Am/daN0RTCvCy9UA7uiTZiaxAi7NV8SNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUnEen8SkfisGsBL+GfCweKFC7llrrn8LFJEfzVdtrd/Ew+Faub8UsFhj4ksyDw03he8kv64vFwBe/0X1U1LpzknCyOY2Zuv5IjAOGBmwFRBovQlTRfj2K3nPu8csT/2NDf2qBwViu4ynbLCsGzA6pND1aZtrBnN7M8jEe85Yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6BDB3363;
	Thu, 14 May 2026 09:22:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 58974600CDB4; Thu, 14 May 2026 09:22:56 +0200 (CEST)
Date: Thu, 14 May 2026 09:22:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko@lists.linux.dev
Cc: alistair23@gmail.com, ojeda@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/18] X.509: Make certificate parser public
Message-ID: <agV4ULnj0Y1UV1Xi@wunner.de>
References: <20260508031710.514574-3-alistair.francis@wdc.com>
 <20260508034543.D9D2FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508034543.D9D2FC2BCB0@smtp.kernel.org>

On Fri, May 08, 2026 at 03:45:43AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message claims to adjust the `#include <linux/time.h>` directive to `#include <linux/time64.h>`, but the patch fails to do so.

Observation is valid, but appears to be caused by an outdated commit
on Alistair's development branch.  The corresponding commit on my
development branch does change the #include directive as advertised
in the commit message:

https://github.com/l1k/linux/commit/64b5f6e24ba9
