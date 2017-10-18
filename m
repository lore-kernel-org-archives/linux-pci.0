Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:1472
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750800AbdJRS0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 14:26:18 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        "Komali Katari" <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Wed, 18 Oct 2017 18:26:12 +0000
Message-ID: <MWHPR12MB160062C111CCD212AC1ECB63C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home>
 <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>,<20171018180248.GB6332@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171018180248.GB6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: Bjorn Helgaas <helgaas@kernel.org>
| Sent: Wednesday, October 18, 2017 11:02 AM
|  =20
| On Wed, Oct 18, 2017 at 05:09:33PM +0000, Casey Leedom wrote:
| > | From: Luis R. Rodriguez <mcgrof@kernel.org>
| > | Sent: Tuesday, October 17, 2017 6:14:20 PM
| > |
| > | You referred to commit 2355869. What tree and more importantly what
| > | patch title?
| >=20
| >   Ah, my bad.  Sorry, I had the impression that git commit IDs were
| > preserved across repositories.  That's in Linus' main repository:
| >=20
| >   commit 235586939d7fe4833ada9e988f92af543ee6851f
|=20
| Oh, sorry!  You *did* provide the git SHA1 already.  I just didn't
| recognize it because it as one because it happened to contain no hex
| digits (a-f) in the seven characters you quoted.  I wonder what the
| chances of that are.

  10^7 / 16^7 ~=3D 3.7%

Casey
