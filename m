Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CFC282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DFA20857
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfA1NYn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:24:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:42464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbfA1NYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 08:24:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EEA4AD23;
        Mon, 28 Jan 2019 13:24:41 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:24:40 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/7] MIPS: SGI-IP27: clean up bridge access and header
 files
Message-Id: <20190128142440.591d2115ac7844863713aa77@suse.de>
In-Reply-To: <20190128132003.GA744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
        <20190124174728.28812-3-tbogendoerfer@suse.de>
        <20190128132003.GA744@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Jan 2019 05:20:03 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Jan 24, 2019 at 06:47:23PM +0100, Thomas Bogendoerfer wrote:
> >  #ifndef __ASSEMBLY__
> > +/* Address translation entry for mapped pci32 accesses */
> > +union bridge_ate {
> > +	u64	ent;
> > +	struct ate_s {
> > +		u64	rmf:16;
> > +		u64	addr:36;
> > +		u64	targ:4;
> > +		u64	reserved:3;
> > +		u64	barrier:1;
> > +		u64	prefetch:1;
> > +		u64	precise:1;
> > +		u64	coherent:1;
> > +		u64	valid:1;
> > +	} field;
> 
> Note that we generally try to avoid using bitfields for hardware
> descriptions and instead use masking/shifting, possibly hidden in
> macros.  The portability argument for that doesn't really apply
> here as the code is obviously MIPS/big endian specific, but I think
> it generally is a good example and more readable as well.

I totally agreed. I only moved the original defintion around while cleaning
up the header file. Right now there is no code using it. Should I remove it
and access macros as soon there is a need for it ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
