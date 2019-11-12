Return-Path: <SRS0=oUFn=ZE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D9C43331
	for <linux-pci@archiver.kernel.org>; Tue, 12 Nov 2019 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F2520679
	for <linux-pci@archiver.kernel.org>; Tue, 12 Nov 2019 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573579159;
	bh=85dgABjfLst0EJiLfQ6UppL83HD41+jlwGeYc+PJi5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=H8/3GXY7IrgLGxBL+HinvYtPB+bPBs2ODXiXGWp3X2XdquU7aazmRaqBsmvahZlw1
	 xQ2Bjc5P3ESZrMgi+FqyIC0G0ByMDTAM0INidvu7ohrdYVSf/dGBYMTeK1Zj6H5q0q
	 v6n6SUgrmnMtTqN7aFtqDWJekplWQsFZQOyULQtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKLRTS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLRTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 12:19:18 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C2520659;
        Tue, 12 Nov 2019 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573579158;
        bh=85dgABjfLst0EJiLfQ6UppL83HD41+jlwGeYc+PJi5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xdL+G1zDFE46caLzbkDRg0br9X96M7qfTympBm/tlAae7Dosfy8oNmO241YvCY3ot
         o/AK0tQcwpY1drq9ZXLTRTg83BCM/T44eZYlb5MREr/qYT9bAmbRggcZgaxXabvtMW
         jK+xizZQdMqOiW5ALdmPKCHortPXcRVIeEtOVC2I=
Date:   Tue, 12 Nov 2019 11:19:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
Message-ID: <20191112171915.GA167243@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 05:45:15PM +0100, Michel Dänzer wrote:
> On 2019-11-11 8:29 p.m., Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add definitions for these PCIe Link Control 2 register fields:
> > 
> >   Enter Compliance
> >   Transmit Margin
> > 
> > and use them in amdgpu and radeon.
> > 
> > NOTE: This is a functional change because "7 << 9" was apparently a typo.
> > That mask included the high order bit of Transmit Margin, the Enter
> > Modified Compliance bit, and the Compliance SOS bit, but I think what
> > was intended was the 3-bit Transmit Margin field at bits 9:7.
> 
> Can you split out the functional change into a separate patch 1? That
> could make things easier for anyone who bisects the functional change
> for whatever reason.

Great idea, thanks!  Wish I'd thought of that.

While fixing that, I also noticed I missed one case in
amdgpu/si.c.  I'll post a v3.
