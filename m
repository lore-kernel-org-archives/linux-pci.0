Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99A4AD7FE;
	Thu,  3 Sep 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455432; cv=none; b=HgM05YqP9SvBH8ZgoHeKK9YEjNQOZcigXroKppJKJnY02pVP77Ud+aeav89eioLV+80RUa8jtlkSTqhBRc88qTpQwouzjXtEFYeGkEqGzpaGAA0VEQ5ayYUC9Nwb3MJuXOMDYqK27l/RaN/Xucrxwe1PYotBl22Gk0lu3wve56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455432; c=relaxed/simple;
	bh=O3rZ5tLQ1bPk5uw9ISjhJMMEzyygbSDAk8kbDPJI76s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXsFx1rIejPv5jh92xzMQ2caXv02clO29Y/wBykZlu4IQ6Enid6XGLbBusG1I8fmHHX4cnDQ2McN1RRdH2FBDAm6meHmezx4uspZc1RddU1BCZ640GGE52+tmODdV2wAiiXs5SLV9dOU4HXWeXgFvytA1Ho/JHgWLG7nuICy6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf+rz9ak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf+rz9ak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF31F000E9;
	Thu,  3 Sep 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455430;
	bh=9r1zlyL/iXrCaKoyx0AwUXuYUG7/W7U2gQ8EW+UG7wM=;
	h=From:To:Cc:Subject:Date;
	b=Cf+rz9akStCtBK4xV/yt08SoR9V/ydT9F4BndJmQDWP9A3V/TkmTtVYm1M3GKFNsC
	 QiGLFIfzfojHXiZPMuw1UQwifCO9TDhHVZU8fsGZSmKtuOhIeWl3j+G6QRxXSNiOxx
	 vhsQ2chLWmIBIa0922+4U2WvFFx+EneoVBTQzjV9UsyKgKUz6Eqzr8lV+S4Ka7yoRA
	 Ij1sBvK0rzS0OY1zRE2TsgNNdrtFZeh5u/ULO9FzIMjGJF/CLnJa5WsG9z8sHQMjZd
	 Y6tsbS09yJwnJXickDmLyXyg7FFKmTR5PLX0gDpo9V+bQiM3GYNMqmmqAZ0gXO7lrC
	 G+6fiyvRm1Cfg==
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
 [PATCH v3 0/4] ACPI: scan: Adjust power management initialization and PCI
 devices handling
Date: Thu, 03 Sep 2026 18:57:09 +0200
Message-ID: <6044499.DvuYhMxLoT@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/

that adds 1 patch, 3 two patches, and addresses review comments in patch [2/4].

The new patch drops in v3 is a cleanup relocating the acpi_bus_init_power()
declaration to an internal header file in the core ACPI support code (patch
[3/4]).

One of the patches dropped from the v2 has been folded into patch [2/4]
and the other two have become cleanups on top of this series that can be
done later.

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
for devices with missing dependencies and PCI devices are handled by
acpi_bus_attach() like any other devices which is a mistake.

Please see the changelogs of individual patches for details.

Thanks!


Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]



