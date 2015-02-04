Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59781 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S966274AbbBDNIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 08:08:01 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Patch v2 00/23] Improve ACPI resource parsing interfaces and enable IOAPIC hotplug
Date: Wed, 04 Feb 2015 14:30:55 +0100
Message-ID: <2374667.Ax4uOxXn95@vostro.rjw.lan>
In-Reply-To: <54D1AEDE.1070901@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com> <10471247.hI8hB2sD9x@vostro.rjw.lan> <54D1AEDE.1070901@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, February 04, 2015 01:32:14 PM Jiang Liu wrote:
> 
> On 2015/2/4 5:54, Rafael J. Wysocki wrote:
> > On Monday, February 02, 2015 10:42:45 AM Jiang Liu wrote:
> >> During enabling ACPI based IOAPIC hotplug, Thomas noticed some issues
> >> in ACPI resource parsing interfaces. So this is an effort to improve them.
> >>
> >> Patch 1 refines ACPICA resource descriptors, which has already been
> >> merged into "git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge"
> >>
> >> Patch 2-12 improve ACPI resource parsing interfaces and also fixes some
> >> bugs.
> >>
> >> Patch 13-20 try to share the common data structure resource_list_entry
> >> between PCI and ACPI. It may also be shared with PNP too.
> >>
> >> Patch 21-23 enable ACPI based IOAPIC hotplug.
> >>
> >> The patchset is based on v3.19-rc6+ and passed Fengguang's 0day test
> >> suite. You may get it from:
> >> https://github.com/jiangliu/linux.git acpires_v2
> > 
> > Patch [1/23] has been in linux-next for a while already.
> > 
> > I've just queued up patches [2-20/23] for 3.20.
> > 
> > I have some questions to patch [21/23] which I'll ask in a reply to that one.
> >  
> > If [22-23/23] do not depend on [21/23] in any way, I can queue them up too, so
> > please let me know if that's the case.
> Yes, we could apply all other patches without 21/23.

Well, there seems to be a problem with patch [17/23].  Namely, it looks like
one of the commits in the PCI tree introduces struct resource_list_entry for
DT which then fails to compile when your patch [17/23] is merged.  I'm yet
to confirm that, but would there be a problem to send an updated version of
patch [17/23] with the new type called "struct resource_entry" instead?
It doesn't look like the "list" part of the type name is really essential
here.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
