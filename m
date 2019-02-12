Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE3C282CA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1F222C5
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FujlZtKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfBLTHg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:07:36 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:42944 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfBLTHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 14:07:35 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 07A055C026A;
        Tue, 12 Feb 2019 20:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549998453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlWBYt/s+9V0QpZCLG+zjbxSYF/nR3fEJEG7YnknZbM=;
        b=FujlZtKyTZDcZACzadu4K+pY0YMakG2X562sMstwC4cxxzImEWOwuccvhkuLLwRGV4FN7g
        uuC7kCbjAifkBaCmd7uExCJFHyFKA0q+/FQ6mokXWADZAU7Bj3JBgPzAqL+YfEYjUyDqB9
        ClqLMHr6eP3Y3aXUC0ct07xzVP47CUs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Feb 2019 20:07:32 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
In-Reply-To: <20190212113257.GA23658@red-moon>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
 <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
 <20190211213900.GA247873@google.com>
 <1549961694.2546.18.camel@pengutronix.de> <20190212113257.GA23658@red-moon>
Message-ID: <fcb87e85b72680b274667cc843055150@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.02.2019 12:33, Lorenzo Pieralisi wrote:
> On Tue, Feb 12, 2019 at 09:54:54AM +0100, Lucas Stach wrote:
>> Hi Bjorn,
>>
>> Am Montag, den 11.02.2019, 15:39 -0600 schrieb Bjorn Helgaas:
>> > On Wed, Feb 06, 2019 at 10:57:32AM +0100, Stefan Agner wrote:
>> > > Define the length of the DBI registers. This makes sure that
>> > > the kernel does not access registers beyond that point, avoiding
>> > > the following abort on a i.MX 6Quad:
>> > >   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>> > >   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>> > >   ...
>> > >   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>> > >   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>> > >   ...
>> >
>> > I assume this problem happens when using the pci_read_config() path or
>> > something similar?
>> >
>> > Could this be solved using pci_dev.cfg_size instead of building a new
>> > dwc-specific mechanism?  There are some quirks that set dev->cfg_size
>> > to keep from reading past certain points in config space, e.g.,
>> > quirk_citrine(), quirk_nfp6000().
>> >
>> > I'm not necessarily opposed to doing it in dwc, but maybe there's some
>> > advantage in reducing the number of ways of doing the same thing.
>>
>> This actually started out as a quirk changing the cfg size. But the
>> valid config space size seems to be different between root ports that
>> share the same (broken) device ID (Synopsys abcd), so I doubt that this
>> would be easier and/or any cleaner to implement as a quirk.

For reference, this was the initial patch using
DECLARE_PCI_FIXUP_HEADER:
https://lore.kernel.org/lkml/20181019111350.6170-1-stefan@agner.ch/T/#u

> 
> There are two things here: matching the root port and setting
> the cfg size limit.
> 
> I agree with Bjorn that the cfg size limit, given that it is
> implemented in core code should be leveraged instead of reinventing
> the wheel to solve the same problem in driver specific code.

Seems sensible yes.

> 
> In the quirk code I do not think it is that complicated to retrieve
> the IMX variant to apply the quirk accordingly on the pci_dev.

It seems that drivers/pci/controller/pcie-iproc.c uses FIXUP functions
which access driver specific structs. I think we can get from (struct
pci_host_bridge *)->sysdata to struct pcie_port * and from there to
struct dw_pci.

I will give this a try next week.

> 
> Please let me know if that's feasible so that I can drop the
> patches from the branch and update it with a new version.
> 

Fine for me.

--
Stefan
