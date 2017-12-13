Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:41760
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbdLMWSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 17:18:32 -0500
From: Casey Leedom <leedom@chelsio.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        "Komali Katari" <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Wed, 13 Dec 2017 22:18:27 +0000
Message-ID: <SN1PR12MB03524D627983E00817C624B4C8350@SN1PR12MB0352.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home>
 <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>
 <MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <SN1PR12MB03524AF87997DFAC404CD514C8350@SN1PR12MB0352.namprd12.prod.outlook.com>,<CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com>
In-Reply-To: <CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

/ From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
| Sent: Wednesday, December 13, 2017 1:47 PM
|
| This should have been fixed with:
|
|   commit 6878e7de6af726de47f9f3bec649c3f49e786586
|   Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
\   Date:   Wed Sep 13 16:29:48 2017 -0700

  I see that was committed on September 13, 2017.  I should have mentioned
that Komali started her bisect with kernel.org commit
a638349bf6c29433b938141f99225b160551ff48 which is dated December 11, 2017.
So something more needs to be done ...

  It looks like you and Eric are discussing an additional fix.  If you come
up with a patch, we [Komali] can test it for you.

Casey
