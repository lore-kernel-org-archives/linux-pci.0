Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57058 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab3HVVtp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 17:49:45 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so474600oag.18
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 14:49:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
References: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 22 Aug 2013 15:49:24 -0600
Message-ID: <CAErSpo49W9iYWUfVRCALr9Nkvuzs38MwzNUAXLgr91BRiRFtFQ@mail.gmail.com>
Subject: Re: VIA chipset with Root Port under a bridge
To: Wolfgang Denk <wd@denx.de>, Shaohua Li <shli@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[replace Shaohua's dead Intel address with @kernel.org address; please
reply to this, not the original]

On Thu, Aug 22, 2013 at 3:47 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Shaohua, your commit 8e822df700 references a VIA chipset with a Root
> Port under a bridge, and that commit adds a special case to disable
> ASPM for that situation.
>
> I know this is pretty old (the commit is from 2009), but do you have
> any more details about that system?  A pointer to the original problem
> report, lspci output, dmesg output, etc.?
>
> I'm concerned because other parts of PCI make assumptions about Root
> Port topology, e.g., in MPS configuration, and we might need to make
> similar changes elsewhere.
>
> Bjorn
