Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:35603 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaCEEMT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 23:12:19 -0500
Subject: Re: sblk->status_tag on drivers/net/ethernet/broadcom/tg3.c
From: Michael Chan <mchan@broadcom.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
CC: <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <CAD6G_RTVVb2qdU43PqKm3BAD2-pvVcs_O=Wck2SCBhRRV-d+Lw@mail.gmail.com>
References: <CAD6G_RQVD7=v7b6S-muiZBYV7PEykTHOTM23i-BL=wcA5z=4Qg@mail.gmail.com>
	 <CAD6G_RQ130TunwZDL+8vwx__8NsfzE0AfcfnS7z5OXtZF5T8xQ@mail.gmail.com>
	 <1393975344.4632.10.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
	 <CAD6G_RTVVb2qdU43PqKm3BAD2-pvVcs_O=Wck2SCBhRRV-d+Lw@mail.gmail.com>
Content-Type: text/plain; charset="cp1252"
Date: Tue, 4 Mar 2014 20:12:18 -0800
Message-ID: <1393992738.4632.15.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-03-05 at 09:33 +0530, Jagan Teki wrote:
> The driver is not seeing the status block mean - tg3.c driver?

Yes, tg3 driver.  All IRQ events (link change, rx, tx) are in status
block.  If tg3 does not see the correct bits and indexes in the status
block, it won't know what to do.  In this case, it doesn't see the link
change bit in status block (I suspect), so it is not acknowledging and
clearing the link change event.  Status block is DMA'ed from the NIC to
memory.

> Does it relates to ISR or addressing of PCIe RC driver, I'm doing
> nothing on my PCIe RC driver just read the legacy INT# status and
> return.

RC stands for what?  Root Complex?  I don't know what an RC driver does.


