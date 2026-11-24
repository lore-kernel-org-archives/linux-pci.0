Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513576;
	b=Ztcnt6yshtn2dWMNpZZMJ8+QAnUqlx1OviYtb3uI/9ctx2aqWMBjTVga+PipmaVgHv87
	 LWYfgyDRWEy6RirV2pgT7se3Q6MhQQuS3pwdbP73QslyIVK5MDIRTGwsurCQrkKeVwLZ/
	 XM5fFovVhm0sV8GQ95rIEQGRixGFAbeRVgFn34eI9xgDyoPdUaP3WqEJX9rmNQS8pi5kO
	 z1WNqbWY7ovIhFedk17ZzDizpYzp16TuB7LE6KGIhbN0gYN35eYfSk7eo3v9RDn6f9IwU
	 JyJH/ZwIogFIl0DfE/h5x66X7zuveC/iGYFVN/ixGuSIBzlqVUfzjJ2bOZ1gIfq5ZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=cpTS94Nlb5etqG8ClWRhdF0oxfHbFp//wqSv3Y/5cKI=;
	b=a2hLA+nyumgHGUjKED/Eu9hTzX4p65QMx968ZMIDehR+rBwV5nERcIVMOsJgGACjrIHw
	 lqxZT71ZVH3VeEZlPEEKdPLVdgU7KCNLi+mth5hU1WF5JJxLehO138W7u/isAavqq/88a
	 2QarEDGa/pzIgTsIi2JibXJRvEPS8BZtDTUyQEPRhWcD+Vvy+SQUbQuubhEi0xOFK11z1
	 V1MsEIXTSd6R9xKcihrVL+vf1p8xKYDl1Us4DVRbHE3EmQn3pk8BEx+++2SvjUBBiiIkc
	 s4eP4zLz9IVQUCxymeeAhoGE7n1PizmqQSzCOgcFxjOteJjMJcalt0wR5w6tCk9IBbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gvw8DUWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB16606B033;
	Tue, 24 Nov 2026 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gvw8DUWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85131F000C4;
	Tue, 24 Nov 2026 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513575;
	bh=cpTS94Nlb5etqG8ClWRhdF0oxfHbFp//wqSv3Y/5cKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gvw8DUWVJURXZPN6ZRi0RTKSYd8JK8tfvyMMCiQKqdmRKRyE+KMgApmRrT9+f9hRg
	 SoaUHiR/UScRwQ7YxbuXQtviPo4xgeJvxCWRyLrzg518CTKdlmaqGFc+UgwlWJ0ExK
	 9YaN46IoUKkchdS0CPECdWS30cucl3toj+Ky1fabeo3WTstnBESvd6tkRHLMk/RGIJ
	 fEcCIzF1iqWmYejBgHuCloMrflvYJl7mfjsahKGSbNtvt+rwHPw4r2k1LLv2TrERcg
	 t5yQL9tI6ySCfsJGmi59PPrNr4BBN1yFWG7oJ0udsb8Mnq0YsBTJohxfqqIVXG7c8c
	 X+/f2uxbfx+jA==
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
Subject: [PATCH v4 25/33] driver core: Expose committed device trust level
Date: Tue, 24 Nov 2026 11:43:56 +0200
Message-ID: <20261124-device-trust-core-v4-25-037eb0d17b1f@nvidia.com>
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
index b968bfc937346..ddd570773a070 100644
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
index a3a583eeb484c..1ac9cb5b3ceb3 100644
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

