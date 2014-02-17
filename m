Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59796 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbaBQGkG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 17 Feb 2014 01:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1WFHs3-0002L8-MQ
	for linux-pci@vger.kernel.org; Mon, 17 Feb 2014 07:40:03 +0100
Received: from ABTS-North-Static-072.159.160.122.airtelbroadband.in ([ABTS-North-Static-072.159.160.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 07:40:03 +0100
Received: from anand.mistry by ABTS-North-Static-072.159.160.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 07:40:03 +0100
To: linux-pci@vger.kernel.org
From: Anand Mistry <anand.mistry@spectross.com>
Subject: PCI-PCI bridge memory ranges in linux device tree
Date: Mon, 17 Feb 2014 06:31:16 +0000 (UTC)
Message-ID: <loom.20140217T065100-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Can anybody please help me out with this one. My linux kernel is not
programming memory ranges of PCI-PCI bridges and crashes on finding devices
beyond the bridge. How do i enable automatic resource allocation of PCI-PCi
bridges in the kernel? 

For reference,
Processor is MPC8313
Kernel version is 2.6.23.
Code from the DTS file

/* code starts */
pci@8500 {
	bus-range = <0 0>;
	ranges = <02000000 0 90000000 90000000 0 10000000
	          42000000 0 80000000 80000000 0 10000000
	          01000000 0 00000000 e2000000 0 00100000>;
	#interrupt-cells = <1>;
	#size-cells = <2>;
	#address-cells = <3>;
	reg = <8500 100>;
	compatible = "fsl,mpc8349-pci";
	device_type = "pci";
	interrupt-parent = < &ipic >;
	interrupts = <42 8>;
	interrupt-map-mask = <0F800 0 0 7>;
	interrupt-map = <

			// ** For reference **
			// INTA = IRQ1 = 0x11
			// INTB = IRQ2 = 0x12
			// INTC = IRQ0 = 0x30
			// INTD = IRQ4 = 0x14

			// BUS 0 IDSEL 0x18 (IDSEL = AD24)
			0c000 0 0 1 &ipic 11 8  // PCI_INTA 
			0c000 0 0 2 &ipic 12 8  // PCI_INTB  
			0c000 0 0 3 &ipic 30 8  // PCI_INTC 
			0c000 0 0 4 &ipic 14 8  // PCI_INTD 
			>;

}; 

/* code ends */



Thanks and Regards,
Anand Mistry


