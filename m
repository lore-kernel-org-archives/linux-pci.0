Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513460;
	b=f39cIID9weUMM3RCil9BSidkf61C92wXp2bgE6aVoPb3b+Z2HnTcUvhs7nENXqreLGj2
	 duV/VGkfmKynkQI0X2m9Atqy/i8C0Ez6gY50k4XEEXd5KyqANrH2IcatZgAcZ3mQAIDJG
	 5LHlJTf7sVmuBMuqUMpIKJgzeZK8pplzTUB0U/WqgPlRCwm3sRHgNnk+8STxog+TB5X6k
	 yU0oxzpfoEbVVMuhsF0DncYozr/iLjSBn0oPQl3KobN+D1LmM+8q/8WKyoOCCYj4yv09+
	 zvFo6+05nSHM5kIuCynC5UXgu29W02/zSK3RiJ/mCKmQkaZLDgMqrUhAl8UR95ShkZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513460;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=0q1TynGssykC2LOKqTJCRLWewJrYt+Qms+Y+NUNnNmQ=;
	b=YO0lR1BGDb082E8NjlIeImGQO8KxXo7DHuycr2I5Hm/8awuNr3IjJqHqxpwhj/LrHQXi
	 f/2Z/Qvyp7rh+lNX9B+Dx9KV9eZxJW9G+PI5dsQGZW8R7lZd9ongAet4Qc9egHERNa8Ur
	 sN8GuIIJR6aYSBTvtrZ5vALS5qUG/i/V7TOE2Z8i1EHsLWQh7GmdxI+gA9ghsEXbe/Mgr
	 EFb8dINaFjuVZEN0D7opIl2hHsiYCES8e83WwZPQyB+BEJPS6Kgf/p2/yk5gxbcEIdpqQ
	 OuoAXq68xNm7eh8i0kfe+jlgZ8u5akFUWLCTNyRaLntWBV2Mh0HpiE7cYarnF8DubeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQfkEJzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC0606A68B;
	Tue, 24 Nov 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQfkEJzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A81F000F0;
	Tue, 24 Nov 2026 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513460;
	bh=0q1TynGssykC2LOKqTJCRLWewJrYt+Qms+Y+NUNnNmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQfkEJzPxWxHAzsKlB+3KWBFh3wYLHR82k5EG50AGPZhb+T9glDqQMvlMmfMtSOsK
	 In3GXSvT1Jx+Jxn+Km78xmHJzxBLwhqsXcrJAuhYUqFIoVqJ+WHaejJqWpCjGKm3v6
	 /zxNmhC64QH0D6xK8bYsCcBXC/28rKjSmHFOt+P0edzymxb93WC7Nt6MQK4Zdcb95X
	 1qjP+v64Mpi7Xqe38t5wyqV3NypSpHuPHmNYtMm8QGg4E6NCtQoVYXHj4WRef+fSkN
	 CheEna9tLKzM1eH1J1w3rXzz7WHsNDJeMxkMu5zEVDJ+o7jMpogXdOqI6B8fq1KEdp
	 /+RaSpBgtj5mg==
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
Subject: [PATCH v4 01/33] wifi: mac80211_hwsim: lock device for manual driver binding
Date: Tue, 24 Nov 2026 11:43:32 +0200
Message-ID: <20261124-device-trust-core-v4-1-037eb0d17b1f@nvidia.com>
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

