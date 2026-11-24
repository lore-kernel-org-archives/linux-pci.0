Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513512;
	b=y2/GwYiiFDz5R04k9FbmuD5RwZBwr1HXPmH6hsWQIef3YP/86lFcD3yj4DAtwoYx33HQ
	 VTwzxJp/KtIOy/uF9wdxrL+bNJ4U62J0UD0Z22jPNB2n/JhHicux4zSVCDuhQIFECc3kI
	 QPwmnzmHufx4aiU/MRjCykZbrfr9nhTOY9mq7WD+q7hgRg3ki2pKf7F99B4gWH7A+EZyD
	 gyzmDSH8Xx+DsXP5N4RJWwLOmwS3WWUgzxgYT4k9hkphHG9BXXxn69022kzIj5BMF9r/x
	 UGNpunDBhFN8rQMavCbbZO/Jw1dgc/MtOmw7vH+uxgBCRx7APSoNTRcaUB023ItTBbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513512;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ApA1EolZAFdk8jTSD56scrzuYcCnsTXqldWRwLF6D30=;
	b=IvdQTHCQ32f/JLGCgaZMaWd9BBijFKh7qc7J+PmVf8qoT7MmI9fmoOtNoWbvc1qcXOq4
	 YrGtw0ibjlPvHf12+m8wZvu0dEo2WWz7udScQZPUmjzxfiuXrSMYeC/yvQj8sGwQNX2Gq
	 WHvMe/ZrRs9WGtlQxhfFGtEHyrVKObVDsNn/z7tL+LOr933TmlqS9lDKkaJwBHoBGGT5q
	 I38pyMZEB7PYc62NTcsC2OMzwZv3djpiQnUDxhhJs7EXuhPq3VOE+8t9MbkcM224uatep
	 xNo5pRppQcs4EGOopdYGImvq7+r9ri55RWq49lrxSkryrYlqbKOnCVIar///wbILXRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsMHhECp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1C606B009;
	Tue, 24 Nov 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsMHhECp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6251F000EC;
	Tue, 24 Nov 2026 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513511;
	bh=ApA1EolZAFdk8jTSD56scrzuYcCnsTXqldWRwLF6D30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsMHhECpMclIPMnGtu0zf0pupBnYZkXAJKko1nz2op4MVz7EyK7UAvMi70u64yaNy
	 m0jdf9unTFmIN/sCjAJOZyDUdsB02qfAqqiYhICFSTRZwrEIjTOKEFpX8/nI+q1Z/m
	 o7g9u3MnrD4XeLbyb99HkZHrSEUOUNvu5p6TxniqIjvcw6nsWsa04QrMmAGADT15ZY
	 UwxmDwUn1aWkbmOsWlhnP7K9ATyYL/9pIVm0gA47Vh2h9NG14Iy82PwToW30MsMQLd
	 dpKwMcLtBcgkoyigbi3QCzPfCuxoYA97ybDBh398iA/6W5JWKiWFtMhQoOEdEi2u46
	 U1W/qV08lIJwg==
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
Subject: [PATCH v4 14/33] cdx: Propagate DMA configuration errors
Date: Tue, 24 Nov 2026 11:43:45 +0200
Message-ID: <20261124-device-trust-core-v4-14-037eb0d17b1f@nvidia.com>
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

