Return-Path: <SRS0=I3i3=DQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490CC433E7
	for <linux-pci@archiver.kernel.org>; Fri,  9 Oct 2020 10:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E50222C3
	for <linux-pci@archiver.kernel.org>; Fri,  9 Oct 2020 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602241042;
	bh=kHOFqclHrdBBz1Ryt/WeaTaY4X02dr3AcOscUBLI+pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FEbmtDCIOoqhF56nJgxu4YL87ZDQ6YNlbx9i5nBbc/QlDyLCsVVtY+iKyLI7x5XHA
	 QrVe06t4mssNEk75l33MSMLQKdmHK5QFbmdD8faizQXXSWQwXJOBTmM5NctoUKgm0Y
	 Xjt8QKFRryV7cWu6IVT6AlgdmY/6i8p1rNU2ORF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbgJIK5T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Oct 2020 06:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbgJIK5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 06:57:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B50922277;
        Fri,  9 Oct 2020 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602241038;
        bh=kHOFqclHrdBBz1Ryt/WeaTaY4X02dr3AcOscUBLI+pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDySZdo8ogOvvFAvfoOvwcvjxWeR1WwNSfI9D3bnjZKGkyyun/LM2tvFaBCG2rEo6
         nVoZ0deBG7KOCK5o+s/18boeFzFxdFlCSaBF1AkNBr4eEngIikwngVuVjouAM14YHd
         XY8m3BRogYTEIV0Cm2EMOXkh5ALWcoubP/dOjosw=
Date:   Fri, 9 Oct 2020 12:58:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 15/17] sysfs: Support zapping of binary attr mmaps
Message-ID: <20201009105803.GA505688@kroah.com>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-16-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009075934.3509076-16-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 09:59:32AM +0200, Daniel Vetter wrote:
> We want to be able to revoke pci mmaps so that the same access rules
> applies as for /dev/kmem. Revoke support for devmem was added in
> 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the
> region").
> 
> The simplest way to achieve this is by having the same filp->f_mapping
> for all mappings, so that unmap_mapping_range can find them all, no
> matter through which file they've been created. Since this must be set
> at open time we need sysfs support for this.
> 
> Add an optional mapping parameter bin_attr, which is only consulted
> when there's also an mmap callback, since without mmap support
> allowing to adjust the ->f_mapping makes no sense.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> ---
>  fs/sysfs/file.c       | 11 +++++++++++
>  include/linux/sysfs.h |  2 ++
>  2 files changed, 13 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
