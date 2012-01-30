Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51280 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab2A3Vq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2012 16:46:56 -0500
Received: by wgbed3 with SMTP id ed3so5176179wgb.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2012 13:46:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1327956544.28487.47.camel@pasglop>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165820.3231.9878.stgit@bhelgaas.mtv.corp.google.com> <1327956544.28487.47.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Jan 2012 13:46:35 -0800
Message-ID: <CAErSpo7qV084bxjfds=oaZ45xDB4=u78T6UmjpmbDWd3yBcCmA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 14/18] powerpc/PCI: get rid of device resource fixups
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2012 at 12:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-01-30 at 09:58 -0700, Bjorn Helgaas wrote:
>> Tell the PCI core about host bridge address translation so it can take
>> care of bus-to-resource conversion for us.
>>
>> N.B. powerpc used a 32-bit mask when converting IO addresses.  If we
>> figure out the right offset, I think simple addition should do the
>> same thing, but I might not have it exactly right yet.
>
> Wow that's going to be a big change :-) A quick look... seems like you
> do a per-resource offset right ? I will need that (was about to change
> powerpc) as we have hardware that provides us with two different windows
> to MMIO space with different offsets unfortunately.

Exactly ... the offset is per-aperture.

> One thing I also want to generalize is the whole "REASSIGN_ALL_RSRC"
> flag, ie, avoid reading & printing all those resources we know we are
> just going to kill off.
>
> I'll try to test your stuff asap (I'm doing 3 things at once right now
> so it might take a few days unless I find somebody to look at it).

Thanks!  No particular rush on my side; I'm expecting to have to
iterate a few times to get this right.

Bjorn
