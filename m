Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:5876
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933298AbcA0OfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 09:35:22 -0500
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V2 0/5] PCIe Xilinx generic driver for Microblaze and
Date: Wed, 27 Jan 2016 14:35:15 +0000
Message-ID: <8520D5D51A55D047800579B09414719825873DB9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <33382572.XZxh3toaBY@wuerfel>
In-Reply-To: <33382572.XZxh3toaBY@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH V2 0/5] PCIe Xilinx generic driver for Microblaze and
> 
> On Tuesday 12 January 2016 23:06:08 Bharat Kumar Gogada wrote:
> > This patch series does modifications to pcie-xilinx.c, to support
> > common driver on both Zynq and Microblaze architectures.
> > Microblaze pci-common.c has been modified to support generic driver.
> >
> > I'm aware Paul Burton <paul.burton@imgtec.com> has also sent patches
> > related to pcie-xilinx.c, but I'm unable to comment on them.
> > I request Paul Burton to please add me in cc list so that I can
> > comment on those patches.
> 
> Very nice work overall!
> 
> I've commented on a few smaller things that I think could be improved.
> 
Thanks, I will do the accordingly.

Bharat
