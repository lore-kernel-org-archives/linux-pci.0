Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50513 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab3DZOur (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2013 10:50:47 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so4091061oag.31
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2013 07:50:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <517A45E602000078000D0F78@nat28.tlf.novell.com>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
 <20130422231214.32621.37394.stgit@bhelgaas-glaptop> <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
 <5179164902000078000D0A26@nat28.tlf.novell.com> <20130425164238.GA3052@google.com>
 <517A45E602000078000D0F78@nat28.tlf.novell.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Apr 2013 08:50:27 -0600
Message-ID: <CAErSpo73yJcBU7Affd1qHhS_VVLnOS4msNfwrt-RaKhJce5Ngw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v4 18/22] xen/pci: Pay attention to PCI_MSIX_TABLE_OFFSET
To: Jan Beulich <JBeulich@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	xen-devel <xen-devel@lists.xensource.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 26, 2013 at 1:16 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 25.04.13 at 18:42, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Apr 25, 2013 at 10:40:57AM +0100, Jan Beulich wrote:
>>> Recent hypervisors will actually
>>> only consume this to issue a warning if not matching what gets
>>> read from the corresponding BAR. Earlier hypervisors used this
>>> instead of reading the BAR.
>>
>> Note that pci_resource_start() gives you a CPU address, and what you
>> read from the BAR is a PCI bus address.  These are not in the same
>> address space and can't be directly compared.  I assume the
>> hypervisors take that into account and do the appropriate
>> conversions?
>
> I suppose Xen has never been run on a system where the two
> would differ, and it's quite likely that it would break on such
> systems. Question is - are there any x86-based systems where
> this is the case?

I haven't personally seen one, but it looks like they're coming, based
on this patch we merged last year:

commit b4873931cc8c934a9893d5962bde97aca23be983
Author: Mike Yoknis <mike.yoknis@hp.com>
Date:   Wed Nov 7 15:52:20 2012 -0700

    x86/PCI: Allow x86 platforms to use translation offsets

    The memory range descriptors in the _CRS control method contain an address
    translation offset for host bridges.  This value is used to translate
    addresses across the bridge.  The support to use _TRA values is present for
    other architectures but not for X86 platforms.

    For existing X86 platforms the _TRA value is zero.  Non-zero _TRA values
    are expected on future X86 platforms.  This change will register that value
    with the resource.

    Signed-off-by: Mike Yoknis <mike.yoknis@hp.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
