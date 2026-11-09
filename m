Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209660;
	b=aGm8pt+VRWk1naiatDjpP+2gCjIy0ST/4xYClsJN4uFAz5PhEliNEXVmZW7IzVl7lHWm
	 T7uJS579oj3o9aIii2Qu/D1kMHcZFcfrQwCb0RP6S9rw7LgsSRR+EUT6ZyRDaOAXa6sKK
	 7ogJ/tNaxAlD/lqFJ0/Z+GUX5quFl/8N9gWCb1U4XayC/Q8p4VFdrGovkZP4STNaMQ/nh
	 +MAguPJ6ehsRGvPwtzy12BJDfbWwyfg5jV7ZjAU5Xl3rx2+4sJvpNd3pbv+aOxryLXGTP
	 epNcinPCPBM015KYyoftzO+RAXl26jg3ORYeqCVp3GIqVjWFneQCUtug4YHLXJEOq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=wh2ChqYF9XmNrt6b8ATpGBOGwb3/qYFuxeZ+hTus5/8=;
	b=jmGFALX9uzjFWdVunLJ+mqgnHA+1OFJ/ESN02ouCwRM5+gnRNVs63Cd0Bw0YeHdVzqZL
	 sJO7i7TVBOwfyBNq5fa/N75naqGD4PBgHmX7GBYNiiPQ1y5Ut+3SXAc0OfHHYDKNgNYSc
	 J4/9XCGmHsS6Ia6nUbBs7ZusSpVBHUZyCipWiFODm65EOwrCTUIA2UawO8HOT3oGcWTV4
	 yO4/0jZu4fN4o+PZgkcSBKIRNQ3zdHQtNFdLADEUWBXORaR8BizteXK01nf/lnumNSfhu
	 A2ioqnSNra5EvM5GUHOgFeFYc9TUDCsDB7fK+cCCZQIk1FhW9GeTzhvYTLqZ1mH3bKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laYxnljf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE236082BD7;
	Mon,  9 Nov 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laYxnljf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB551F008A1;
	Mon,  9 Nov 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209659;
	bh=wh2ChqYF9XmNrt6b8ATpGBOGwb3/qYFuxeZ+hTus5/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=laYxnljfw/dZnl22s4rzHk5vSm7ZDFxtqehSxMhT3r/VinDboZwVpJfyJNhGqjE/h
	 WCze+Mn1WHl2/tNoC9vojzEpPivRs+6SRkVyF9nygJo3xSduXtKOCloTwRoaB6gbBh
	 yXAgTbI2MamI/qPYq7pd4M0R/b6UQ39nDW3jvi3Erqp5sU8AeOL2xWsr5HX57guu8k
	 TFtnF74FBLBk/vmEzDCrXOz+hr4i2BmbSWfck9TU6NWMqQRbnvPbwsP44NFHEHEl1P
	 aD1hvNkvAXaJoZp1iJYhlSiGiKNI71pRNQdHRiPaSDCvDKCRFsgd6ntWXGf59d1iGm
	 JCQ+qySHzerAA==
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
Subject: [PATCH v2 06/19] cdx: Propagate DMA configuration errors
Date: Mon,  9 Nov 2026 09:33:36 +0200
Message-ID: <20261109-device-trust-core-v2-6-3b12d9a9f861@nvidia.com>
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

CDX reports successful DMA configuration when firmware setup defers or
default-domain acquisition fails. Driver probing can then proceed without
the required DMA setup or IOMMU ownership.

Return the configuration result so driver core stops or defers probing
instead of allowing a driver to use a rejected domain.

Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/cdx/cdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index a118a89a7779d..0a030bf522690 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -367,7 +367,7 @@ static int cdx_dma_configure(struct device *dev)
 			arch_teardown_dma_ops(dev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void cdx_dma_cleanup(struct device *dev)

-- 
2.56.0

