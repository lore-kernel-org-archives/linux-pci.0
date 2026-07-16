Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8741F7D4;
	Thu, 16 Jul 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210750; cv=none; b=r8RSNQdAcDKykf6iiKJmxxHSBOWBldBNsjrN4R2Bv/Rms4hY+mjs9Mw6XFf4i3V8W8ecjj1YMf22b5XRTuOo895bE3oXMX05el32qHjt7LDYphSpKUDH5Rd1jZvopstxuCd8DeI7h+HHeA6Pje/8u0J2cRp5G4yLZwP3JrKLauk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210750; c=relaxed/simple;
	bh=l63rcMbv8glGYvwLJe9duT6ZRlcmMrWjvSYW3VeYnC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m0PJY0zW83QwVCSc5xgXOk3vZVxMw6Sgigidyg6oSGO8RoA4awJK8RKeoC6DHQq/RzQ+eaG3kmTlbUHWpBRcsfW7/Rot2ULtzD7z0vxvcly2Lf9U4HnqUqVHAui4Z2QEoYAojyOY3kBe+HeB9l/cAezyRAjDjvILzVAufBEmBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNn6XgpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNn6XgpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BD41F00A3A;
	Thu, 16 Jul 2026 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210749;
	bh=LXfGoC+Q6fH7VKtkDmjkzHAIJoXk/VEZG4n7L5/r2zw=;
	h=From:To:Cc:Subject:Date;
	b=JNn6XgpV5NWiMLrcPB9pFNtH1JTnC6vFCz53vB/EYVSvwNUkxOQ3yl87JYQeiNuP4
	 k6jRGGIsPN361IZ7eW/b6dYlh5pe5Otsh8ReDKLBwyHYiaQPTJBpPRl1eYnwvHtg9r
	 qWzCdVJvccegVD9UujQKPoNJrSfqfwkek4PvPc+6O4SgkWkgVxvytTEniCVYDiPPsj
	 uAks4THfeBB/or7qA78CdehkcuzDIrAAV6qddpLsDvTImdvPRrEuKZk6aKL8+db6kA
	 FVfnb2ujAVtHHiiu1CSJK2pKZnDUk33ZtPgZVT7ulSE9f23zBSiGqGcc9XWzcP9afB
	 +OneZmv9OgpbQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 0/4] ACPI: Add and use acpi_dev_get_pci_dev()
Date: Thu, 16 Jul 2026 15:59:09 +0200
Message-ID: <12935400.O9o76ZdvQC@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/5115219.31r3eYUQgx@rafael.j.wysocki/

that is sent to address review comments from Andy.

The original series description below still applies.

This series is based on the observation that the majority of acpi_get_pci_dev()
callers already know the ACPI device they want to look up the PCI device for
and so they don't need to look up the ACPI device.  Accordingly, a function for
PCI device lookup based on an ACPI device is introduced and used.

The first patch is a simplification utilizing a mutex guard.

The second patch introduces acpi_dev_get_pci_dev() and redefines
acpi_get_pci_dev() as a static inline helper.

The third patch moves a device_put() call in the ACPI video bus driver to
a place after the device in question has been used.

The last patch updates the ACPI video bus driver, which is the heaviest user
of acpi_get_pci_dev(), to use acpi_dev_get_pci_dev() instead of it.

Thanks!



