Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:17619
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754706Ab2IAAEx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2012 20:04:53 -0400
Received: from mail56-ch1 (localhost [127.0.0.1])	by mail56-ch1-R.bigfish.com
 (Postfix) with ESMTP id EB39A1600E1	for <linux-pci@vger.kernel.org>; Sat,  1
 Sep 2012 00:04:52 +0000 (UTC)
Received: from CH1EHSMHS036.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.232])	by mail56-ch1.bigfish.com (Postfix) with ESMTP id 948FF60043
	for <linux-pci@vger.kernel.org>; Sat,  1 Sep 2012 00:04:50 +0000 (UTC)
Message-ID: <50415150.9030006@vanderbilt.edu>
Date: Fri, 31 Aug 2012 19:05:36 -0500
From: Mathew Binkley <mathew.binkley@vanderbilt.edu>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
Subject: Determining if PCI device is in slot or on motherboard?
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is there a simple way using the "lspci" command to tell if a PCI device 
is in a slot, or is on the motherboard?   Thanks.


Mat

