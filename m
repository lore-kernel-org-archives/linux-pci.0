Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64410 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752004Ab3KSUil (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 15:38:41 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"Moore, Robert" <robert.moore@intel.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>
Subject: Re: [PATCH 0/10] ACPI: Device objects for all namespace nodes and PCI root hotplug integration
Date: Tue, 19 Nov 2013 21:51:19 +0100
Message-ID: <3736594.HRILCo6Ms2@vostro.rjw.lan>
In-Reply-To: <20131119143046.GL2281@intel.com>
References: <1421028.Rsfpmhnym3@vostro.rjw.lan> <20131119143046.GL2281@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 19, 2013 04:30:46 PM Mika Westerberg wrote:
> On Sun, Nov 17, 2013 at 05:29:41PM +0100, Rafael J. Wysocki wrote:
> > This is 3.14 material, but I'm posting it today to let you know it is coming.
> > Of course, if you see any immediate problems with the following patches, please
> > let me know.
> 
> For what it's worth, I have tested this series on three different systems
> that have Thunderbolt and it still works fine after the series has been
> applied :)

Awesome, thanks!

I hope you won't mind if I add your Tested-by to the series. :-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
