Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdJRSCv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 14:02:51 -0400
Date: Wed, 18 Oct 2017 13:02:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Casey Leedom <leedom@chelsio.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        Komali Katari <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Message-ID: <20171018180248.GB6332@bhelgaas-glaptop.roam.corp.google.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home>
 <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 05:09:33PM +0000, Casey Leedom wrote:
> | From: Luis R. Rodriguez <mcgrof@kernel.org>
> | Sent: Tuesday, October 17, 2017 6:14:20 PM
> |
> | You referred to commit 2355869. What tree and more importantly what patch
> | title?
> 
>   Ah, my bad.  Sorry, I had the impression that git commit IDs were
> preserved across repositories.  That's in Linus' main repository:
> 
>   commit 235586939d7fe4833ada9e988f92af543ee6851f

Oh, sorry!  You *did* provide the git SHA1 already.  I just didn't
recognize it because it as one because it happened to contain no hex
digits (a-f) in the seven characters you quoted.  I wonder what the
chances of that are.
