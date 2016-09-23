Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:43200
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964968AbcIWJ72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Sep 2016 05:59:28 -0400
From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: ATA failure regression
Date: Fri, 23 Sep 2016 09:25:51 +0000
Message-ID: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Resending this wider audience=20

Currently I am working on AMD future platform.  I am hitting the same bug o=
f ATA Failure Regression reported in past.
(https://patchwork.kernel.org/patch/6875661/) or http://lkml.iu.edu/hyperma=
il/linux/kernel/1507.3/01961.html

I am newbie to this and because of this Ubuntu  16.04 is not booting. If di=
sable IOMMU and MSI obviously it works but that is not solution. Even when =
I bisected it boiled to same place which was mentioned in past discussion.

Now my question is there anything required to be done for this future platf=
orm in order to make above patch working because it is already present in U=
buntu 16.04 kernel i.e. 4.4 kernel.

Please help me to debug this issue.

Looking forward to hear from you.

Thanks and Regards
Nehal Shah



