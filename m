Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27693 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753580AbdFSJvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 05:51:00 -0400
Subject: Re: PCI endpoint API question
To: Christoph Hellwig <hch@infradead.org>
References: <20170618140530.GA22519@infradead.org>
CC: <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f7596eb9-cb96-7b82-699a-c8a1f7e85b6e@ti.com>
Date: Mon, 19 Jun 2017 15:20:29 +0530
MIME-Version: 1.0
In-Reply-To: <20170618140530.GA22519@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Sunday 18 June 2017 07:35 PM, Christoph Hellwig wrote:
> Hi Kishon,
> 
> I've been looking at porting some code to the current incarnation
> of your PCI endpoint API.  Once thing that I'm missing is a notification
> for writes to BARs - is this and intentional omission?  It seems
> like the only current option is to poll for changes.

You mean write to the address that's mapped to BAR in the EP side?

PCI doesn't allow hosts to interrupt the EP (AFAIK), so we have to poll for any
writes by the host to EP memory.

However recently I found "Mailbox" module in dra7xx can be used in conjunction
with PCI for PCI host to interrupt EP. I'm yet to add support for using such
SoC specific mechanisms for EP interrupts.

Thanks
Kishon
