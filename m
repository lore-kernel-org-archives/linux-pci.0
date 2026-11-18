Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030106;
	b=E+qXiezoQMgVhcn7PNIhRkdoQ7598V/zxrhMLxdrpWUGh+Y1npnXoWmabkU/VJszUSxs
	 2VGJbaiqDSgQmn5vJZj5yf3FfHhaQQY2LxXNnLWpdVV8+BVNBNrqmZQkAbCLT1aYuls+l
	 yjllx9jg9nydHQRKPXjr9f0K0d3K7nqWYl0au9SXJIhnQzNp0pO8unR5w+oOvYTTNuI4w
	 EKk+uiYfXvjXPE7RVrhGNNTNQk+rpNY2tSXWsryCfXiwkRqQlubcNOJKlC0y17ZVVkN5b
	 vXvR8bXW997SgnZdcF/o2mjzkBVXS1WWga6+EBS2lqvQXKbiv4Io0vOUy4wSsjB6OQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ApA1EolZAFdk8jTSD56scrzuYcCnsTXqldWRwLF6D30=;
	b=DrDj6vzlYP2fKPWRJsplu8tMoH+0KINCZGur0evvv9fO1fY8/JCPlgiwjqdtRXKl4IWs
	 TmXtUHqHJmTfkVY0yhsGd3qG58qdTRjI+Fi8IM2BeoCt7CKWlHiumr1DrlMk5EXUGTr71
	 9wHU4r8Nfra5eL2trWrkcUOJUdTTOCxk1aFb57IfbC2bEvRtL0lKc7v/YSRZ+IFILaKBw
	 7UarII8MAmDIuEAI+b+ag86iQedsalLrqHdVdnEt+dpkmKSSUltpN2LIMzw1EyDj/2ZfJ
	 Zq0gVnRQNUbJCsfBAACFpiGAxaKSRDym8J6x1rifsPo1NnpKYGwa7WAl2Jwf2rBP89Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgcySklo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D50606A7C1;
	Wed, 18 Nov 2026 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgcySklo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF801F000CA;
	Wed, 18 Nov 2026 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030106;
	bh=ApA1EolZAFdk8jTSD56scrzuYcCnsTXqldWRwLF6D30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgcySkloYrBvpvesN8jcB9tGP6YC+ET/UoMhIM3sh4bTQvo7pmABdQ3PnPxcG5LhD
	 8PZOJwYLMyBtmyTOmMfQFPY3sK93qdaYFqX68MVQ7B140DqE1Ib/sixizRkp0lNJAh
	 K14jy5daNzrDgykjesq5tH/6turRA6k87zuZ/9ljoNAErM/ZU3ZZtkQx9ufASIELfh
	 Vpd8sUGMLxFt0GywHGn2LnxaFwvldZZ37QCaQ42m8uZti5hI1drHG/pG2s1iknCY9E
	 +msqCgR3iqt74uNvr8G7p2wl86wJFqQvLqZ2Bs8Olk1bI++ZPk8K4RwshSe5u/m2zR
	 K+RvbJToA4dew==
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
Subject: [PATCH v3 13/31] cdx: Propagate DMA configuration errors
Date: Wed, 18 Nov 2026 21:26:43 +0200
Message-ID: <20261118-device-trust-core-v3-13-d655875c4bfb@nvidia.com>
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
2.56.1

