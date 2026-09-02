Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9B29ACFD;
	Wed,  2 Sep 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377876; cv=none; b=gX5/VHWosD7e7BEsDw53ie0x99h5ToMG6xrufjKekLYLZ2n7x/hgUDFmdCnr01aW2RWAjEeIDdGKvvjhznCe00hdkI7uGmK4J4Owa0vmD4Jncugx1YOdMWq0pMhyKOCUQFUWoFQD5zEX9LyUwi89z2IYF65Jof1xUXS/UcF3bDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377876; c=relaxed/simple;
	bh=HuWuCObhAJ4M8DDwLtt2gimxUt9sl2WhAv6nAaGDSXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpFcufBvP+Hw49isZo3VKvZVz2pyF60jSXADuvibWEr5J27ion+XJeEvroT7h8e9rUBOevCWPyzpPICzNmSu8A0vw7TOZRuiEiYomA/Y4N1ue9L5VzDuiRRwHNrAQ768NPz5ZxqW7vHqei89RvbeP/PibpEkROoe0koVY/utSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOHSuC76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOHSuC76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194E41F00A3E;
	Wed,  2 Sep 2026 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377862;
	bh=NfnAMEvrg4Gwqwur0dkgpZW4W2Hv33GecGAJAxMbpSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XOHSuC762BoGFmqqwQjlm3xT5W0X6OKQe/tI2C/WNkJlMd/ylxJ2jlpBwnlTf8/88
	 7vbHcvqMr1+RIQ/nkrGXMevro8RVtPbn19K1Ruzllv8MlHz/E4QDFMNqy0WvmUatCA
	 CDQMMk36nh5f5SRgE69lY45+QlpW6KSprKJLLlEI63J02GGqdlv4zG7Bp3uGZnrJTU
	 gliVUMqoKaMu//BDqwFIJ7VFPFyYrRJhJdefErFmkm48v9UHxnzLEMRy6ISV66gRLL
	 ezE4HREEWNe+I3GON0u83RXTrvyHAsbOIcysoduz6260FxTAUsUW1dr6ZXf0krLQwM
	 lBIDVD43cwSVw==
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
 [PATCH v2 3/6] ACPI: scan: Combine two conditionals in acpi_bus_attach()
Date: Wed, 02 Sep 2026 21:30:00 +0200
Message-ID: <8743568.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5144065.31r3eYUQgx@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There are two conditionals in acpi_bus_attach() that can be combined,
which slightly reduces the overhead and makes the code a bit easier
to follow, so do that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Reverse checks to avoid multiple negations (Andy)
   * Rebase on top of the new [2/6]

Link to the v1:
https://lore.kernel.org/linux-pci/2021470.taCxCBeP46@rafael.j.wysocki/

---
 drivers/acpi/scan.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4586f1798685..7208cc515866 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2370,13 +2370,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (ret < 0)
 		return 0;
 
-	if (ret > 0 && !device->flags.enumeration_by_parent) {
-		acpi_device_set_enumerated(device);
-		goto ok;
-	}
-
-	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
-	    device->flags.enumeration_by_parent)
+	if (device->flags.enumeration_by_parent ||
+	    (!ret && (device->pnp.type.platform_id || device->pnp.type.backlight)))
 		acpi_default_enumeration(device);
 	else
 		acpi_device_set_enumerated(device);
-- 
2.51.0




