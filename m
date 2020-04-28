Return-Path: <SRS0=9Hmn=6M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC61C83000
	for <linux-pci@archiver.kernel.org>; Tue, 28 Apr 2020 11:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65267206D7
	for <linux-pci@archiver.kernel.org>; Tue, 28 Apr 2020 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588074356;
	bh=Las+uCbQVZ+GZlJ232xGH/+wbJHgK1QldnpQi8ikEtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=01FInTLkb0Q9j42laWnoMVBTV1Yd+NrmsNjeZbqjDYutMBEB6FY2YeU9tL8hqkbYs
	 4hzhMVzUS1bUN+7HtZ4XjBdZmtlquGMRKG8dCFS2mIhpskDrpD+KjrKgqD1QoPCRF2
	 ZzDEeMPYMp6oqoQwdlfm5c1hl+c7Z+wr80oyKArQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD1Lpz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD1Lpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 07:45:55 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF72206D7;
        Tue, 28 Apr 2020 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588074355;
        bh=Las+uCbQVZ+GZlJ232xGH/+wbJHgK1QldnpQi8ikEtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P9vnXJX9gAE9ZzqQl2OfHTbD4muunuH8+NP6L9VJEEEDGDYAakdOSH7gLM0xIXjt0
         GYaMZwxFb++wkPhZYXBr+Y3zOv3SnUufbADnRjWOGDo7Xh0nhajRel3Xcv6R6V6pY0
         /DOBdB5qqBO9qVBxn5onYL6/4T0mmD3AVoJzumws=
Date:   Tue, 28 Apr 2020 06:45:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Jon Derrick <jonathan.derrick@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200428114553.GA123760@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c97e05-2682-9046-a362-d8bc29be7482@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 08:20:07PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 4/27/20 5:02 PM, Bjorn Helgaas wrote:
> > I split this up a bit and applied the first part to pci/error to get
> > it into -next so we can start seeing what breaks.  I won't be too
> > surprised if we trip over something.
>
> Any reason for the split? I don't see reason for still keeping HEST
> parser.

I don't either.  My hope is that splitting makes them easier to
understand and review.  I didn't have time last night to finish the
second and explain it.  The second is actually quite different and has
implications for EDR and DPC that need to be considered.

Bjorn
