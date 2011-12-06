Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:34119
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933037Ab1LFKFu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 05:05:50 -0500
Date: Tue, 6 Dec 2011 11:05:37 +0100
From: Joerg Roedel <joerg.roedel@amd.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: PRI/PASSID cleanup and fix
Message-ID: <20111206100537.GH25178@amd.com>
References: <20111111170319.32668.48479.stgit@bling.home>
 <20111123104705.GC11876@amd.com>
 <20111123144510.56ff6d1d@jbarnes-desktop>
 <20111128104055.GI11876@amd.com>
 <20111205102423.476b7ce4@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111205102423.476b7ce4@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 05, 2011 at 10:24:23AM -0800, Jesse Barnes wrote:
> On Mon, 28 Nov 2011 11:40:55 +0100
> Joerg Roedel <joerg.roedel@amd.com> wrote:

> > Great. Can you provide a seperate branch with these changes that I can
> > pull into my tree, please? I have upcoming changes that will conflict
> > with these patches. And I would like to solve them before merge.
> 
> Ok, I pushed these to a 'pri-changes' branch, which is a superset of my
> current linux-next branch.

Great, thanks :)

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

