Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:1058 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab3KRIC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 03:02:28 -0500
From: "Yuval Mintz" <yuvalmin@broadcom.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Is there an API for adding/removing a single MSIX entry?
Date: Mon, 18 Nov 2013 08:02:19 +0000
Message-ID: <979A8436335E3744ADCD3A9F2A2B68A52AF091AB@SJEXCHMB10.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

There are scenarios in which we need to add/remove MSI-X entries -
a good example for this is when a user configures a networking device for 
additional channels; Current implementation forces us to:
	1. Prevent HW from generating interrupts.
	2. Call `pci_disable_msix()'
	3. Call `pci_enable_msix()' with the new set of requested entries.
	
Now, is it feasible to add support for dynamically adding/removing of single 
entries, or does this request poses some major difficulties (either by simply 
being unfeasible due to the standard or because it will require a lot of code change)?

(If I'm mistaken and there IS a way of doing this today, I'd be grateful for a
bit of instructions on how-to)

Thanks,
Yuval Mintz


