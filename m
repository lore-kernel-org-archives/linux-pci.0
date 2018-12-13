Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7FC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B94620870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544714408;
	bh=3TRzL5JtzHpU0nY4U+cc2WOjnTZnN+Gx1vhogImV5cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WLcZNAFWlr78quPPIWyvjHGWeMdEM3j2Q1/uRDuVsgpZKvIjQoermOeedKZkf0yRi
	 WiPr9Ss+u9lHCJYLP5yqAyJhMAEMiyt2xD4oMlg8W8KFKKXqJHeyWWsXcv8ZgoTaVx
	 P8ToSk8dKEMLna6JDJ+EIQCBQPi52koGo+kPw1QM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B94620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeLMPUH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbeLMPUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 10:20:07 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F67320849;
        Thu, 13 Dec 2018 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544714406;
        bh=3TRzL5JtzHpU0nY4U+cc2WOjnTZnN+Gx1vhogImV5cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFyxM6auhFnSZhALgyapwi9dYY0tvhTrgSAjLIipinCH7off6zqs5rMTDypcmR0ol
         +c09XhccEkzDKPV3HCFzQl7i111AS0lydrkcuyTHZMuR8tS08xh9HJ71khCbVyS2+w
         X9xRlunxhqFaLibZLTG2cTz1qB4E1D260Qdc4Jws=
Date:   Thu, 13 Dec 2018 09:20:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH 0/5] Switchtec MRPC DMA mode support
Message-ID: <20181213152005.GE4701@google.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 05:12:19PM +0800, Wesley Sheng wrote:
> Hi, Everyone,
> 
> This patch series adds support for the Switchtec MRPC DMA mode.
> 
> Switchtec switches supports 2 MRPC interaction modes: MRPC normal mode and
> MRPC DMA mode, a new feature in the latest firmware versions. MRPC normal 
> mode requires the host to read the MRPC command status and output data. 
> In MRPC DMA mode the command status and output data are pushed directly to
> host memory and issues an interrupt upon completion. The advantage of MRPC
> DMA mode is avoiding potential high latency response from the Memory Read
> TLP. 
> 
> Additionally, we've made the following changes:
> 
> * Improve the efficiency of filling MRPC Input buffer by enabling write 
>   combining on MRPC region of BAR
> * Software workaround for delay responded Memory READ TLPs that access 
>   the BAR
> * And several bug fixes
> 
> Regards,
> Wesley
> 
> --
> 
> Changed since v1:
>   - It's a resend of v1
> 
> --
> 
> 
> Boris Glimcher (1):
>   switchtec: Set DMA coherent mask in Switchtec driver
> 
> Joey Zhang (1):
>   switchtec: A temporary variable should be used for the flags of
>     switchtec_ioctl_event_ctl
> 
> Kelvin Cao (2):
>   switchtec: Remove immediate status check after submit a MRPC command
>   switchtec: Improve MRPC efficiency by leveraging write combining
> 
> Wesley Sheng (1):
>   switchtec: MRPC DMA mode implementation
> 
>  drivers/pci/switch/switchtec.c | 154 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/switchtec.h      |  16 +++++
>  2 files changed, 153 insertions(+), 17 deletions(-)

I applied all these on pci/switchtec for v4.21, thanks!

If you want to change anything, let me know.  I'm happy to replace or
update patches.
