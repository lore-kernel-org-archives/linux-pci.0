Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:38084 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeCOMvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 08:51:43 -0400
Received: by mail-ot0-f169.google.com with SMTP id 95-v6so6721015ote.5
        for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2018 05:51:43 -0700 (PDT)
Message-ID: <5AAA6C4E.7070508@fredlawl.com>
Date: Thu, 15 Mar 2018 07:51:26 -0500
From: Frederick Lawler <fred@fredlawl.com>
MIME-Version: 1.0
To: Christian Zigotzky <chzigotzky@xenosoft.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PASEMI: PCI_SCAN_ALL_PCIE_DEVS
References: <e6083bae-42a0-c598-5040-fb0089c53d3f@xenosoft.de>
In-Reply-To: <e6083bae-42a0-c598-5040-fb0089c53d3f@xenosoft.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Christian Zigotzky wrote:
> Hi All,
> 
> We always have to add 'pci=pcie_scan_all' to the kernel boot arguments
> for our P.A. Semi boards. Please find attached a patch for solving this
> issue.
> 
> Could you please add this patch to the official kernel source code?
> 
> Thanks,
> Christian
> 

Morning,

I would recommend reading the following prior to patch submission:

http://elixir.free-electrons.com/linux/latest/source/Documentation/process/submitting-patches.rst

https://marc.info/?l=linux-pci&m=150905742808166&w=2

It is very difficult for us to review and comment on patches that are
submitted via attachment.


Frederick
