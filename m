Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 17 Nov 2017 18:02:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
Message-ID: <20171118000243.GC16907@bhelgaas-glaptop.roam.corp.google.com>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
 <20171116201745.GB7266@bhelgaas-glaptop.roam.corp.google.com>
 <16b9ac67-042d-1010-0c8c-205b2fa40a7f@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <16b9ac67-042d-1010-0c8c-205b2fa40a7f@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-arm-kernel@lists.infradead.org,
 Dongdong Liu <liudongdong3@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 16, 2017 at 03:52:47PM -0500, Sinan Kaya wrote:
> >>
> >> Whether the AER driver reads ~0 or not really depends on timing. The
> >> link may come up from the DPC driver by the time AER driver reaches
> >> here as an example.
> >>
> >> Bad things do happen. We have seen this with e1000e driver.
> > 
> > I don't doubt that bad things happen.  I'm just trying to understand
> > exactly *what* bad things happen and how, so we can fix them cleanly.
> 
> This was random crashes in the e1000e drivers accompanied with stack
> traces coming from WARN and msi allocation routines.

I didn't look in detail, but I'm not sure there's sufficient locking
in the AER path to make it safe from concurrent device removal.  I
suspect AER could be improved both with respect to handling ~0 data
and this potential concurrency issue.

> > So the "stop" and "recover" commands you mention must be related to
> > AER.  
> 
> I was talking about pci_stop_and_remove_bus_device() vs. error_detected()
> as "stop" and "recover"

Thanks for clearing that up!

> > I suspect this all probably requires tighter integration between DPC
> > and AER, and I'm totally fine with that.  I think the current
> > separation as separate "drivers" is pretty artificial anyway.
> 
> Got it. We will try to plumb DPC error handling into AER driver's error
> handling mechanism.

Looking at the AER code today, I noticed it already uses "DPC" in
another sense.  I don't know what it stands for there (probably
"deferred" something), but I don't think it's "Downstream Port
Containment" :)

> What do you think about the rescan following link up? The only entity
> that does rescan today is hotplug after DPC recovery. There could be
> a platform with DPC support but no hotplug support. 
> 
> How should we handle it?

Good question.  If your system does support both DPC and hotplug, I
assume the link comes back up after you clear DPC Trigger Status.
Does pciehp notice that "link up" event and add the device back?

So I think your question is whether the DPC code should explicitly do
a rescan so that if we don't have pciehp, we'll still automatically
rediscover the device.  I dunno, maybe.  Seems like a plausible idea
anyway.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
