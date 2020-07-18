Return-Path: <SRS0=9ytz=A5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7915FC433DF
	for <linux-pci@archiver.kernel.org>; Sat, 18 Jul 2020 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF112064B
	for <linux-pci@archiver.kernel.org>; Sat, 18 Jul 2020 14:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGRO1m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:27:42 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:44880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbgGRO1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jul 2020 10:27:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4A0BA18566;
        Sat, 18 Jul 2020 14:27:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell32_63132ee26f14
X-Filterd-Recvd-Size: 3682
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Jul 2020 14:27:39 +0000 (UTC)
Message-ID: <e9571e823a855f5c3c671c9c9c5ffe423b313ca4.camel@perches.com>
Subject: Re: [PATCH] ACPI/PCI: fix array_size.cocci warnings
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Date:   Sat, 18 Jul 2020 07:27:38 -0700
In-Reply-To: <20200718080145.GA55766@adfac4dc55cb>
References: <a5da506cb5cd5d590d88da8537ad01c0167840da.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <20200718080145.GA55766@adfac4dc55cb>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2020-07-18 at 16:01 +0800, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> drivers/acpi/pci_root.c:150:37-38: WARNING: Use ARRAY_SIZE
> 
>  Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
[]
>  static char *get_osc_desc(u32 bit)
>  {
> -	int len = sizeof(pci_osc_control_bit) / sizeof(pci_osc_control_bit[0]);
> +	int len = ARRAY_SIZE(pci_osc_control_bit);
>  	int i = 0;
>  
>  	for (i = 0; i <len; i++)

And likely better to not declare len at all
and ARRAY_SIZE directly instead.

static char *get_osc_desc(u32 bit)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(pci_osc_control_bit); i++) {
		if (bit == pci_osc_control_bit[i].bit)
			return pci_osc_control_bit[i].desc;
	}

	return NULL;
}

and also likely both arrays should be const.

Something like:
---
 drivers/acpi/pci_root.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841c59f5..bfb437cf749a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -122,10 +122,10 @@ static acpi_status try_get_root_bridge_busnr(acpi_handle handle,
 
 struct pci_osc_bit_struct {
 	u32 bit;
-	char *desc;
+	const char *desc;
 };
 
-static struct pci_osc_bit_struct pci_osc_support_bit[] = {
+static const struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_EXT_CONFIG_SUPPORT, "ExtendedConfig" },
 	{ OSC_PCI_ASPM_SUPPORT, "ASPM" },
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
@@ -135,7 +135,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
 };
 
-static struct pci_osc_bit_struct pci_osc_control_bit[] = {
+static const struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_NATIVE_HP_CONTROL, "PCIeHotplug" },
 	{ OSC_PCI_SHPC_NATIVE_HP_CONTROL, "SHPCHotplug" },
 	{ OSC_PCI_EXPRESS_PME_CONTROL, "PME" },
@@ -146,17 +146,18 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
-			    struct pci_osc_bit_struct *table, int size)
+			    const struct pci_osc_bit_struct *table, int size)
 {
 	char buf[80];
 	int i, len = 0;
-	struct pci_osc_bit_struct *entry;
 
 	buf[0] = '\0';
-	for (i = 0, entry = table; i < size; i++, entry++)
-		if (word & entry->bit)
+	for (i = 0; i < size; i++) {
+		if (word & table->bit)
 			len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
-					len ? " " : "", entry->desc);
+					len ? " " : "", table->desc);
+		table++;
+	}
 
 	dev_info(&root->device->dev, "_OSC: %s [%s]\n", msg, buf);
 }


