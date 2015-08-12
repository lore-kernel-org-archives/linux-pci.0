Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:29566 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933708AbbHLHLe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 03:11:34 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSY0033SJZ77A80@mailout3.w1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Aug 2015 08:11:31 +0100 (BST)
From: Pavel Fedin <p.fedin@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jayachandran C' <jchandra@broadcom.com>
Cc: 'Will Deacon' <will.deacon@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Suravee Suthikulpanit' <Suravee.Suthikulpanit@amd.com>,
	'Ming Lei' <ming.lei@canonical.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
In-reply-to: <20150804234956.GF17327@google.com>
Subject: RE: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
Date: Wed, 12 Aug 2015 10:11:29 +0300
Message-id: <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hello!

> I dropped the acks and tested-by because of that change, but I'll happily
> add them back if Lorenzo and Pavel confirm.  

 Confirm.
 Tested-by: Pavel Fedin <p.fedin@samsung.com>

 I also added MSI support. Can i post it as patch on top of your branch?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

