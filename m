Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:60024 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaA3AEe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 19:04:34 -0500
Received: by mail-oa0-f51.google.com with SMTP id h16so2863428oag.24
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 16:04:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
 <20140117182231.GA18421@google.com> <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Jan 2014 17:04:13 -0700
Message-ID: <CAErSpo4fGBhb+pj6pTpKFTTj9rzLYzB2w-EX2ghWRYR3Cjyd9g@mail.gmail.com>
Subject: Re: EHCI host broken -- interrupts disabled
To: "Chen, Jamie" <jamie.chen@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 20, 2014 at 5:15 AM, Chen, Jamie <jamie.chen@intel.com> wrote:
> Try to apply this patch to kernel 3.8.0.
>
> Make sure the ehci can work fine and lspci show that PCI_COMMAND_INTX_DISABLE is 0.
>
> The patch can resolved this issue.

Thanks for testing it.  Can you collect the complete dmesg output or
dmidecode output?  (Remove secret details from it, of course.)

I'm going to put this info into a bugzilla report for future reference.

Bjorn
