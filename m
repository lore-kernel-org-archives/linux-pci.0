Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43046 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423424Ab3FUS4U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 14:56:20 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so19329035iea.25
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 11:56:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t_NUOq_XNb1mQKqPFG=bRDLTP_DqRgUL2G6XJ2bTd2ssA@mail.gmail.com>
References: <CAH9N0t_NUOq_XNb1mQKqPFG=bRDLTP_DqRgUL2G6XJ2bTd2ssA@mail.gmail.com>
Date: Fri, 21 Jun 2013 11:56:20 -0700
Message-ID: <CAE9FiQUQX0uq7c_FgU=M383K9eea--XO0XzAfMOjnNi6rTSkKw@mail.gmail.com>
Subject: Re: PCIe Hotplug Script Automatization
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 21, 2013 at 9:13 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello,
>
> I'm trying to automatize the hotplug procedure.
> As far as i have seen it is possible using the udev deamon.
>
> 1. I have a script to remove a pcie card when it is unpluged from
> system but i am doing it manually.
> 2. Also I have a pcie board script that actually re-enumerates the pci
> bus and inserts the device drivers when the card is plugged into the
> system.
>
> My question: is it possible to trigger these scripts automatically? If
> so, how can that be done exactly?

acpiphp or pciehp does not work on your system?

Yinghai
