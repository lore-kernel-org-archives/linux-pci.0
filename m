Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8BCC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026BB20656
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 10:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfANKmw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:42:52 -0500
Received: from ozlabs.org ([203.11.71.1]:42437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfANKmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 05:42:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dVRY21Ynz9s9G;
        Mon, 14 Jan 2019 21:42:49 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Kconfig label updates
In-Reply-To: <20190111112024.GD14180@gate.crashing.org>
References: <20190108223024.GA147017@google.com> <87tviiroqy.fsf@concordia.ellerman.id.au> <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com> <874lafg23v.fsf@concordia.ellerman.id.au> <20190111112024.GD14180@gate.crashing.org>
Date:   Mon, 14 Jan 2019 21:42:48 +1100
Message-ID: <87muo3zfiv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Fri, Jan 11, 2019 at 05:06:12PM +1100, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> > It is basically the predecessor to PAPR "Power Architecture Platform Reference".
>> > Which the LoPAPR document is available through power.org. Not sure if there is
>> > any desire to adopt PAPR in place of RPA. It is the platform reference doc that
>> > outlines how we do DLPAR and PCI Hotplug.
>> 
>> True. But a user is unlikely to know "PAPR" either, and it googles badly.
>
> Googling for "powerpc papr" works fine afais?  With a working link to a
> pdf on the first page and all!

True if you know to add "powerpc".

I only get a link to LoPAPR, which is similar but not identical. If
there's a link to PAPR then someone is in trouble :)

cheers
