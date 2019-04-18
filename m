Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E4C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46632083D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555595711;
	bh=dJ32c9YVsVuxpoD4f+g3olQkO+nfTWVl9BA8+VYQno4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u6DPieO0ZocZax3Fb31BHMBJkuT7PEQtzgGi+w9WamN8x/wasIzpagH/PTEXBsFyT
	 aTHpgCZ7GuM8omBkVeE0U4Lq+omBvtcOpyORoYVWKgTvBrOUN70Zc6nDwMd7a8vWoi
	 xn0IkwO5ZdiLe7GdPO7I5RLjUJEeKcwy3rEdbP48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfDRNzL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRNzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 09:55:11 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6538720835;
        Thu, 18 Apr 2019 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555595710;
        bh=dJ32c9YVsVuxpoD4f+g3olQkO+nfTWVl9BA8+VYQno4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe3KkeAWwWfZ9Gl/VUVdEDmbdd0LhC5cEYmzubqOQRJLEmNnKvFwDlVcZNoKhbUnz
         XqjIgQ+QXblHFSocw23U8iTGTFnsJiDq1TFsNAnkO2gpPu+7m0zL6SJYsP91R8UHHS
         GxaUId4DbGgDAneeRtXmPrGB9I7RN7cLGonlimXU=
Date:   Thu, 18 Apr 2019 08:55:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH v2 0/2] Fix two bugs of switchtec module
Message-ID: <20190418135509.GA126710@google.com>
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 10:41:40PM +0800, Wesley Sheng wrote:
> Hi, Everyone,
> 
> This patch series fix two bugs of switchtec module.
> 
> The first is introduced by device spec definition issue: the maximum
> supported PCIe function number by hardware should be 255 instead of 
> the false number of 48. Rectify it in driver and for backward 
> compatible, a new ioctl and corresponding data structure are created,
> while keep the deprecated one.
> 
> The second is MRPC event unintentionally masked at corner case.
> Fix this bug by skipping the mask operation for MRPC event in event ISR
> like what we already do for LINK event.
> 
> Regard,
> Wesley
> 
> --
> 
> Changed since v1:
>   - rewrapped the commit message of [PATCH 1/2] into one paragraph
> 
> --
> 
> Wesley Sheng (2):
>   switchtec: Fix false maximum supported PCIe function number issue
>   switchtec: Fix unintended mask of MRPC event
> 
>  drivers/pci/switch/switchtec.c       | 42 +++++++++++++++++++++++++-----------
>  include/linux/switchtec.h            |  2 +-
>  include/uapi/linux/switchtec_ioctl.h | 13 ++++++++++-
>  3 files changed, 42 insertions(+), 15 deletions(-)

Applied to pci/switchtec for v5.2, thanks!
