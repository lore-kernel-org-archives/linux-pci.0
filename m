Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A279C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB9264DFC
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1Xwd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhA1Xwd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 18:52:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00AB564DEF;
        Thu, 28 Jan 2021 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611877912;
        bh=+06htxCvAjj5N6kbjTFvZE9GRROzfGZvJul1Zorpiqw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aLuUyOXiYz8sI5W33RFHmVm/DfbYr4c9bzWiWoGf45k/LB6vVTwehmweJ199sxZhl
         j1Z2lk88BEx5smN3mtFyLtkZRyKVZ3AjMFUWpTXgLU99DaOdGGFCFv8oTk3N1BAWxt
         uYMgFCzqgxok4+0ktXjgjGHDTafNZAKLGLhi/xzv7oqXsdsLtLd9eGOM9W1q6hwxlo
         TgAoVzLGqsxu5E3fI9BoIdEHk5RptCrfo73ElcIpBf+IS0lZ10a+2alfS1lfkon5/m
         vjfo/VMmArgCmXX3EsQvnsthss1HnhIrhXWR8GiArz9p/ermLFRmAkbK5GkOiejuaw
         /xRRa66GBSeuQ==
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
References: <20210128233929.GA39660@bjorn-Precision-5520>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <6bfe3128-4f4d-6447-ab91-1bc54a02e16f@kernel.org>
Date:   Thu, 28 Jan 2021 18:51:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128233929.GA39660@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
> AFAICT, this thread petered out with no resolution.
> 
> If the bandwidth change notifications are important to somebody,
> please speak up, preferably with a patch that makes the notifications
> disabled by default and adds a parameter to enable them (or some other
> strategy that makes sense).
> 
> I think these are potentially useful, so I don't really want to just
> revert them, but if nobody thinks these are important enough to fix,
> that's a possibility.

Hide behind debug or expert option by default? or even mark it as BROKEN
until someone fixes it?
