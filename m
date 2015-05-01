Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:32829 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbbEASrF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 14:47:05 -0400
MIME-Version: 1.0
In-Reply-To: <1430493730.7979.58.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com> <1430493730.7979.58.camel@kernel.crashing.org>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 1 May 2015 13:46:44 -0500
Message-ID: <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 1, 2015 at 10:22 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-05-01 at 07:54 -0500, Rob Herring wrote:
>
>> The difference seems to be whether you allocate space or just point to
>> the FDT for various strings/data. Is that right?
>>
>> >    * of_fdt_add_subtree() is the introduced API to do the work.
>>
>> Have you looked at overlays and if so why do they not work for your purposes?
>>
>> Why do you need to do this with the flattened tree?
>
> The basic idea I asked Gavin to implement is that since the FW needs to
> provide a bunch of DT updates to Linux at runtime in the form of new
> nodes below an existing one, rather than doing it via some new/custom
> format, instead, have it send a bit of FDT blob to expand under an
> existing node.

Overlay = an FDT blob to graft into a live running system. Sounds like
the same thing.

> As for the details of Gavin implementation, I haven't looked at it in
> details yet so there might be issues there, however I don't know what
> you mean by "overlays", any pointer ?

CONFIG_OF_OVERLAY

http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-keynote-v3.pdf

Rob
