Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:20785
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706Ab3LJTxO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Dec 2013 14:53:14 -0500
Received: from mail43-db9 (localhost [127.0.0.1])	by mail43-db9-R.bigfish.com
 (Postfix) with ESMTP id EC516680362	for <linux-pci@vger.kernel.org>; Tue, 10
 Dec 2013 19:53:12 +0000 (UTC)
Received: from DB9EHSMHS020.bigfish.com (unknown [10.174.16.232])	by
 mail43-db9.bigfish.com (Postfix) with ESMTP id 1DEDFC0008D	for
 <linux-pci@vger.kernel.org>; Tue, 10 Dec 2013 19:53:10 +0000 (UTC)
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Question about how PCI subsystem uses device trees
Date: Tue, 10 Dec 2013 19:53:05 +0000
Message-ID: <a8c8cc16a5424e45b226bb40425b3772@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am trying to understand and create device tree for a new powerpc platform. (Please feel free to point out any problems with my device tree below.) My questions: 

1) For a PCI-PCI bridge that I'm representing like this:

pcie@2,3 {
	vendor-id = <0x10b5>;
      device-id = <0x8618>;
      class-code = <0x060400>;
      #size-cells = <2>;
      #address-cells = <3>;
      device_type = "pci";
      bus-range = <0x20 0x2f>;
      reg = <0x00021800 0x00000000 0x000000000        /* Cfg:2.3.0: */
             0x00000000 0x00000000>;
      ranges = <0x02000000 0x00000000 0xA0000000      /* Mem behind bridge: 0xA0000000 - 0xA03FFFFF */
                0x02000000 0x00000000 0xA0000000
                0x00000000 0x04000000>;
};

Is the above is only to _notify_ the kernel that this is how the firmware shall be setting the PCI bridge (Thus firmware has obligation of setting it like this before passing control to the kernel), and hence the kernel will merely take note of it and not really configure the bridge registers? 

Or is the above telling the kernel that this is how the kernel should _setup_ the device (thus firmware does not set up the device, but rather the kernel use this info to setup the device)?

2) For an PCI endpoint that I am representing like this:


xyz@20,0 {
	vendor-id = ...
      device-id = ...
      class-code = <0x0880>;
      compatible = ...
	...
      reg = <0x00200000 0x00000000 0x00000000 /* Cfg:20.0.0: */
             0x00000000 0x00000000
             0x02200010 0x00000000 0xA0000000 /* Mem:20.0.0:(Bar0) 64MB@0xA0000000 */
             0x00000000 0x04000000>;
	...
};

Does the above tell the kernel to _program_ the BAR0 register using the above address? Or does it cause the kernel to assume that the BAR0 has been programmed with this address?

3) Lastly, what is the difference in behavior when I select PCI_PROBE_NORMAL over PCI_PROBE_DEVTREE? 

Thanks,

Rajat

