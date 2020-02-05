Return-Path: <SRS0=seBN=3Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B9AC352A2
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07AF218AC
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580933938;
	bh=1U2JNySow9ywV+0MoIP2f05Iqj1pjEt3CoLVZfd9sIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z94/gGxAc0fH1MtS8zQwTH45m7dk9yTmz7foxOLwiMbDzxbNDrNK5sYDM+wsjditn
	 XN/sfbXjMYZGtfxTIivQKWdzB3ujqcbAc5hLfQ1bBrD8NGozXmmDj4lnEHsCND38Og
	 67/oe8hcNxSqUK+N+IbzZQwExBuT3ixjuamqAFAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgBEUS6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBEUS6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 15:18:58 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293BB20720;
        Wed,  5 Feb 2020 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580933937;
        bh=1U2JNySow9ywV+0MoIP2f05Iqj1pjEt3CoLVZfd9sIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtfVJGGE53V8jsRx4jZS4KtqAT6NoNv+ezxGCKvxqdo9kMyIQs3JAnkNhg7g8io+a
         FEvppDkZoFTQllOk2fRgVfUtfkZLq7+xx9UZO8+UxeUrtDadP46ROtLEtqvSewGyKg
         WjBroJhKWkH6fKrAyDNTwtsmd8AOQ2ONRb8cIKPI=
Date:   Wed, 5 Feb 2020 15:18:56 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/apic/msi: Plug non-maskable MSI affinity race
Message-ID: <20200205201856.GF31482@sasha-vm>
References: <87lfpn50id.fsf@nanos.tec.linutronix.de>
 <20200205144509.7004C21D7D@mail.kernel.org>
 <87wo91rsgg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wo91rsgg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 02:58:55PM +0000, Thomas Gleixner wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> Hi,
>>
>> [This is an automated email]
>>
>>
>> NOTE: The patch will not be queued to stable trees until it is upstream.
>>
>> How should we proceed with this patch?
>
>Use V2 :)

My little bot can't keep up :)

-- 
Thanks,
Sasha
