Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CA48B364;
	Wed, 15 Jul 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128945; cv=none; b=O+b/b1xqlT67BeT2h7E2YPtxlfzKZA50K4+LJynddKhGDRCyMDxBeLK1w2/AgMXowyNDzuwqVmMSHChebaVfi8iKLFVdu+CvSpZh5HVUPjDIvIfGkBVRDFjgBE+Vx2bwsFTZ/HTQS5fAiCsvom2uDows47edlJgFMBsqkrvzaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128945; c=relaxed/simple;
	bh=jjacU6eaYOVdJE0phNw/ONyk+xzpZNNR1RVMSXwKTGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJA2EeSTjdUqOnKEEinl/TyJS6YQM6PI1UMVgjW7MKJI7YujK4qE9nwrszlNi9xEZQDHc1t1os3lQwf58Lrl7CvESppE3sgDhVzuVB34lMnPzm2VgIOXPS4+Io71SVpz7ryzbrs0zAuDkaq8kkHLule5U7ovGDwh0x9s4/UgjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQmI2rYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQmI2rYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A81F000E9;
	Wed, 15 Jul 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128944;
	bh=EHmecRF3UFYLB0/HIZVpa9Vi0WShvpJ+xhGFAHXmT80=;
	h=From:To:Cc:Subject:Date;
	b=kQmI2rYDLJRPFtN9Bbmp7ZuALWv3CKz2bA+5s+dAWYQd79B2oiDuTdSY8F1AhOKt7
	 TLkQfsbPInkvfrS7r7QGssm5pco73MgyB49qcsnKqpLhUpPtebOCx7TVQh4IbOod/D
	 WF0HYhe+Fi+pyYrQhzfQBioXSL85SWKnkgMzz+oUAs9xsjD8kAhuX8EHgR4RTDJWJG
	 GSGPAON8V8XBnzDzgxaZqjHJqfmrd+qZgwwewWqaxtXZhfptfkI/tgO1wM3FMf68f7
	 cHQedk2Dp2urJ8Nze7We5cyMoah7Zt+w8mIx+zFWMlmYVPN71C1bKpzKBLadY9HcUk
	 R2dv/GpqPPJBQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 0/4] ACPI: Add and use acpi_dev_get_pci_dev()
Date: Wed, 15 Jul 2026 17:13:27 +0200
Message-ID: <5115219.31r3eYUQgx@rafael.j.wysocki>
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



