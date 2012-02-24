Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab2BXFXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 00:23:19 -0500
Received: by ggnh1 with SMTP id h1so993323ggn.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 21:23:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
References: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
Date: Thu, 23 Feb 2012 21:23:18 -0800
Message-ID: <CAE9FiQWjNW8W+TROU1HOdaDS_Ccii+fyDj7GidsOqF2h56R21g@mail.gmail.com>
Subject: Re: pci_probe_only and bus_to_resources patches rebased to pci
 linux-next branch
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2012 at 9:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Jesse,
>
> I rebased these series:
>

>    v2 add PCI bus-to-resource offset support in core
>    (http://marc.info/?l=linux-pci&m=132884138928641&w=2)
>

did you solve concerns that i raised?
1. two lists that one for host bridge and one for root buses
2. for dev to get host bridge data is some expensive. Now for every
dev, you need go up to find root bus, and loop the host bridge list to
find the host bridge.

     Yinghai
