Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33040 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbLGBtS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2015 20:49:18 -0500
MIME-Version: 1.0
In-Reply-To: <20151204222840.GK20125@localhost>
References: <1449141474-3378-1-git-send-email-lftan@altera.com>
	<20151204222840.GK20125@localhost>
Date: Mon, 7 Dec 2015 09:49:16 +0800
Message-ID: <CAFiDJ5-cYbuaAa75bTEtr_ibd2G6wn17pkso23BY_eTN-pkS4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] fixes to support multi-functions device
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 5, 2015 at 6:28 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 03, 2015 at 07:17:51PM +0800, Ley Foon Tan wrote:
>> This series of patch fixes the issues when work with multi-functions PCIe
>> devices. Host controller can't access to endpoint with non-zero devfn, due to
>> incorrect rootport devfn. It also add checking for TLP status and fix issue in
>> interrupt probing.
>>
>> Tested on Ethernet adapter card with multi-functions enabled.
>>
>> Ley Foon Tan (3):
>>   PCI: altera: fix incorrect devfn for requester ID
>>   PCI: altera: check TLP completion status
>>   PCI: altera: fix error when INTX is 4
>>
>>  drivers/pci/host/pcie-altera.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> We initially merged the Altera driver for v4.4-rc1, it looks like
> it's not really useful without these changes, and there's no danger of
> breaking anything in the field, so I put these on my for-linus branch
> and will ask Linus to pull them before v4.4.  Thanks!
>
That's great!
Thanks.

Regards
Ley Foon
