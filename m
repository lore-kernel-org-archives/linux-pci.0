Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47016 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbHDHgE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 03:36:04 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSJ00M34RS1R290@mailout1.w1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 04 Aug 2015 08:36:01 +0100 (BST)
From: Pavel Fedin <p.fedin@samsung.com>
To: 'Jayachandran C' <jchandra@broadcom.com>,
	'Will Deacon' <will.deacon@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>
Cc: 'Suravee Suthikulpanit' <Suravee.Suthikulpanit@amd.com>,
	'Ming Lei' <ming.lei@canonical.com>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
In-reply-to: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
Subject: RE: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
Date: Tue, 04 Aug 2015 10:35:59 +0300
Message-id: <00b601d0ce88$35b2f8a0$a118e9e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hello!

> Notes:
>  - passing a zeroed out pci_sys_data for ARM looks ok, but I haven't
>    tested it on ARM.
>  - tested it on ARM64 fast model
>  - Any information on how this can be tested on arm is welcome.

 I have tested it on SMDK5410, works OK. By the way, PCI generic is missing MSI support, i had to
add it. I can share the patch if interested, it's very small.

Tested-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


