Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29710C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27972087E
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553621761;
	bh=YXLJneDdQ/itgJczvkMM0t4YyOjOJz4y69G+lY/+Yec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8pkSLdZcRjqcYow5yTQK/Y16AcIKgC9L9psFCuXIhebZ9IulAac+/AfV5ESCZUzm
	 Q+F5AV+NRgVJLbMOMz25Zq716DMXAEIKmqSFMEjAWKhajGBkXgnzDiKOnL7LbWkC8Y
	 m4WLnCGIn2/ZszjdTTpxTSspLmRPaONSedZQ1etM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfCZRgA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZRf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 13:35:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF8220823;
        Tue, 26 Mar 2019 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553621759;
        bh=YXLJneDdQ/itgJczvkMM0t4YyOjOJz4y69G+lY/+Yec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpUOBYYdeuCkfc2cFqZJLR2NO+mTzxzvlqYbx3VSDnUtqO+MCz6UpSElvf/ztLyt3
         7PfwfjkjX3cvPaWx8VgCQB3vG2FirW7iQplhPgUltTfL/fmmgXO/upNL8NWJvAV7Ku
         FndzKkT/z/MjzQEoe1DeueanIdj64vW4XYJcKLiI=
Date:   Tue, 26 Mar 2019 12:35:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [pci:review/pci/resource 8/21] drivers/nvme/host/pci.c:2919:6:
 sparse: symbol 'nvme_rescan_prepare' was not declared. Should it be static?
Message-ID: <20190326173556.GK24180@google.com>
References: <201903262317.Xf94y2xJ%lkp@intel.com>
 <20190326154012.GA8171@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326154012.GA8171@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sergey]

On Tue, Mar 26, 2019 at 08:40:12AM -0700, Christoph Hellwig wrote:
> Please make sure all nvme patches go by the nvme maintainers and have
> an ACK, btw.  I've not even seen this patch before.

Thanks for pointing that out!  I haven't accepted any of this series
yet; I just pushed the branch to get build checking from the robot in
parallel with reviewing things.

Bjorn
