Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030041;
	b=g1siZkCJyv4OVol72kNWjIusG+YY3qwRZrdsX1ZKlrXIbZn0dcoUH1KObXJPpc/I3Fp+
	 m9R+WdEduNDfd5dFfDkq2AL61DybczyULxjZtPfhJuOzXyz/UOLMCGgkHeFtV1ImytiqW
	 2ocvDP19JyqxrrNoEP6nw2pzK5iTZNpdFyLbTpzBkjYWjwMktBP6leWYUeSqJigF1v427
	 oHSAFNwUHwxDT92yCjdWb4kMVS98cTr/6xPKQO5EKRxga+jJbE35senT4IDPbQzqf5sPy
	 v2n3+gyVg1cErIhusHpCHLLUq2ko03dzLLQJa6ZdDdzyOSwoxbMVSpTs5Z2zx7hZHNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=0q1TynGssykC2LOKqTJCRLWewJrYt+Qms+Y+NUNnNmQ=;
	b=XmaBCmmsF32ng43C+VzTTbxeWkhNOcQBW46JsKTZiPsZZEevsvVwkr54B8gniOzpyjU3
	 8oyD9WVl8Pt44y7lm//LNEmZyDiKFriL0ipT6nu8X7WuAecQjuwRjJGoM4Ks32oRQcWGI
	 Se/kYae0pU1zNtduZxbpZ0n0XwOekmNs0alIML7h3e0Az8gG9VUg0Wi3J3KGZDmdUPlCQ
	 89SWrweU1TNjqVAS3lFw0Js6cC6YfT+ibIRPj1jPe0SRR9pqJ4eiwVf4HDAcYwZ64d+qj
	 Hn97EOLmFViuqOWbHp/r7gbYeMxSzS7JST+iUd3LRLwJ7VRvG1MxqLkXkxquSjIXiLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiMBpwfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78562606A325;
	Wed, 18 Nov 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiMBpwfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6729A1F000C6;
	Wed, 18 Nov 2026 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030041;
	bh=0q1TynGssykC2LOKqTJCRLWewJrYt+Qms+Y+NUNnNmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hiMBpwfrjl85DWLJPdGsFdo1dx3SonbuhvpM6QUiy9ACYFdkJKsr806pKMwu6EGdf
	 uttd5jCD7Fe2XyIoXYkc8QrqK3NDRUwxmXQai8YBKkElcdnCigyMNObTNkgUDmWjPg
	 hwuG7wZn1VoQ1RaA5WDxeVd/Ip9YQ7UTxRQQBiuHp+A7i+NFqZgIagSKpVzhzf2hwC
	 +KW7PRUmk8Xiaijkpad2QvLUghhmudE6WxVLsz3+7UNKlMnXim598zK7am1ZuulVAw
	 Ygt0OutVArPGmZ0uVeF5/dCPE782AS9a/3fKGF4hpxYalDvW6oFNPIRA72gJPnNkwA
	 3vGL4GVfqZeZA==
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
Subject: [PATCH v3 01/31] wifi: mac80211_hwsim: lock device for manual driver binding
Date: Wed, 18 Nov 2026 21:26:31 +0200
Message-ID: <20261118-device-trust-core-v3-1-d655875c4bfb@nvidia.com>
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

The documented API contract for device_bind_driver() requires the device
lock. mac80211_hwsim uses it for a newly created class device with no bus,
so no automatic driver-core path can bind the device concurrently and the
missing lock was safe.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index e53714b81ec2c..b796da3dd54b3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5769,7 +5769,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		goto failed_drvdata;
 	}
 	data->dev->driver = &mac80211_hwsim_driver.driver;
+	device_lock(data->dev);
 	err = device_bind_driver(data->dev);
+	device_unlock(data->dev);
 	if (err != 0) {
 		pr_debug("mac80211_hwsim: device_bind_driver failed (%d)\n",
 		       err);

-- 
2.56.1

