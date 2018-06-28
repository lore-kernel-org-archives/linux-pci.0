Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935883AbeF1Qxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 12:53:42 -0400
Date: Thu, 28 Jun 2018 11:53:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/5] pci: export pcie_get_speed_cap and pcie_get_width_cap
Message-ID: <20180628165341.GA120578@bhelgaas-glaptop.roam.corp.google.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
 <20180625210606.2736-2-alexander.deucher@amd.com>
 <20180628134221.GC90450@bhelgaas-glaptop.roam.corp.google.com>
 <CADnq5_OMmcbKsWQ3QfuMKYOxhrZZxOCs4YTN+Pyf7zuy43ypyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADnq5_OMmcbKsWQ3QfuMKYOxhrZZxOCs4YTN+Pyf7zuy43ypyA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 10:19:41AM -0400, Alex Deucher wrote:
> On Thu, Jun 28, 2018 at 9:42 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jun 25, 2018 at 04:06:02PM -0500, Alex Deucher wrote:
> >> So drivers can use them.  This can be used to replace
> >> duplicate code in the drm subsystem.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Thanks a lot for doing this!
> >
> > If you haven't applied these yet, please
> >
> >   s/pci: export/PCI: Export/
> >
> > in the subject.
> 
> 
> Will fix.  Any objections to taking this via the drm tree?

Nope, I acked it because I assumed you would merge it along with the rest
of the series via some non-PCI tree, so the drm tree would be great.
