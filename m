Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.189]:61679 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbdCJPPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2017 10:15:25 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mason' <slash.tmp@free.fr>, Robin Murphy <robin.murphy@arm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: Neophyte questions about PCIe
Date: Fri, 10 Mar 2017 15:14:59 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7C973@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
In-Reply-To: <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mason
> Sent: 10 March 2017 15:06
...
> My RC drops packets not targeting its BAR0.

I suspect the fpga/cpld logic supports RC and endpoint modes
and is using much the same names for the registers (and logic
implementation).

If your cpu support more than 1GB of memory but only part is
PCIe accessible you'll have to ensure that all the memory
definitions are set correctly and 'bounce buffers' used for
some operations.

	David
