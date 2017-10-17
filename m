Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:36446
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754212AbdJQSgZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 14:36:25 -0400
From: Casey Leedom <leedom@chelsio.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "Komali  Katari" <komali@chelsio.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Tue, 17 Oct 2017 18:36:21 +0000
Message-ID: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi there,

  I hope this is the right Linux list for this issue.  One of our QA staff
has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCIe
SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this case=
)
is automatically loaded.  That's fine and has been the case for some time.
But, we remove the driver module (rmmod cxgb4vf) and then attach one of the
VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded in
the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
big change done by Luis R. Rodriguez in kernel.org commit revision 2355869
but we haven't yet isolated the new behavior to that commit.  That'll be ou=
r
next test but I wanted to get this out there for comment.

Casey=
