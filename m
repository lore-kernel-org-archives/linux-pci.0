Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43576 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab3EEFSq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 May 2013 01:18:46 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so3109416iea.32
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2013 22:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367712932.11982.20.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
Date: Sat, 4 May 2013 22:18:45 -0700
Message-ID: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 4, 2013 at 5:15 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2013-05-05 at 10:10 +1000, Benjamin Herrenschmidt wrote:
>> Once upon a time, our PCI resource assignment code use to be reasonably
>> straightforward... right now I'm having a hard time making any sense
>> of it.
>
> Note that the devices so far seem to be working and here's the resulting
> layout:

we intend to assign unassigned resources in two try,
first one will try to allocate must_have and optional ones the same time.

if it fails to do that, will only allocate must_have again.

now optional one only include SRIOV related.

Yinghai
