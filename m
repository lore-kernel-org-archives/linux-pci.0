Return-Path: <SRS0=rep4=T7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E49C04AB6
	for <linux-pci@archiver.kernel.org>; Fri, 31 May 2019 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958726A22
	for <linux-pci@archiver.kernel.org>; Fri, 31 May 2019 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559311974;
	bh=mSt2ZlKZCnk88aAZtbqzQ9/EkHtdKO9xQmIniYkrw3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=io4RU/IHF9JSU6j58hkD3bW32EL3LH1r1ZvCPy431/k6FZuJxsvxZ1xXGdvjUg5w+
	 r2YeK8GZCRHy0CF+bfXpOYSRDG6fWTKCgYGZ3kTZLouNupG5j5FYr1sCf5l163u2lr
	 TJ2SPvAy3Q5OoLY7MjsYNbGmUaucWalvexqMgywc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEaOMy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 31 May 2019 10:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaOMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 10:12:53 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DA826A22;
        Fri, 31 May 2019 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559311973;
        bh=mSt2ZlKZCnk88aAZtbqzQ9/EkHtdKO9xQmIniYkrw3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zku0jvJ+xuQNLjLF31JLZW9hJwgkOYE8YvkzBvtzSY9I0sR8aT/90SA72gWQV2P/X
         cvhV08YOwAx1PnEL7to2RdX2EPDI6pVGkn9mEfAmvpZJltBd0SZQx2VtpsYWyitaW4
         cOn2lhNmNOO6dTnpaJ7/W/xeU2GQ1pMxHuopwc+A=
Date:   Fri, 31 May 2019 09:12:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v3 0/5] Add Error Disconnect Recover (EDR) support
Message-ID: <20190531141251.GR28250@google.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 14, 2019 at 03:18:12PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This patchset adds support for following features:
> 
> 1. Error Disconnect Recover (EDR) support.
> 2. _OSC based negotiation support for DPC.
> 
> You can find EDR spec in the following link.
> 
> https://members.pcisig.com/wg/PCI-SIG/document/12614
> 
> Changes since v1:
>  * Rebased on top of v5.1-rc1

I'm sure you'll do this anyway, but please rebase the v4 on my pci/master
branch (v5.2-rc1).
