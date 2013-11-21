Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41110 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab3KUVF7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 16:05:59 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so233491vcb.23
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 13:05:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
	<1384912317-3721-7-git-send-email-yinghai@kernel.org>
	<20131121103021.GA29873@yanx>
	<CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
Date: Thu, 21 Nov 2013 13:05:59 -0800
Message-ID: <CA+55aFyM5o39pmFtPOc1VVE5y_SYp1WXtz773cBp3fHrvnzOLQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI: Try to allocate mem64 above 4G at first
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 21, 2013 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> 3. or more generic, treat all pci BAR 32bit prefetechable as normal
> MMIO32 during allocation. aka mmio prefectechable will be used for pci
> bridge that support 64bit mmio pref and leave bridge's 32bit only pref
> bar register blank.
>
> Bjorn, Linus,
> Are you happy with No 3?

I don't think I understand your #3. If there's a 32-bit device behind
the bridge, it will need to be in the low 4G, so you can't use the
64-bit window because it will be out of range. So that wouldn't work.
So you'd need to have a bridge window in the low 32-bit area too if
there are any 32-bit devices behind the bridge.

Also, haven't we tried the "try to allocate 64-bit devices in high
memory" and it has always failed because there are broken devices?

                Linus
