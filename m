Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209645;
	b=Fw09vnRc1jkC9PoMjjH7C6jxUQQSNOgU3G34Bh+9HL8v3PViORoOf3Fw+k/NIRhkDM1v
	 cpCJ/nMP3xQpq829FMoHtQpQhSsKYilsK1L4eDZ35KC2jUR7VVn9OB09R2Nf7UKOACAtl
	 dqRust6ILxBzYE0Gfe/aatW+BD4qJ1bh6Fpaee98LBxrEvyuX/8bTvCoqp9nsqRSlZtEa
	 CXvyGJRYN2Y6jUL2ZYp87ayxEOpg4zdFtlLJYu8KX/AdJxw4y6RCmcOiAI9BWsRe/kg3h
	 I3fsQLXDDZ0CmQlFJpTBZ3AVaTE3htxuN/fe2L8vi11d1DplxjIcEoXn3A9KaWoe1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=cdCM073jR/DCJh2HUDXaqMPcxaAwWF1lPqWNiB/vLUE=;
	b=0vKsntalvKb5zwLeRqR9lMsWOLgL1hbOYyDK4vuZRMZu4CwhQLc1yh/G9Q6aSVo2Hx47
	 SMrnv2t08dtMBd0FyMftlcm7VENlT4v8O8vaMKLMli8LoUY63LrW97FEgepvUl9Zj9E6+
	 VnpkCiIz3yyx1n2qzMGGzn5gFWysMA9p1W2TVDjEJfMxBSU40a7nUT6Y84TwYYTxWk+zY
	 boX++8ks5hobUX4WpVA+Vk+WZfNePoYKe3w6gcs2LHNfP7OlrJC3ctfnDt8UU/sUePLYy
	 e8yhScubrrI2I1+CmWCwkLfNhcHlorjmetrR4VZ8l5c4+R8YPsj+ekpRMmuUxVUuh7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFbxgJSV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5A606A33E;
	Mon,  9 Nov 2026 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFbxgJSV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA111F0089F;
	Mon,  9 Nov 2026 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209644;
	bh=cdCM073jR/DCJh2HUDXaqMPcxaAwWF1lPqWNiB/vLUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFbxgJSVJyGy7SW+J+0KIAxI1XhrPwQhbNaVT6wRNqGNJPT7ebLpgixmX6f5TRYUI
	 mI7fszmxT6vtfO/WS/HH6XQEZxYbeDKtCIRxOS5I/TRspMJWr6Z+uaJ9I3EU8aqlVh
	 pleyfOrhrz2HjvolsAzEt/GTTS2xbbCRZknTG+Sc+H8nIXLaQ1Lpa9AS5AiqsYy4bC
	 VOfWafAmh07YVtc7Ezu9uhzDbqubQgq0VCD6lMiMWbwT9piMq3DbO7ZkTu4Yv3jDxE
	 hIAGVG2IO4CDNeMLIpywlIWi4W0JI7iD08jh9GM9edSnABb/Lcb6rQM9etPnCUrZJ+
	 wv+htg3AQIizg==
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
Subject: [PATCH v2 02/19] wifi: mac80211_hwsim: lock device for manual driver binding
Date: Mon,  9 Nov 2026 09:33:32 +0200
Message-ID: <20261109-device-trust-core-v2-2-3b12d9a9f861@nvidia.com>
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
2.56.0

