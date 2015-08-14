Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35930 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbbHNOqt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2015 10:46:49 -0400
Received: by igxp17 with SMTP id p17so13497754igx.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2015 07:46:48 -0700 (PDT)
Date: Fri, 14 Aug 2015 09:46:44 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Pavel Fedin <p.fedin@samsung.com>,
	'Jayachandran C' <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	'Arnd Bergmann' <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	'Ming Lei' <ming.lei@canonical.com>, marc.zyngier@arm.com
Subject: Re: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
Message-ID: <20150814144644.GC26431@google.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com>
 <20150812090449.GA22485@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150812090449.GA22485@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 10:04:50AM +0100, Will Deacon wrote:
> On Wed, Aug 12, 2015 at 08:11:29AM +0100, Pavel Fedin wrote:
> > > I dropped the acks and tested-by because of that change, but I'll happily
> > > add them back if Lorenzo and Pavel confirm.  
> > 
> >  Confirm.
> >  Tested-by: Pavel Fedin <p.fedin@samsung.com>
> > 
> >  I also added MSI support. Can i post it as patch on top of your branch?
> 
> There shouldn't be any need with the changes queued in tip/irq/core. Can
> you give the following branch a go, please (it doesn't look like Bjorn's
> stuff is in linux-next, unfortunately)?

We still have a build issue (undefined reference to pci_write_msi_msg
in imx_v6_v7_defconfig) to resolve before putting it in linux-next.
Hopefully we can resolve that today.
