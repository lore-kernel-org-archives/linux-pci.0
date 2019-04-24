Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5AC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C412175B
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128447;
	bh=2INTD9CWzqr4fjUIP/9/Otv0PhQ1zMWgSjDTU1U8cEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iBNVRduvtufwahrmnTizXK3rqc+QUKed59aT0O+LH3WeTwqf5QZ/583ZAJYVs4OhJ
	 BDOz8EHRPnIc0uOetLHGUJPz82DQYTMeULAUxddLMrvth5aw/3Fdge2ES92FK40tEH
	 QsPbsL8/ct2OZcbERntYgWCE46d96IL+1z4fKMx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbfDXRyA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:54:00 -0400
Received: from casper.infradead.org ([85.118.1.10]:46170 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390252AbfDXRx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 13:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B4WEGbnCyfW0Q3Xttpd8TsmO+qZt8FAt27+U8RemGZY=; b=Y8nxckKtP/K4PlyahScpltMG7l
        +mEFwN711HmK/Gaw8WY/PvSMElTYdfrb3bYool6kSS5bMv7B/2CAWM1F+Lhd6FGfzAqPkG94taHjT
        g0I3j8sjV49VSGPRWSZof+iKL9ajYk9yCFEHbiz2scV9DQjsMexUowd+vD1QhgDjJ+kLH0gYqivPo
        5P69F7ffYMR+3mmzLHz+yr92ujdYHOnjG91H8ITHr6JXhrOggoQ/V8G6mVsRFVOQscGf3JRvoNCLe
        A3JpC0ZAWesWhGt+x+ZlctOKT8vtO6/Iqz7ZtF6yLXRfOwjqTTNVRSlcjND/SrAxvStsV9JX2IZ0t
        H3sf8hMw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJM5j-0000Pd-7c; Wed, 24 Apr 2019 17:53:55 +0000
Date:   Wed, 24 Apr 2019 14:53:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424145348.0631c8a1@coco.lan>
In-Reply-To: <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-10-changbin.du@gmail.com>
        <20190423180316.7f042bc4@coco.lan>
        <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 25 Apr 2019 00:28:52 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 23, 2019 at 06:03:16PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 24 Apr 2019 00:28:38 +0800
> > Changbin Du <changbin.du@gmail.com> escreveu:
> >   

> > > +.. note:: Only ACPI METHOD can be overridden, any other object types like
> > > +   "Device", "OperationRegion", are not recognized. Methods
> > > +   declared inside scope operators are also not supported.
> > > +.. note:: The same ACPI control method can be overridden for many times,
> > > +   and it's always the latest one that used by Linux/kernel.
> > > +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> > > +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".  
> > 
> > Hmm... this may work (not sure if Sphinx would warn or not), but it
> > is visually bad on text mode. I would code it, instead, with something 
> > like:
> > 
> > .. note::
> > 
> >     - Only ACPI METHOD can be overridden, any other object types like
> >       "Device", "OperationRegion", are not recognized. Methods
> >       declared inside scope operators are also not supported.
> > 
> >     - The same ACPI control method can be overridden for many times,
> >       and it's always the latest one that used by Linux/kernel.
> > 
> >     - To get the ACPI debug object output (Store (AAAA, Debug)),
> >       please run::
> > 
> > 		echo 1 > /sys/module/acpi/parameters/aml_debug_output
> > 
> > As this would make it visually better on both text and html formats.
> >  
> No warnings given.

Interesting. I'm now wondering if it did the right thing or if it produced
some weird output... Maybe the answer depends on the Sphinx version one
would be using.

> Your suggested style is better so applied it. Thanks!

Thank you!

Thanks,
Mauro
