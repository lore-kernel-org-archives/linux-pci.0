Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:39057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeCMLN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2018 07:13:58 -0400
Subject: Re: PCI enumeration broken on Ventana gw5200
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b440214a-0768-38a4-9410-9eedc7a79dca@green-communications.fr>
 <CAOMZO5DeTvR2YiJa1ei7vW=m1FukJRhdO-DaoeKLrFeSvFO0QA@mail.gmail.com>
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Message-ID: <b09e3fc8-683b-10f8-9ccc-b3fafd7146a1@green-communications.fr>
Date: Tue, 13 Mar 2018 12:13:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DeTvR2YiJa1ei7vW=m1FukJRhdO-DaoeKLrFeSvFO0QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/03/2018 11:54, Fabio Estevam wrote:
> Hi Nicolas,
> 
> On Tue, Mar 13, 2018 at 7:45 AM, Nicolas Cavallari
> <Nicolas.Cavallari@green-communications.fr> wrote:
>> When testing v4.16-rc2 on a Ventana gw5200, the mini-PCIe cards were
>> not recognised.  Only the bridge was recognised.
> 
> Please try 4.16-rc5 instead.
> 
> Koen's commit should fix the issue you described:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/dwc?h=v4.16-rc5&id=fc110ebdd014dd1368c98e7685b47789c31fab42
> 

Oh, i only looked for changes in probe.c since 4.16-rc2, didn't think that it
could get fixed in the dwc driver.

I just tested 4.16-rc5 and indeed the issue is fixed. Thanks !
