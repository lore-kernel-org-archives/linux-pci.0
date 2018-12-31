Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA2AC43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708D2133F
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546272927;
	bh=Am3+w3t6qP0HcTeFYT8WNzFw5jcDYA04XaQzh66E60Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LwxWJ6S7SFB3kyRn2xP4b87NcvIK6nb5Yw8Txk7TCHUl7rbdXLG4UDQWcOcQHaRbY
	 XK4jtq7nls2kcv3oLffGzOnoru5qjIsvF15I0twV0QspZ2ZRWhC8Uj59Fh/NA4vaGZ
	 H/OBYxbe/4KkdzbFUDn+voNH53tsGaiuDPHSG5YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeLaQP0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 11:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeLaQP0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 11:15:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C513D2133F;
        Mon, 31 Dec 2018 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546272926;
        bh=Am3+w3t6qP0HcTeFYT8WNzFw5jcDYA04XaQzh66E60Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbRJ+V9HReqyoeMpba9DjJrr6c8V7q7QW8W4QfWjYtuWsJob9UNGNDIoUX0ATHUIP
         xY/7i/W1CqvyJ0okuxcpfwjj8SapVJUuKHAdGFq4rC43qJ/HtgIJc2Qq1TZke2rhso
         Idlf9WcF9UDEgF4Omb1gv88ZSra2kO/X++0FcfYw=
Date:   Mon, 31 Dec 2018 10:15:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com
Subject: Re: [PATCH v2 0/2] Add Stratix10 PCIe Root Port support
Message-ID: <20181231161523.GF159477@google.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 31, 2018 at 04:24:51PM +0800, Ley Foon Tan wrote:
> Add PCIe Root Port support for Stratix10 device and also update

"Stratix10" is a big step better than "StratixXX" because a web search
for the latter finds nothing, while the former does find useful
things.

Intel materials on the web seem to use "Stratix 10".  You might as
well include the space in English text.
