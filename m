Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030133;
	b=UKI6PnzQ8dja858e6CuBkth5G+eyz/Ca7xAlggjdlCMQbdpoBg1PRA9L1lIJZagysQxu
	 OjwPo1lMh7H9Z+BABnI8ICjhaJWz4LU58iE53kQ9ZR4wmQKzyzoP6e0OVa/ohWzIT4+vC
	 UQdyaxj/k2ZIAHQR/C6QFa27EYLlhThtz7Nn0rLBIIA4biJ3erssULtC9EM1WzeSxIt9W
	 Yyc+NTwp6a9Zq7LrlZ0O/ffr7Zd3TbZXHAWsNFL2tRg+vmtj8rlojEX1sof/rARcDlbVX
	 k4Mu3CVLgFguRKG1gy9xCZr1At1PFCgIQBT+k8vy1PQfY+IMb7v0KZ3NKTZiGaqddtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=8ql7Gs6IPvDUW+2y3xzhQuwvMgWp9DTIXsnZOX9sE1g=;
	b=o+2lrTpDy8M3lPO3fAp22/iFMEGksW08AuNvsK5G/GH4UPk0GcydxG/CUPI/F9BXTTBc
	 NXNevq9yaSIi8sLJvZFti/1Ra4+9uhHQBzEYwbwtZKyl7EcNJW1OIM7rP0hn6cPASio0s
	 tm/HvaO45olg51W785aNj2Qe16XMUqtHbBrluJg03FzG9re6sqRQFKKYiPo1e25TGj9uN
	 z0k17fMq9Yn+aygrOAKBqq3mKce8mTJjcaSqd4CK+cxBIGFY3+BwEDKg7XHNJep5FzHQR
	 ZCwz0LjI8O50wWePD9G5GzK/NLBbjy6g8fXcxfxMWG/xw0U131q7hu030TmWTFjiY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qsr5VKX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E6606A33D;
	Wed, 18 Nov 2026 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qsr5VKX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE431F000CA;
	Wed, 18 Nov 2026 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030133;
	bh=8ql7Gs6IPvDUW+2y3xzhQuwvMgWp9DTIXsnZOX9sE1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qsr5VKX7dEHW6nEP/mXkYfFjekNc43hPvpq/jbgU3kkZJ8KveVWrhEptPbINSdOJX
	 pzbunSL5gp/6veEIwGYXkKkyiYekdGKD5H14CqFpQnWSNQYi5qB3ngc7HnZaq6Lvyw
	 ha0s1nwXRPKzYhY12Bq5usLxZm+dvL+6CQt+kXRmGe/oTznJeKt+5HOWpcFRTNpVxu
	 MtEBqafEgP1ZA+x06kl/1aXql2EWAmsXlDodZbuXK6/yuk+aQ+k2qOq8PbwAlz/6cs
	 wK8Br1GB502oGBece2uXydKfwbaSSXeXBa1biPzTRzxKsdLumaxniiCQlBDRkTKX1m
	 /gaoIt4/hxXjA==
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
Subject: [PATCH v3 25/31] driver core: Document trust admission and initrd authorization
Date: Wed, 18 Nov 2026 21:26:55 +0200
Message-ID: <20261118-device-trust-core-v3-25-d655875c4bfb@nvidia.com>
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

Allowing a driver to bind does not establish device identity or prevent DMA
initiated by the hardware. An initrd that treats those as equivalent could
authorize a device before attestation or containment is ready.

Document the authorization workflow and the division of responsibility
between userspace, driver core and bus infrastructure. Explain which
decisions survive probe failure and unbind, and when queued probes may
start, so policy agents can prepare the device before granting access.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../driver-api/driver-model/device-trust.rst       | 323 +++++++++++++++++++++
 Documentation/driver-api/driver-model/index.rst    |   1 +
 2 files changed, 324 insertions(+)

