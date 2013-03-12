Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:42379 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab3CLOJV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 10:09:21 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so5697132oag.20
        for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2013 07:09:20 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Mar 2013 15:09:19 +0100
Message-ID: <CANB7UkHhjUYkSt7j=P41qGO-BApiukLNcFr86kX4hJ7s+j_iYw@mail.gmail.com>
Subject: Questions about PCIe
From: Aurelien Cedeyn <aurelien.cedeyn@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am trying to figure out how the PCI Express specification is
implemented in the Linux kernel.

I read[1] that the PCI Express devices can be accessed like in a
network with a specific protocol with read/wirte requests.
I looked at the kernel source code and i didn't see anything about
such of PCIe packets.

Is this kind of mecanism in the PCIe implementation of the linux
kernel  ? Is this "network" protocol completly transparent and only
managed at the lower layers ?


[1] http://xillybus.com/tutorials/pci-express-tlp-pcie-primer-tutorial-guide-1


Thanks,

-- 
Aurélien Cedeyn
