Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36082C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11736217F9
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfAKLVT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:21:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:38805 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbfAKLVT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 06:21:19 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0BBKRfF007409;
        Fri, 11 Jan 2019 05:20:27 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x0BBKPRR007407;
        Fri, 11 Jan 2019 05:20:25 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 11 Jan 2019 05:20:24 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Kconfig label updates
Message-ID: <20190111112024.GD14180@gate.crashing.org>
References: <20190108223024.GA147017@google.com> <87tviiroqy.fsf@concordia.ellerman.id.au> <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com> <874lafg23v.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lafg23v.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 11, 2019 at 05:06:12PM +1100, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> > It is basically the predecessor to PAPR "Power Architecture Platform Reference".
> > Which the LoPAPR document is available through power.org. Not sure if there is
> > any desire to adopt PAPR in place of RPA. It is the platform reference doc that
> > outlines how we do DLPAR and PCI Hotplug.
> 
> True. But a user is unlikely to know "PAPR" either, and it googles badly.

Googling for "powerpc papr" works fine afais?  With a working link to a
pdf on the first page and all!


Segher
