Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:34944
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751351AbaBXC6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2014 21:58:30 -0500
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Kamel BOUHARA <k.bouhara@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: iMX6 PCIe EP
Date: Mon, 24 Feb 2014 02:58:26 +0000
Message-ID: <cbb2ca07700a4cdb85261cbc738cfca2@BLUPR03MB136.namprd03.prod.outlook.com>
References: <CAM9uW_4bXH_jmcY7eJhC-YyMrmQ_FQmU78N380fNfTmkjf0Yfg@mail.gmail.com>
In-Reply-To: <CAM9uW_4bXH_jmcY7eJhC-YyMrmQ_FQmU78N380fNfTmkjf0Yfg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi K.Bouhara:


> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Kamel BOUHARA
> Sent: Friday, February 21, 2014 4:47 PM
> To: linux-pci@vger.kernel.org
> Subject: iMX6 PCIe EP
> 
> Hi,
> 
> I was wondering if there is any effort made to support imx6 pcie as endpoint ?
> And how hard it will be to get a simple configuration with two BAR's (IO and
> MEM) ?

[Richard] I used to setup one i.MX6 PCIe EP/RC validation system in FSL Linux BSP(imx_3.0.35_4.1.0 release, or, imx_3.10 beta release),
 and validated the i.MX6 PCIe EP mode.
You can make a reference from FSL Linux BSP, if you want the i.MX6 PCIe used as EP mode.
About the HW environment setup, you can make a reference to the following URL.
https://community.freescale.com/docs/DOC-95014

> 
> BR,
> K.Bouhara
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
Best Regards
Richard Zhu

