Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA39341050;
	Sat, 28 Mar 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725258; cv=none; b=YBKO9PIKpHlVrcpcEJmqgZnh3JJWmKFzhmtM3pVE+eIxEURGM6rGe8GgmOWTWMocxShu9EfIXe7Sw/zNPi6uGqAwuzSELJRGl1WMDEwhwdR44WpWkInVre9dLEPyYGBVKIusrbNRp0sKqBVApoq/gscy4PdffpVi5HHXZ3wWCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725258; c=relaxed/simple;
	bh=wX8AQeZzuPnlJESJ4AJHNDw8vSwoPPygn8/7lDKLpjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1p8BvCDjetcHXTSHo6W6uVvlswDUSYYa+k/DfiOA3p8xMERGPqle82cBY+We0nocpkEHYli+TTzNWatN9Ir+q5Ysb2DwB37XiA7d/oe6ev3MCD/3kO5RUIfehegn4GvAl9w9rKdWhC5j2aGiIAPa47Mxs4tAcQ01okVFGHuc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id F035CC14;
	Sat, 28 Mar 2026 20:14:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BAC8D600D150; Sat, 28 Mar 2026 20:14:14 +0100 (CET)
Date: Sat, 28 Mar 2026 20:14:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <acgohjvBpVcR7HcK@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>

On Sat, Mar 28, 2026 at 05:16:08PM +0100, Bernd Schumacher wrote:
> Thank you for your patch. But ...
> Applying the patch to v6.12.73 did not help. (same errors).

Hm, could you provide full dmesg output please with
"dyndbg=file drivers/pci/* +p" added to the kernel command line
(the double quotes need to be included on the command line).
Be sure to set CONFIG_DYNAMIC_DEBUG=y in .config when compiling
the kernel.

Ideally both for a non-working kernel such as 6.12.73 and for a
working kernel such as 6.12.63.  That should make it easier to
root-cause the issue.

Thank you!

Lukas