diff --git a/Documentation/driver-api/driver-model/device-trust.rst b/Documentation/driver-api/driver-model/device-trust.rst
new file mode 100644
index 0000000000000..5c06f3a3340c2
--- /dev/null
+++ b/Documentation/driver-api/driver-model/device-trust.rst
@@ -0,0 +1,323 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Device trust
+============
+
+Device trust controls how the kernel uses a device. It does not verify the
+device's identity or firmware. Driver core tracks the requested policy,
+permission to bind, and active trust level separately.
+
+Policy and active trust
+=======================
+
+The writable ``trust_policy`` attribute accepts ``default``, ``blocked``,
+``adversary``, or ``unrestricted``. The bus may set the initial policy;
+otherwise it starts as ``default``. Boot options can override it for all
+devices, a named driver, or an individual device. See `Boot policy`_ for
+precedence.
+
+The read-only ``trust`` attribute reports the active trust level:
+
+``DEVICE_TRUST_BLOCKED`` (``blocked``)
+  There is no active driver setup or binding. The requested policy decides
+  whether a later bind is allowed.
+
+``DEVICE_TRUST_ADVERSARY`` (``adversary``)
+  The device is classified as potentially malicious. Protections depend
+  on bus, DMA, and driver support; classification alone adds none.
+
+``DEVICE_TRUST_UNRESTRICTED`` (``unrestricted``)
+  The device uses the normal privileges allowed by the bus and DMA policy.
+
+Policy resolution
+=================
+
+A bus can implement ``bus_type::trust_resolve`` to choose the active level
+from the device, candidate driver, and requested policy. For ``default``,
+it may use topology or firmware information. Other policies must resolve
+to the matching level or fail.
+
+The callback must not enable the device or grant DMA access. Those steps
+belong in setup callbacks, after resolution and before probe.
+
+Without this callback, ``default`` and ``unrestricted`` resolve to
+``DEVICE_TRUST_UNRESTRICTED``, and ``adversary`` to
+``DEVICE_TRUST_ADVERSARY``. Explicit ``blocked`` blocks binding.
+Enforcement is provided separately by bus, DMA, and driver code.
+
+Admission and policy writes
+===========================
+
+Authorization is userspace's choice of adversary or unrestricted for a blocked
+device. Commitment happens when the kernel accepts a policy and operating
+level, before starting driver setup. Both limit later policy changes.
+
+Without device trust boot options, legacy unrestricted mode preserves bus
+defaults and existing bus authorization. Buses can use
+``device_trust_enabled()`` to distinguish this mode from boot opt-in.
+Changes through ``trust_policy`` are disabled. An explicit
+``device_trust.default=default`` enables them while preserving bus
+defaults; device and driver boot rules also opt in.
+
+With ``device_trust.default=unrestricted``, runtime policy changes are
+unavailable for every device, including devices with a boot policy
+exception. Writing a different policy returns ``-EBUSY``. Writing the
+current policy succeeds without changing state or suppressing a pending
+driver boot rule. Boot device and driver rules retain their precedence.
+
+When enabled, runtime policy writes follow the internal states
+below; these are not additional sysfs values.
+``P`` is the requested policy and ``L`` is the committed operating level.
+
+.. list-table:: Admission states
+   :header-rows: 1
+   :widths: 25 40 35
+
+   * - State
+     - Meaning
+     - Policy writes
+   * - SELECTABLE
+     - The device has not been authorized or committed.
+     - Any policy is allowed. Selecting blocked enters WAITING.
+   * - WAITING
+     - Policy is blocked - no operating level is committed.
+     - Choose adversary or unrestricted to enter AUTHORIZED(P).
+   * - AUTHORIZED(P)
+     - Userspace has chosen adversary or unrestricted from WAITING.
+     - The policy cannot change, even before setup begins.
+   * - COMMITTED(P, L)
+     - The kernel has accepted P and L for setup.
+     - Neither the policy nor the operating level can change.
+
+Bus defaults and boot options set the initial state: blocked starts in
+WAITING; other policies start in SELECTABLE. Driver boot rules apply later,
+when a matching driver attempts to bind. They may still replace this
+initial state, including WAITING, unless a per-device boot entry or a
+successful policy write takes precedence.
+
+Userspace cannot move WAITING back to SELECTABLE by writing ``default``.
+Choosing adversary or unrestricted from WAITING locks that policy immediately.
+
+After boot initialization, the state transitions are::
+
+  SELECTABLE ----select blocked----> WAITING
+      |                                 |
+      |                             authorize
+      |                       adversary/unrestricted
+      |                                 |
+      |                                 v
+      |                            AUTHORIZED(P)
+      |                                 |
+      +------ permitted resolution -----+
+                       |
+                       v
+                 COMMITTED(P, L)
+
+Binding and device lifetime
+============================
+
+A manual bind that reaches WAITING returns ``-EPERM`` before driver or DMA
+setup. Automatic matching skips the rejected driver and tries the next
+candidate. Rejected attempts leave the device waiting for authorization
+through an enabled policy interface.
+
+Active trust stays at L through DMA setup, probe, operation, removal, and
+``bus_type::dma_cleanup``. It returns to blocked only after cleanup ends.
+
+The state lasts for the device object's lifetime, including the switch
+from initrd to the root filesystem. Unbinding and rebinding a registered
+device does not reset it. A removed device cannot be registered again; a
+new object starts with bus and boot policy.
+
+Bus code that operates a device before ``device_add()`` must call
+``device_trust_prepare(dev, drv)`` with the device lock held before driver
+setup. Registration preserves the admitted policy and commitment. After
+setup fails or the claimant stops using the device, call
+``device_trust_clear()`` under the same lock to clear active trust while
+retaining the commitment.
+
+Compatibility attachment
+========================
+
+This compatibility API **must not be used in any new code**. Its
+unrestricted-only restriction prevents devices from using the device trust
+authorization infrastructure. New code must use ``device_driver_attach()``.
+
+``device_driver_attach_unrestricted()`` supports manual attachment with the
+caller's existing subsystem serialization. It requires a policy that
+resolves to unrestricted and either no device trust boot options or an
+explicit ``device_trust.default=unrestricted``. Other configurations return
+``-EPERM`` before calling the driver. The legacy case preserves bus
+defaults. Buses implementing ``trust_resolve`` must use
+``device_driver_attach()``.
+
+Per-device boot exceptions still apply: blocked and adversary reject
+attachment. If a ``device_trust.driver=`` list is configured, the device
+must also have an explicit ``device_trust=`` entry; otherwise this API
+returns ``-EPERM``. That entry prevents a concurrent driver rule from
+changing the policy.
+
+The caller provides the subsystem's existing manual-binding serialization
+and excludes bus-specific policy changes. Binding and removal are
+serialized separately; an overlapping transaction returns ``-EBUSY``.
+Holding the device lock alone does not prevent attachment. The API takes
+neither the device nor parent lock, commits unrestricted before the probe
+callback, and publishes the binding after probe succeeds. It does not
+perform normal driver-core DMA, pinctrl, or power-domain setup. A failed
+probe or binding clears active trust but retains the unrestricted
+commitment.
+
+Boot policy
+===========
+
+Built-in drivers can probe before userspace starts. Use boot options to
+set their initial policy. All three options accept default, blocked,
+adversary, and unrestricted.
+
+Any option in the ``device_trust`` namespace selects blocked as the
+implicit default, including missing values and unrecognized options.
+The bare ``device_trust`` option enables this default without device entries.
+``device_trust.default=`` overrides this default regardless of option
+order; the last valid value wins. Explicit default preserves bus policy.
+Other values replace bus policy, including topology and removability
+defaults.
+
+``device_trust=`` sets policy for individual devices using a comma-separated
+list of ``<bus>:<device>=<policy>`` entries. Names must match
+``/sys/bus/<bus>/devices/<device>`` exactly. The first colon separates the
+bus name; later colons are part of the device name. Names cannot contain
+whitespace, control characters, commas, equals signs, or double quotes.
+Wildcards are not supported.
+
+A device entry overrides driver rules, the global setting, and bus policy,
+regardless of option order. Explicit default asks the bus or generic
+resolver to choose a level, even if the global setting is blocked. The
+last entry for a device wins. If the option is repeated, the last valid
+list replaces all earlier lists. A malformed list is ignored in full,
+with a warning.
+
+``device_trust.driver=`` sets policy by driver name using a comma-separated
+list of ``<bus>:<driver>=<policy>`` entries. Use exact names from
+``/sys/bus/<bus>/drivers/<driver>``, not module names or aliases. Driver
+names may contain spaces; quote the option when they do. Other name
+restrictions and list handling are the same as for device entries. The two
+lists are independent. Driver rules cover built-in drivers, modules, and
+hotplug.
+
+The first bind attempt with a matching driver rule applies it before
+resolution and setup. It overrides bus and global defaults, including
+global blocked. It cannot override a per-device entry or an existing
+authorization or commitment. A successful sysfs policy write also takes
+precedence, except for a no-op write with
+``device_trust.default=unrestricted``. The rule applies only once per
+device object, even if resolution or setup fails.
+
+After a blocked driver rule applies, rejected probes and driver changes
+leave the device in WAITING. Userspace can authorize it unless the global
+mode is unrestricted. A driver without a matching rule follows the device's
+current policy.
+
+An initrd can hold devices with ``device_trust.default=blocked`` and use
+boot exceptions for devices and suppliers needed to reach the initrd and
+perform attestation. These exceptions allow operation before fresh initrd
+attestation. Devices without an exception stay blocked even if their bus
+would normally choose adversary or unrestricted.
+
+Global and per-device rules apply before device registration. Buses that
+need policy earlier call ``device_trust_init()`` after setting the bus,
+name, and initial policy. Driver rules apply later, when a candidate driver
+is known.
+
+All boot rules remain available for newly discovered devices. Initialize
+boot policy before device registration. These options are not runtime
+controls or proof of hardware identity. Blocked blocks early binding and,
+outside global unrestricted mode, allows later authorization. Adversary and
+unrestricted permit early binding without fresh initrd attestation.
+
+DMA containment
+===============
+
+Blocked blocks driver binding, not DMA that hardware starts on its own.
+The bus and IOMMU must provide containment while a device waits for
+authorization.
+
+Adversary does not require an IOMMU. Without an IOMMU group, or with IOMMU
+support compiled out, binding uses the platform's normal DMA configuration.
+Adversary policy alone does not provide DMA isolation.
+
+Device trust admission does not change DMA handling, IOMMU domain selection,
+or ATS permission according to active trust. Those remain governed by existing
+bus and platform mechanisms. Integrating them with admission is separate
+work. A setup failure after commitment leaves the chosen mode fixed; it
+cannot fall back to unrestricted.
+
+Drivers that manage DMA themselves must provide their own containment.
+Drivers that do not use DMA need no domain.
+
+Initrd attestation sequence
+===========================
+
+Drivers with init-only probe callbacks cannot retry a binding held by
+blocked policy. They need a boot exception or a persistent probe callback.
+
+For a device that uses normal driver attachment:
+
+1. Boot with ``device_trust.default=blocked`` to hold all devices. To
+   hold selected devices, use ``device_trust.default=default`` with
+   per-device blocked rules. Add exceptions needed to reach the initrd
+   and provide DMA containment while waiting. Blocked attempts remain
+   in WAITING, including attempts by built-in drivers.
+
+2. In the initrd, control probing and attest the current device through a
+   transport that works without its functional driver. Keep policy blocked
+   during verification and preparation. Leave it blocked if verification
+   fails or is unavailable. Removal or replacement invalidates the result;
+   a reused bus address is not proof of identity. Repeat attestation if a
+   reset or preparation step invalidates the evidence.
+
+3. Once all checks and preparation are complete, write adversary or
+   unrestricted to ``trust_policy``. This locks the choice and allows
+   binding.
+
+4. Request binding through ``drivers_probe`` or another attach path. The
+   kernel commits the operating level before setup. Retries keep the same
+   policy and level. Retry if the interface reports ``-EAGAIN``. A scan
+   can skip rejected candidates without returning an error, and a
+   successful ``drivers_probe`` write need not wait for a concurrent probe.
+
+The ``driver`` link appears before probe completes. To observe successful
+binding, start monitoring ``bind`` uevents before authorization and
+correlate them with the current device lifetime, or use a successful
+synchronous per-driver bind operation. Link visibility alone is not a
+completion signal.
+
+Queued or concurrent probes may start as soon as step 3 completes, before
+step 4. Evidence must still be valid when authorizing the device.
+Boot exceptions that permit adversary or unrestricted allow early operation
+without fresh initrd attestation.
+
+The kernel interface provides neither an attestation transport nor a verifier.
+
+Driver use and independent properties
+=====================================
+
+Drivers read active trust with ``device_get_trust_level()`` or
+``device_is_adversarial()``. They may cache it while bound, but must not
+change requested policy or treat trust as proof of other security
+properties. Use the adversary check for paths that bypass the DMA API.
+General DMA containment belongs in bus and IOMMU code.
+
+Code that needs the level fixed for the device's lifetime can use
+``device_get_committed_trust_level()``. It returns blocked before
+commitment and the fixed level afterwards, including after failed setup
+or unbind. It does not permit operation while unbound.
+
+Trust does not describe transport protection, encryption, verified
+identity, memory privacy, or DMA addressability. Keep these properties
+independent of the requested policy and active trust level.
+
+Policy writes cannot revoke authorization or switch an operating device
+between adversary and unrestricted. Stopping it requires a separate
+procedure to quiesce the driver, tear down DMA, and contain the device on
+its bus.
diff --git a/Documentation/driver-api/driver-model/index.rst b/Documentation/driver-api/driver-model/index.rst
index abeb4b36636b6..af547cd13b2c4 100644
--- a/Documentation/driver-api/driver-model/index.rst
+++ b/Documentation/driver-api/driver-model/index.rst
@@ -9,6 +9,7 @@ Driver Model
    bus
    design-patterns
    device
+   device-trust
    devres
    driver
    overview

-- 
2.56.1

