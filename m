Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23744AD7E8;
	Wed,  2 Sep 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377886; cv=none; b=bB6oJM1xP/InSBo4cA8g+0kooAdEp6FFbXfonx24nHv201XbWq5DYyCYn/ao4JFg7OlegerFOwANtQqTJjL/gOVR/bpgLfaWNB4kUvkO4d2VT0TV5B+wg6t+RWLljwOzJPnBxZrDIzI5SmBtOzvwWDMOzElWa9MosiULP1j26Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377886; c=relaxed/simple;
	bh=85rOTWoFB2balKBcm2AoyBCASk0/LgpZ4YrXVC6sm1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nP5+RF+qTqtJN0RjFpg4lFrwonpmqnFN69pMBVJMZhTBmr1fRnbhi389X2I+b7u7xFGg+oB+WGUHSj1BKwjybPqQGSpjzilAwIySqVIEEulRKkdsMjXq7UNC/mhGyTA874bSyuvPE9GGCnLzNDviz+mXum0Z1m1dstZrNTvBeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSKtKMcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSKtKMcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842A81F00A3F;
	Wed,  2 Sep 2026 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377877;
	bh=Jm8sSs0Ij/1COxgV58dTpYSRz7LPeAA0VfisFBbngnE=;
	h=From:To:Cc:Subject:Date;
	b=eSKtKMcroyhb6c9Z6zZGsIClwyTD/FW1rN7g4GIC8HfcogiTpbXCVT0PvIyIIkN4Q
	 UOJUsNhgBihS4oOFhlgcQvbBlPOSLSkuECEvPiYaXZr23Z0+Pw1KySlCCgYxUpLy9n
	 lHihGn9La1u0CcG5WhQKzbC/eAvZUE8QZ/dCAH6dcI7JRLO1HnFHgJ6T9Wrv2/aZzF
	 MLbQ01awhzTcJ+91m3TP3ZB7zHD74d7aqG/yMhezpFkdo5/TvHXkALco2av3G3w09C
	 x4RmUwqB3d3Dw9HAy+qdJ4VB8PVK34kdvhVYQsfG5bFjoxoIPag1oKNYlfhHBcDoO7
	 DLMkFRegH6kSQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Peixin Xie <peixin.xie@linux.spacemit.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v2 0/6] ACPI: scan: Adjust power management initialization and PCI
 devices handling
Date: Wed, 02 Sep 2026 21:21:34 +0200
Message-ID: <5144065.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-acpi/3435655.aeNJFYEL58@rafael.j.wysocki/

that adds one patch, drops two patches, and addresses review comments in
some other patches in the series.

The new patch drops an unneeded parent power state update that may lead to
issues in theory from acpi_device_get_power().

One of the patches dropped from the original series is not necessary any
more after addressing review comments in patch [2/6], and the other one
might introduced some issues pointed out by Sashiko.

Overall, the series aims at addressing a few issues present in the core ACPI
device enumeration code, mostly related to the acpi_bus_attach() function.

The first one is that, on some systems, ACPI power management is initialized
twice for devices that have missing dependencies to start with.  An attempt
to address this issue had been made during the 7.3 merge window, but it had
to be reverted [1].  The approach used here is roughly the same as in the
reverted commit, but it takes PCI devices (which are a special case) into
account.

In addition to the above, ACPI power management may be initialized prematurely
for device objects whose parents are not ready for enumeration.

The other issues are that flags are unnecessarily cleared by acpi_bus_attach()
for devices with missing dependencies, the "initialized" ACPI device object
flag is not particularly useful, the "visited" ACPI device object flag is
used for two different things which is confusing at best, and PCI devices
are handled by acpi_bus_attach() like any other devices which is a mistake.

Please see the changelogs of individual patches for details.

Thanks!


Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]


