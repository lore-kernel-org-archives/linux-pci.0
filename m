Return-Path: <SRS0=8M4G=EJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B0C388F7
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7BA2074B
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 10:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8zpMpCf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xR/dsrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKCKQ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCKQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 05:16:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649FC0613D1;
        Tue,  3 Nov 2020 02:16:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604398616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gpvq/2A1yvnMwjL+wAA74Kn6/JPuAETBiuqTCH14fqo=;
        b=A8zpMpCfPTvAWGaiNtuCYgrtlN4XtGIUidHXWXDyiPmNCzHYxjgvQglp4o4zdPYBXLQD/q
        fDMGjdPh6sDM/Bjgb9UqJCNfBghh5+YCBn2vZd4Bbh80UPc7v6lvhO8dR3zWBMI8hajT7o
        nuZsG3Y1n/EOhFP2NHHdziAFtESpY8h6q7xr/uDi/+8FNujB7BFMj0OGlzSeUdvu5UQQz+
        qEl3FQ5oiMU8rGJA4NN7Ns+CKcE4wM7KlI40VQ7LJ0VBqBK5VzJdCqPvQpRsTKgPR0whVV
        DObuN4wzHHNFH2tCVxfAh+KNZI1Vhd5oWiAJu2R75cUUn+kq0StjH4rSqNXXTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604398616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gpvq/2A1yvnMwjL+wAA74Kn6/JPuAETBiuqTCH14fqo=;
        b=3xR/dsrIRDTurROfujbz4Q4AchrZlTwRSm9Jtw/CEB2g10wK0qvFQby2/nH7G3i8nhxDLS
        1FNL9iat9504AGAQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de> <877dr38kt8.fsf@nanos.tec.linutronix.de> <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
Date:   Tue, 03 Nov 2020 11:16:56 +0100
Message-ID: <87o8ke7njb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03 2020 at 09:54, Marc Zyngier wrote:
> On 2020-11-02 22:18, Thomas Gleixner wrote:
>> On Mon, Nov 02 2020 at 17:16, Thomas Gleixner wrote:
>>> On Mon, Nov 02 2020 at 11:30, Marc Zyngier wrote:
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus
>>>> *bus)
>>>>   		d = pci_host_bridge_msi_domain(b);
>>>> 
>>>>   	dev_set_msi_domain(&bus->dev, d);
>>>> +	if (!d)
>>>> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>>> 
>>> Hrm, that might break legacy setups (no irqdomain support). I'd rather
>>> prefer to explicitly tell the pci core at host registration time.
>> 
>> s/might break/ breaks /     Just validated :)
>
> For my own edification, can you point me to the failing case?

Any architecture which selects PCI_MSI_ARCH_FALLBACKS and does not have
irqdomain support runs into:

	if (!d)
		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

which in turn makes pci_msi_supported() return 0 and consequently makes
pci_enable_msi[x]() fail.

Thanks,

        tglx
