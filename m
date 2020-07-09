Return-Path: <SRS0=o9sU=AU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79DC433E0
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jul 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79406207DD
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jul 2020 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594322698;
	bh=8WabetCgwVG9DllPtJNp//ALDfDm8n6ryWtUjpDnK0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=vYtQSEfnTOMHleR5QKzb7jxEim4+Jlv+Pz7lXZgdaazQQqGElU3lIrUF9ZtPLPwax
	 bqN2YrWg6iMj4D7VGuhAyr8Ooz5ax0Q2Me7/9kquFPDWdt/8Xa3lW6ZaB8zIjflbVJ
	 wCgEKgFq+/WtbwF/IACxmPP8173g3NzbTrvsmEkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGITY6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGITY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 15:24:57 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B00320775;
        Thu,  9 Jul 2020 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594322697;
        bh=8WabetCgwVG9DllPtJNp//ALDfDm8n6ryWtUjpDnK0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=li8p8+EzZG8tGvGkw6YvDyone1lKT93akiLXJnhWtlABghzZKxX8MGMWnVbG/AIy7
         EFZqMUO+IitTkLdaNcljnFLB1lKu08c6NwkOaZDCIbor0ndZBfg3sFUiuW3nU449W7
         5VnfozvoV8wpqnP2zi4K+5yJSgT10GauwUXj9hBM=
Date:   Thu, 9 Jul 2020 14:24:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manish Raturi <raturi.manish@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Dump of registers during endpoint link down
Message-ID: <20200709192455.GA12154@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn-FMy0i=c6jj_yvtQXrKMU5T8F+2AUd79qUw7U98vs9U35hA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 12:44:24PM +0530, Manish Raturi wrote:
> Hi Team,
> 
> I have a generic query , if an hotplug pcie endpoint connected to the
> CPU root port shows link down, then from the debugging perspective
> w.r.t PCIE what all register can be dump during the failure condition,
> what I can think of is these registers from the root port side
> 
> 1) Link status /control/capability
> 2) Slot status /control/capability
> 3) Lane error status registers.
> 
> Anything else we can dump which gives us more insight into the issue.
> Also is there anything by which we can check from PCIE clock
> perspective.

If you have this:

  Root Port ----- Endpoint

and the Link is down, you won't be able to read any registers from the
Endpoint.  You can dump all the Root Port registers, of course, e.g.,
with "lspci -vvvxxxx".
