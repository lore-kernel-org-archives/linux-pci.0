Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mfdf0171.ocn.ad.jp ([153.128.50.73]:48999 "EHLO
        mfdf0171.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbcI1ODH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2016 10:03:07 -0400
Received: from mogw0109.ocn.ad.jp (mogw0109.ocn.ad.jp [118.23.109.83])
        by mfdf0171.ocn.ad.jp (Postfix) with ESMTP id 3C8EB110149D
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2016 22:44:08 +0900 (JST)
Date: Wed, 28 Sep 2016 22:43:54 +0900 (JST)
Message-Id: <20160928.224354.1290265177946822498.anemo@mba.ocn.ne.jp>
To: keith.busch@intel.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        ralf@linux-mips.org, lukas@wunner.de, wzhang@fb.com
Subject: Re: [PATCHv3 1/5] mips/pci: Reduce stack frame usage
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1475007815-28354-2-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
        <1475007815-28354-2-git-send-email-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 27 Sep 2016 16:23:31 -0400, Keith Busch <keith.busch@intel.com> wrote:
> The struct pci_dev is too large to allocate on the stack. This patch
> removes the fake pci device in early config access and instead uses the
> pci bus to get the same functionality.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Got the 'ok' (link below), but I don't see this is merged yet. That's
> okay, since I need to include it in this series to avoid 0'day build
> failure. If this is ok with everyone, perhaps this can go through 'pci'.
> 
>   https://www.linux-mips.org/archives/linux-mips/2016-09/msg00255.html

Sorry, I had missed the patch.  Looks good.  Thank you.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
