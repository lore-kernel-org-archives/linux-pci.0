Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209642;
	b=0VTEjbG0GvErYj+d1hmSiYOmZ184gXCWdcIrheTp7A5Vx3LOlv8dMhDENa9U8Cn+kMMb
	 eIqTgPOCvLgZG4hejlJY7/SJZhC7qSKvsvHLQ3AC9YX7dTdBJSdp9oi7RMYqQ1MZLlWZ/
	 W8+pzzoUbWQjBMDtOb/oA7M0/ElSxg+vttBdXyaLSyo2C25aV1PeocN82KdMy6WEn929y
	 LdxuqIzifxV8hlsSyn+F42QQdOLrJs/BV7ZS6uCPq63vmMaM5YaGL7WBhYYtq2gxcTeaO
	 UBr7zYrKFCli3a1d0EWbN0hbhCcXiQu/N5jdzWMbLeBOJIgWjna3G7+L8ivjPgDtGOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding;
	bh=BOudLxnS5pVPT2tPMn88TB0pOWjmfO5Gatem6QmrQcA=;
	b=ufzSu7dIOYzt2fI4maPaYxuvpsMcTADk6Ja5irIMGVlwxE8AENRl87nQdF9OfDF1CVhT
	 UuhuHEcbh5JJaXxFGNTUhXDhoFLhg4uJJm9UfFLMW3U00MqhCeg6Y60XSn19RWtv0JedK
	 KvX2A4Y+hJImjaYmwSmlSPZrZN2K/QkDKdN4lK1S3xQ3U99rU7dcqCEnaW6ewnC41KR7o
	 avLWjYecy/S+f3B7IWxZMOtG4DN4g5IygAmbXcWehPzlPZ8Hh+X9Z7V2QUfU5X8HGZBSv
	 DBqqxUE0pf8gy+SdOch8mACbDj8y5XpyXd88mC4ukPwgpN4FdM59NqkWQdZRgpo0qKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhnY8YMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567A606A31C;
	Mon,  9 Nov 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhnY8YMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCF61F0089F;
	Mon,  9 Nov 2026 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209641;
	bh=BOudLxnS5pVPT2tPMn88TB0pOWjmfO5Gatem6QmrQcA=;
	h=From:To:Cc:Subject:Date;
	b=jhnY8YMdt8nGcYBaSKvJbCx3LFW8GkUkfxG2KVQyfFPxlK/zuviCXPcVmAKOjjqep
	 OJwKBI+522F08dkhOUewjW7oWj3wn3XyzARmmIbVOrDxcxSRGcS40fmfCdvk4AMyhp
	 MOjTYj5wCRejfz+oJhv1T4pVMKG3/VZeEHqKSqdLPc4a5x8apUuXMnQ1aIaY9WUDP+
	 qG+bmJlMqJWo98xyXORHh1De0UINQ9Ms5bi+a/yYR9oTHj1OSMGHFyMwzSujrBUncm
	 Ztid65rG+5tchiq/F8VP8JJGHkylUG+CZBGVjKcamjj2pAddBJRgS+/eioJ1UGNvSY
	 J5UdD+59m5jow==
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
Subject: [PATCH v2 00/19] driver core: Authorize device trust before driver binding
Date: Mon,  9 Nov 2026 09:33:30 +0200
Message-ID: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
X-Mailer: git-send-email 2.56.0
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
X-Change-ID: 20260915-device-trust-core-12934e618489
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

Device trust policies need to precede driver setup, including manual
attachment, so userspace can authorize devices before they operate.

Introduce disabled, adversary and full policies with boot-time selection,
sysfs authorization and lifetime commitment. Apply them to PCI and USB.
Keep serio and generic PHY attachment under their existing subsystem
locks through an API restricted to device_trust.default=full. Freeze
runtime policy changes in that mode and require per-device boot entries
to exclude driver rules from manual attachment.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v2:
- Replace the serio and PHY attachment conversions with
  device_driver_attach_full(), restricted to device_trust.default=full.
