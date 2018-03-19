Return-Path: <SRS0=Yawx=GJ=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=Yawx=GJ=linutronix.de=tglx@kernel.org>
Date: Mon, 19 Mar 2018 20:50:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jan Kiszka <jan.kiszka@siemens.com>, Ingo Molnar <mingo@redhat.com>,
    "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
    x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
    virtualization@lists.linux-foundation.org,
    Andy Shevchenko <andy.shevchenko@gmail.com>,
    Benedikt Spranger <b.spranger@linutronix.de>,
    Juergen Gross <jgross@suse.com>, Mark Rutland <mark.rutland@arm.com>,
    Otavio Pontes <otavio.pontes@intel.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/7] jailhouse: Enhance secondary Jailhouse guest
 support /wrt PCI
In-Reply-To: <20180319194813.GJ77194@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1803192049500.1520@nanos.tec.linutronix.de>
References: <cover.1520408357.git.jan.kiszka@siemens.com> <20180319194813.GJ77194@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Mon, 19 Mar 2018, Bjorn Helgaas wrote:

> On Wed, Mar 07, 2018 at 08:39:11AM +0100, Jan Kiszka wrote:
> > Basic x86 support [1] for running Linux as secondary Jailhouse [2] guest
> > is currently pending in the tip tree. This builds on top and enhances
> > the PCI support for x86 and also ARM guests (ARM[64] does not require
> > platform patches and works already).
> > ...
> 
> Hi Jan,
> 
> What tree do you plan to merge this through?  I was sort of assuming
> x86, since the main point of jailhouse is not PCI, but I do notice
> most of the changes here are PCI-related, so thought I should make
> sure you're not waiting on me.

I picked it up already. It's sitting in tip x86/platform

Thanks,

	tglx
