Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33924 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbbDGQtF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 12:49:05 -0400
Received: by qgfi89 with SMTP id i89so23446909qgf.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2015 09:49:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150406.203533.1356187749826485194.davem@davemloft.net>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-4-git-send-email-yinghai@kernel.org> <20150406220638.GH10892@google.com>
 <20150406.203533.1356187749826485194.davem@davemloft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Apr 2015 11:48:44 -0500
Message-ID: <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
To: David Miller <davem@davemloft.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 6, 2015 at 7:35 PM, David Miller <davem@davemloft.net> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Mon, 6 Apr 2015 17:06:38 -0500
>
>> But this is a general change that affects all platforms, and it's late in
>> the cycle for something as invasive as this.  I'd rather include your patch
>> in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
>> windows to fit in upstream windows") for v4.0.
>
> I would kindly ask that we not proceed this way and use the change
> which implements the fix properly.

I reworked the changelog and pushed this to my for-linus branch for
v4.0.  I'll ask Linus to pull it tomorrow.

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=1a3ec5e7b00dcd9cac24efe3d65bfccf82597ce5

Thanks for your help.

Bjorn
