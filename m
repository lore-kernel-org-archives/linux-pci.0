Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:59965 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757395Ab1LNQaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2011 11:30:20 -0500
Date: Wed, 14 Dec 2011 08:30:16 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: linux-next: Tree for Dec 9 (ibmphp)
Message-ID: <20111214083016.4c938d32@jbarnes-desktop>
In-Reply-To: <CAErSpo5dbAJiJ4FhR4bso+4MnJ9mk45T2Z+spmdzRr95w8jAZg@mail.gmail.com>
References: <20111209163247.1de15dcb5b735ca5e1ad030b@canb.auug.org.au>
	<d4bdd33396b823c5241c4939b981e8a6.squirrel@xenotime.net>
	<4EE637F3.7070606@xenotime.net>
	<CAErSpo5dbAJiJ4FhR4bso+4MnJ9mk45T2Z+spmdzRr95w8jAZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 13 Dec 2011 17:41:08 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, Dec 12, 2011 at 10:20 AM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On 12/09/2011 10:51 AM, Randy Dunlap wrote:
> >>
> >> On Thu, December 8, 2011 9:32 pm, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20111208:
> >>
> >> (This build error  was first seen in 20111208.)
> >>
> >>
> >> ERROR: "pci_scan_bus" [drivers/pci/hotplug/ibmphp.ko] undefined!
> >>
> >> Full randconfig file is attached.
> >
> >
> > Same for 20111212.
> 
> I changed pci_scan_bus() from an inline function (visible to modules)
> to a normal function (by default, not visible to modules), which broke
> the ibmphp.ko build.
> 
> The updated patch is attached, as well as the incremental change (just
> adding "EXPORT_SYMBOL(pci_scan_bus);".
> 
> (Also available at git://github.com/bjorn-helgaas/linux.git on the "pci-scan-v6"
> branch as bef4a9eefaa69dd9bc998e29d619127d1653683d)

Just pushed the fix (rolled it into a v2 of the convert patch).

-- 
Jesse Barnes, Intel Open Source Technology Center
