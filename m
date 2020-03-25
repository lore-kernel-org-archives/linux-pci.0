Return-Path: <SRS0=HRHx=5K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439AC54FCF
	for <linux-pci@archiver.kernel.org>; Wed, 25 Mar 2020 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAE2206F8
	for <linux-pci@archiver.kernel.org>; Wed, 25 Mar 2020 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585120573;
	bh=rAaMmZCfF2JGaNLQBxQpmYG0YuF1N707UWJZWRwGZWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NbCYYWMQJ0nbl44/4oErQGxm3HAvFDhBnMb29ItsTPYq4s3y1lwjlJaF8v/VQ3pEe
	 sMuh+wpNGo9VOwKoLTnuIR8irx/E3gkjrLNIwCYRawH4X/Wo+V7p+46DyMtg7ef/2y
	 uSph4QBdN9r1eFt6UBZ1R6qGgw52T3A8Zo2NLfrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCYHQN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgCYHQN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 03:16:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969C6206F6;
        Wed, 25 Mar 2020 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585120571;
        bh=rAaMmZCfF2JGaNLQBxQpmYG0YuF1N707UWJZWRwGZWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPMpc2mobI+Ysg9uSGbcV0ubNoAUuYAcTUU1KuTdXYelkuLrKrHu8qT68KKUX6Kfu
         0Y0YRw0lpWYt37ipCZnvC4xe3cDa0ojFF68UlSMKOVYfSY4LKSMFBe929xoGzBy0Gj
         7nUkaoFRd0D3Htxih4RSnD+dwURE9Ip4YSQNNoG8=
Date:   Wed, 25 Mar 2020 08:16:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, rbilovol@cisco.com, ddutile@redhat.com,
        ruslan.bilovol@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, bodong@mellanox.com
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI: sysfs: Change bus_rescan and
 dev_rescan to rescan
Message-ID: <20200325071608.GA2978943@kroah.com>
References: <20200324234848.8299-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324234848.8299-1-skunberg.kelsey@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 05:48:48PM -0600, Kelsey Skunberg wrote:
> From: Kelsey Skunberg <kelsey.skunberg@gmail.com>
> 
> rename device attribute name arguments 'bus_rescan' and 'dev_rescan' to 'rescan'
> to avoid breaking userspace applications.
> 
> The attribute argument names were changed in the following commits:
> 8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
> 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")
> 
> Revert the names used for attributes back to the names used before the above
> patches were applied. This also requires to change DEVICE_ATTR_WO() to
> DEVICE_ATTR() and __ATTR().
> 
> Note when using DEVICE_ATTR() the attribute is automatically named
> dev_attr_<name>.attr. To avoid duplicated names between attributes, use
> __ATTR() instead of DEVICE_ATTR() to a assign a custom attribute name for
> dev_rescan.
> 
> change bus_rescan_store() to dev_bus_rescan_store() to complete matching the
> names used before the mentioned patches were applied.
> 
> Signed-off-by: Kelsey Skunberg <kelsey.skunberg@gmail.com>

You should add:
Fixes: 8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
Fixes: 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")

to this too, and a
	Cc: stable <stable@vger.kernel.org>
to the signed-off-by: area so that it gets properly backported.

Other than that minor thing, looks good to me, thanks for fixing it so
quickly:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
