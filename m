Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513457;
	b=MXDvT1veisZNEbpckXlUNmubq3qvDs10bLw7xROHnCUgbhgftn8KNBPfaD6QmHu4oqF/
	 1DW38P5Ub2JVawzH02f9JpN4DgoWzkCKFEZzN5MtQm+ku78drVYvonZRJVAXq1TF86uWO
	 QERRQmzv8rzQdDhVGAxW/1tgLrTavEo9YIBKy4afElMR0IX81XScHvgmkh4TmlKxaa3AW
	 pYN+hQFWmNK5oL7ijX39gfFSbaMpcz5dKiA/u0cuDoSwMdChQFK2iaMY4fP8/Muqvfqtn
	 gEO15uKGd/Pg0eyQsVLg1PzjyhAx5jDNVsh80tYcIvQOhtoqBd/Fn6AFjqgTGESeZCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding;
	bh=MVyh89LSnjdyTdIzBNZRkbM9Weu4yYexQ4Ew0x0v/rQ=;
	b=VaZMYQUpuLoFjJNs4yBMst+ZztBG9QMqwE44Xz2pEb2INQNNINa6jcVA/G7MzzH2D6LO
	 /c7oqyb+HXR0t0G9OYueczLYHKu1slF9xejmWdXLXwWay55bRtE+7V68eknWbg9hK15fQ
	 2w15KRWzQJE2uS4HqYN/CMkYRF+Gzvb0cPeXJKOL1a/HyoyO7WhYCmx8iH9y/3FeyQHZs
	 1h7O5eRTeYWL0aZiH5DCHpoS2Bk3CpD/bRUXWfRuamcdf3KyTUoTlXiumPSZSScrHi7rv
	 E4phhCe35S90wSHoo9h8+dxdLT+7gHIcamuvAHBL7foxnyjO31ORISjryEKA+hWmCSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPz5Kqpd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11F606A336;
	Tue, 24 Nov 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPz5Kqpd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270941F000C0;
	Tue, 24 Nov 2026 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513457;
	bh=MVyh89LSnjdyTdIzBNZRkbM9Weu4yYexQ4Ew0x0v/rQ=;
	h=From:To:Cc:Subject:Date;
	b=dPz5KqpdK9nRPKUG6HUSe0vOj09Sy3JXT3OmWwG6jKg0jPV//81DZIrqZ9cs4jXkP
	 e5jysJUgPxSHDEdvRIBPlMnRhve/j0ygvAMePt1RCUH45XYZvtV/aeyfIK/X1Ifn2B
	 ctYWo+8swz85c0hjAjpMsVLPTHzme8kWcSexD1DD291wZLjXDenM0/ykH4wFjGdmCo
	 +NEsrDDUg5fjAhyDjb5L5BMmR/S5qSXaJotzaodPFCvmwbSA5grmcSX1/GcsctGDt/
	 UtKyMHvV7Vr4u82Zoh4tL4cn07Ykj9ze1498N1xgF/MZn7PEu+qOtnZEmsE7mJUa73
	 hyuQsDuJkX2cw==
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
Subject: [PATCH v4 00/33] driver core: Authorize device trust before driver binding
Date: Tue, 24 Nov 2026 11:43:31 +0200
Message-ID: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
X-Mailer: git-send-email 2.56.1
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

This series introduces device trust policy, authorization, and lifetime
commitment. Authorization does not reconfigure ATS capabilities or replace
IOMMU domains selected during discovery and further ATS and IOMMU integration
will follow in a separate series.

The table below tries to summarize the possible kernel command line
options and system behavior after that:

Command line                        Initial behavior
----------------------------------  ---------------------------------------
No device_trust options             General: existing driver binding.
                                    PCI: existing ACPI/topology
                                      restrictions.
                                    USB: existing authorized sysfs flow.

device_trust.default=default        General: use each bus's initial policy.
                                    PCI: keep the platform classification
                                      and its restrictions; device rules
                                      can replace it.
                                    USB: devices and interfaces denied by
                                      USB defaults wait for authorization
                                      before binding.

device_trust.default=blocked        General: block driver binding until
                                      authorization.
                                    PCI: restrict every device from
                                      discovery; authorization does not
                                      revisit domain and ATS decisions.
                                    USB: leave devices and interfaces
                                      unbound until authorized.

device_trust.default=adversarial    General: allow adversarial binding.
                                    PCI: restrict every device as
                                      adversarial.
                                    USB: allow adversarial binding,
                                      overriding USB authorization
                                      defaults.

device_trust.default=unrestricted   General: allow unrestricted binding;
                                      freeze trust policy changes.
                                    PCI: replace the platform
                                      classification; removable devices
                                      lose their DMA restrictions.
                                    USB: authorize devices and interfaces
                                      regardless of USB defaults.

device_trust=...                    General: matching rules select policy;
or device_trust.driver=...            unmatched devices stay blocked.
without an explicit default         PCI: rules replace the platform
                                      classification; a device rule of
                                      default resolves to unrestricted.
                                    USB: matching rules select device or
                                      interface policy.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v4:
- Documentation, commit messages e.t.c
- Don't fail BT device initialization if WiFI USB claim fails/
- Rename "adversary" to "adversarial" as was agreed at the beginning.
- Added new patch to drain usbfs during disconnect.
- Added another new patch to reject usbfs connect requests for
  unregistered interfaces.
