Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:38037 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeCMKyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2018 06:54:31 -0400
Received: by mail-ot0-f169.google.com with SMTP id 95so18465055ote.5
        for <linux-pci@vger.kernel.org>; Tue, 13 Mar 2018 03:54:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b440214a-0768-38a4-9410-9eedc7a79dca@green-communications.fr>
References: <b440214a-0768-38a4-9410-9eedc7a79dca@green-communications.fr>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Mar 2018 07:54:30 -0300
Message-ID: <CAOMZO5DeTvR2YiJa1ei7vW=m1FukJRhdO-DaoeKLrFeSvFO0QA@mail.gmail.com>
Subject: Re: PCI enumeration broken on Ventana gw5200
To: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Nicolas,

On Tue, Mar 13, 2018 at 7:45 AM, Nicolas Cavallari
<Nicolas.Cavallari@green-communications.fr> wrote:
> When testing v4.16-rc2 on a Ventana gw5200, the mini-PCIe cards were
> not recognised.  Only the bridge was recognised.

Please try 4.16-rc5 instead.

Koen's commit should fix the issue you described:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/dwc?h=v4.16-rc5&id=fc110ebdd014dd1368c98e7685b47789c31fab42
