Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030049;
	b=2EBMDjsIp+40D5uSBl/QiWzVFUMBQ0xfy5w8ssWDOL7guu5bOCHcLfFLdG5dpuS32Mhx
	 CiGQmG6UAbZn60Y09A0ewmyGBsBGY/IigxoQ8hI+NPQgU2+0iBwyiwPQFLM1/xLDfJDTR
	 d/f6NqcVOOLGhzkeV4AYfVwUJTqPWyOlRTJZ6JvNuxDsmBqGu9jkMBJYdHVhlqnZHtBsP
	 5caYCMvAqLVwOT3AIEu/0QeTodF8EIMLaPQfUH/IqbGppw3ZzGY2D1AcFZD3gkh7YLyEL
	 53dmQCCwmKSREbtY4vljmJ93tqqVjmsgKEFYUQPOi9CbnhI3p7qGCCjeROhFC2URXFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=p4sT5+vbEJgTPXn0ZxCwAz9v5MiOVyx+czs5SWxFdeU=;
	b=I1bogf9Zdcwhb0YJUGqEWGzE8082UJljTlBVn7Mwc6w73o/O4qjLFWqFVTTp6lK2697+
	 GOM4K06u93UFAEFkgpwJR4wqMPgblxjrgItCPqdRhDPbMgW7G2MfAznh/aCZWhtq42nkH
	 CJ2puwMSFbAlHfQ3MXlnVe/m/1pNduD7FHLe32X9RToCLQOhC8OTjdx42E4B8H3sxuNsm
	 SjCgzzR1eEmq2ozhW84lAISkNpcW270VL+dXtl+mSxlavvhWIkH0ZLXl/6KizPmjN2eYD
	 QxJID8Xm1P/MuVyNq/2OFZwdT2Xl2MLoLJIYimnDZvYDHgYXm42PzdqCocOJzcBDJpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DX0DWC/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA231606A333;
	Wed, 18 Nov 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DX0DWC/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BB71F000CF;
	Wed, 18 Nov 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030049;
	bh=p4sT5+vbEJgTPXn0ZxCwAz9v5MiOVyx+czs5SWxFdeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DX0DWC/XWrMRnax1dnyz64DHeCC7MDTnGaxyhIDpdHcai9waT0XcsKypg+D4QfrOI
	 pmaUh2Z7APtyu2kiL38XzxpzkSN2vzSKTw+CNLuQX6HKjj7X55f+/hj9cKg15LzIgj
	 21O5PtOoNmZsagQIQ28hmZxgLZBb6TkDBTGoP8jYLf8vmvfwKVB9fjIg/Ohkt8QHsO
	 yxW7GDs2k6SyXCjng1R5IkkKkJ5LD29xapKsXauA2I2juIfRoGgl6yBOlVzga2rqPn
	 EtysFUjm04Yt9bsmWXBaSSke1iATngbnxQLGNzQHPj9FUbN32qRax3UMuIPbqlbXCY
	 NMSI7H9jmzflA==
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 04/31] USB: serial: Register USB drivers with their owning module
Date: Wed, 18 Nov 2026 21:26:34 +0200
Message-ID: <20261118-device-trust-core-v3-4-d655875c4bfb@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The USB-serial core allocates each USB driver on behalf of its serial
module, which deregisters and frees it during module exit. Registering
through usb_register() instead identifies the USB-serial core as its
owner, so a module reference does not retain the driver's allocation.

Pass the serial module's owner and KBUILD_MODNAME to usb_register_driver().
Keep the module name separate from the USB driver name so built-in drivers
also link to the correct module.

Fixes: 68e24113457e ("USB: serial: rework usb_serial_register/deregister_drivers()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/serial/usb-serial.c | 4 +++-
 include/linux/usb/serial.h      | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 4a19621f08ba2..ccbd0875339a3 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1513,6 +1513,7 @@ static void usb_serial_deregister(struct usb_serial_driver *device)
  * @serial_drivers: NULL-terminated array of pointers to drivers to be registered
  * @owner: owning module
  * @name: name of the usb_driver for this set of @serial_drivers
+ * @mod_name: name of the module containing the serial drivers
  * @id_table: list of all devices this @serial_drivers set binds to
  *
  * Registers all the drivers in the @serial_drivers array, and dynamically
@@ -1520,6 +1521,7 @@ static void usb_serial_deregister(struct usb_serial_driver *device)
  */
 int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
 				  struct module *owner, const char *name,
+				  const char *mod_name,
 				  const struct usb_device_id *id_table)
 {
 	int rc;
@@ -1559,7 +1561,7 @@ int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers
 		}
 	}
 
-	rc = usb_register(udriver);
+	rc = usb_register_driver(udriver, owner, mod_name);
 	if (rc)
 		goto err_free_driver;
 
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 5866f19d3c7b8..fcfd0e26e0ffb 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -321,9 +321,11 @@ struct usb_serial_driver {
 	container_of(d, struct usb_serial_driver, driver)
 
 #define usb_serial_register_drivers(serial_drivers, name, id_table) \
-	__usb_serial_register_drivers(serial_drivers, THIS_MODULE, name, id_table)
+	__usb_serial_register_drivers(serial_drivers, THIS_MODULE, name, \
+				      KBUILD_MODNAME, id_table)
 int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
 				  struct module *owner, const char *name,
+				  const char *mod_name,
 				  const struct usb_device_id *id_table);
 void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_drivers[]);
 void usb_serial_port_softint(struct usb_serial_port *port);

-- 
2.56.1