- Link to v3: https://patch.msgid.link/20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com

Changes in v3:
- Rewrote all commit messages
- Split USB patches to smaller chunks
- Introduced special device attach function which works only in
  untrusted mode
- Remove the special PHY -EBUSY IRQ handling.
- Clarify that further ATS and IOMMU integration follows separately.
- Link to v2: https://patch.msgid.link/20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com

Changes in v2:
- Replace the serio and PHY attachment conversions with
  device_driver_attach_unrestricted(), restricted to device_trust.default=unrestricted.
- Add USB authorization on top of device trust: export
  device_trust_set_policy() and convert the USB authorized attributes.
- Documentation and commit messages fixes
- Small USB patches rewrote and split
- Link to v1: https://patch.msgid.link/20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com

---
Leon Romanovsky (33):
      wifi: mac80211_hwsim: lock device for manual driver binding
      Bluetooth: btusb: Fix MediaTek ISO claim locking
      USB: Lock interfaces during manual driver binding
      USB: serial: Register USB drivers with their owning module
      USB: Reject claims of DT-disabled interfaces
      USB: Reject usbfs connect requests for unregistered interfaces
      USB: Release interface claims according to binding state
      USB: Reject claims after interface registration failure
      ALSA: usb-audio: Release interface claims when probe fails
      USB: Pin modules for unregistered interface claims
      USB: Add helpers to release unpublished interface claims
      USB: Unwind interface claims after registration or binding failure
      PNP: Attach card devices through the driver core
      cdx: Propagate DMA configuration errors
      driver core: Report deferred probes through sysfs drivers_probe
      driver core: Add a compatibility API for manual driver attachment
      Input: gameport - use the compatibility driver attachment API
      Input: serio - use the compatibility driver attachment API
      net: phy: Use the compatibility driver attachment API
      USB: Drain usbfs when a device is unregistered
      driver core: Introduce a generic device trust level
      driver core: Expose device trust authorization interfaces
      driver core: Accept device trust policy on the kernel command line
      driver core: Accept device trust policy by driver name
      driver core: Expose committed device trust level
      driver core: Cover trust authorization and binding with KUnit
      driver core: Document trust admission and initrd authorization
      PCI: Use device trust for platform restrictions
      iommu: Use device trust for DMA restrictions
      driver core: Allow driver attachment with the device lock held
      USB: Retain the result of configuration requests
      USB: Authorize interfaces through device trust
      USB: Authorize devices through device trust

 Documentation/ABI/testing/sysfs-bus-drivers-probe  |   14 +
 Documentation/ABI/testing/sysfs-bus-usb            |   18 +
 Documentation/ABI/testing/sysfs-devices-trust      |   37 +
 Documentation/admin-guide/kernel-parameters.txt    |   37 +
 .../driver-api/driver-model/device-trust.rst       |  343 +++
 Documentation/driver-api/driver-model/index.rst    |    1 +
 Documentation/usb/authorization.rst                |   37 +
 MAINTAINERS                                        |    2 +
 drivers/base/Makefile                              |    2 +-
 drivers/base/base.h                                |   52 +
 drivers/base/bus.c                                 |    9 +-
 drivers/base/core.c                                |   52 +-
 drivers/base/dd.c                                  |  192 +-
 drivers/base/test/Makefile                         |    1 +
 drivers/base/test/device-trust-test.c              | 2487 ++++++++++++++++++++
 drivers/base/trust.c                               |  509 ++++
 drivers/bluetooth/btusb_main.c                     |   55 +-
 drivers/cdx/cdx.c                                  |    2 +-
 drivers/input/gameport/gameport.c                  |   22 +-
 drivers/input/serio/serio.c                        |   29 +-
 drivers/iommu/amd/iommu.c                          |    3 +-
 drivers/iommu/dma-iommu.c                          |   14 +-
 drivers/iommu/intel/iommu.c                        |   14 +-
 drivers/iommu/iommu.c                              |    9 +-
 drivers/net/phy/phy_device.c                       |   28 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |    2 +
 drivers/pci/ats.c                                  |    4 +-
 drivers/pci/pci.c                                  |    5 +-
 drivers/pci/probe.c                                |   18 +-
 drivers/pci/quirks.c                               |    7 +-
 drivers/pnp/card.c                                 |   12 +-
 drivers/usb/core/devio.c                           |   12 +-
 drivers/usb/core/driver.c                          |  118 +-
 drivers/usb/core/generic.c                         |    2 +-
 drivers/usb/core/hub.c                             |   42 +-
 drivers/usb/core/message.c                         |  104 +-
 drivers/usb/core/sysfs.c                           |    9 +-
 drivers/usb/core/trace.h                           |    2 +-
 drivers/usb/core/usb.c                             |    6 +
 drivers/usb/core/usb.h                             |    7 +-
 drivers/usb/serial/usb-serial.c                    |    4 +-
 include/linux/device.h                             |   21 +
 include/linux/device/bus.h                         |   10 +
 include/linux/device/trust.h                       |   54 +
 include/linux/pci.h                                |   18 +-
 include/linux/usb.h                                |   25 +-
 include/linux/usb/serial.h                         |    4 +-
 sound/usb/card.c                                   |    7 +
 48 files changed, 4246 insertions(+), 216 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260915-device-trust-core-12934e618489

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

