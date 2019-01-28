Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8354C282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02732171F
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LgxSjMBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1NUJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:20:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 08:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eWdKiHJs4ZcdjvWeOb8bm/wqnaevlt8LQR3cvGa16f4=; b=LgxSjMBWJkwBFiuTd2zyTH8At
        GU/TJ30p8sAaJM73zNFDRNtyIhaoBfrcucP29mTH02X0K4ljOuOPCk1IJbJ/dVBrtXBlF+gb5yPYg
        SIx1JdeLvVOh4Ll0FNjftJ1+j5GFYTj71Oz4pXRbOHZ2k+UCh5FR67o5pF9HnQehb8Rf9gJJ9DQj/
        mmpXcCQg+/wZkuybYbozy8JtbZVBjIVw1b3D69wFwT8nDIOQVLItq0CopX+G8FX7tD85bNseURWqp
        IPfrK/jo/z7iCW7WOIF+oGHGawxzbWxnj1G9VZtEZ9D27GwzCJ+DYuSUfvf90NgI+LrZVPUArawxW
        EN3teTMIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go6pX-0005FQ-CJ; Mon, 28 Jan 2019 13:20:03 +0000
Date:   Mon, 28 Jan 2019 05:20:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/7] MIPS: SGI-IP27: clean up bridge access and header
 files
Message-ID: <20190128132003.GA744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-3-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124174728.28812-3-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 06:47:23PM +0100, Thomas Bogendoerfer wrote:
>  #ifndef __ASSEMBLY__
> +/* Address translation entry for mapped pci32 accesses */
> +union bridge_ate {
> +	u64	ent;
> +	struct ate_s {
> +		u64	rmf:16;
> +		u64	addr:36;
> +		u64	targ:4;
> +		u64	reserved:3;
> +		u64	barrier:1;
> +		u64	prefetch:1;
> +		u64	precise:1;
> +		u64	coherent:1;
> +		u64	valid:1;
> +	} field;

Note that we generally try to avoid using bitfields for hardware
descriptions and instead use masking/shifting, possibly hidden in
macros.  The portability argument for that doesn't really apply
here as the code is obviously MIPS/big endian specific, but I think
it generally is a good example and more readable as well.
