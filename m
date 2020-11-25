Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6FC6379D
	for <linux-pci@archiver.kernel.org>; Wed, 25 Nov 2020 11:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD162087C
	for <linux-pci@archiver.kernel.org>; Wed, 25 Nov 2020 11:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywQ8QxOv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+/u2xvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKYLyo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:54:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYLyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 06:54:44 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606305281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4HNcEhYd2VgvyfBGtCMGm1chw2/6OizpvW8l9Q1z+M=;
        b=ywQ8QxOvwDbvJE9c9JPJzdHwfBCFRH3928DMITp+dq6S9GRoV/xjLwkQeLiEne8RKqkllG
        iKVa1fAyiQhkE2K7EL2ZNXg5qcjEmYm4NNClmpSikNsbWuCiNyB7kThBL538GP24uhK34p
        QLNAWIcOQX73qxCvPL3M6lrU4JZWg+HY4PluhL+athGxq2jX1pMZjDobYjGsk4N6lh7QCk
        IxdDzTsWYNI32jzPQhMjuO8WcLU/ZQGWEWO4eGfvD9Q1iMHcmUc2+NbbedEoH3fn7wqymB
        HN09hyC9SnRqW+yBncQcahkJ+xgGcPQH17GwsQge1MhyUAAW3rxRYCuGLaAkYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606305281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4HNcEhYd2VgvyfBGtCMGm1chw2/6OizpvW8l9Q1z+M=;
        b=f+/u2xvQDCOr/gl/tvrYOTM09dSlbIXP+gm/q5P2/5ke+AusnJMy2GxaO+M4gwP2xdULK6
        Mv04xdkGQIaP7zCQ==
To:     Stefan =?utf-8?Q?B=C3=BChler?= 
        <stefan.buehler@tik.uni-stuttgart.de>,
        sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
In-Reply-To: <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com> <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
Date:   Wed, 25 Nov 2020 12:54:41 +0100
Message-ID: <87zh35k5xa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan,

On Wed, Sep 16 2020 at 12:12, Stefan B=C3=BChler wrote:

sorry for the delay. This fell through the cracks.

> this quirk breaks our serial ports PCIe card (i.e. we don't see any=20
> output from the connected devices; no idea whether anything we send=20
> reaches them):
>
> 05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-P=
CI Bridge (rev aa)
> 06:00.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 1695=
0 UART) function 0 (Uart)
> 06:00.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) fun=
ction 0 (Disabled)
> 06:01.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 1695=
0 UART) function 0 (Uart)
> 06:01.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART)
> function 0 (Disabled)

Can you please provide the output of:

 for ID in 05:00.0 06:00.0 06:00.1 06:01.0 06:01.1; do lspci -s $ID -vvv; d=
one

Thanks,

        tglx
