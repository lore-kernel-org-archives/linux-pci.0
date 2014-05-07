Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:48646 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbaEGOBM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 10:01:12 -0400
Received: by mail-ig0-f169.google.com with SMTP id hl10so4139332igb.4
        for <linux-pci@vger.kernel.org>; Wed, 07 May 2014 07:01:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t8HdJadhJ9A=Z2owAb0RZU70g2G+XWE+MG155hbb4BfWQ@mail.gmail.com>
References: <CAH9N0t8HdJadhJ9A=Z2owAb0RZU70g2G+XWE+MG155hbb4BfWQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 7 May 2014 08:00:51 -0600
Message-ID: <CAErSpo4-M7dF_ACAt41mGK8HvtGRK8Bs8cCng3qdT7hHqxYCgg@mail.gmail.com>
Subject: Re: Hotswap with an ATCA PCI Express carrier containing a PCIe Switch
To: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 7, 2014 at 7:09 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello,
> Im trying to remove and insert a carrier PCI Express card that
> contains an endpoint card from an ATCA system. ...

> Also when I run "lspci" command PEX 8696 no longer appears (of course)
> and the branch of the entire PCI express tree (path until the FPGA
> endpoint) reaches only until the PEX 8733 downstream port.
>
> Can anybody explain what is happening and what can I do to restore the
> PCI express link each time I perform the hotswap procedure?
> Also, from the registers snapshot I could see that somehow when this
> happens there is always TLP packet that is waiting to be delivered
> (pending I suppose) but I don't know if this is an hardware or
> software issue.

Please include complete "lspci -vv" output (with carrier installed)
and a complete dmesg log that includes removal and insertion events.

Bjorn
