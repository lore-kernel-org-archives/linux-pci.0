Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030038;
	b=W6Z0Zc8e7CyAHCqiq3xEB2+gT3AW08/eGTtC2GgINPY4ZELWX0lqIJmb8faxdGtdeoCr
	 1I80uNT85/R1iMkcg545sNduNM6UaUIQG73DtEiw5IlG+fLWVoj9R4v6+MeLgkyjCDwfF
	 XQhefAIurmFJ4CT/IbS2wHcOMHP2mbwFACSTsgO0tj3iBiJlRi4T4f9XH2t6Gzvq0sOq3
	 pKTTzJzlIhFGYgph+6mBxohUvrh6Y5HW8G81jQ2C9Vjml0K0eTIsoBYB4676iA63yyT+k
	 Vk1BUIr/W96cdN8oZfBcQOY44X2b816kFBNqCnQrsMvMDuhDdmqHYpJ4qSzBzN48BfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding;
	bh=BCQjSl+UyhKmnMy/FBBwR/Y4e953R9N1RQvuUIFqeFQ=;
	b=flpPtnm39v+R5IusfTqWCEA8gZVsuiQ+BXmRL/2ObC9vVm2AYKfkzutpmdm539j2pvDS
	 6f1cLt6m1WPwbkssvARHY6jgUPCD0XwdxXQOVy0p23dfKHE4KtVLKqUjaF/yxTxRvS0A7
	 YHtep93XwPVsUKc21cOAbZvXIiyvsjzgm1U8CHjW84Axk27f/RL/IA8ZIYyHpB9bKvAfV
	 en+uNgcWqdK8ue9k/ocZGChR120C9obei0FGQTeeqmRjetT+4NwSP1S/xnnHHb7eWP3fV
	 P5jJ6PHL+uJU0CM2nOSBwybtnnRX+FIBYJw75mgBeA8gxqYr3qU/YLHxDTq6M6MzPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Lbe58D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E33606A320;
	Wed, 18 Nov 2026 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Lbe58D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01CE1F000C7;
	Wed, 18 Nov 2026 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030037;
	bh=BCQjSl+UyhKmnMy/FBBwR/Y4e953R9N1RQvuUIFqeFQ=;
	h=From:To:Cc:Subject:Date;
	b=a8Lbe58DBMpEAxA4r5TOCAf5iBHegruQvn97EQlvPBNS2hiv5VsV2CjJBwo5W4mbu
	 oIAeInveN8MblMw+kpDuK/6mgRi7IVOyBJgREqeYEktOY4OdPuKAdqaD/1LZ20CRde
	 cgCB5ZP2dBG7mPXEBP+kgSrAfcRezYxd036OqOPLAcwE8a9aZ3/17QJ4xnzwgyH0F4
	 c+9BE02vkk76YO/ShOPrfbD2oCU8ah/bI6m/UvTFN0RjS5sr55RkzcZsmiglLh0C7D
	 5LHv5ObEfaX5sUGCO0BqnpYBDm1TVF19qfO7cDynDmqHe1qmxvcri9pvkK3ecNS17h
	 mKbVdiaPFFVSw==
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
Subject: [PATCH v3 00/31] driver core: Authorize device trust before driver binding
Date: Wed, 18 Nov 2026 21:26:30 +0200
Message-ID: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
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
                                    PCI: use platform trust policy; keep
                                      existing domain and ATS decisions.
                                    USB: devices and interfaces denied by
                                      USB defaults wait for authorization
                                      before binding.

device_trust.default=blocked        General: block driver binding until
                                      authorization.
                                    PCI: keep existing domain and ATS
                                      decisions while binding is blocked.
                                    USB: leave devices and interfaces
                                      unbound until authorized.

device_trust.default=adversary      General: allow binding as an adversary.
                                    PCI: keep existing platform-based DMA
                                      handling, domain and ATS decisions.
                                    USB: allow binding as an adversary,
                                      overriding USB authorization
                                      defaults.

device_trust.default=unrestricted   General: allow unrestricted binding;
                                      freeze trust policy changes.
                                    PCI: unrestricted active trust; keep
                                      existing domain and ATS decisions.
                                    USB: authorize devices and interfaces
                                      regardless of USB defaults.

device_trust=...                    General: matching rules select policy;
or device_trust.driver=...            unmatched devices stay blocked.
without an explicit default         PCI: rules select admission policy;
                                      existing domain and ATS decisions
                                      remain.
                                    USB: matching rules select device or
                                      interface policy.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
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
Leon Romanovsky (31):
      wifi: mac80211_hwsim: lock device for manual driver binding
      Bluetooth: btusb: Fix MediaTek ISO claim locking
      USB: Lock interfaces during manual driver binding
      USB: serial: Register USB drivers with their owning module
      USB: Reject claims of DT-disabled interfaces
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
 Documentation/admin-guide/kernel-parameters.txt    |   35 +
 .../driver-api/driver-model/device-trust.rst       |  323 +++
 Documentation/driver-api/driver-model/index.rst    |    1 +
 Documentation/usb/authorization.rst                |   37 +
 MAINTAINERS                                        |    2 +
 drivers/base/Makefile                              |    2 +-
 drivers/base/base.h                                |   52 +
 drivers/base/bus.c                                 |    9 +-
 drivers/base/core.c                                |   52 +-
 drivers/base/dd.c                                  |  192 +-
 drivers/base/test/Makefile                         |    1 +
 drivers/base/test/device-trust-test.c              | 2461 ++++++++++++++++++++
 drivers/base/trust.c                               |  508 ++++
 drivers/bluetooth/btusb_main.c                     |   57 +-
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
 drivers/usb/core/driver.c                          |  121 +-
 drivers/usb/core/generic.c                         |    2 +-
 drivers/usb/core/hub.c                             |   39 +-
 drivers/usb/core/message.c                         |  106 +-
 drivers/usb/core/sysfs.c                           |    9 +-
 drivers/usb/core/trace.h                           |    2 +-
 drivers/usb/core/usb.c                             |    5 +
 drivers/usb/core/usb.h                             |    6 +-
 drivers/usb/serial/usb-serial.c                    |    4 +-
 include/linux/device.h                             |   21 +
 include/linux/device/bus.h                         |   10 +
 include/linux/device/trust.h                       |   54 +
 include/linux/pci.h                                |   18 +-
 include/linux/usb.h                                |   25 +-
 include/linux/usb/serial.h                         |    4 +-
 sound/usb/card.c                                   |    7 +
 47 files changed, 4190 insertions(+), 213 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260915-device-trust-core-12934e618489

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

