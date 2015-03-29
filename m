Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:45687 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752334AbbC2R7t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2015 13:59:49 -0400
Message-ID: <1427651985.2715.39.camel@perches.com>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
From: Joe Perches <joe@perches.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 29 Mar 2015 10:59:45 -0700
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2015-03-29 at 15:36 +0200, Michael S. Tsirkin wrote:
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

Hello again Michael.

It's nicer if you send this cover letter to all mailing lists
that receive any of the individual patches so that people can
reply to the 0/n patch and a single discussion thread can
happen for generic issues for the entire patchset.

It'd be even nicer to cc all of the maintainers of any of the
sections modified, but vger mailing lists reject any email
with more than 2k of email headers.  Unfortunately, patchsets
for multiple subsystems create long cc lists that generally
exceed this limit.

