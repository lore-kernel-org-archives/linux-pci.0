Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:53021 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab2K1UFM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2012 15:05:12 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so8054935lag.19
        for <linux-pci@vger.kernel.org>; Wed, 28 Nov 2012 12:05:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121128190106.GA30376@kroah.com>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu> <20121128190106.GA30376@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Nov 2012 13:04:50 -0700
Message-ID: <CAErSpo4X5B_CsixjBk=XPzeyhWZ_tSk4Qqxhs4VPd494rQ_6iw@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: Remove use of CONFIG_HOTPLUG
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bill Pemberton <wfp5p@virginia.edu>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 28, 2012 at 12:01 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 21, 2012 at 03:34:51PM -0500, Bill Pemberton wrote:
>> This is a respin of the patches to remove CONFIG_HOTPLUG for the PCI
>> subsystem.  The end result is the same as the patches in the big
>> patchset I sent out earlier this week but the changelog entries have
>> been changed to be consistent with the capitalization of PCI.  The
>> removal of the __dev* entries has also been squashed into a single
>> patch.
>
> Bjorn, any objection for me taking these patches through my driver-core
> tree?  If not, can I get your ack?

No objection.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
