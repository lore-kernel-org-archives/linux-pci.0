Return-Path: <SRS0=dP1m=G2=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=dP1m=G2=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Feng Kan <fkan@apm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Toan Le <toanle@apm.com>
Subject: Re: [PATCH V3] PM / core: fix deferred probe breaking suspend resume order
Date: Thu, 05 Apr 2018 18:38:30 +0200
Message-ID: <7780328.CMcpMVPvTI@aspire.rjw.lan>
In-Reply-To: <CAL85gmBtFnXje9tPngXEyCCwuvxvH6YHB=HrvjfU7npPDiSTCw@mail.gmail.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com> <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com> <CAL85gmBtFnXje9tPngXEyCCwuvxvH6YHB=HrvjfU7npPDiSTCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 4, 2018 11:10:41 PM CEST Feng Kan wrote:
> On Fri, Mar 30, 2018 at 3:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Mar 15, 2018 at 11:41:33AM -0700, Feng Kan wrote:
> >> On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
> >> > When bridge and its endpoint is enumerated the devices are added to the
> >> > dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
> >> > This causes the bridge to be moved to the end of the dpm list when
> >> > deferred probe kicks in. The order of the dpm list for bridge and
> >> > endpoint is reversed.
> >> >
> >> > Add reordering code to move the bridge and its children and consumers to
> >> > the end of the pm list so the order for suspend and resume is not altered.
> >> > The code also move device and its children and consumers to the tail of
> >> > device_kset list if it is registered.
> >> >
> >> > Signed-off-by: Feng Kan <fkan@apm.com>
> >> > Signed-off-by: Toan Le <toanle@apm.com>
> >> > ...
> >> >
> >> Hi, just wanted to check if there is anything else I need to change on
> >> this. Thanks.
> >
> > I'm assuming Rafael will handle this.
> Rafael, sorry to ping again. Do you have a position on this patch yet?

Sorry, I thought that Greg might want to send a comment here.

I'm basically fine with the approach.  I only have two minor remarks to the
kernedoc comment of the new function, but let me reply directly to the patch
message.
