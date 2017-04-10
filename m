Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbdDJNeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Apr 2017 09:34:36 -0400
Date: Mon, 10 Apr 2017 08:34:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Serial info, Mac address in PCI configuration space, and missing
 interpratation of 2 bytes
Message-ID: <20170410133431.GA13170@bhelgaas-glaptop.roam.corp.google.com>
References: <CAGXs5wV_Q6NTg46Tbu0TMXwnigJOHOqiR-2zkBYaVezAcb3igQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXs5wV_Q6NTg46Tbu0TMXwnigJOHOqiR-2zkBYaVezAcb3igQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 09, 2017 at 06:54:51PM +0300, Kevin Wilson wrote:
> Hi,
> When I am running (for a Mellanox Connectx-2 NIC):
> lspci -vvv -s 0000:01:00.0 | grep  Serial
> I get :
> 
> Capabilities: [148 v1] Device Serial Number 00-02-c9-03-00-57-b1-00
> 
> The MAC address of the device is 00-02-c9-57-b1-00; this is the output
> of the above lspci command without the two
> inner bytes of 03-00
> 
> I noticed that I get the same thing with other NIC devices from other
> vendors(I mean that the the MAC address is the result excluding the
> two inner bytes); but the values of the inner bytes differ. For
> example, in a different case I got "ff ff" as the two inner bytes,
> 
> My question is: what does the "03-00" and "ff-ff" (and probably other
> values for other  nics) mean  and how can I decipher them ?

The PCIe spec (r3.1, sec 7.12) only requires that the serial number be
a 64-bit unique identifier.  There might be some convention or spec
requirement that the MAC address be included in the serial number, but
I don't know about it.

> And what is [148 v1]  which immediately follows: "Capabilities:" in
> the output of the lspci above? in a different nic I got
> 140 and not 148, like this:"Capabilities: [140 v1]"

The "148" is the hex offset of the capability in the device's config
space.  This can vary between devices because the capabilities are in
a linked list and the offset of each depends on the type and order of
other capabilities in the list.

The "v1" is the version of the serial number capability.  As of PCIe
r3.1, only version 1 is defined.

Bjorn
