Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831F1C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE81206B7
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKMHh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:07:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfDKMHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 08:07:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44g0CB15NTz9s4V;
        Thu, 11 Apr 2019 22:07:33 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com addresses
In-Reply-To: <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com> <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
Date:   Thu, 11 Apr 2019 22:07:32 +1000
Message-ID: <87k1g0vj7f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Joe Perches <joe@perches.com> writes:
> On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
>> Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
>> to @linux.ibm.com in commit 1dfddcdb95c4
>> ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
>> some still remained.
>> 
>> We update the remaining email addresses in MAINTAINERS, hopefully finally
>> catching all cases for good.
>
> Perhaps update all the similar addresses in other files too
>
> $ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
> 315

A good number of them are no longer valid. So I'm not sure it's worth
updating them en masse to addresses that won't ever work.

We have git now, we don't need email addresses in files, they're just
prone to bitrot like this.

Should we just change them all like so?

  -arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer <jwboyer@linux.vnet.ibm.com>
  +arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer (IBM)


To indicate the author was at IBM when they wrote it?

Or should we try and update them with current addresses? Though then the
authors might start getting mails they don't want.

cheers
