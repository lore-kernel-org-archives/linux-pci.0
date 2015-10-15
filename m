Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52716 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbJOTlP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 15:41:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@kernel.org>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Mark Brown <broonie@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: iproc: fix 32-bit build error
Date: Thu, 15 Oct 2015 21:40:45 +0200
Message-ID: <5754881.OPA6La0Zg0@wuerfel>
In-Reply-To: <561FD20F.1090004@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com> <20151015160028.GA17702@localhost> <561FD20F.1090004@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The iproc PCI driver tries to figure out whether the MMIO window has
a valid size, but does this using a 64-bit modulo operation, which
is not allowed on 32-bit kernels and leads to a link error:

drivers/built-in.o: In function `iproc_pcie_setup':
:(.text+0x4b798): undefined reference to `__aeabi_uldivmod'

This works around that error by using the div64_u64() function
provided by the kernel. While this is an expensive operation,
it is harmless because we only call it during the probing
of the driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ray Jui <rjui@broadcom.com>
Fixes: 0ab99ca8eb6c ("PCI: iproc: Fix compile warnings")

---
On Thursday 15 October 2015 09:19:27 Ray Jui wrote:
> On 10/15/2015 9:00 AM, Bjorn Helgaas wrote:
> > 
> > Ping; I can easily fix up the static, but it'd be nice to have real acks
> > from Ray and Hauke.


Argh, I knew there was one patch from my build fixes that I needed to
redo, I just couldn't find it again. Thanks for the reminder.


diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index f3481ddff344..9193951ae861 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -241,6 +241,7 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 	struct iproc_pcie_ob *ob = &pcie->ob;
 	unsigned i;
 	u64 max_size = (u64)ob->window_size * MAX_NUM_OB_WINDOWS;
+	u64 remainder;
 
 	if (size > max_size) {
 		dev_err(pcie->dev,
@@ -249,7 +250,8 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 		return -EINVAL;
 	}
 
-	if (size % ob->window_size) {
+	div64_u64_rem(size, ob->window_size, &remainder);
+	if (remainder) {
 		dev_err(pcie->dev,
 			"res size %pap needs to be multiple of window size %pap\n",
 			&size, &ob->window_size);

