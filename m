Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:35410 "EHLO mout3.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdCJF2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Mar 2017 00:28:19 -0500
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout3.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.85 #1)
        id 1cmCsb-0002ly-9m
        for linux-pci@vger.kernel.org; Fri, 10 Mar 2017 06:14:17 +0100
Received: from localhost ([::1]:57111 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.85 #1)
        id 1cmCsb-00035B-62
        for linux-pci@vger.kernel.org; Fri, 10 Mar 2017 06:14:17 +0100
Received: from mx5.freenet.de ([195.4.92.15]:50821)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.85 #1)
        id 1cmCov-0002NQ-Pm
        for linux-pci@vger.kernel.org; Fri, 10 Mar 2017 06:10:29 +0100
Received: from p5deb0bf1.dip0.t-ipconnect.de ([93.235.11.241]:46766 helo=mail.maya.org)
        by mx5.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (port 465) (Exim 4.85 #1)
        id 1cmCov-0002Nr-LS
        for linux-pci@vger.kernel.org; Fri, 10 Mar 2017 06:10:29 +0100
To: linux-pci@vger.kernel.org
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: IOMMU suuport for Ryzen / x370?
Message-ID: <658a7e9c-7dff-f62e-e2ba-fe151fdbe7d2@01019freenet.de>
Date: Fri, 10 Mar 2017 06:10:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all!


I've got just one quick question: Is there already usable support for
IOMMU in an actual released kernel (chipset x370)? I would need it for
virtualization with vfio / vfio_pci to passthrough PCI and PCIIE cards
to kvm VMs as I'm already doing it with FX 8350 processor (AMD 990X
chipset).



Thanks,
regards,
Andreas
