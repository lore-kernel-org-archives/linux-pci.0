Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab2JZHMR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Oct 2012 03:12:17 -0400
Message-ID: <508A37CC.5060900@redhat.com>
Date: Fri, 26 Oct 2012 09:12:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
CC: shashank chaturvedi <chaturvedi9950@gmail.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xhci Portsc register issue
References: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com> <20121025153552.GA5205@xanatos>
In-Reply-To: <20121025153552.GA5205@xanatos>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


  Hi,

> But I'm not sure, since I've never attempted to memory map PCI registers
> from userspace.  I was under the impression that you just can't do that.

You can mmap /sys/bus/pci/devices(${device}/resource0.  Just hacked up a
tool which dumps the capability registers this way:

http://www.kraxel.org/cgit/usb-tools/tree/usb-print-caps.c

cheers,
  Gerd

