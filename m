Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513529;
	b=NsKTHZSJOLmOSakE2x+1JzlwqMUNSJlukRt+HNfe3bFD0c/YofsWeEjy9gfDP7Mk6gFG
	 uCQh5DZENiKBYhdeefJoLhiQPphygmVM7f9tBk7QCZ2VmM6UW9Tbd/aIycYjF9ZNztsQH
	 pyZh8cEuUkl6QOwb/+lOUdYmw3e56S5xTpyxqKfyxwerId4JkJxptnd4Z9NhsZ2ZnJO+I
	 W1qw2U5SjUHT+nFWcXUUopOxAJg22lk02TwRHGXXIntM6j3p39dS11O9aZl+z6DzrBx4D
	 WAGUOn0lt1WKRrqJiLCFuseHlxL885z+YULUHk5NQ+reDLR003NPzVKvZKAGINeh7LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=AI23EedCHOkVt2bUFVxVq0Tw4jV6qHaXsCMKfKtBCb8=;
	b=hD+gFyMGeFGQaiiIDBJxxKXQ3tvNvna7TnJG9KVl1wsitQfRupY/qDPeZ+FFKm3B++at
	 E4mrx+dmTcCbSUAAMmTET8EGJqvhAM05A4vfHCpPLayjXbbhZOsMeaScC2eFIqrxuz+IL
	 0xVQZ+Epw/3wXV7vVIjkxcOaF07nV5Zkk8FLWn4eFR5MWp1Z9QV6i0J79GCkqT+oo5CMk
	 duySJX8MU3PqxbkdttdFmDqshKp9qLS6lniAkEXrLyxNEQhBebYYAu3gwVu6RClOniFNJ
	 gRAZjEhl3op9GVJHTFAp2erBbxXHGv81SByAjO+wwcYduks+F0m2/J8b2/CttNWPCbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnHik31J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2460A2607;
	Tue, 24 Nov 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnHik31J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B1A1F000C4;
	Tue, 24 Nov 2026 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513529;
	bh=AI23EedCHOkVt2bUFVxVq0Tw4jV6qHaXsCMKfKtBCb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnHik31JyN/Y3TS9cyBiDeVRA00Ub5gX3cbTGh5LLBhpP23T1U52BZf4Z3OXrcbY4
	 whWIq5d7u/lP5039cdtVPaeBNWaoyZkH343rSPE3yYysFNt6Z1+xh8hmVMgwstoXBZ
	 O8DiJJUb4YTDb1FUZnp7XskQSA5mcrL49QyGzXh0NlfvsyWF88vKOejkr2dlkdzeAD
	 7GjXVqLpdb5QnUIJFVvJIY/v6UIL1rJOeAgsV4aeVu6m4yeDgK0RptHlm10daF1DWZ
	 f0fmo265bGWWnLUn9NTXM8iNkDKUIwkv/PrqdITUo25T2QoKRdDZvZ1m0QbGp8Nkba
	 cAX09au3hVw6g==
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
	Jeff Garzik <jeff@garzik.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>
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
Subject: [PATCH v4 15/33] driver core: Report deferred probes through sysfs drivers_probe
Date: Tue, 24 Nov 2026 11:43:46 +0200
Message-ID: <20261124-device-trust-core-v4-15-037eb0d17b1f@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
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

Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-drivers-probe | 14 ++++++++++++++
 MAINTAINERS                                       |  1 +
 drivers/base/bus.c                                |  9 +++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-drivers-probe b/Documentation/ABI/testing/sysfs-bus-drivers-probe
new file mode 100644
index 0000000000000..ed8828e55d6bf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-drivers-probe
@@ -0,0 +1,14 @@
+What:		/sys/bus/.../drivers_probe
+Date:		February 2007
+Contact:	driver-core@lists.linux.dev
+Description:
+		(WO) Writing a device name requests driver attachment on this
+		bus, even when drivers_autoprobe is disabled. A successful
+		write does not guarantee that a driver bound. The driver link
+		can appear before probe completes; a bind uevent signals
+		successful binding.
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
2.56.1

