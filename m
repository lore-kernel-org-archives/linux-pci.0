Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43167 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab2BXRjF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 12:39:05 -0500
Received: by wibhm11 with SMTP id hm11so122299wib.19
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2012 09:39:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWjNW8W+TROU1HOdaDS_Ccii+fyDj7GidsOqF2h56R21g@mail.gmail.com>
References: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
 <CAE9FiQWjNW8W+TROU1HOdaDS_Ccii+fyDj7GidsOqF2h56R21g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Feb 2012 09:38:44 -0800
Message-ID: <CAErSpo7Qh8_3m1TNG-mGEYnPrGbM9Saiv-fk+OjnCFYKDJ=qRQ@mail.gmail.com>
Subject: Re: pci_probe_only and bus_to_resources patches rebased to pci
 linux-next branch
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2012 at 9:23 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 23, 2012 at 9:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Hi Jesse,
>>
>> I rebased these series:
>
>>    v2 add PCI bus-to-resource offset support in core
>>    (http://marc.info/?l=linux-pci&m=132884138928641&w=2)
>
> did you solve concerns that i raised?
> 1. two lists that one for host bridge and one for root buses
> 2. for dev to get host bridge data is some expensive. Now for every
> dev, you need go up to find root bus, and loop the host bridge list to
> find the host bridge.

No.  I responded to those concerns on the list, but I haven't made any
changes to the patches yet.

I'll look at #1 again; we should do something about that, though I
don't think it's important enough to gate the patches.

I don't think #2 is worth worrying about, given that we do it so
infrequently (once per BAR at boot-time).

Bjorn
