Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1126 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754399AbbDPODT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2015 10:03:19 -0400
Date: Thu, 16 Apr 2015 21:59:38 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: [query] how to use "ranges" in device tree
Message-ID: <20150416215938.347caa68@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I didn't fully understand the "ranges" usage, here is one situation which I dunno
how to handle.

In arch/arm/boot/dts/berlin2q.dtsi, we describe the /soc ranges as

ranges = <0 0xf7000000 0x1000000>;

That's fine. Now there's a pci device based on pcie-designware.c which prefer
put "config" space in reg. But the config space starts at 0xe0000000, due to
the /soc ranges, the "config" space following pcie node is not correct in fact.

soc {
	ranges = <0 0xf7000000 0x1000000>;
	...
	pcie: pcie@e40000 {
		compatible = "...";
		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
		reg-names = "dbi", "pad", "config";
		...
	};
	...
};

How to define the "config" space in this situation? Did we need to change
the /soc ranges as the following?

soc {
	ranges;
}

Thanks in advance,
Jisheng
