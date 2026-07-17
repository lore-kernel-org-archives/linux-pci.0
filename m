Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651642E8ED
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299907; cv=none; b=Td/+KEuKNRbhmQDJQL1re/WLi95BkGobZpcQ46rqXcbUQUav97CI8zXARdM+M7bK67VhxOWMD2ib0m+JaxeABNRehTbRyGEQU/ohpqYsT59fe6fHuorEQaIajaYxog0iKSnocI54bZOakdJbzVxJVVnWxa/tmBEGQ9AXkdK9l7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299907; c=relaxed/simple;
	bh=6BxJ1rk3uw0QmuryqABbYkEAqwccaNqsUVnmSNWwysA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdmhDsBgkZorr9/+FX3K8PXd5cKHbrwsidfq6hbyD3piiQX7gXPsvvvKRfkhlk4oCifAEIqLm4ovwSKNSKdgmOUTpEZuWO3wjPVWD2pAKRuUa1D147EkVxa933iO2LlbYW/le/u6CMZThIibcyM11JtKcLMr/uw0+LZcisx5kpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aOMdq7dE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aOMdq7dE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so7893468a12.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784299901; x=1784904701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q7pV5T7C4uEA9sAbt6vn+1Fvo8ODjwjOidQkSnlemhA=;
        b=aOMdq7dEgUf5n8Z7DwZSjWhmp34LZMAUIZ7I3GfzhvJIcVzgw5Bw4LrtlEWFAtV94t
         icva2wWPW7vHttPe7zMKRE8X7y0TC/b92I++3VLkjJkQOSsvHuKsuoCOUFakjiWJZR3r
         Zgl2dZVDlD5KuJEh3vCIQuCvFGmN3upi+GYHwIzWzxi0q+laLrTLVgPM8Eu7tjy/iDYF
         UqyvyJcCztDf7TcTy3r1ZcUP2Q5yX+AtjAOo+XQcN+vDzLBE3l7cSty/3IPbz9kDe9K6
         1S8KIqKgV6HmSbHSFOCmziRNjIP+mBqsbJS1I6b/J6Jv684S8yAeXEus63n+jgtRvl1y
         +BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299901; x=1784904701;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7pV5T7C4uEA9sAbt6vn+1Fvo8ODjwjOidQkSnlemhA=;
        b=ZvJvkvgw9eqrEgqQHjpav9wqfAFXaBgS7kRsKS1viOxc++6pZcoNwAOWwotLq50ZLL
         aCTUv5sBfoy59Ow/4pgXF5muu8qEMCAjxrm+L+f4VzQuVHjdeB9beav0TTr/j32l9Jwa
         BtesB5yQgsJeCmV3+zHsImG3N4b6LcrcXi72a+No7G62K3mlclQLb/IvgipGppyuOYFJ
         CMLwVS88xkSnMb+Cl7oaa4bwKCflY9BvFi1/YhPY1080OoQgOj6nw9jR+ufMX6amqoYE
         AVJHkkGkJJbYc4Zr1bFUqLj4HDAYV8EtOti7Xw6FDgsW5FumzovLwvYQA1QHxLQ29Am2
         H0ow==
X-Forwarded-Encrypted: i=1; AHgh+Rot66vytltKPrbHu3a8pmSMs8aMLgCSGYeQ4CZM14JwqQf3zpbNVxD5OZyzZD3OGwmLn3YJuyrpKGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MROGAVNQCkJWoCl3bjIIpXa1bHyHDevE5Qbcj0p1xTFRjzuq
	YL2Xiq0/Gy3pklTMAgiqHFYDnpCVKCbAEHH/6Bu5kskeUdnxXbWe61MT7ATxgtho+HU=
X-Gm-Gg: AfdE7cn+etT3TFKlfSsvJMnMtnI2GzI8qztjD5QheLW8ec4GiAX4KfuaWYPK55+xKZL
	XbdoDMEcchbvaa5S9P8bkRieUrsBrLLnwISTca1IBSw3ERb/Il5Y/Bua87k2m5JJL1103UpDvw8
	Q/KS236Rcub0+1MD/jnMjOQAV4SdriovG2ZLL3YE+mFj2AIBKJiJOOVhjR+rq6dKgCs62HzjBO2
	pvCbK8dxGZS0v8jjdtqdlwdwC5muEOdPEaag3IRmcnLLXqPbI8Ee2vtIwaphGv62tGIlrHzRkcu
	OKoUXiemwY+NkV7/S6ra7WVjnQ9tJKEQZrWPbFBqY3PcrN3zXjRUl09noJIq028w4k3C9CXW28U
	+8Oh/sEvAXzOtxednUCddoiTtda3ZRYUUwRGChWUn4GGHgpRRxsFA8L4UoAJQNYiC55gLxrwaDZ
	cJzPq6i1PN+guspAI21uTP6iQbXo/rARC9DHILplztr4P34ol2oySPkglEhEbEkeyPNg==
