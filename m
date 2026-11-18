Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030129;
	b=bGldiYGqX8QSZhLVJf/k2SkeRqPDoAHV/qR10Loa5Mq9/F1MhOOScjUVDxeIS84LMplR
	 GO18IZgH8VOO8FjnMyCtWrn0iUr/CzaEyU6ZSgEz7ML1CaaTXJ014Hw862D96Jdr61nA/
	 tC/wu9mDcflqikD7QgkZm4mux6LjjU8qOKrcVifsYQ9xvNCES13q7uerWAESxz//dSvfT
	 CgLxegKKHpEsUR+Vz0hrCQ01ju7S5t8n0BXlbDdgvC7eC8eF+YOMkS0E1pUS82XojL1NR
	 +Qn836Y8TegXDEB//tRRa2I21/2gc4olPreWJSr32fFyjzup9f6bC2g/36HvnyBBZow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030129;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=yDvVfD4XGROkqlQ6t/rdrEpB1IqmVmjUCkZ/2kUJqAc=;
	b=wMl41V21n9WMEzAoHiSQ8euTZMzBkzmWhn8RDTrrVmQ059/HHyxLt5qa/HJz/PtqI1gG
	 Ny2cchTQ2ImooNJn5B79A3eGouuuy/TaYQUS0dB4FWgE6Iy2m02vtJ4wQhMdhbyNo8Iu7
	 gy4PLasQ07Y4YtJsPKc35FO92+y9Tx9MKo4gqMGzjmWxBm6KAMrrgEN+kD8KMPybvKCA2
	 pFgDB8JVCQwJCkwM6crMsZY8bcYbkr/ssMMgowWSKj3Tw10yJPZu+pRhGMmGX2t+JYG/X
	 h9oc61L8qzqd0FLo9dGj6PD4FizdVLr/H7p9KQ8A2vPgOinZBfcnWwUV/N9SAio8NXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezAk30VY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8760606B125;
	Wed, 18 Nov 2026 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezAk30VY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FF41F000C4;
	Wed, 18 Nov 2026 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030129;
	bh=yDvVfD4XGROkqlQ6t/rdrEpB1IqmVmjUCkZ/2kUJqAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezAk30VYnRbpMbCNjIz6B9yXjadUXio8NcD87dyr8Lsgi4871qJE2Sw4g3Btt2vhl
	 rFXyF4AmjPcc29B18lm9p8w5GCbZKsbmcoedjx+PvDjpv3DavftJ2Rf4JnjL4Hcsfm
	 1+M3BDfvsIX9MOYzmy1g0mYnJqcstG1NF35T1mHyuR1VeCwgdVlmsK8oH/Hw5cMYId
	 Cr0XdZeCtynf+n3++KJN2cTR7ZohjWPW1uKTFQY6eUr7LTf7FNJ02SGb+Uq7COPlgW
	 8scImXuet37N8MouZgKIVIISVZ0SSa+bXn8OgN2smfCkLySiggOxueBYy7vXZ9VD8v
	 unBmgaHFIIdgw==
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
Subject: [PATCH v3 23/31] driver core: Expose committed device trust level
Date: Wed, 18 Nov 2026 21:26:53 +0200
Message-ID: <20261118-device-trust-core-v3-23-d655875c4bfb@nvidia.com>
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

After probe failure or unbind, active trust returns to blocked while the
accepted operating level remains committed. IOMMU state and other
infrastructure can outlive the driver, so active trust alone cannot tell
them which operating level was accepted.

Expose the retained commitment separately. This lets infrastructure honor
the original level after probe failure or unbind without mistaking inactive
driver state for a new authorization opportunity.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/base/trust.c         | 13 +++++++++++++
 include/linux/device/trust.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 03a56f85f0f33..bf4f2c8b31d09 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -155,6 +155,19 @@ enum device_trust_level device_get_trust_level(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_trust_level);
 
+/**
+ * device_get_committed_trust_level - Return the lifetime trust commitment
+ * @dev: device to inspect
+ *
+ * Return: %DEVICE_TRUST_BLOCKED before admission, otherwise the level fixed
+ * before driver setup. The commitment survives setup failure and unbind.
+ */
+enum device_trust_level device_get_committed_trust_level(const struct device *dev)
+{
+	return READ_ONCE(dev->trust_committed_level);
+}
+EXPORT_SYMBOL_GPL(device_get_committed_trust_level);
+
 /**
  * device_is_adversarial - Test whether a device is operated as an adversary
  * @dev: device to inspect
diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
index 0258e07f938d1..22d3a4dc768e8 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -48,6 +48,7 @@ int device_trust_set_policy_locked(struct device *dev,
 				   enum device_trust_policy policy);
 int device_trust_set_policy(struct device *dev, enum device_trust_policy policy);
 enum device_trust_level device_get_trust_level(const struct device *dev);
+enum device_trust_level device_get_committed_trust_level(const struct device *dev);
 bool device_is_adversarial(const struct device *dev);
 
 #endif /* _DEVICE_TRUST_H_ */

-- 
2.56.1

