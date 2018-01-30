Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32778 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752385AbeA3GGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 01:06:42 -0500
From: Victor Gu <xigu@marvell.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Nadav Haklai <nadavh@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Designware 64bit PCIe bus address support
Date: Tue, 30 Jan 2018 06:06:37 +0000
Message-ID: <c3a54516e4004323bdc5be30971f40f8@SC-EXCH04.marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo and Pratyush,

I am Victor Gu, SW RD from Marvell.

During the testing we found the designware PCIe works well with 64 bit CPU address and 32 bit PCIe bus address(translated by ATU).
But cannot access the PCIe EP if both of them use the 64 bit CPU address, such as 0x800000000.

Do you know if the designware PCIe IP supports 64 bit PCIe bus address?
And if the designware PCIe Linux driver supports 64 bit PCIe bus address?

Thank you for the help!

Best Regards,
Victor Gu
