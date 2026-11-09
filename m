Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209690;
	b=Q75DFzkMkgIR4WbJCu6hd7MV0NI9F04jAmSwnOY7uM8qtypl4fbKSTG7iPQkfC3SIYmS
	 bAj5LFX03lBEhf3YDod+6BZXoRh7fwN8x0WGwi23meE2iyEkIvSsxAn45jiMeWT9Fhipm
	 ZlXz6erUf7QFIvzw8SX0oCZhNvAnp/OM28MxR6JnJ6R6+8Juqg39bDW61emD2tMTEbVZM
	 5mbRZ2Zw2DdjYE1mqmNvC3kGKNET8dCNQ2/8hVJOTM2dIbVHDFR5WHX7GQfStbckFlsGR
	 HLIu5e8qQ48bi4R22F5cAe21NeCFlj9/xvwYRL6qalL/a+X2GZ9nZyU+Spf0Uj7C0eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Mz8AXu/UZmuCcqZREPjQc9nW4LF1v2AIqPDriU8p2gM=;
	b=ibHncncJYfnabNw2MQ0fUF1A7Ul9z2fxsGPPBUQAqnV3sFiFVnw0G1wSgp4MR+Sjsf+O
	 Io8JCeQDl5FBwFWhYHyy8AbHZA61sgEu7seNoEy1bEb5kh0dul0yLj0w7SAF9WV3ThbK1
	 U0ZrCoSjKRiZUSvnBgycO2YVWKUuarghZgqcSK5GrYsrHaJLXQ4b/S/7sMS9alLe13c95
	 f6xZ8NQCvOn7TcAuBqb9j0cLiDcXndnYs73VhDmnpMNt7nch5b+AD9czJvUdZVNTkp139
	 BmrZMtys5asIDwTTZKXbknHEG/6XOxS8IzdVk3mkVKJXvI2w3DuKWSvbfCcdHW8bQqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Brs/1/m6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBCA606B405;
	Mon,  9 Nov 2026 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Brs/1/m6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34BA1F008A2;
	Mon,  9 Nov 2026 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209689;
	bh=Mz8AXu/UZmuCcqZREPjQc9nW4LF1v2AIqPDriU8p2gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Brs/1/m6NdBI9NBGZ6bvDBC1p/1LQ6Wr/mJVT2LlMj/tEtmEQO57PvprcowFnJT0Y
	 Itea69hZnB5riJSfxpDQGqyZ2ny5p3ayaFW/xhtpw+mA5uHepseIGv3eJFq4BGmKju
	 YBGtBlDevC4sYQ0+e2ru2JmyCjiPrthzo2URgipJJfXv8rFizZ3kZKc/ixqTBOWjgw
	 jRWkiWecnUy+dSH5dfcWIgVZtafBZr86FBua7Bjm2J94wO9EQ7iqNtg0NqlGV2IDAt
	 0oPhdB/VHlyDYrOZ5IqUKzkxb9HJQGAGnEmnpYE3JEgu7aqRDfhay2UvymyBoxNjpZ
	 XSHF9tgYkYvCw==
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
Subject: [PATCH v2 15/19] driver core: Expose committed device trust level
Date: Mon,  9 Nov 2026 09:33:45 +0200
Message-ID: <20261109-device-trust-core-v2-15-3b12d9a9f861@nvidia.com>
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

IOMMU state can outlive a functional driver, including after failed setup
and unbind. The active trust level becomes disabled in those states, so
infrastructure needs access to the retained authorization.

Export device_get_committed_trust_level() to expose the existing lifetime
commitment independently of the active binding.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/base/trust.c         | 13 +++++++++++++
 include/linux/device/trust.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/trust.c b/drivers/base/trust.c
index 2bec6825ef31e..f79762e201178 100644
--- a/drivers/base/trust.c
+++ b/drivers/base/trust.c
@@ -93,6 +93,19 @@ enum device_trust_level device_get_trust_level(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_trust_level);
 
+/**
+ * device_get_committed_trust_level - Return the lifetime trust commitment
+ * @dev: device to inspect
+ *
+ * Return: %DEVICE_TRUST_DISABLED before admission, otherwise the level fixed
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
index 9d6d387d01203..decf5aaf2d46d 100644
--- a/include/linux/device/trust.h
+++ b/include/linux/device/trust.h
@@ -41,6 +41,7 @@ enum device_trust_policy {
 void device_trust_init(struct device *dev);
 int device_trust_set_policy(struct device *dev, enum device_trust_policy policy);
 enum device_trust_level device_get_trust_level(const struct device *dev);
+enum device_trust_level device_get_committed_trust_level(const struct device *dev);
 bool device_is_adversarial(const struct device *dev);
 
 #endif /* _DEVICE_TRUST_H_ */

-- 
2.56.0

