Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:35761
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103Ab3JINgg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Oct 2013 09:36:36 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
Subject: Difference between hot-plug on PCIe rootport vs downstream port
Date: Wed, 9 Oct 2013 13:36:27 +0000
Message-ID: <43e5eb8dd8c04af197a01dc974f52924@BLUPR05MB118.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

1) Does the pciehp support hotplug on both rootport and downstream port?

2) What is so different about these that downstream port hotplug was part of the kernel since very long, but root port hotplug was included releatively recently? Are there any added complexities? I couldn't find anything on the net on this. From my understanding it should be exactly similar?

3) I understand the hotplug on downstream port is architecture independent. But is the root port hotplug architecture dependent (assuming that the CPU complies to the PCIe, spec, it shouldn't be, right)? 

4) Can you point me to the code where the root port hotplug is implemented?

Thanks,

Rajat

