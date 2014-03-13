Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:27259 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbaCMU4X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 16:56:23 -0400
Subject: Re: ethernet/broadcom/tg3.c - DMA Status error with INTx
From: Michael Chan <mchan@broadcom.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
CC: <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <aav@xilinx.com>,
	Srikanth T <srikuuuu@gmail.com>
In-Reply-To: <CAD6G_RQef0pQqswW6jsfSgpBC=81wBWcL63t3oR04sM2aHFvPw@mail.gmail.com>
References: <CAD6G_RRaDG-F9tqDMc3HWJdEZ3h_apNe8bx12g+ddTsPpHx06w@mail.gmail.com>
	 <CAD6G_RQef0pQqswW6jsfSgpBC=81wBWcL63t3oR04sM2aHFvPw@mail.gmail.com>
Content-Type: text/plain; charset="cp1252"
Date: Thu, 13 Mar 2014 13:56:20 -0700
Message-ID: <1394744180.4632.116.camel@LTIRV-MCHAN1.corp.ad.broadcom.com>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-03-11 at 19:11 +0530, Jagan Teki wrote: 
> Just add one more point here, Read DMA Status Register(0x4804) value here
> was 0x10 which means Read DMA PCI Parity Error, can anyone send what are
> the possible cases to trigger this error.! 

A parity error is detected during read DMA (from root complex to tg3
device).  You can also check the AER capability in config space which
has more information about correctable and uncorrectable errors.  I
think it means that your PCIE link is not very stable if you get these
errors repeatedly.

