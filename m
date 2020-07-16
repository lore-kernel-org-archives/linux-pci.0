Return-Path: <SRS0=+2wZ=A3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EF5C433E3
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8AE20787
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594912029;
	bh=brugnNfIO3xKY0c62BddSSLWek+/YWe6CdH/i3pei8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=V+gPSdL+gQhvrjfZtU+vbz3A9en/UYnR6r0fAg2dQBxpZcFokvY7816CQdSun7Z/e
	 6uAfelMjBw8M5pSW9ZjWJFbZdAcbC1C6Cw+d36ygDjUvtaPcCurtf5K0OpchU9XXMc
	 Za0cauhUPs2eYI0mTFM1/4TkVl0B5x/FgNi86w78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGPPHJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPPHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 11:07:08 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D3A2063A;
        Thu, 16 Jul 2020 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594912028;
        bh=brugnNfIO3xKY0c62BddSSLWek+/YWe6CdH/i3pei8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1jyVcIGbtVHPD2AU++kWANs751g9eMwzqJeLGO4dpSXzKevPIF9ZF0oSfS5JnWfG9
         o1BPAPm7A5r+GwKeZfCOx3nCnD6JNxR5t17cd7xmHkWxN5LhEUUgD917BzMrg7IRjO
         NSP5gF50a0kGyFTo8jGRF8Qlypk85oVCjtqdnMmc=
Date:   Thu, 16 Jul 2020 10:07:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific
 Capability
Message-ID: <20200716150706.GA628795@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f490460-62f8-8b49-0735-ad29653bfbc0@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 15, 2020 at 07:55:11PM -0700, Randy Dunlap wrote:
> On 7/13/20 11:23 PM, David E. Box wrote:
> > Add PCIe DVSEC extended capability ID and defines for the header offsets.
> > Defined in PCIe r5.0, sec 7.9.6.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index f9701410d3b5..09daa9f07b6b 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -720,6 +720,7 @@
> > +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
> > @@ -1062,6 +1063,10 @@
> > +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
> > +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */
> 
> Just a little comment: It would make more sense to me to
> s/DVSEC/DVSPEC/g.

Yeah, that is confusing, but "DVSEC" is the term used in the spec.  I
think it stands for "Designated Vendor-Specific Extended Capability".
