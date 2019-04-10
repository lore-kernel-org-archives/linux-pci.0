Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97516C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6185020830
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554931339;
	bh=vRpziHRw77/PZG0lu2U+YGrhLPzsZCBpVeDGIU+6uAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ChM6vmAoTOoHVoRNUcokZj1V8442Ob3osS9QT0Uir2hnAqQnytTq+ZWfDaijnu7RJ
	 M5s0YeQRlZIuENvnGl/VUhm9honcLdWlCGzxb/2U6E0zWtruF65iEYYKbLioQBR14b
	 k1YPShMsiww8Ljy18lLWE3LczkFrsgcx0UCk+Jew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfDJVWS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDJVWS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:22:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6422082A;
        Wed, 10 Apr 2019 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554931338;
        bh=vRpziHRw77/PZG0lu2U+YGrhLPzsZCBpVeDGIU+6uAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxbg+7YT2kfk6KrWBy3vfkRSigJJsusW6n0hupyyIDHGuz/qwC6v+CEFA1/DqllSq
         MEm1ZeiiBqiDzH3P0vQsYogz+Kbr4m+YN7AW9LojIocZSNb9k9qPlwE6KJOEYD5LH8
         AtRfjQodxkAGLcksGKvk6J4lUCN+7Yo/XK5ev3cw=
Date:   Wed, 10 Apr 2019 16:22:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Micah Parrish <micah.parrish@hpe.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com, lukas@wunner.de,
        s.miroshnichenko@yadro.com
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190410212216.GI256045@google.com>
References: <20190408195540.GF159318@google.com>
 <e11b4d88-f20d-9989-c249-2f235ef0dc28@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11b4d88-f20d-9989-c249-2f235ef0dc28@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 09, 2019 at 05:41:24PM -0600, Micah Parrish wrote:
> Because this bug affects our Proliant nvme hardware, I would like to request
> the patch be merged to 5.1 and 4.19 longterm.
> 
> I have filed kernel BZ https://bugzilla.kernel.org/show_bug.cgi?id=203237

Thanks, I added that BZ as well as a reported-by and tested-by from you and
moved the patch to my for-linus branch for v5.1.