X-Received: by 2002:a05:6402:5304:b0:698:ac05:5b2f with SMTP id 4fb4d7f45d1cf-69e6525c4a6mr1233838a12.4.1784299901393;
        Fri, 17 Jul 2026 07:51:41 -0700 (PDT)
Received: from localhost (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-69e6fff71d7sm798892a12.27.2026.07.17.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:51:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Keng-Yu Lin <keng-yu.lin@hpe.com>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Alexander Graf <graf@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Akshay Gupta <Akshay.Gupta@amd.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 12/12] misc: Unify code style for various *_device_id arrays
Date: Fri, 17 Jul 2026 16:50:58 +0200
Message-ID:  <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=24626; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=6BxJ1rk3uw0QmuryqABbYkEAqwccaNqsUVnmSNWwysA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWkFjDYDPvZF+FHKWPU7nWDUaijQbLyicZiVoJ nNMst3wb12JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalpBYwAKCRCPgPtYfRL+ TkbJB/9Wp0LdyzoemEXcuyFK9RCYBHlNPjBmzF59mwhOWveHWjXHNRuonJ2I9KJIeDYbVsuU0g3 0tYF67SBmT/5qbicR1BcL+iqABhdMuDS1OH+Zmc1MSO7Q2CNJsSWh53mpm52WHWjPH6kiXMcWkk NM4fTvg8ahTC9cfwRkxw+I1XAazpF5A2s3AptE/tQcxcF7wK9jn7egvHfhE4OPTvyb2GTNIqIGh R/mBqYYi5uXOtxm6eWqTHMwluFk51dkBd46nTFesNhTlMV1RESB24ih32co34cIZMvj0/XKYoPv EYq3jNel4dhgAD26SdMZGixGc/6Viqxxn8n1/13bU0MiBeZ5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

 - Add a trailing comma for initializers unless the closing brace is on
   the same line and for the list terminator;
 - Use a single space in the list terminator;
 - A space after an opening { and before a closing };
 - Use the PCI_DEVICE* macro in two drivers for pci_device_id entry
   which is usual for these arrays
 - No explicit zeros in the list terminator;

None of these changes introduces changes to the compiled result.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/misc/amd-sbi/rmi-i2c.c                |   2 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   2 +-
 drivers/misc/cardreader/alcor_pci.c           |   2 +-
 drivers/misc/cb710/core.c                     |   5 +-
 drivers/misc/hi6421v600-irq.c                 |   2 +-
 drivers/misc/hpilo.c                          |   6 +-
 drivers/misc/ibmasm/module.c                  |   2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   |   4 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c |   4 +-
 drivers/misc/mei/pci-csc.c                    |   2 +-
 drivers/misc/mei/pci-me.c                     | 166 +++++++++---------
 drivers/misc/mei/pci-txe.c                    |   6 +-
 drivers/misc/mrvl_cn10k_dpi.c                 |   2 +-
 drivers/misc/nsm.c                            |   2 +-
 drivers/misc/ocxl/pci.c                       |   2 +-
 drivers/misc/pci_endpoint_test.c              |  16 +-
 drivers/misc/phantom.c                        |   6 +-
 drivers/misc/pvpanic/pvpanic-pci.c            |   4 +-
 drivers/misc/rp1/rp1_pci.c                    |   2 +-
 drivers/misc/vmw_vmci/vmci_guest.c            |   4 +-
 21 files changed, 121 insertions(+), 122 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index bbc0d14d1cfc..463a9a757464 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -226,7 +226,7 @@ static const struct i3c_device_id sbrmi_i3c_id[] = {
 	I3C_DEVICE_EXTRA_INFO(0x0, 0x100, 0x118, NULL), /* Socket:1, Venice */
 	I3C_DEVICE_EXTRA_INFO(0x112, 0x0, 0x119, NULL), /* Socket:0, Venice */
 	I3C_DEVICE_EXTRA_INFO(0x112, 0x100, 0x119, NULL), /* Socket:1, Venice */
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i3c, sbrmi_i3c_id);
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 5773ffb46f0f..7aa818a7717a 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1632,7 +1632,7 @@ static void bcm_vk_shutdown(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id bcm_vk_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, bcm_vk_ids);
diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 8e7ea2c9142d..9e0f4f91763e 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -47,7 +47,7 @@ static const struct pci_device_id pci_ids[] = {
 		.driver_data = (kernel_ulong_t)&au6621_cfg },
 	{ PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6625),
 		.driver_data = (kernel_ulong_t)&au6625_cfg },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
 
diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 2dd212f04fed..8e0d11e59c4e 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -292,9 +292,8 @@ static void cb710_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id cb710_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB710_FLASH,
-		PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, }
+	{ PCI_DEVICE(PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB710_FLASH) },
+	{ }
 };
 
 static SIMPLE_DEV_PM_OPS(cb710_pm_ops, cb710_suspend, cb710_resume);
diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 5ba40222eb12..143f2ffa846f 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -285,7 +285,7 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 
 static const struct platform_device_id hi6421v600_irq_table[] = {
 	{ .name = "hi6421v600-irq" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hi6421v600_irq_table);
 
diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index ff3f03ea577e..40e96d15164a 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -33,10 +33,10 @@ static unsigned int max_ccb = 16;
 static char ilo_hwdev[MAX_ILO_DEV];
 static const struct pci_device_id ilo_blacklist[] = {
 	/* auxiliary iLO */
-	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979) },
 	/* CL */
-	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP_3PAR, 0x0289)},
-	{}
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP_3PAR, 0x0289) },
+	{ }
 };
 
 static inline int get_entry_id(int entry)
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
index 4509c15a76a8..97f661f54b31 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -178,7 +178,7 @@ static void ibmasm_remove_one(struct pci_dev *pdev)
 static struct pci_device_id ibmasm_pci_table[] =
 {
 	{ PCI_DEVICE(VENDORID_IBM, DEVICEID_RSA) },
-	{},
+	{ }
 };
 
 static struct pci_driver ibmasm_driver = {
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 48bea1117771..b0b678e6b28d 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -150,7 +150,7 @@ static const struct pci_device_id pci1xxxx_tbl[] = {
 	{ PCI_DEVICE(0x1055, 0xA035) },
 	{ PCI_DEVICE(0x1055, 0xA045) },
 	{ PCI_DEVICE(0x1055, 0xA055) },
-	{0,}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci1xxxx_tbl);
 
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 8eddbaa1fccd..82635db04dc5 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -513,8 +513,8 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
 static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
 
 static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
-	{.name = "mchp_pci1xxxx_gp.gp_gpio"},
-	{}
+	{ .name = "mchp_pci1xxxx_gp.gp_gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, pci1xxxx_gpio_auxiliary_id_table);
 
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
index a2ed477e0370..09841c4f1a06 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -419,8 +419,8 @@ static void pci1xxxx_otp_eeprom_remove(struct auxiliary_device *aux_dev)
 }
 
 static const struct auxiliary_device_id pci1xxxx_otp_eeprom_auxiliary_id_table[] = {
-	{.name = "mchp_pci1xxxx_gp.gp_otp_e2p"},
-	{},
+	{ .name = "mchp_pci1xxxx_gp.gp_otp_e2p" },
+	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, pci1xxxx_otp_eeprom_auxiliary_id_table);
 
diff --git a/drivers/misc/mei/pci-csc.c b/drivers/misc/mei/pci-csc.c
index 70792bf9b3c0..6e1e8008f267 100644
--- a/drivers/misc/mei/pci-csc.c
+++ b/drivers/misc/mei/pci-csc.c
@@ -240,7 +240,7 @@ static const struct dev_pm_ops mei_csc_pm_ops = {
 
 static const struct pci_device_id mei_csc_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, MEI_CRI, MEI_ME_CSC_CFG) },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, mei_csc_pci_tbl);
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 55e0b8a98827..790a4647811b 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -27,114 +27,114 @@
 
 /* mei_pci_tbl - PCI Device ID Table */
 static const struct pci_device_id mei_me_pci_tbl[] = {
-	{PCI_DEVICE_DATA(INTEL, MEI_82946GZ, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_82G35, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_82Q965, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_82G965, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_82GM965, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_82GME965, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_82Q35, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_82G33, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_82Q33, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_82X38, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_3200, MEI_ME_ICH_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_82946GZ, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_82G35, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_82Q965, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_82G965, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_82GM965, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_82GME965, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_82Q35, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_82G33, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_82Q33, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_82X38, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_3200, MEI_ME_ICH_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_6, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_7, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_8, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_9, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9_10, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9M_1, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9M_2, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9M_3, MEI_ME_ICH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH9M_4, MEI_ME_ICH_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_6, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_7, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_8, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_9, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9_10, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9M_1, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9M_2, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9M_3, MEI_ME_ICH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH9M_4, MEI_ME_ICH_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH10_1, MEI_ME_ICH10_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH10_2, MEI_ME_ICH10_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH10_3, MEI_ME_ICH10_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICH10_4, MEI_ME_ICH10_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH10_1, MEI_ME_ICH10_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH10_2, MEI_ME_ICH10_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH10_3, MEI_ME_ICH10_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICH10_4, MEI_ME_ICH10_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_IBXPK_1, MEI_ME_PCH6_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_IBXPK_2, MEI_ME_PCH6_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CPT_1, MEI_ME_PCH_CPT_PBG_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_PBG_1, MEI_ME_PCH_CPT_PBG_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_PPT_1, MEI_ME_PCH7_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_PPT_2, MEI_ME_PCH7_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_PPT_3, MEI_ME_PCH7_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_LPT_H, MEI_ME_PCH8_SPS_4_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_LPT_W, MEI_ME_PCH8_SPS_4_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_LPT_LP, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_LPT_HR, MEI_ME_PCH8_SPS_4_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_WPT_LP, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_WPT_LP_2, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_IBXPK_1, MEI_ME_PCH6_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_IBXPK_2, MEI_ME_PCH6_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CPT_1, MEI_ME_PCH_CPT_PBG_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_PBG_1, MEI_ME_PCH_CPT_PBG_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_PPT_1, MEI_ME_PCH7_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_PPT_2, MEI_ME_PCH7_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_PPT_3, MEI_ME_PCH7_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_LPT_H, MEI_ME_PCH8_SPS_4_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_LPT_W, MEI_ME_PCH8_SPS_4_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_LPT_LP, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_LPT_HR, MEI_ME_PCH8_SPS_4_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_WPT_LP, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_WPT_LP_2, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_SPT, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_SPT_2, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_SPT_3, MEI_ME_PCH8_ITOUCH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_SPT_H, MEI_ME_PCH8_SPS_4_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_LBG, MEI_ME_PCH12_SPS_4_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_SPT, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_SPT_2, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_SPT_3, MEI_ME_PCH8_ITOUCH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_SPT_H, MEI_ME_PCH8_SPS_4_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_LBG, MEI_ME_PCH12_SPS_4_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_BXT_M, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_APL_I, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_BXT_M, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_APL_I, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_DNV_IE, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_DNV_IE, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_GLK, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_GLK, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_KBP, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_KBP_2, MEI_ME_PCH8_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_KBP_3, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_KBP, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_KBP_2, MEI_ME_PCH8_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_KBP_3, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_CNP_LP, MEI_ME_PCH12_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CNP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CNP_H, MEI_ME_PCH12_SPS_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CNP_H_3, MEI_ME_PCH12_SPS_ITOUCH_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_CNP_LP, MEI_ME_PCH12_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CNP_LP_3, MEI_ME_PCH8_ITOUCH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CNP_H, MEI_ME_PCH12_SPS_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CNP_H_3, MEI_ME_PCH12_SPS_ITOUCH_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_CMP_LP, MEI_ME_PCH12_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CMP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CMP_V, MEI_ME_PCH12_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CMP_H, MEI_ME_PCH12_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_CMP_LP, MEI_ME_PCH12_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CMP_LP_3, MEI_ME_PCH8_ITOUCH_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CMP_V, MEI_ME_PCH12_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CMP_H, MEI_ME_PCH12_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_ICP_LP, MEI_ME_PCH12_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ICP_N, MEI_ME_PCH12_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICP_LP, MEI_ME_PCH12_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ICP_N, MEI_ME_PCH12_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_TGP_LP, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_TGP_H, MEI_ME_PCH15_SPS_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_TGP_LP, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_TGP_H, MEI_ME_PCH15_SPS_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_JSP_N, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_JSP_N, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_MCC, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_MCC_4, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_MCC, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_MCC_4, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_CDF, MEI_ME_PCH8_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_CDF, MEI_ME_PCH8_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_EBG, MEI_ME_PCH15_SPS_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_EBG, MEI_ME_PCH15_SPS_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_ADP_S, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ADP_LP, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ADP_P, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ADP_N, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_S, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_LP, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_P, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_N, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_RPL_S, MEI_ME_PCH15_SPS_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_RPL_S, MEI_ME_PCH15_SPS_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_MTL_M, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ARL_S, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_ARL_H, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_MTL_M, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ARL_S, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_ARL_H, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_LNL_M, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_LNL_M, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_PTL_H, MEI_ME_PCH15_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_PTL_P, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_PTL_H, MEI_ME_PCH15_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_PTL_P, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_WCL_P, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_WCL_P, MEI_ME_PCH15_CFG) },
 
-	{PCI_DEVICE_DATA(INTEL, MEI_NVL_S, MEI_ME_PCH22_IOE_CFG)},
-	{PCI_DEVICE_DATA(INTEL, MEI_NVL_H, MEI_ME_PCH15_CFG)},
+	{ PCI_DEVICE_DATA(INTEL, MEI_NVL_S, MEI_ME_PCH22_IOE_CFG) },
+	{ PCI_DEVICE_DATA(INTEL, MEI_NVL_H, MEI_ME_PCH15_CFG) },
 
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, mei_me_pci_tbl);
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index f5441bc5efe2..815ca72877ce 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -24,10 +24,10 @@
 #include "hw-txe.h"
 
 static const struct pci_device_id mei_txe_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, 0x0F18)}, /* Baytrail */
