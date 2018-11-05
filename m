Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50842C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB972086B
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNB3rz/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB972086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeKFERx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKFERx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Nov 2018 23:17:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E3720700;
        Mon,  5 Nov 2018 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541444207;
        bh=uA/9PejGPhK+uDWYc0j4mb8M6xq6M+r5YIT3xMYH5IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNB3rz/nWPLaTqcZRsNAp2OOwKapPk+vxgRmZwu1EKQYFQGZeDA0j9YzRdCkaoiiz
         h5PqrQoSRXo2S8a3fCZOy7xVwIQ+ePig3mj6kgbT34DVSCPKmwHdzTcKcqXdEBQAKg
         fRv81xyhKg5Kr0f8tOb6ukaIxHJE71LZqiIWeUd4=
Date:   Mon, 5 Nov 2018 19:56:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
Message-ID: <20181105185633.GB5321@kroah.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <20181103062554.GA32644@kroah.com>
 <30102591E157244384E984126FC3CB4F6399E2F1@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30102591E157244384E984126FC3CB4F6399E2F1@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 06:46:26PM +0000, Thinh Nguyen wrote:
> Hi Greg,
> 
> On 11/2/2018 11:26 PM, Greg KH wrote:
> > On Fri, Nov 02, 2018 at 06:47:38PM -0700, Thinh Nguyen wrote:
> >> Move Synopsys HAPS platform device IDs to pci_ids.h.
> > Why?  pci_ids.h, at the top of the file, says to not add new entries to
> > the file.
> 
> Yes, I notice. However, I want to reference these IDs in
> /drivers/pci/quirks.c. It's related to this patch subject "[PATCH 2/2]
> pci: quirks: Override Synopsys USB 3.x HAPS device driver".
> I will CC that patch to linux-usb mailing list also. Please let me know
> if this is ok. Otherwise, any suggestion?

Ah, ok, that is fine, as I never saw patch 2/2, I didn't know that :)