- Add USB authorization on top of device trust: export
  device_trust_set_policy() and convert the USB authorized attributes.
- Documentation and commit messages fixes
- Small USB patches rewrote and split
- Link to v1: https://patch.msgid.link/20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com

---
Leon Romanovsky (19):
      Input: gameport - attach manual drivers through the driver core
      wifi: mac80211_hwsim: lock device for manual driver binding
      USB: Lock registered interfaces during manual driver binding
      USB: Release interface claims refused during registration
      PNP: Attach card devices through the driver core
      cdx: Propagate DMA configuration errors
      driver core: Report deferred probes through sysfs drivers_probe
      driver core: Add a compatibility API for manual driver attachment
      Input: serio - use the compatibility driver attachment API
      net: phy: Use the compatibility driver attachment API
      driver core: Introduce a generic device trust level
      driver core: Expose device trust authorization interfaces
      driver core: Accept device trust policy on the kernel command line
      driver core: Accept device trust policy by driver name
      driver core: Expose committed device trust level
      driver core: Cover trust authorization and binding with KUnit
      driver core: Document trust admission and initrd authorization
      PCI: Replace untrusted state with device trust
      USB: Authorize devices and interfaces through device trust

 Documentation/ABI/testing/sysfs-bus-drivers-probe  |   13 +
 Documentation/ABI/testing/sysfs-bus-usb            |   11 +
 Documentation/ABI/testing/sysfs-devices-trust      |   33 +
 Documentation/admin-guide/kernel-parameters.txt    |   29 +
 .../driver-api/driver-model/device-trust.rst       |  289 ++++
 Documentation/driver-api/driver-model/index.rst    |    1 +
 Documentation/usb/authorization.rst                |   20 +
 MAINTAINERS                                        |    2 +
 drivers/base/Makefile                              |    2 +-
 drivers/base/base.h                                |   31 +
 drivers/base/bus.c                                 |    9 +-
 drivers/base/core.c                                |   18 +-
 drivers/base/dd.c                                  |  108 +-
 drivers/base/test/Makefile                         |    1 +
 drivers/base/test/device-trust-test.c              | 1720 ++++++++++++++++++++
 drivers/base/trust.c                               |  406 +++++
 drivers/bluetooth/btusb_main.c                     |   42 +-
 drivers/cdx/cdx.c                                  |    2 +-
 drivers/input/gameport/gameport.c                  |   21 +-
 drivers/input/serio/serio.c                        |   24 +-
 drivers/iommu/amd/iommu.c                          |    3 +-
 drivers/iommu/dma-iommu.c                          |   14 +-
 drivers/iommu/intel/iommu.c                        |   17 +-
 drivers/iommu/iommu.c                              |   17 +-
 drivers/net/phy/phy_device.c                       |   29 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |    2 +
 drivers/pci/ats.c                                  |    4 +-
 drivers/pci/pci.c                                  |    5 +-
 drivers/pci/probe.c                                |   23 +-
 drivers/pci/quirks.c                               |    7 +-
 drivers/pnp/card.c                                 |   12 +-
 drivers/usb/core/driver.c                          |   29 +-
 drivers/usb/core/generic.c                         |    2 +-
 drivers/usb/core/hub.c                             |   17 +-
 drivers/usb/core/message.c                         |   34 +-
 drivers/usb/core/sysfs.c                           |    9 +-
 drivers/usb/core/trace.h                           |    2 +-
 drivers/usb/core/usb.c                             |    5 +-
 drivers/usb/core/usb.h                             |    4 +-
 include/linux/device.h                             |   20 +
 include/linux/device/bus.h                         |   10 +
 include/linux/device/trust.h                       |   47 +
 include/linux/pci.h                                |   30 +-
 include/linux/usb.h                                |   29 +-
 44 files changed, 2988 insertions(+), 165 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260915-device-trust-core-12934e618489

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

