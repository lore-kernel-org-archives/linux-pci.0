Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209663;
	b=5sFaYNPrHprXAexrFFK7oIGCBXzsh1he+OYaRPqV1GS7xs+wGegfbbqj0NABqbGtPrkF
	 C9HTvhYn1qPv/fk+u6gcoGrYSEk2Xmncys2oyaJi3+fbkLIJHWPCHs5AsfLEwSQacutbX
	 1WCtdhWB48wUHmMlq1rAU6dQqppGbykZRJb//P1YTtODHQVL2b4NehYDsvv/jYzTsC3vK
	 tPRIppOLYMY7due0G+ItSU7H//tGugP9ZJ6hjMOioKkXtVMql0PHgRwAgZxwG4A8OJ31T
	 5qOeG0fTY7CFW+cbYOk0fEEnHWox7NnKC5gVMrH3C9sk+shDzSF662P1AOWB7P5N/kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Kya3esT+ja5CoFsJojA0B+sdCKA8A1pbdw4lgiA8vnE=;
	b=rcrTfWxEaABGTvXPY8DyElQ3bIYpIPDPUEwu/f0ULOV1iuPCTgFuvHqePZhQqhyQzO1t
	 Kw5dunzPrkikeA7YnUzZQXkVjKY9lTSK+nKDMg+ZrM3GK00Q9+AUuoTNzZ5rFf6wJwh0F
	 xQV1NiiWwHLGBJPJWg0Bnw5D3su2Pv+GHaY0kONsynSb9z20dSp48gdBOFNy3GfXARYR1
	 otpxsskmYOouJpJYQuNvctHtSvQ9lP51i9dwxNft5/lmGhP0CmE/nRRDtWQZ7EewmtmRw
	 mFdZC9aUQFkuo2mFptJlxgUEak+5o1/poaAbcc3k9wnrXiy5QTCu48LE8Z7JIbaXSpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfNN0+N4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD6606EE81;
	Mon,  9 Nov 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfNN0+N4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238EC1F008A3;
	Mon,  9 Nov 2026 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209662;
	bh=Kya3esT+ja5CoFsJojA0B+sdCKA8A1pbdw4lgiA8vnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfNN0+N4So4tkvt4WfCeInlWHoD/4kPLBlBnFfJ0JgvY1mvme/G/1EYi9aUGb3Oag
	 wFVlAhC1MDqV/SVGdSnWGm47kMCESUEI74OMDvDo+JYhtNj8BUN2ZYKh4JmwjuJQHu
	 ArBIIDjzsOHKK39DdwkvxeEtJvmc9stNwmFvLuVFXKbaiFLsiuTfd3p7XnyBxYqUxc
	 CXhhAH2yRgcg26kaB2jOkurFASrYlSMgSn/LaV2RUfmBlg4WfJ5ku0hBiwJb5UCSax
	 2pJhKLrCZgwknCAlZvsKYz6zdBHIbFw1uafrBOdsyIktdv6Z5v6jjNgOPcoMl8Xxz7
	 n+CuFlQO83Fbg==
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
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
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
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 07/19] driver core: Report deferred probes through sysfs drivers_probe
Date: Mon,  9 Nov 2026 09:33:37 +0200
Message-ID: <20261109-device-trust-core-v2-7-3b12d9a9f861@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
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

commit b8c5cec23d5c ("Driver core: udev triggered device-<>driver
binding") introduced the concept of "Systems who want to control the
driver binding with udev" can use the drivers_probe sysfs to trigger a
driver bind based on the kernel's match list.

If attaching the driver is deferred before its probe callback runs,
userspace sees EINVAL and cannot tell it should try again, maybe after
loading other drivers.

Map that deferral to EAGAIN and add missed documentation for the
drivers_probe sysfs. A deferral requested by the probe callback itself
is still not reported.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-drivers-probe | 13 +++++++++++++
 MAINTAINERS                                       |  1 +
 drivers/base/bus.c                                |  9 +++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-drivers-probe b/Documentation/ABI/testing/sysfs-bus-drivers-probe
new file mode 100644
index 0000000000000..851c65b9331ae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-drivers-probe
@@ -0,0 +1,13 @@
+What:		/sys/bus/.../drivers_probe
+Date:		February 2007
+Contact:	driver-core@lists.linux.dev
+Description:
+		(WO) Writing a device name requests driver attachment on this
+		bus, even when drivers_autoprobe is disabled. A successful
+		write does not guarantee that a driver bound. The device's
+		driver link reports the result.
+
+		EAGAIN means attachment was deferred before the driver's probe
+		callback, for example while a supplier or the device itself
+		is not ready. ENODEV means the device was not found. Other
+		attachment errors return EINVAL.
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..b726344362b41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8149,6 +8149,7 @@ M:	Johan Hovold <johan@kernel.org>
 L:	driver-core@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
+F:	Documentation/ABI/testing/sysfs-bus-drivers-probe
 F:	Documentation/core-api/kobject.rst
 F:	Documentation/driver-api/driver-model/
 F:	drivers/base/
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 396097fdb3162..ecff32c3704b5 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -310,13 +310,18 @@ static ssize_t drivers_probe_store(const struct bus_type *bus,
 				   const char *buf, size_t count)
 {
 	struct device *dev;
-	int err = -EINVAL;
+	int err;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (!dev)
 		return -ENODEV;
-	if (bus_rescan_devices_helper(dev, NULL) == 0)
+	err = bus_rescan_devices_helper(dev, NULL);
+	if (!err)
 		err = count;
+	else if (err == -EPROBE_DEFER)
+		err = -EAGAIN;
+	else
+		err = -EINVAL;
 	put_device(dev);
 	return err;
 }

-- 
2.56.0

