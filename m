Return-Path: <SRS0=ofoM=4W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543F1C3F2D1
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F7B20801
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583434790;
	bh=uzvWwK4iXXA140bVXUMyz25//ogiOnp/uH+7SiSRj1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=LpScGwntJMFvktdk3NCJi2sEZSXClAQ1qKwbJfP6A3VA8KUQomA+ACow0J6OCnc/s
	 lGIXBhNIQ+ZIXnUOwr1KD6FX2IhzpChp74ix+LO2LnxZnLgjWs8sEyusUTs4lMV9H2
	 vgrkL1GvZKQL6eeuz8Emf/k3y1OJFAykQj66a7TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgCES7t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCES7t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 13:59:49 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7752206E2;
        Thu,  5 Mar 2020 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583434788;
        bh=uzvWwK4iXXA140bVXUMyz25//ogiOnp/uH+7SiSRj1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cEhtgog95EpseE8u/JsJbdOzirgAHaNdRwZyCvPqUcaCZIFwV8oIDdqZtj/J2w93s
         tzYXFCq/YkjCCl7XAq2XPnNbFvDKjfKLHNVAn7QZ0tbw3hzWIzWsumD37oWsVCdgkR
         WQwCQG2i4s+wrlTmA+JmU3pjWqBcAswUwQZrIOws=
Date:   Thu, 5 Mar 2020 12:59:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v16 7/9] PCI/DPC: Export DPC error recovery functions
Message-ID: <20200305185946.GA99050@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d0be7f-1cbe-22c9-ebb1-e2205ff5a732@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 05, 2020 at 09:42:21AM -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 3/5/20 8:37 AM, Christoph Hellwig wrote:
> > Please fix your subject.  Nothing is being exported in this patch.
> I will do it. I meant it as its being used outside dpc..

I'll update this.  I have some other tweaks so I'll post an updated
series soon.
