Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64657 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab2D3ViW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2012 17:38:22 -0400
Received: by lbbgm6 with SMTP id gm6so537310lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 30 Apr 2012 14:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120428192559.GB28349@parisc-linux.org>
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com> <20120428192559.GB28349@parisc-linux.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Apr 2012 15:38:00 -0600
Message-ID: <CAErSpo6mpUJTuUe8nE3k+zhDfsu2g2CEMNy0bc3=9+o8WwBqAA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe hierarchy
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <james.paradis@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 28, 2012 at 1:26 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> On Wed, Apr 25, 2012 at 05:36:32PM -0600, Bjorn Helgaas wrote:
>> @@ -2161,6 +2161,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>                               on: Turn realloc on
>>               realloc         same as realloc=on
>>               noari           do not use PCIe ARI.
>> +             pcie_scan_all   Scan all possible PCIE devices.  Otherwise we
>> +                             only look for one device below a PCIE downstream
>> +                             port.
>
> We should probably s/device/slot/ throughout.  I've recently become
> aware of a hype-rvisor that doesn't include PCI device number remapping,
> so if you assign, say, function 03.6 to a guest, the PCI scanning code
> doesn't find it.

"Device" has a clear meaning in the context of PCIe addressing, i.e.,
bus/device/function numbers.  But the spec uses "slot" to refer to a
physical place where an add-in card can be inserted and things related
to that place, e.g.,  power, hot-plug buttons, latches, chassis
labels, etc.

So I don't understand what you're proposing here.  I don't know what
"scan all possible PCIe slots" would mean because I don't know what
that change would look like in the code.

Bjorn
