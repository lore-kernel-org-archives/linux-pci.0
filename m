Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:40027 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaIXQkD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 12:40:03 -0400
MIME-Version: 1.0
Date: Wed, 24 Sep 2014 22:10:01 +0530
Message-ID: <CANwwZzUvLHVGshgqrf_w4Pz8wP1H95YAXWLpWFTLD1hWKE_voA@mail.gmail.com>
Subject: Can a PF driver access the VF config space, BAR(MMIO) etc?
From: Bob Biloxi <iambobbiloxi@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am new to writing pci sriov drivers. So i could use your help and
expertise here....

As I understand once sriov is enabled, the PF driver can access the
PF(Physical Function) configuration space, BAR(MMIO) etc and the VF
driver can access the VF(Virtual Function) configuration space,
BAR(MMIO)...

Is it possible for a PF driver to access the VF config space, BAR(MMIO)?
If yes, can you please point me as to what needs to be done in order
to do it(existing driver sources will be really helpful).

Now as to why this requirement is if the PF driver is ready and the VF
driver is still under development, and I want to simulate the VF
functionality from PF itself.

It would be of immense help to me if anyone can help me understand my
aforementioned query.


Thanks a lot!!!


Best Regards,
Bob
