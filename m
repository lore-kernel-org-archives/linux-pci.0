Return-Path: <SRS0=CtSx=4D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BB6C2BA83
	for <linux-pci@archiver.kernel.org>; Sat, 15 Feb 2020 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3092072D
	for <linux-pci@archiver.kernel.org>; Sat, 15 Feb 2020 09:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgBOJ0R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Feb 2020 04:26:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgBOJ0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Feb 2020 04:26:17 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2tiE-0005xL-FC; Sat, 15 Feb 2020 10:26:10 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E74BD101161; Sat, 15 Feb 2020 10:26:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>, bhelgaas@google.com,
        corbet@lwn.net, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kar.hin.ong@ni.com, sassmann@kpanic.de,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: Re: [PATCH 0/2] Add boot interrupt quirk mechanism for Xeon chipsets
In-Reply-To: <8736bctd7a.fsf@nanos.tec.linutronix.de>
References: <20200214213313.66622-1-sean.v.kelley@linux.intel.com> <8736bctd7a.fsf@nanos.tec.linutronix.de>
Date:   Sat, 15 Feb 2020 10:26:09 +0100
Message-ID: <87zhdkryku.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Sean V Kelley <sean.v.kelley@linux.intel.com> writes:
>> When IRQ lines on secondary or higher IO-APICs are masked (e.g.,
>> Real-Time threaded interrupts), many chipsets redirect IRQs on
>> this line to the legacy PCH and in turn the base IO-APIC in the
>> system. The unhandled interrupts on the base IO-APIC will be
>> identified by the Linux kernel as Spurious Interrupts and can
>> lead to disabled IRQ lines.
>>
>> Disabling this legacy PCI interrupt routing is chipset-specific and
>> varies in mechanism between chipset vendors and across generations.
>> In some cases the mechanism is exposed to BIOS but not all BIOS
>> vendors choose to pick it up. With the increasing usage of RT as it
>> marches towards mainline, additional issues have been raised with
>> more recent Xeon chipsets.
>>
>> This patchset disables the boot interrupt on these Xeon chipsets where
>> this is possible with an additional mechanism.  In addition, this
>> patchset includes documentation covering the background of this quirk.
>
> Well done! The documentation is really appreciated!
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Bjorn, this should go into stable as well IMO.

Thanks,

        tglx

