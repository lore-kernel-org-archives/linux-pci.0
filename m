Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750698AbcKFRI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Nov 2016 12:08:29 -0500
Date: Sun, 6 Nov 2016 10:08:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Shouldn't VFIO virtualize the ATS capability?
Message-ID: <20161106100832.41e173d5@t450s.home>
In-Reply-To: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 6 Nov 2016 11:13:09 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Hi 
> I've noticed that VFIO doesn't virtualize the ATS capability.
> It seems to me that translation caching and Smallest Translation Unit is something you would want to control on the host. Am I wrong?

What about those fields would we virtualize?  Why does the host need to
be an intermediary?  Can the user induce poor behavior with direct
access to them?  Thanks,

Alex
