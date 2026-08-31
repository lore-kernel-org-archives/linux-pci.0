Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AD4A092B;
	Mon, 31 Aug 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199421; cv=none; b=PasnbJRZxP3EdpsJF6QT+1w4Cy977QLn+JLtIWLjrGdpqfrybsZCxRdlo6gBoHx7hp0N7I79SCyt3g4A2QtKrky0o68CtkDuigByGfsr92hd1qP2kEDhTDwbkvP21Ascy1kUbe5HbJWHHBVL7EsiLcRT//D7ugXMlkQhfDzVITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199421; c=relaxed/simple;
	bh=II9wom9svLKecnivIvV0TnL+nprkbs/6auF3lF1kiaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3Y8f1rnjLeDO/NDVZdmkJ1rU3CJsoNioAXeV1UJZl4DcV3T9H12zXJyOcfZTEyusYOZ5Ph/dDpzVh/q8v+gckRILA9T5jIBBgSzkmrnL18WNYyWjCp5Bg2Bz25D1xyWUOSWQQ1odfodTU+4m8IbBC9KixltSslbWbtksO4Kkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwM9qGVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwM9qGVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29D51F000E9;
	Mon, 31 Aug 2026 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199419;
	bh=mC8M8sDW7Z8VK7QyO3vAJB3ESBcsyz+W1uPbTLNMPQE=;
	h=From:To:Cc:Subject:Date;
	b=ZwM9qGVsjAJ0flyHc/PO7v1Xj/mNpoA+/903ziP6taT8M2XXcWbVO+bQeq8GZWWDE
	 Ge27t5JPC4J2Kk73GmdsjYv/saxeqPwrPXAgPUOOy5TUFiBpovyHxA/pa446t9n0R+
	 GaLeZuv7j13kea780ih2BPiBABpMA/a1y6N31jsCBqL61/tfu41drtvOXA0KDeBukP
	 dxsoMEHxtejzu8ApXaqWiOQ80BgB6/Z/gstitPgzZf6j87twHMNpV16v9UhCl5La9B
	 xO7xQtYcR/HGyqMFE5G0B1fgvB9oJy8qjA9aXWhXJV9ZyFvdyzn0SrZBTJLCdRhqd/
	 J0LU2L5MSR0lA==
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
 [PATCH v1 0/7] ACPI: scan: Address power management initialization and PCI
 devices handling
Date: Mon, 31 Aug 2026 18:20:42 +0200
Message-ID: <3435655.aeNJFYEL58@rafael.j.wysocki>
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

This series aims at addressing a few issues present in the core ACPI device
enumeration code, mostly related to the acpi_bus_attach() function (that
gets renamed in one of the patches).

The first one is that, on some systems, ACPI power management is initialized
twice for devices that have missing dependencies to start with.  An attempt
to address this issue had been made during the 7.3 merge window, but it had
to be reverted [1].  The approach used here is roughly the same as in the
reverted commit, but it takes PCI devices (which are a special case) into
account.

The other issues are that flags are unnecessarily cleared by acpi_bus_attach()
for devices with missing dependencies, the "initialized" ACPI device object
flag is not particularly useful, the "visited" ACPI device object flag is
used for two different things which is confusing at best, and that PCI
devices are handled by acpi_bus_attach() like any other devices which is
a mistake.

Please see the changelogs of individual patches for details.

I have tested this series on a couple of machines, but let's see what
Sashiko has to say about it.

Thanks!


Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]


