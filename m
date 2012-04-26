Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51138 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756609Ab2DZOmB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Apr 2012 10:42:01 -0400
Received: by lahj13 with SMTP id j13so1040935lah.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 07:41:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F993F8F.7060704@redhat.com>
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQWUvZZ+z6-g3B1xCjjPcY_VwcY8FX5oMgRDAvLut=vXNw@mail.gmail.com> <4F993F8F.7060704@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 26 Apr 2012 08:41:39 -0600
Message-ID: <CAErSpo4ZMAZ4=QqncHn-5SVSy5SXPN9F8EC+_vkiLP-FTyGG8w@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe hierarchy
To: Prarit Bhargava <prarit@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.wilcox@linux.intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <james.paradis@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2012 at 6:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
> On 04/25/2012 08:30 PM, Yinghai Lu wrote:
>> On Wed, Apr 25, 2012 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> A PCIe downstream port is a P2P bridge.  Its secondary interface is
>>> a link that should lead only to device 0 (unless ARI is enabled)[1], so
>>> we don't probe for non-zero device numbers.
>>>
>>> Some Stratus ftServer systems have a PCIe downstream port (02:00.0) that
>>> leads to both an upstream port (03:00.0) and a downstream port (03:01.0),
>>> and 03:01.0 has important devices below it:
>>>
>>>  [0000:02]-+-00.0-[0000:03]--+-00.0
>>>                              \-01.0-[0000:xx]--+-[USB]
>>>                                                \-[NIC]
>>>
>>> Previously, we didn't enumerate device 03:01.0, so USB and the network
>>> didn't work.  This patch adds a DMI quirk to scan all device numbers,
>>> not just 0, below a downstream port.
>>
>> is there output for
>> lspci -vvxxx -s 03:00.0
>> lspci -vvxxx -s 03:00.1
>>
>> like to know what is the 03:00.0.
>
> [Adding correct email addy for Jim@stratus]
>
> Jim, can you provide this output?

Also note that I only looked for "ftServer" in the DMI SYS_VENDOR
field.  Prarit's original patch looked at both SYS_VENDOR and
BOARD_VENDOR.  I don't know whether BOARD_VENDOR is necessary.  My
guess was dmi_name_in_vendors() was just a convenient interface, and
we only need to check one place.

Bjorn
