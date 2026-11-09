Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209670;
	b=Od7W2Lv2HeB+uCjmVddRYj8nsO9KZYbFwYn1sSJo2VISaN3S6PBwZRgb2mWWGOPjsHGs
	 Q+7SB623/Mh9BuXJK1GZhQv+1x3vJ+cXlK91L9Qj33mhUXzNpL8N8Xmf7vSWvVcesZpi/
	 9LkjPKyqzFn3jgxBZcwE3xmL/M/oObUSlhLo6JqOuD8JJSR77ORB8GhZ8+r1jMHzKrU6Q
	 vtAoFBXTJGp7V0dNNOKhHh6Ifx0OJ3+E7SeDzE5kFR+P0q1GzGPO+AoTmfx5AElwg1A5D
	 cCtEtA3B5Avoa3MJlGZTsY/5VJd11EALsD0+ZQp5xPk3yeuM99TCcs7kS1hMmY6KdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=esc9u5h8nOfzpC94QRqfexD7Tae+1nWvmVwsrbhWx44=;
	b=Ttw+ctwlD7a6au+8A+/8lqj916jxTmC8k2c6G6vykRiNcz/GkONOlOyqvQ2jHu8O26P7
	 YgQQSqSeJ6s1baj/vCdXNk3z0E/9OJmfErqH4OqEEJaa+OH1HdomGtsJvS8ctxOiGgwOS
	 g1+H0huFGviO8g2Ks7ndPkVy6IHi5oNt7mrtJqFUh4u63GO7mRay3CvYBeTamsq9E4imD
	 gK+xtrR7bCUQGdTRkrthhUx+Skpz3CWAQYCTY7XZADethG1jYqsJCC4Z5RbK38jEeFuzV
	 6HIk5cAUHCGgi3blndiVvzC44TcmC0Pt2xhdvU7NQ3v7SOrfFU+VgKVzfdLE6fyWGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcRiolhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0138606D816;
	Mon,  9 Nov 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcRiolhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BE1F008A1;
	Mon,  9 Nov 2026 07:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209669;
	bh=esc9u5h8nOfzpC94QRqfexD7Tae+1nWvmVwsrbhWx44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcRiolhRIA0fkin82BnV5Mz7Eg4PU5O+xYrDITtO71vHvH0RwQd8VJblq8+YS4h3T
	 NOkB+bnPBQXa1v7EuatD5G0/EDIlXbmpoZwzNTxNIGhGRqohn36IiODzdQ7yyWM917
	 TnAONCGBnLJK7j3fN2SrDeIIPa85cnkng+xOF1KNVZcJMcpv7strjc23rZFjzl1mV8
	 ahptbyXit3g2EgyF/FpAkJYIZrwFpqJ3mVcNu5B+UwdLNsyJF95LfG8pseXE8pJmBd
	 8YaxHb266eHE0QJNZQ5+A82Vo2mKkmfOXtn10V3wzJlQ7L2JskhUGREK34/cLTER8t
	 GYBp7PsFmuKCg==
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
Subject: [PATCH v2 09/19] Input: serio - use the compatibility driver attachment API
Date: Mon,  9 Nov 2026 09:33:39 +0200
Message-ID: <20261109-device-trust-core-v2-9-3b12d9a9f861@nvidia.com>
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

Manual serio binding invokes connect and publishes the binding under its
own subsystem serialization. Driver core needs an entry point before
connect to enforce device trust admission.

Use device_driver_attach_full() after the port ID check. Preserve the
existing locking and let the helper handle probe and binding cleanup.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/input/serio/serio.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b027..b54072769ab68 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
 
 static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
 {
-	int error;
-
-	if (serio_match_port(drv->id_table, serio)) {
-
-		serio->dev.driver = &drv->driver;
-		if (serio_connect_driver(serio, drv)) {
-			serio->dev.driver = NULL;
-			return -ENODEV;
-		}
+	if (!serio_match_port(drv->id_table, serio))
+		return 0;
 
-		error = device_bind_driver(&serio->dev);
-		if (error) {
-			dev_warn(&serio->dev,
-				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
-				 serio->phys, serio->name,
-				 drv->description, error);
-			serio_disconnect_driver(serio);
-			serio->dev.driver = NULL;
-			return error;
-		}
-	}
-	return 0;
+	return device_driver_attach_full(&drv->driver, &serio->dev);
 }
 
 static void serio_find_driver(struct serio *serio)

-- 
2.56.0

