Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369FC4332F
	for <linux-pci@archiver.kernel.org>; Sat,  9 Apr 2022 13:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbiDINbE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Apr 2022 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbiDINbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2022 09:31:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C539AE6C;
        Sat,  9 Apr 2022 06:28:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id f7cabe0ba700f433; Sat, 9 Apr 2022 15:28:54 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B7AED66BCD0;
        Sat,  9 Apr 2022 15:28:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 6/7] PCI/PM: Clean up pci_set_low_power_state()
Date:   Sat, 09 Apr 2022 15:26:44 +0200
Message-ID: <1752041.VLH7GnMWUR@kreacher>
In-Reply-To: <4419002.LvFx2qVVIh@kreacher>
References: <4419002.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekvddgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshht
 vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the following assorted non-essential changes in
pci_set_low_power_state():

 1. Drop two redundant checks from it (the caller takes care of these
    conditions).

 2. Modify error messages printed by it to make them more
    consistent with the messages printed by pci_power_up() and
    pci_set_full_power_state().

 3. Change the log level of one of the messages mentioned above to
    "debug", because it only indicates a programming mistake.

 4. Make the function return -ENODEV (instead of -EIO) when the
    device is not accessible.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1324,16 +1324,9 @@ static int pci_set_low_power_state(struc
 {
 	u16 pmcsr;
 
-	/* Check if we're already there */
-	if (dev->current_state == state)
-		return 0;
-
 	if (!dev->pm_cap)
 		return -EIO;
 
-	if (state < PCI_D1 || state > PCI_D3hot)
-		return -EINVAL;
-
 	/*
 	 * Validate transition: We can enter D0 from any state, but if
 	 * we're already in a low-power state, we can only go deeper.  E.g.,
@@ -1341,7 +1334,7 @@ static int pci_set_low_power_state(struc
 	 * we'd have to go from D3 to D0, then to D1.
 	 */
 	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
-		pci_err(dev, "invalid power transition (from %s to %s)\n",
+		pci_dbg(dev, "Invalid power transition (from %s to %s)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
 		return -EINVAL;
@@ -1354,10 +1347,10 @@ static int pci_set_low_power_state(struc
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
+		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
-		return -EIO;
+		return -ENODEV;
 	}
 
 	/*



