Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7338E8A2;
	Mon, 31 Aug 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199411; cv=none; b=qBPY7HjkAORsRfINmFNPc4gHlMGIlb2dspTARFI/909u8DUwb+a8gxA92GDaHQEofBgN+5E3FYzeyXpvQd252q7JTL1mNOl4WxzKw2hSOl6zEngh/uINB1wy/nuaTJfBFHzeVBoDEjFWaIF/Fs6Oveq0kNcxPVcn8pUEPNP802Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199411; c=relaxed/simple;
	bh=iHgX4wPZ797duEz+UZ3coCSjqsjhTVQSCXWGsca1UIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1ABnICCtOTV3L+z/N1TBHTOHw1iblSf1H+IVm70uviPMpaaPHOxqFIeC9Yn7DlQbVihIbAFyFK2qupdtDjc8Som8KgCnX9zOz56rpAnIPlc+zLS63klXqCJZGe9ryLQCglS+KFOaWUe3l3S4Yco2w1OKFIhwcdmlA+yyDkJyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH9aGm79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH9aGm79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189441F00A3D;
	Mon, 31 Aug 2026 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199409;
	bh=PORnacK5J4/pKyaM9WzCxndGZ36BCmS3WYRH2I/takw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GH9aGm79wshjTiR5zp7thEDZ9htBCOfRoFrbDLPHRKCnelC71vtE3nf/gqkqa9M2l
	 fxfD8ZKIOIcOopKJaakQj6i3W4UFH9UQe9aijDSUYqhCs3hiw3grgjZAkv433Vj9jD
	 S5jfPIRei06srwCaog//JmNeQYu4QCdkQolEU/QfplYpUistdOFLBHhf95UjY7z2gP
	 ibdVi6Fu7LQLSCRL38jfz/s/ClJqXJ533yYcHXLTTQ7IdcOsN8WnUcjMQfEWbIZOdP
	 ODH4Muy1IZtm72xGYzE9yWE/+KUnE+n2X5B54OLLCseFVlEL1pXgkQDcXzesCxBf+C
	 rB940U10W9FKA==
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
Subject: [PATCH v1 2/7] ACPI: PM: Introduce acpi_device_init_power()
Date: Mon, 31 Aug 2026 18:25:52 +0200
Message-ID: <2055986.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3435655.aeNJFYEL58@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Two out of three callers of acpi_bus_init_power() need to clear
flags.power_manageable for the target device on errors, which
is somewhat cumbersome, so rename the function to
__acpi_device_init_power(), add a wrapper called
acpi_device_init_power() around it that will take care
of the flags.power_manageable clearing, and make the two
callers of acpi_bus_init_power() in question invoke that
wrapper.

While at it, clean up the declaration of local variables
in __acpi_device_init_power().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c | 22 +++++++++++++++-------
 drivers/acpi/scan.c      |  5 ++---
 include/acpi/acpi_bus.h  |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index a680e6972a8c..7fd780125177 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -169,10 +169,8 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 		return -EINVAL;
 
 	if (device->power.state == ACPI_STATE_UNKNOWN &&
-	    acpi_bus_init_power(device)) {
-		device->flags.power_manageable = 0;
+	    acpi_device_init_power(device))
 		return -ENODEV;
-	}
 
 	acpi_handle_debug(device->handle, "Power state change: %s -> %s\n",
 			  acpi_power_state_string(device->power.state),
@@ -310,10 +308,9 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 }
 EXPORT_SYMBOL(acpi_bus_set_power);
 
-int acpi_bus_init_power(struct acpi_device *device)
+static int __acpi_device_init_power(struct acpi_device *device)
 {
-	int state;
-	int result;
+	int result, state;
 
 	result = acpi_device_get_power(device, &state);
 	if (result)
@@ -355,6 +352,17 @@ int acpi_bus_init_power(struct acpi_device *device)
 	return 0;
 }
 
+int acpi_device_init_power(struct acpi_device *device)
+{
+	int ret;
+
+	ret = __acpi_device_init_power(device);
+	if (ret)
+		device->flags.power_manageable = 0;
+
+	return ret;
+}
+
 /**
  * acpi_device_fix_up_power - Force device with missing _PSC into D0.
  * @device: Device object whose power state is to be fixed up.
@@ -417,7 +425,7 @@ int acpi_device_update_power(struct acpi_device *device, int *state_p)
 	int result;
 
 	if (device->power.state == ACPI_STATE_UNKNOWN) {
-		result = acpi_bus_init_power(device);
+		result = __acpi_device_init_power(device);
 		if (!result && state_p)
 			*state_p = device->power.state;
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1ad8dffc2daf..5aa3ecb000e1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2362,9 +2362,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	acpi_ec_register_opregions(device);
 
 	if (device->flags.power_manageable &&
-	    device->power.state == ACPI_STATE_UNKNOWN &&
-	    acpi_bus_init_power(device))
-		device->flags.power_manageable = 0;
+	    device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_device_init_power(device);
 
 	if (device->flags.visited)
 		goto ok;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a45e0d521d8..b0d9057ccb8a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -618,7 +618,7 @@ int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_set_power(acpi_handle handle, int state);
 const char *acpi_power_state_string(int state);
 int acpi_device_set_power(struct acpi_device *device, int state);
-int acpi_bus_init_power(struct acpi_device *device);
+int acpi_device_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
 void acpi_device_fix_up_power_extended(struct acpi_device *adev);
 void acpi_device_fix_up_power_children(struct acpi_device *adev);
-- 
2.51.0




