Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34604 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbbHTSYE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 14:24:04 -0400
Received: by iodb91 with SMTP id b91so55707601iod.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2015 11:24:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150820.104728.699050706854625548.davem@davemloft.net>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
 <20150820054800.GB10267@google.com> <20150820.104728.699050706854625548.davem@davemloft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 11:23:43 -0700
Message-ID: <CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
To: David Miller <davem@davemloft.net>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Meelis Roos <mroos@linux.ee>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 20, 2015 at 10:47 AM, David Miller <davem@davemloft.net> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Thu, 20 Aug 2015 00:48:00 -0500
>
>> [+cc Dave, Eric, Ben, sparclinux]
>
> I think the comment is terrible.

I'll update the comment if you suggest some text.  Do you object
mainly to the mention of the specific systems?

> It is not limited to those two systems, it is a general problem with
> how the code assumes the root PCI-E port is instantiated in the PCI
> bus hierarchy which will not be true on any system which has a PCI
> controller that doesn't actually provide a bonafide config space to
> access.

I agree, we should not crash if the hardware we find isn't what we expect.

Bjorn
