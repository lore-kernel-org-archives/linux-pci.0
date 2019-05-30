Return-Path: <SRS0=0U9d=T6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1C8C28CC0
	for <linux-pci@archiver.kernel.org>; Thu, 30 May 2019 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835FA24451
	for <linux-pci@archiver.kernel.org>; Thu, 30 May 2019 02:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185011;
	bh=CW7CTMKWriQ7bvjQGyXm+qun++joMFi9uYzYhbLg1Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bO1y1iVCqzN1B+evSrQx+B5PelCxaDzFOzGMHlkM9ZUZuN5VX4J98mDdhNH3JMp7W
	 63OXLY42sNhAzsOXZN5E+D9W+EHtVdAhA77s/iRWL46nNd0RfFh+yDSvq1dr0y8t4Y
	 64rR4Xt4+lY8ve/DdbasuT3x4bypON5/xV8C2D68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfE3C4v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 May 2019 22:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfE3C4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 22:56:50 -0400
Received: from localhost (15.sub-174-234-174.myvzw.com [174.234.174.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E784324451;
        Thu, 30 May 2019 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185010;
        bh=CW7CTMKWriQ7bvjQGyXm+qun++joMFi9uYzYhbLg1Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrnNcbykDBG2QPD7dQcntt41q6Jgzr/5IsmeoJp0JnQAa+8YFhOfAFPj4V+WmEsdg
         fG6if8u5Ql+oZySjqu7WQm6SlTBGyxfPe8i/pbhJTfjbuemm9H1jTdEfXNRiQWYrOZ
         WLqUB85b4wWdr5dyc1T/VgdIQEHbdS1opfBCbkFc=
Date:   Wed, 29 May 2019 21:56:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190530025648.GH28250@google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
 <20190520061014.qtq6tc366pnnqcio@mail.google.com>
 <20190529163510.3dd4dc2d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163510.3dd4dc2d@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 04:35:10PM -0600, Jonathan Corbet wrote:
> On Mon, 20 May 2019 06:10:15 +0000
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Bjorn and Jonathan,
> > Could we consider to merge this serias now? Thanks.
> 
> Somewhat belatedly, but I think we could.  Bjorn, do you have a preference
> for which tree this goes through?  I don't remember if we'd come to an
> agreement on that or not, sorry...

I don't have a preference.  I somehow had the impression it would go
through your tree, but I'd be happy to merge it if you'd prefer.

Bjorn
