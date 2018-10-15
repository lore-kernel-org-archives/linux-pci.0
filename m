Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A039C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F4A208B3
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 20:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y9Qs1GYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F4A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJPEoZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeJPEoZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 00:44:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D2320869;
        Mon, 15 Oct 2018 20:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539637049;
        bh=JbR+qejWYYxvpxi64qJy3Ey75rv5Lb98WdAM6q2w5rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9Qs1GYYa3+e062Ub9NH5yhrmPqrbyo2CIDtQtWQYXKHIZYo5ZBpB/wWZVTwuZ1Q4
         mZoyxL2xes/JhTUnxCvrAKJCughNHMyhpqNFb8iSebacv6x3A+yGEWNaqMbqntMNMz
         MD/WBrHdY1TA4O+dDRvzKDFAQGSSh6xbdQ+fG4Vw=
Date:   Mon, 15 Oct 2018 15:57:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/8] aha152x: rename the PCMCIA define
Message-ID: <20181015205727.GD5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 13, 2018 at 05:10:09PM +0200, Christoph Hellwig wrote:
> We plan to enable building the pcmcia core and drivers, and the
> non-prefixed PCMCIA name clashes with some arch headers.

In the followup PCMCIA patch, you capitalized "PCMCIA core".
