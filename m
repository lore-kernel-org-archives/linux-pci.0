Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C6C433EF
	for <linux-pci@archiver.kernel.org>; Thu,  5 May 2022 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351003AbiEESfZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 May 2022 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385269AbiEESaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:18 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C929913FBD;
        Thu,  5 May 2022 11:20:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 673a922d1a087de5; Thu, 5 May 2022 20:19:29 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 422AB66C2F5;
        Thu,  5 May 2022 20:19:28 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 10/11] PCI/PM: Rearrange pci_set_power_state()
Date:   Thu, 05 May 2022 20:16:50 +0200
Message-ID: <2139440.Mh6RI2rZIc@kreacher>
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
References: <4738492.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduiedurddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The part of pci_set_power_state() related to transitions into
low-power states is unnecessary convoluted, so clearly divide it
into the D3cold special case and the general case covering all of
the other states.

Also fix a potential issue with calling pci_bus_set_current_state()
to set the current state of all devices on the subordinate bus to
D3cold without checking if the power state of the parent bridge has
really changed to D3cold.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1446,19 +1446,25 @@ int pci_set_power_state(struct pci_dev *
 	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
 		return 0;
 
-	/*
-	 * To put device in D3cold, we put device into D3hot in native
-	 * way, then put device into D3cold with platform ops
-	 */
-	error = pci_set_low_power_state(dev, state > PCI_D3hot ?
-					PCI_D3hot : state);
+	if (state == PCI_D3cold) {
+		/*
+		 * To put the device in D3cold, put it into D3hot in the native
+		 * way, then put it into D3cold using platform ops.
+		 */
+		error = pci_set_low_power_state(dev, PCI_D3hot);
 
-	if (pci_platform_power_transition(dev, state))
-		return error;
+		if (pci_platform_power_transition(dev, PCI_D3cold))
+			return error;
 
-	/* Powering off a bridge may power off the whole hierarchy */
-	if (state == PCI_D3cold)
-		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+		/* Powering off a bridge may power off the whole hierarchy */
+		if (dev->current_state == PCI_D3cold)
+			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+	} else {
+		error = pci_set_low_power_state(dev, state);
+
+		if (pci_platform_power_transition(dev, state))
+			return error;
+	}
 
 	return 0;
 }



