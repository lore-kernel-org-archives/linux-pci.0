Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:38992
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932555AbcA0O12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 09:27:28 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	nofooter <nofooter@xilinx.com>
Subject: RE: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
Date: Wed, 27 Jan 2016 14:27:16 +0000
Message-ID: <8520D5D51A55D047800579B09414719825873D88@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
 <5660994.Bgxrr57r2H@wuerfel>
In-Reply-To: <5660994.Bgxrr57r2H@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
> 
> On Tuesday 12 January 2016 23:06:10 Bharat Kumar Gogada wrote:
> > Removing struct hw_irq and adding generic PCI core API's.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Removing architecure dependecy structure struct hw_irq which is ARM
> > 32-bit specific structure, and adding generic PCI core API's to
> > register to PCI subsytem.
> > Removing funtions which are not being used with generic API's.
> >
> 
> typo: s/hw_irq/hw_pci/
> 
Yes, its struct hw_pci, will correct it in next patch.

