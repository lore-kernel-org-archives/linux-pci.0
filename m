Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32041 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbHNNor (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2015 09:44:47 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NT200DG6RI28I00@mailout3.w1.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 14 Aug 2015 14:44:26 +0100 (BST)
From: Pavel Fedin <p.fedin@samsung.com>
To: 'Will Deacon' <will.deacon@arm.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jayachandran C' <jchandra@broadcom.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Lorenzo Pieralisi' <Lorenzo.Pieralisi@arm.com>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	suravee.suthikulpanit@amd.com, 'Ming Lei' <ming.lei@canonical.com>,
	marc.zyngier@arm.com
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com> <20150812090449.GA22485@arm.com>
In-reply-to: <20150812090449.GA22485@arm.com>
Subject: RE: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
Date: Fri, 14 Aug 2015 16:44:24 +0300
Message-id: <019001d0d697$55a5cf40$00f16dc0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hello!

> >  I also added MSI support. Can i post it as patch on top of your branch?
> 
> There shouldn't be any need with the changes queued in tip/irq/core. Can
> you give the following branch a go, please (it doesn't look like Bjorn's
> stuff is in linux-next, unfortunately)?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel

 I have checked, they already implemented generic handling for "msi-parent" property in the device
tree, and MSI works out of the box.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


