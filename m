Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:8352
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932405AbdCUOeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Mar 2017 10:34:50 -0400
From: Eli Cohen <eli@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: Bodong Wang <bodong@mellanox.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: RE: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Date: Tue, 21 Mar 2017 14:34:46 +0000
Message-ID: <VI1PR0501MB2798FFB6E0337AB860B5D2A8C53D0@VI1PR0501MB2798.eurprd05.prod.outlook.com>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
        <20170320230706.GA12252@gwshan>
        <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
        <20170320225708.6868676a@t450s.home>    <20170321054305.GA12230@gwshan>
        <20170321000158.444991a3@t450s.home>    <20170321092518.GA19657@gwshan>
 <20170321082329.4f408a9e@t450s.home>
In-Reply-To: <20170321082329.4f408a9e@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> If we want to talk about the ABI, I would suggest drawing from existing A=
BIs.  We already have
> drivers_autoprobe as part of the standard sysfs ABI, so if we want a bina=
ry switch, then=20
>sriov_drivers_autoprobe might be a logical choice.  If you're concerned ab=
out this mythical overhead of > binding to one driver then another, then wh=
y not draw from the driver_override interface to allow the=20
> user to specify the driver to bind to, perhaps sriov_driver_override.  Th=
en if the user wants to bind all=20
> the devices to vfio-pci, they can do so easily.  I still fail to see that=
 probing some fixed number of the VFs=20
> and leaving the rest unprobed has any practical value and I imagine bugs =
coming in because users are=20
> confused why some of their VFs behave differently than others.  Thanks,

I agree with Alex - the interface should better be binary - either probe VF=
s or not. The rest can be done with binding/unbinding VFs as necessary. The=
 main goal is to refrain from automatically initializing virtual functions =
at the hypervisor if they were initially instantiated to assign then to gue=
sts.
