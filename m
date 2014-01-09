Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f65.google.com ([74.125.82.65]:36973 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaAIKvu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 05:51:50 -0500
Received: by mail-wg0-f65.google.com with SMTP id k14so611638wgh.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 02:51:49 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 9 Jan 2014 16:21:49 +0530
Message-ID: <CA+sq2CfthYc3Eda3GRa-Q-TA9gq+ygBTLrPjvzhRquikm220GA@mail.gmail.com>
Subject: Query regarding ARI configuration of a on-board PCIe device.
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a platform which has a on-board PCIe device attached to PCIe port.
This device is an ethernet device with SRIOV capability having morethan
8 virtual functions.

I am going through Linux's ARI configuration code and saw that it is checking
if upstream bridge supports ARI or not. In our case its a on-board device and
no bridge is involved.

Need some help or ideas on how i can configure ARI on the device so that
all VFs gets added.

Do i need to change the ARI configuration code or is there a way to fake a
PCI bridge for this purpose ?

Thanks,
Sunil.