-	{PCI_VDEVICE(INTEL, 0x2298)}, /* Cherrytrail */
+	{ PCI_VDEVICE(INTEL, 0x0F18) }, /* Baytrail */
+	{ PCI_VDEVICE(INTEL, 0x2298) }, /* Cherrytrail */
 
-	{0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, mei_txe_pci_tbl);
 
diff --git a/drivers/misc/mrvl_cn10k_dpi.c b/drivers/misc/mrvl_cn10k_dpi.c
index 7d5433121ff6..29b7a4110300 100644
--- a/drivers/misc/mrvl_cn10k_dpi.c
+++ b/drivers/misc/mrvl_cn10k_dpi.c
@@ -658,7 +658,7 @@ static void dpi_remove(struct pci_dev *pdev)
 static const struct pci_device_id dpi_id_table[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_MRVL_CN10K_DPI_PF,
 			 PCI_VENDOR_ID_CAVIUM, PCI_SUBDEVID_MRVL_CN10K_DPI_PF) },
-	{ 0, }  /* end of table */
+	{ }  /* end of table */
 };
 
 static struct pci_driver dpi_driver = {
diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index ef7b32742340..7940e80979a9 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -61,7 +61,7 @@ struct nsm {
 /* NSM device ID */
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_NITRO_SEC_MOD, VIRTIO_DEV_ANY_ID },
-	{ 0 },
+	{ }
 };
 
 static struct nsm *file_to_nsm(struct file *file)
diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
index cb920aa88d3a..0cf38bd482a9 100644
--- a/drivers/misc/ocxl/pci.c
+++ b/drivers/misc/ocxl/pci.c
@@ -9,7 +9,7 @@
  * vendor/device ID to help differentiate devices.
  */
 static const struct pci_device_id ocxl_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x062B), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x062B) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ocxl_pci_tbl);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3635741c3e7a..a10fce77e0b4 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1416,18 +1416,18 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
-	  .driver_data = (kernel_ulong_t)&am654_data
+	  .driver_data = (kernel_ulong_t)&am654_data,
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
@@ -1446,8 +1446,8 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
 	  .driver_data = (kernel_ulong_t)&rk3588_data,
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index 34a5054a6b40..331cae539290 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -481,10 +481,10 @@ static int __maybe_unused phantom_resume(struct device *dev_d)
 }
 
 static struct pci_device_id phantom_pci_tbl[] = {
-	{ .vendor = PCI_VENDOR_ID_PLX, .device = PCI_DEVICE_ID_PLX_9050,
-	  .subvendor = PCI_VENDOR_ID_PLX, .subdevice = PCI_DEVICE_ID_PLX_9050,
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			 PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050),
 	  .class = PCI_CLASS_BRIDGE_OTHER << 8, .class_mask = 0xffff00 },
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, phantom_pci_tbl);
 
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index b21598a18f6d..572c6148a297 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -35,8 +35,8 @@ static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *e
 }
 
 static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
-	{}
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
 
diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 81685e3f3296..f5cdf05ae4ec 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -288,7 +288,7 @@ static void rp1_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id dev_id_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dev_id_table);
diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 476af89e751b..83355c0ec1d2 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -960,8 +960,8 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id vmci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_VMWARE, PCI_DEVICE_ID_VMWARE_VMCI), },
-	{ 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VMWARE, PCI_DEVICE_ID_VMWARE_VMCI) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, vmci_ids);
 
-- 
2.55.0.11.g153666a7d9bb

