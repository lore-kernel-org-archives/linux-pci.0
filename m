Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:59005 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754901Ab3FAWDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 1 Jun 2013 18:03:19 -0400
Received: from mailout-de.gmx.net ([10.1.76.1]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LiqoN-1U90712Vbh-00cuVR for
 <linux-pci@vger.kernel.org>; Sun, 02 Jun 2013 00:03:18 +0200
Message-ID: <51AA6FA4.3000900@gmx.de>
Date: Sun, 02 Jun 2013 00:03:16 +0200
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-parisc@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] parisc/PCI: lba: fix: convert to pci_create_root_bus()
 for correct root bus resources
References: <20130530141033.GA3665@ls3530.box> <CAErSpo69AxKgz8Dg8+T7n5jsuOzdSoCUstqrX+uUh8TZ08ayqg@mail.gmail.com> <51A7ACBF.4030601@gmx.de> <20130530211244.GA28735@google.com> <51A7C763.4080704@gmx.de> <51A90C21.7010602@gmx.de> <CAErSpo6oX4ADT39_ya_PbHhkQ=i_TaT+hwfrh6qXDn2xCEnx7w@mail.gmail.com>
In-Reply-To: <CAErSpo6oX4ADT39_ya_PbHhkQ=i_TaT+hwfrh6qXDn2xCEnx7w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/31/2013 11:25 PM, Bjorn Helgaas wrote:
>>>> Maybe it has devices that aren't
>>>> officially supported and the firmware did the wrong thing?  (Though it'd
>>>> still be nice if Linux did something more sensible than this.)
>>
>> Ok, I removed all unnecessary cards, incl. 100MBit NIC, 1000MBit NIC, Matrox G200 and a Visualize FX.
>>
>> Now it works nicely and as expected.
>> Even the Visualize EG graphics card and the Voodo2 work (which were my main problem) :-)
> 
> Good, glad that works.  We *ought* to be able to do better, e.g., by
> just ignoring cards that we can't use.
> 
> If you have a chance, you might collect the complete dmesg log from
> both the working configuration and the broken one, and attach them to
> a new kernel.org PCI bugzilla. 

I opened bugzilla #59191
https://bugzilla.kernel.org/show_bug.cgi?id=59191
(Someone needs to reassign this bug to Driver/PCI component - I can't.)

Thanks!
Helge
