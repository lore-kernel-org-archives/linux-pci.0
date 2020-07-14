Return-Path: <SRS0=Y43U=AZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23116C433DF
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jul 2020 23:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AF22071B
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jul 2020 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594771095;
	bh=0GSa/vVCcx42dxvvYTf+RjT7Q8jkxKwjCrADCf84T9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Lall/AAuRose2pIaYzY66rS0QUo2o6CVPXOhErJH4ay+Pb0kp9qmaWWGEFbdeTe+5
	 e95dot9CzNWW7jeNn4ne8hKQDo0r5WWSSKne4DuvAh+RQwnbDdyQsJoPrb+Z34du35
	 3GB94VwahG0Dedrd8wuGYRjKWCctiOAELEgSxBnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNX6O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgGNX6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 19:58:13 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F416420674;
        Tue, 14 Jul 2020 23:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594771093;
        bh=0GSa/vVCcx42dxvvYTf+RjT7Q8jkxKwjCrADCf84T9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l/XewjLCrd7mBMmLFyFKhMrkJw6V6+SJWGzw2FiDegtDkHNXyZrIObbeauAIJu7Tv
         5DA1MrHRz2/ApdIN6JvRLBeyjYMQP8YsB+cCsfH85ROs1s1w8qpVXCHJQJizdBlS3m
         LKBPtWwF1Pivdy2kazXUi6s14xHYYsLdbbNwTpcc=
Date:   Tue, 14 Jul 2020 18:58:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ian May <ian.may@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with
 reset_lock and device_lock
Message-ID: <20200714235811.GA431846@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 08:56:50PM +0200, Lukas Wunner wrote:
> On Mon, Jun 15, 2020 at 09:32:49AM -0500, Ian May wrote:
> > Currently when a hotplug interrupt and AER recovery triggers simultaneously
> > the following deadlock can occur.
> > 
> >         Hotplug				       AER
> > ----------------------------       ---------------------------
> > device_lock(&dev->dev)		   down_write(&ctrl->reset_lock)
> > down_read(&ctrl->reset_lock)       device_lock(&dev->dev)
> > 
> > This patch adds a reset_lock and reset_unlock hotplug_slot_op.
> > This would allow the controller reset_lock/reset_unlock to be moved
> > from pciehp_reset_slot to pci_slot_reset function allowing the controller
> > reset_lock to be acquired before the device lock allowing for both hotplug
> > and AER to grab the reset_lock and device lock in proper order.
> 
> I've posted a patch to address such issues on Mar 31, just haven't
> gotten around to respin it with a proper commit message:
> 
> https://lore.kernel.org/linux-pci/20200331130139.46oxbade6rcbaicb@wunner.de/
> 
> I've solved it by moving the reset lock into struct pci_slot.
> I think that's simpler than adding two callbacks.
> 
> Do you think the AER deadlock could be fixed based on my approach?

How should we proceed on this?
