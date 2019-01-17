Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4800C43613
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A244920851
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547731294;
	bh=WXgQ1cEWJDNa3zri+d6T+nIQ3nQXTbwdMtaxHT59StE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZGS4etPzGf+YM/hpMlr36FpyehODZBdklUu2o35SgW3xhSBa+i9xT46EQksDCuog
	 4mIF2v9mwJ58psZI4qGseMkT/XOyGSL1yqPfJrtyYD2ZaZc1mi2Auq+P1mIB4lf90M
	 zeJqJNHalb1/odc604Mr+aXnPT2yZtHiKCZA55IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfAQNVd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfAQNVd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 08:21:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBAC20652;
        Thu, 17 Jan 2019 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547731292;
        bh=WXgQ1cEWJDNa3zri+d6T+nIQ3nQXTbwdMtaxHT59StE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTSnbB2vrUiPIQJOpxqoeHgS7mAi4k/WhLifz8H1selqN2UcexaYH+xsUmmOopWBb
         QWgSMrTVA5mOb9KO30ftEhOWkfL02lY9ORiVmLfjdeqK+WJGYGbbs8G6PL9j3HN5iq
         CutawZLXtGg+jwdLAcHFnF6KJVcdUxe6qQuRR4Iw=
Date:   Thu, 17 Jan 2019 14:21:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: hv: Use vPCI protocol version 1.2 for v4.9
Message-ID: <20190117132130.GA9557@kroah.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547758038-5255-1-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 02:17:15AM +0530, Ajay Kaher wrote:
> For now, please consider these patches for review and suggest if these can be merged to mainline kernel v4.9.
> 
> These patches add support for vPCI protocol version 1.2, by baqkpotring from v4.14 to v4.9. Individual patches are summarised below: 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
