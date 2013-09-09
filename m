Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49862 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3IIQP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 12:15:27 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so2823315ieb.23
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 09:15:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130909070017.GB3726@weiyang.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130906230941.GC12956@google.com> <20130909070017.GB3726@weiyang.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Sep 2013 10:15:07 -0600
Message-ID: <CAErSpo5BTV_b1NpeifuAPwHvfsrAERpdmwgnUFMS6gQ3Asik-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 9, 2013 at 1:00 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Fri, Sep 06, 2013 at 05:09:41PM -0600, Bjorn Helgaas wrote:
>>[+cc Kenji, Alex]
>>
>>On Fri, Sep 06, 2013 at 09:45:56AM +0800, Wei Yang wrote:
>>> In __pci_bus_size_bridges() we check whether a pci bus is a root
>>> bus by testing bus->self. As indicated by commit 79af72d7
>>> ("PCI: pci_is_root_bus helper"), bus->self == NULL is not a proper
>>> way to check the pci root bus.
>>>
>>> This patch changes it to pci_is_root_bus() to check whether it is
>>> a root bus.
>>
>>I think this is a good change, even if only on the grounds of
>>consistency.
>>
>>Did you trip over a case where a root bus has bus->self != NULL?
>>I'd like to know more details about the case where:
>>
>>  (bus->parent == NULL) && (bus->self != NULL)
>
> I found one case that (bus->self == NULL) and this bus is not root bus.
>
> Not sure, this case will meet your requirement?

I'm definitely interested in that case as well.  Can you include a
complete "lspci -vv" output for the case where this happens?

I suspect this happens with SR-IOV when we create "virtual" buses,
i.e., in virtfn_add_bus().  I think maybe I'll update the comment at
pci_is_root_bus() with a note about why we want to use it instead of
testing for "bus->self == NULL".

I think we still have other tree traversal issues related to those
virtual buses, e.g., the ones I mentioned here [1].  But those are a
separate problem.

Bjorn

[1] http://lkml.kernel.org/r/CAErSpo5sFfr=O-Pp=PyaxGauaEajaTr2aK-EQ_rTVUk1zyz8cA@mail.gmail.com
