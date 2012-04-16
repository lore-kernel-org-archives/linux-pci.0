Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm11.bullet.mail.bf1.yahoo.com ([98.139.212.170]:30092 "HELO
	nm11.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754323Ab2DPS5q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Apr 2012 14:57:46 -0400
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204152256.03198.rjw@sisk.pl> <1334560992.32851.YahooMailNeo@web161806.mail.bf1.yahoo.com> <201204161817.21800.rjw@sisk.pl>
Message-ID: <1334602665.33371.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Date: Mon, 16 Apr 2012 11:57:45 -0700 (PDT)
From: Mikko Vinni <mmvinni@yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <201204161817.21800.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki:

>>  Ok, I tested v4 and also v3, which is in 3.4-rc3. On this laptop both 
> versions
>>  work equally: touchpad works after resume (no help for the card reader
>>  problem, though).
> 
> [...]
> 
>>  Difference from v3:
>>  --- /tmp/v3-uniq        2012-04-16 09:57:42.880521878 +0300
>>  +++ /tmp/v4-uniq        2012-04-16 09:58:03.880545386 +0300
>>  @@ -1019,11 +1018,11 @@
>>         1 Booting Node 0 Processor 1 APIC 0x1
>>         1 CPU1 is up
>>         1 ACPI: Waking up from system sleep state S3
>>  -     11 pcieport 0000:00:02.0: restoring config space at offset 0x1c (was 
> 0x20005151, writing 0x5151)
>>  +      1 pcieport 0000:00:02.0: restoring config space at offset 0x1c (was 
> 0x20005151, writing 0x5151)
> 
> OK, so clearly we need to prevent the writes into the secondary status register
> of the PCIe port from being repreated pointlessly.
> 
> Can you please test the appended patch from completness on top of 3.4-rc3?

I think that's what I did already :)

git pull to 3.4-rc3
(test, result as v3 output/diff in the previous email)
Revert "PCI: Fix regression in pci_restore_state(), v3"
apply v4 of the patch
(test, result as v4 output in the previous email)
git diff v3.4-rc3 -- drivers/pci/pci.c --> matches the patch below


Mikko


> 
> Rafael
> 
> 
> ---
> drivers/pci/pci.c |   18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
> 
> Index: linux/drivers/pci/pci.c
> ===================================================================
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -1015,13 +1015,17 @@ void pci_restore_state(struct pci_dev *d
>     pci_restore_pcie_state(dev);
>     pci_restore_ats_state(dev);
> 
> -    pci_restore_config_space(dev, 10, 15, 0);
> -    /*
> -     * The Base Address register should be programmed before the command
> -     * register(s)
> -     */
> -    pci_restore_config_space(dev, 4, 9, 10);
> -    pci_restore_config_space(dev, 0, 3, 0);
> +    if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> +        pci_restore_config_space(dev, 10, 15, 0);
> +        /*
> +         * The Base Address register should be programmed before the
> +         * command register(s)
> +         */
> +        pci_restore_config_space(dev, 4, 9, 10);
> +        pci_restore_config_space(dev, 0, 3, 0);
> +    } else {
> +        pci_restore_config_space(dev, 0, 15, 0);
> +    }
> 
>     pci_restore_pcix_state(dev);
>     pci_restore_msi_state(dev);
> 
