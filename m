Return-Path: <SRS0=Gu+H=NO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B87C0044C
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 06:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8291A20833
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 06:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz4un4ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8291A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeKCPgL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeKCPgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Nov 2018 11:36:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DA82081B;
        Sat,  3 Nov 2018 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541226358;
        bh=To2IOTtc0E74XIL/0fZKl24SBj9TLseIySf1F5OxRGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz4un4ql4ur+FQHJQJv5l0hjHeJu6vNFgH3jUzeaLosBreGCwXGTaw12Ejfu6+T8f
         /nvF8fvSWBHjzpLZOXeaaX37blvDn06KuoIKrJnio5O3BRq6Pc1MCaHyII+Z0KPOC6
         lebjLwZHOAGxSL18gjWRCmjF1IbaPk1aUvWnGrAQ=
Date:   Sat, 3 Nov 2018 07:25:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
Message-ID: <20181103062554.GA32644@kroah.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:47:38PM -0700, Thinh Nguyen wrote:
> Move Synopsys HAPS platform device IDs to pci_ids.h.

Why?  pci_ids.h, at the top of the file, says to not add new entries to
the file.

thanks,

greg k-h
