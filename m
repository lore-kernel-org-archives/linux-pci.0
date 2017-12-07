Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdLGULe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Dec 2017 15:11:34 -0500
Date: Thu, 7 Dec 2017 14:11:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandan Das <bsd@redhat.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Add a break condition when enabling BAR
Message-ID: <20171207201129.GA17271@bhelgaas-glaptop.roam.corp.google.com>
References: <jpga7yvotm2.fsf@linux.bootlegged.copy>
 <8ce90b86-a2ec-c158-8f6d-e939c97aa065@amd.com>
 <jpgtvx2como.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <jpgtvx2como.fsf@linux.bootlegged.copy>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 07, 2017 at 02:41:03PM -0500, Bandan Das wrote:
> Christian König <christian.koenig@amd.com> writes:
> 
> > Hi Bandas,
> >
> > thanks for the patch, but this is a known issue with a fix already on
> > the way into the next -rc.
> 
> Oh great! Thank you, have a pointer to the patch so that I can test ?

It's in linux-next.  If you want just the patch, see
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=for-linus
(there are a couple patches there).

There's still one fix for a related issue that I haven't applied yet
because it needs a little more detailed changelog.

Bjorn
