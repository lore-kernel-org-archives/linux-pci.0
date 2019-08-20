Return-Path: <SRS0=u+Tb=WQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD8C3A589
	for <linux-pci@archiver.kernel.org>; Tue, 20 Aug 2019 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E8422DD6
	for <linux-pci@archiver.kernel.org>; Tue, 20 Aug 2019 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566334128;
	bh=peTOprTSNKN91AIRo5AL4yoNB2QzHqj8+ADn6ARi+ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M7voMLMrtEOsxvoGuEFG4Novd9j9GRFFSF3Nz7nU02mpFfIYfa9RmYyMJW1bwDmS/
	 SEZerrplsKiSljzlHeurOcXrGuOyspHNJRztKFA4ovYe5PQgGnypoCpbyePvEy3qXf
	 16Z+PU7zuM9Trh0e+ec4iN1Ov1q8NnirkEiKmugw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTUss (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfHTUss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 16:48:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF1E22DD3;
        Tue, 20 Aug 2019 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566334127;
        bh=peTOprTSNKN91AIRo5AL4yoNB2QzHqj8+ADn6ARi+ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DvEK0GTkQzfjMUG8wTzNClG9n4qxmDXMYtNqIZDCHW1zGVKMmUMZjxmEVwbNMZyt
         UIAS8/ZrUkT/uc6yRTTZWfiesEABMTTPrUEiswKsSyxU0WgV/iw+7+xPKqXPEsdxFd
         ZbDn3cnaWjXOMswTE6AzNNa1JOQP1I7PB5SeCNMc=
Date:   Tue, 20 Aug 2019 15:48:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
Message-ID: <20190820204845.GD14450@google.com>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com>
 <20190820103400.GY253360@google.com>
 <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com>
 <20190820193252.GB14450@google.com>
 <CACK8Z6GuzQAoSnDD9chC9yXrPrc3FTtzkiDXMTXdY4MnePgj8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GuzQAoSnDD9chC9yXrPrc3FTtzkiDXMTXdY4MnePgj8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 12:51:09PM -0700, Rajat Jain wrote:
> 
> May be we're digressing now, but I'd like to point out that there is
> atleast one more file in ASPM that potentially violates the "1 value
> per file" rule:
> 
> rajatja@rajat2:/sys/module/pcie_aspm/parameters$ cat policy
> [default] performance powersave powersupersave
> rajatja@rajat2:/sys/module/pcie_aspm/parameters$
> 
> ... although I would argue in this case that it makes it much clear
> what are the allowable values to write, and which is the current
> selected one.

Huh, that's a good point.  That "policy" file is a little problematic
for several reasons, one being the config options
(CONFIG_PCIEASPM_PERFORMANCE, CONFIG_PCIEASPM_POWERSAVE, etc) that
lock a distro into some default choice.

Maybe there's something we can do there, although there's legacy use
to consider (there are a zillion web pages that document
pcie_aspm/parameters/policy as a way to fix things), and it's
certainly beyond the scope of *this* series.

Bjorn
