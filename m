Return-Path: <SRS0=ZO6A=UC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E85C04AB5
	for <linux-pci@archiver.kernel.org>; Mon,  3 Jun 2019 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125126A77
	for <linux-pci@archiver.kernel.org>; Mon,  3 Jun 2019 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559603116;
	bh=HTEBGGiuzJwUClfshDH32ho4zeOOAnP/iWlJw3BK9q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wamLkkSKvCZzusxLOzm4HnWyEN7OOhIdIvXhsz52rqmnMnjourb7M9Pwjk0+ihHih
	 YALUnhtQ3E8sgKUKh0qLZkuBw9Rd4Sa24MDM4awrGiB/C8jzoiJcH7Uy9w5GAljhuh
	 FFqCa+DmD+c7Z6J7t/WXrnsPMQEuJ1hGBz2XbKXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfFCXFP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfFCXFP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 19:05:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5945626A4C;
        Mon,  3 Jun 2019 23:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559603114;
        bh=HTEBGGiuzJwUClfshDH32ho4zeOOAnP/iWlJw3BK9q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIkMrXzwjV7SjLQS8j1ZzCkxYfQyK+19r86dNS3oCjwAIthbFgrfRDE7/CoIKxZHX
         0w2v5ZmrS9/1tPBSeVJsDW9Nwp/JSf9QQnFdrh7mt6w07bkiRYAArAjvmn+flKqf7I
         9/DrPwIGvkCqsethBx6UR4NnNHuzGP2qCKWtLk0Y=
Date:   Mon, 3 Jun 2019 18:05:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     JD Zheng <jiandong.zheng@broadcom.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, keith.busch@intel.com,
        bcm-kernel-feedback-list@broadcom.com,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: SSD surprise removal leads to long wait inside pci_dev_wait()
 and FLR 65s timeout
Message-ID: <20190603230512.GD58810@google.com>
References: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
 <20190603004414.GA189360@google.com>
 <20190602194011.51ceaa23@x1.home>
 <78f95dfe-ac2b-408f-0e2a-b3b9d69575dd@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f95dfe-ac2b-408f-0e2a-b3b9d69575dd@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 03, 2019 at 02:17:36PM -0700, JD Zheng wrote:
> > On Sun, 2 Jun 2019 19:44:14 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > Would you mind opening a report at https://bugzilla.kernel.org and
> > > attaching the complete dmesg log and "lspci -vv" output?
> 
> I submitted one as https://bugzilla.kernel.org/show_bug.cgi?id=203797
> 
> > > Out of curiosity, why do you use "pciehp.pciehp_poll_time=5"?
> 
> This was chosen by other engineer. I tried shorter polling time, which
> doesn't make difference.
> 
> I also tried pciehp.pciehp_poll_mode=0 but hotplug doesn't seem working.
> Should I use poll mode or not?

This is just a tangent to the real issue you're working; I'm not
suggesting any changes here to fix that issue.

In my mind, the existence of the pciehp.pciehp_poll_mode and
pciehp.pciehp_poll_time parameters is a defect in pciehp.  I would far
rather that pciehp figured out by itself whether it needed to poll.  I
don't know whether that's actually feasible, or if there's some reason
why pciehp can't be that smart.

Bjorn
