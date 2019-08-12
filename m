Return-Path: <SRS0=pqED=WI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA543C31E40
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8999C2075B
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565647934;
	bh=dl+Tz0F8DICZ/Q3wJoeTdAyMirqmNwcwyPQV9GAFnro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xkpHN0H4S3EWafcWVrEU1Z+SA6e9Ys1e/nAaIU3ocDxlWMdqREsJQ4kmVrYEmnQKP
	 qa5x1psYtcvZUJHw1GIOZhz93O3PLJmLBAmPVDm7IvW9q+n4lbmGCNIuibHTtzfHkR
	 i7pe0Q5YNmscqV9KorGHs7/xcLL35YnVZ7+OSpQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHLWMN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfHLWMN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 18:12:13 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F54D2070C;
        Mon, 12 Aug 2019 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565647932;
        bh=dl+Tz0F8DICZ/Q3wJoeTdAyMirqmNwcwyPQV9GAFnro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyJMogyknyoe08H7Bmrmj4OuP47idleVZ9nmsE44pjssUABl7AANDVOe+mvolvwa3
         alHvFV/ehAkU8nh0mPOCUa4xm5CzoLSi6xY5nHx7Fo6J+Rf/4vZuzXfBgZ6WLMOIt7
         GPy5w0hxvYNJtKUTpcTpDZi5ziEiMQMo4TVcm1J8=
Date:   Mon, 12 Aug 2019 17:12:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
Message-ID: <20190812221212.GF7302@google.com>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-5-efremov@linux.com>
 <20190812200330.GH11785@google.com>
 <b948bc25-e643-a43c-de70-136a041f13b1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b948bc25-e643-a43c-de70-136a041f13b1@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 12:14:08AM +0300, Denis Efremov wrote:
> > You must have a reason, but why didn't you completely remove
> > pciehp_green_led_on(), etc, and change the callers to use
> > pciehp_set_indicators() instead?
> 
> Well, I don't have the exact reason here. I thought that it would be nice to preserve
> an existing interface and to hide some implementation details (e.g., status of the
> second indicator). I could completely remove pciehp_green_led_{on,off,blink}() and
> pciehp_set_attention_status() in v3 if you prefer.

I might be missing something, but I do think I would prefer to
completely remove pciehp_green_led_{on,off,blink}() and
pciehp_set_attention_status().  Then we'd have exactly one interface
to change indicator state.
