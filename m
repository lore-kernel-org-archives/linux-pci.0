Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60947 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab2ISN5G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 09:57:06 -0400
Received: by lbbgj3 with SMTP id gj3so943695lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 19 Sep 2012 06:57:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXeKxZ5XHqxqXBiyjagmCFqyKsJLcpz0h+Zn3-9aP3EwA@mail.gmail.com>
References: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
 <CAErSpo4d2qirLLcbNBdSSdy0u7N87mVD1ArC=uDr9S7q+=dN8A@mail.gmail.com> <CAE9FiQXeKxZ5XHqxqXBiyjagmCFqyKsJLcpz0h+Zn3-9aP3EwA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Sep 2012 07:56:43 -0600
Message-ID: <CAErSpo4E8vghuGsjz31G+0Qv3HYCJ1br_KRatAfnYF+3Dcq7cQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check bridge secondary/subordinate bus register
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 5:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Sep 18, 2012 at 3:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Sep 10, 2012 at 6:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> Intel DP43BF requires "pci=assign-busses" to discover some devices.
>>>
>>> It turns out BIOS set the bridge 00:1e.0 bus register wrong.
>>>
>>> Try to check that wrong range and reject so next pass could only assign
>>> bus for that bridge.
>>>
>>>         https://bugzilla.kernel.org/show_bug.cgi?id=18412
>>
>> Applied to pci/yinghai-misc, thanks!
>
> ?
> you already put it in pci/yinghai-bridge-subordinate and next

I did, but I thought it wasn't worth having a separate branch for each
of these onesy-twosy patches (this one, vgaarb, kmalloc/kzalloc, bus
resource free, etc.), so I decided to consolidate several of them on
pci/yinghai-misc and then merge *that* into next.

So pci/yinghai-bridge-subordinate is dead and I dropped it from next
(but as I said, it will get to next eventually via pci/yinghai-misc).
I don't recommend using my "next" branch as a base.  There's usually
no need, because patches usually don't depend on other things in
"next".  If they do, it's simpler to base them on the specific
"pci/yinghai-xxx" branch they require.

> commit 4fe24116ccc5518d5b692cb4354342ee59970ca5
> Merge: 8704936 a53d8d3
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Sep 18 11:08:09 2012 -0600
>
>     Merge branch 'pci/yinghai-bridge-subordinate' into next
>
>     * pci/yinghai-bridge-subordinate:
>       PCI: Check P2P bridge for invalid secondary/subordinate range
>
> commit a53d8d32a2b768cdcdd0703f4754f49b02753d2c
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Mon Sep 10 17:19:33 2012 -0700
>
>     PCI: Check P2P bridge for invalid secondary/subordinate range
