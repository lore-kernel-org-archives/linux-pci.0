Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513585;
	b=RoooaaOW7Ux+bHTuSKSAxDQXrHZKIU/TF9tZc7G5lhmEEgS3nu55/MkI28IeKK27OZhI
	 jik5Cao2/wG2ZPR7haNoA5hLKGOfb+FGrb4fIanmnBdDaOJlh/6+Mqe+vZhReGHESW50r
	 apw8Qy2OPNlBXyM/8yYp2U4mdBmF6lbm7BgFITf+ds/j97q6aYLulZcwlc6rO+lmi1F17
	 g2lZvCQBE9onoDhrSeRIQ79voidx/WDKiFtuVRaVpfHVETa/D3+2BaIgt9xm75PrB3zpu
	 h7meU2z/v1K9HwiR8vhGGJ7DPmlxeqkfKIo1rtiyObsgMmvyNAmErDcPUIrtthunryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ACH0QP0Df8Q+KvPtc3RDClRqoeZVsyJD6IcERMn9LAQ=;
	b=0/y9/my4mhXn59PKNYMAA6Ci2p8uifnr/Dk7PcTRLL+I1DRBzbTPf6AmpBS6QGYlA+Al
	 2R1VBdf4WHu5bB67QsJ23OUubmE0xesVANlMu1bwKKTVRew5ki1LepsDVzhjHb+EEOrUp
	 TYIfUIqDnv91F5TuaeH3xqGHWD8WbvigQiBWPwSU20ixaImUEuI9HV5XHqgluztEUcHvA
	 qLwDMuSKmUDZUqNN5aslFurJMb6PMVYcPJMG5eTmLvjp72mbPUmi3DLqw9QBSnNMzBWtv
	 b2kog2y6cQNcMgnRxECNXsBJZ/DBHrm9rLZUqlc0oIoUFoXY8eaZXMDiY4ze75YTwrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IakvQ5Da;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBF606A69E;
	Tue, 24 Nov 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IakvQ5Da
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70021F00A3E;
	Tue, 24 Nov 2026 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513584;
	bh=ACH0QP0Df8Q+KvPtc3RDClRqoeZVsyJD6IcERMn9LAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IakvQ5Da/Gh4K6sBHTyHbfltZXdEyfK98raJEjcwIw6hgnVLjtiXVUQANndVUB++0
	 eKzgwDXvsEe2ZYcD3HgIOAKVhtIlLHQ2dCXQvTshJ9VKFGMOxYSVkjy2OZcQjiHVvB
	 W7q2S3Ln1PCBesXOj5LO1HpWvbzUxKAFb4frmXkYbMd+fqP7C77iX0amCZdKjmiZaL
	 9hfjqN6GitLmaLRYOMeRkk3E1QxpqiCNMy7WlVrwU9x4UEqtnsvNlQsT3PgGr1m3zg
	 u3lMdT1PxyF83Q/kCOn+BehOXAZEWC7uhFUWkz4y6sQG9zhtELyGyQxbZBGY3JVGyd
	 Le3SsmYRMgjiA==
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
Subject: [PATCH v4 31/33] USB: Retain the result of configuration requests
Date: Tue, 24 Nov 2026 11:44:02 +0200
Message-ID: <20261124-device-trust-core-v4-31-037eb0d17b1f@nvidia.com>
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

The generic USB device driver can bind successfully even when setting its
configuration fails. Authorization that attaches this driver therefore
cannot use the attachment result to report configuration errors or decide
whether setup can be retried.

Retain the last configuration result for callers holding the device lock.
Keep driver binding successful so userspace can recover by selecting
another configuration.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/message.c | 12 +++++++++++-
 include/linux/usb.h        |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index ca6976e266f02..32014605b6db6 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2042,6 +2042,8 @@ static bool usb_has_claimant(struct usb_device *dev,
 	return false;
 }
 
+static int usb_set_configuration_internal(struct usb_device *dev, int configuration);
+
 /*
  * usb_set_configuration - Makes a particular device setting be current
  * @dev: the device whose configuration is being updated
@@ -2089,6 +2091,15 @@ static bool usb_has_claimant(struct usb_device *dev,
  * drivers currently known to the kernel.
  */
 int usb_set_configuration(struct usb_device *dev, int configuration)
+{
+	int ret = usb_set_configuration_internal(dev, configuration);
+
+	dev->config_error = ret;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_set_configuration);
+
+static int usb_set_configuration_internal(struct usb_device *dev, int configuration)
 {
 	int i, ret;
 	struct usb_host_config *cp = NULL;
@@ -2347,7 +2358,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	usb_autosuspend_device(dev);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(usb_set_configuration);
 
 static LIST_HEAD(set_config_list);
 static DEFINE_SPINLOCK(set_config_lock);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a5e706f67f33a..d372712eba34c 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -599,6 +599,7 @@ struct usb3_lpm_parameters {
  * @descriptor: USB device descriptor
  * @bos: USB device BOS descriptor set
  * @config: all of the device's configs
+ * @config_error: Result of the last configuration request.
  * @actconfig: the active configuration
  * @ep_in: array of IN endpoints
  * @ep_out: array of OUT endpoints
@@ -686,6 +687,7 @@ struct usb_device {
 	struct usb_host_config *config;
 
 	struct usb_host_config *actconfig;
+	int config_error;
 	struct usb_host_endpoint *ep_in[16];
 	struct usb_host_endpoint *ep_out[16];
 

-- 
2.56.1

