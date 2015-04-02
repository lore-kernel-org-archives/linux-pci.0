Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43833 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbbDBHoc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 03:44:32 -0400
Date: Thu, 2 Apr 2015 09:44:24 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150402094424.0de6c990@endymion.delvare>
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Michael, Bjorn and all,

On Sun, 29 Mar 2015 15:36:55 +0200, Michael S. Tsirkin wrote:
> The macros in pci_ids.h are pretty useful for userspace
> using the pci sysfs interface, e.g. to decode class
> device and vendor sysfs files.
> 
> At the moment userspace is forced to duplicate these macros (e.g. QEMU does
> this, so does gpxe, seabios, etc), it is better to export them in
> /usr/include/linux/pci_ids.h so everyone can just include this header.
> 
> This patchset is structured as follows:
> 1. include/linux/pci_ids.h is moved to include/uapi/linux/pci_ids.h;
>    a stub file is created in include/linux/pci_ids.h to avoid breaking
>    bisect
> 2. all users are converted to use the new header
> 3. include/linux/pci_ids.h is removed
> 4. cleanups for several issues detected during step 2
> 
> The patchset was built on several architectures (mips/ppc/x86),
> boot-tested on x86 only - build seems sufficient for this kind of
> change.
> 
> I think the pci tree is the most appropriate for this patchset.
> Please review it, and consider for 4.1.

I've been thinking some more about the whole move and I'm not so sure
it is a good idea. I don't think that pci_ids.h qualifies as a stable
API for user-space.

1* For one thing, the header of that file says:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

which implies that some IDs will never make it into the file, even if
some user-space tool would benefit from it.

2* For another, we have sometimes removed definitions from that file,
see commits 7ee4910ab31c4b1fafb7e4f273cbe9340ac953aa,
fee8bf4b74e37bfeb8998a349cb788680eb3f634 or
26e8220adb0aec43b7acafa0f1431760eee28522 for recent examples of this.
So user-space tools can't assume that an ID being present in that file
one day will stay there forever.

3* Also IDs are being added over time, so if you build a recent version
of a tool with an old kernel, the most recent IDs may not be there.

This all implies that user-space tools will have to keep defining the
IDs they use for compatibility anyway. So I don't quite see what good
will come from this move. This is a large and intrusive patch set, you
would need a significant benefit to justify its cost. I can't see that.

I think it would only make (some) sense to declare pci_ids.h a
user-space API if we change the rules: all IDs must go in pci_ids.h
again, and IDs that go there can no longer be removed. But that's a big
change (there was a reason for the current rule) and that doesn't even
address point 3 above. So I seriously doubt it's worth it.

Just because some user-space tools give symbolic names to PCI IDs isn't
a sufficient reason to export the kernel's pci_ids.h to user-space. I
mean, <linux/kernel.h> defines the ARRAY_SIZE macro, and many many
user-space projects have a similar macro because it's very useful. That
doesn't mean that the kernel should export it. Same goes for a
countless list of utility macros, linked list management etc, most of
that is reimplemented in various user-space libraries and utilities but
it is certainly not the kernel's responsibility to provide the
implementation.

Kernel/user-space API should be limited to what is required, not what
is possible or what looks convenient. Remember it comes with big
constraints, so as a general rule it must stay as small as possible.

It could be that a small subset of pci_ids.h could be shared with
user-space. I'm thinking of classes, because that list is short and
stable, so we can give some stability guarantees. But I don't know if
the user-space projects you quoted actually use that, so even that may
not be worth it.

-- 
Jean Delvare
SUSE L3 Support
