Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6FC10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558D92133D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDKM1h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:27:37 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:33975 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbfDKM1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 08:27:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C5EC2180A8123;
        Thu, 11 Apr 2019 12:27:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coast83_5f0e5b204912b
X-Filterd-Recvd-Size: 2769
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Apr 2019 12:27:33 +0000 (UTC)
Message-ID: <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 11 Apr 2019 05:27:31 -0700
In-Reply-To: <87k1g0vj7f.fsf@concordia.ellerman.id.au>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
         <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
         <87k1g0vj7f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-04-11 at 22:07 +1000, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> > On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
> > > Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> > > to @linux.ibm.com in commit 1dfddcdb95c4
> > > ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> > > some still remained.
> > > 
> > > We update the remaining email addresses in MAINTAINERS, hopefully finally
> > > catching all cases for good.
> > 
> > Perhaps update all the similar addresses in other files too
> > 
> > $ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
> > 315
> 
> A good number of them are no longer valid. So I'm not sure it's worth
> updating them en masse to addresses that won't ever work.
> 
> We have git now, we don't need email addresses in files, they're just
> prone to bitrot like this.
> 
> Should we just change them all like so?
> 
>   -arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer <jwboyer@linux.vnet.ibm.com>
>   +arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer (IBM)
> 
> To indicate the author was at IBM when they wrote it?

If that's desired, perhaps:

$ git grep -P --name-only '<?[\w\.]+(?:@| at )linux\.vnet\.ibm\.com>?' | \
  grep -vP '\.mailmap|MAINTAINERS' | \
  xargs perl -p -i -e 's/<?[\w\.]+(?:@|\ at\ )linux\.vnet\.ibm\.com>?/(IBM)/g'

> Or should we try and update them with current addresses? Though then the
> authors might start getting mails they don't want.

That'd be my preference.

If authors get emails they don't want, then those contact
emails should be removed.


