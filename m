Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44630 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab2IRXzu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 19:55:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4d2qirLLcbNBdSSdy0u7N87mVD1ArC=uDr9S7q+=dN8A@mail.gmail.com>
References: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4d2qirLLcbNBdSSdy0u7N87mVD1ArC=uDr9S7q+=dN8A@mail.gmail.com>
Date: Tue, 18 Sep 2012 16:55:48 -0700
Message-ID: <CAE9FiQXeKxZ5XHqxqXBiyjagmCFqyKsJLcpz0h+Zn3-9aP3EwA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check bridge secondary/subordinate bus register
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: VL <vl.homutov@gmail.com>, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 3:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Sep 10, 2012 at 6:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Intel DP43BF requires "pci=assign-busses" to discover some devices.
>>
>> It turns out BIOS set the bridge 00:1e.0 bus register wrong.
>>
>> Try to check that wrong range and reject so next pass could only assign
>> bus for that bridge.
>>
>>         https://bugzilla.kernel.org/show_bug.cgi?id=18412
>
> Applied to pci/yinghai-misc, thanks!

?
you already put it in pci/yinghai-bridge-subordinate and next

commit 4fe24116ccc5518d5b692cb4354342ee59970ca5
Merge: 8704936 a53d8d3
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Sep 18 11:08:09 2012 -0600

    Merge branch 'pci/yinghai-bridge-subordinate' into next

    * pci/yinghai-bridge-subordinate:
      PCI: Check P2P bridge for invalid secondary/subordinate range

commit a53d8d32a2b768cdcdd0703f4754f49b02753d2c
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Sep 10 17:19:33 2012 -0700

    PCI: Check P2P bridge for invalid secondary/subordinate range
