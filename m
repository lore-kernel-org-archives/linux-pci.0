Return-Path: <SRS0=EWQp=EI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A112C00A89
	for <linux-pci@archiver.kernel.org>; Mon,  2 Nov 2020 22:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CFD22275
	for <linux-pci@archiver.kernel.org>; Mon,  2 Nov 2020 22:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="upMMtjCR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffZZj7RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgKBWSO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:18:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 17:18:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604355492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xly7vSYeoMILwUk4ixZP3866bXaRUpNDJSG+wlkAlI4=;
        b=upMMtjCRIY89jZxoAMxdlNQ8hF396TY4CzHCkaAW2YJLGseQcXaMCYgQnlf9Y9dabEEvTa
        HaaXeP/uIGaehfLlzQQXUepZBi7g0G59/azJClsTIVrPN0re6XxPtgT1D88Eor2aQUHTcu
        xGFlYCA25mmOMLdCnNkYODrWF5MeyGP8VVrhzb61CeiC8R4GhaUjqxKyOf2ihTaWVBQXXh
        47gZiQJJjg6mt7lMRdpy/CdzNgyPDchdmx1IGh83e71eOSHF7d0eoimsUrUINCuxFeCWIr
        1mTb1rI5ynIUcUb0q9fcYaZ2dTk6V563FC1Bm/kaYWfKMUNFWYnePdEgv0liCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604355492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xly7vSYeoMILwUk4ixZP3866bXaRUpNDJSG+wlkAlI4=;
        b=ffZZj7RAS4e4aSGVv1b2vhc8FpsNZ5T2k3MsoDK0BW4lJjfebln1MNZswIQeqtQjQnEmfg
        KIV78M90DBA+msBw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <87h7q791j8.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de>
Date:   Mon, 02 Nov 2020 23:18:11 +0100
Message-ID: <877dr38kt8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02 2020 at 17:16, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 11:30, Marc Zyngier wrote:
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus 
>> *bus)
>>   		d = pci_host_bridge_msi_domain(b);
>>
>>   	dev_set_msi_domain(&bus->dev, d);
>> +	if (!d)
>> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>
> Hrm, that might break legacy setups (no irqdomain support). I'd rather
> prefer to explicitly tell the pci core at host registration time.

s/might break/ breaks /     Just validated :)

So we really need some other solution and removing the warning is not an
option. If MSI is enabled then we want to get a warning when a PCI
device has no MSI domain associated. Explicitly expressing the PCIE
brigde misfeature of not supporting MSI is way better than silently
returning an error code which is swallowed anyway.

Whatever the preferred way is via flags at host probe time or flagging
it post probe I don't care much as long as it is consistent.

Thanks,

        tglx


