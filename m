Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeCURau (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 13:30:50 -0400
Date: Wed, 21 Mar 2018 12:30:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180321173047.GA38649@bhelgaas-glaptop.roam.corp.google.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[I composed most of this before seeing Lorenzo's response, so sorry
about the duplication.  Maybe seeing things stated a different way
will help :)]

On Tue, Mar 20, 2018 at 11:00:36PM +0000, Sridhar Pitchai wrote:
> Hi Lorenzo,
>    Transparent SRIOV is exposing the NIC directly to the kernel via
> para-virtual device, unlike creating a netdev and associating it with the bond
> driver. Further descriptions here,
>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0c195567a8f6e82ea5535cd9f1d54a1626dd233e
> 
> Previously, when using the bond driver, unique and persistent VF NIC name
> was required, so we used serial number as PCI domain which is included as
> part of the VF NIC name.  Transparent SRIOV mode puts VF NIC based on MAC
> match as a slave of synthetic NIC, so VF NIC’s name is no longer important.

Hi Sridhar,

A few hints about submitting patches more efficiently:

1) You never have to ask "Are we OK with the explanation?  If so, I'll
send a patch with updated changelog."  That forces an extra
round-trip.  Simply post a new version with your proposed update.  If
Lorenzo has more questions, he'll say so and you can do another
version.

2) When Lorenzo is asking for clarification, he's not really asking
for the clarification in an email response, because the email thread
will soon be forgotten and lost in the archives.  What we really want
is for the permanent git changelog to make sense to someone in the
future.  The easiest way is to post a new patch version with a
revised changelog that answers the questions.

3) Please capitalize and punctuate consistently with previous history,
e.g., "PCI: hv: Fix domain ID corruption" for your title, "SR-IOV"
(not "SRIOV") and "bus" (not "BUS") in changelog.  Both "para-virtual"
and "paravirtual" are used in the kernel, but "paravirtual" is much
more common.  Run "git log" and "git log --oneline" on your file and
follow the same style.

4) When you reference a previous commit, please use this style:
0c195567a8f6 ("netvsc: transparent VF management"), i.e., 12-char SHA1
followed by title.  You seem to have removed some spaces from the
commit you mention in the "Fixes" tag.

And a few content questions/observations of my own:

1) "Fix domain ID corruption" isn't a very good title because it
suggests you're fixing a memory corruption or similar defect.  But in
fact, I think you're removing something that used to be a feature
(added by 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain")) but is now no longer needed and in fact now causes a
problem.

2) Your changelog does mention 4a9b0933bdfc, which is good, but
there must be some other <commit X> that makes it safe to remove
4a9b0933bdfc, i.e., <commit X> removes the need for using the device
serial number as the PCI domain.  <Commit X> *must* be mentioned in
the changelog.  Otherwise, people may backport this patch to a kernel
that doesn't include <commit X>, and things will break.

3) I don't understand what you mean by "transparent SR-IOV mode".  Is
that something different than regular SR-IOV?  If so, what exactly is
the difference?  I don't think the PCIe specs mention a "transparent
mode", so is it a Hyper-V thing?  It seems important, but I don't see
any pci-hyperv.c commits that mention it.

Here's a stab at the sort of changelog I would be looking for.
Obviously I don't understand much about Hyper-V and pci-hyperv.c, so
please correct the things I got wrong:

  When Linux runs as a guest in a Hyper-V VM, pci-hyperv.c
  paravirtualizes access to PCI devices assigned to the guest.  For
  each of those devices, hv_pci_probe() creates a virtual PCI bus in
  its own unique PCI domain.

  4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
  overrode that unique PCI domain to be the Hyper-V device serial
  number to make device names more convenient <or whatever the real
  reason is; I don't quite understand this part>.

  One problem with 4a9b0933bdfc is that the Hyper-V device serial
  number is not necessarily unique, so we may end up with two buses
  with the same domain and bus number, and adding the second bus
  fails.

  We no longer need to override the PCI domain numbers because <commit
  X> removed the need for that.

  Revert 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
  domain") so we can reliably support multiple devices being assigned
  to a guest.

  This revert should only be backported to kernels that contain
  <commit X>.

Bjorn
