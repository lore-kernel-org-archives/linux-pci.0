Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:60223 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbaCEGuc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 01:50:32 -0500
Subject: Re: sblk->status_tag on drivers/net/ethernet/broadcom/tg3.c
From: Michael Chan <mchan@broadcom.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
CC: <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <CAD6G_RR=y+myvtEpa3YKiOx_8LR=Ad_nHUxuaXKakfKKyjuEaw@mail.gmail.com>
References: <CAD6G_RQVD7=v7b6S-muiZBYV7PEykTHOTM23i-BL=wcA5z=4Qg@mail.gmail.com>
	 <CAD6G_RQ130TunwZDL+8vwx__8NsfzE0AfcfnS7z5OXtZF5T8xQ@mail.gmail.com>
	 <1393975344.4632.10.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
	 <CAD6G_RTVVb2qdU43PqKm3BAD2-pvVcs_O=Wck2SCBhRRV-d+Lw@mail.gmail.com>
	 <1393992738.4632.15.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
	 <CAD6G_RR=y+myvtEpa3YKiOx_8LR=Ad_nHUxuaXKakfKKyjuEaw@mail.gmail.com>
Content-Type: text/plain; charset="cp1252"
Date: Tue, 4 Mar 2014 22:50:30 -0800
Message-ID: <1394002230.4632.28.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-03-05 at 11:43 +0530, Jagan Teki wrote: 
> As per your point I've a question here like - the status block is not properly
> updated (DMA'ed), does this depends on the address range we are advertised
> on PCIe ranges filed to make sure to use EP-
> http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge 

The status block is in host memory (CPU memory).  This memory is
allocated by the driver.  The DMA address of the status block is then
programmed into the NIC register HOSTCC_STATUS_BLK_HOST_ADDR so that the
NIC knows where to DMA the status block.  When there is an event, the
NIC DMAs a new status block and then generates IRQ.

The status block is not in PCI memory.  PCI memory is where the
registers are mapped.  Hope this helps.

