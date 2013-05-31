Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35552 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab3EaRfy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 13:35:54 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so1959490lbd.1
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 10:35:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
Date: Fri, 31 May 2013 18:35:52 +0100
Message-ID: <CAH9N0t8ODdHOz-ajwUBUv34XOH=i65S=4D0=HnvDLjCV7N3n8g@mail.gmail.com>
Subject: Pcie Linux HotPlug Driver Automatic Scripts
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
Yes all is working.
Although I need to automatize the all process.
I want to unplug the ATCA card and run the script i made to remove
power and so remove driver and want to plug ATCA card and to rescan
pci bus and so insert driver.
I know i have to use udev apporach but dont know what steps are required.

Also, How can I perform an entire pcie express bus reset from linux terminal?
Paulo.
