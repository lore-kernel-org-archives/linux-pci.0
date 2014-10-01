Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61430 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbaJAFGh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 01:06:37 -0400
Received: by mail-ie0-f175.google.com with SMTP id y20so70449ier.20
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2014 22:06:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140930203518.GD5625@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
	<20140930203518.GD5625@google.com>
Date: Tue, 30 Sep 2014 22:06:37 -0700
Message-ID: <CAE9FiQUAO_Dn=eCxMAnEnOAWhpE-x1QvwkPcKzcYJ5e0Fe9e=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: add back missing MEM_64 mask check for hotplug path
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 30, 2014 at 1:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Aug 22, 2014 at 06:15:07PM -0700, Yinghai Lu wrote:
>> We missed that in
>> |  commit 5b28541552ef5eeffc41d6936105f38c2508e566
>> |    PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
>> for pci hotplug path.
>>
>> We have MEM_64 in type_mask from pci_assign_unassigned_root_bus_resources()
>> for boot path.
>
> I think we probably need this patch, but I can't figure out what problem it
> fixes.  If we don't have this, what problem will happen?

We can not do exact type checking. Will not use bridge pref that
support 64bit for 64bit pref.

Thanks

Yinghai
