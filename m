Return-Path: <SRS0=gy3g=6T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AADC47254
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBB12084D
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588697059;
	bh=XSouw40XSxJMsUn+OkpO2j16zf164hOmtUD4omR06L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=W/0wNwO9AfwQkrxyRZ0ZfVT+ZGZnCKJqAPX7d9AY1A5plG2ok84aXrqIFe36Z7AAq
	 ql1XVI6yIl/dtxcHXrebQ+i9wOGfKmMxv763tTgteVukv43UKdVQU5vG6fxAHPS7ch
	 7tkF/DQx4OMXkgDwrZMzbJH1uQXOUNy/6+XDrMic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgEEQoT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 May 2020 12:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgEEQoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 12:44:18 -0400
Received: from localhost (mobile-166-175-56-67.mycingular.net [166.175.56.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED1B206CC;
        Tue,  5 May 2020 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588697058;
        bh=XSouw40XSxJMsUn+OkpO2j16zf164hOmtUD4omR06L4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ulek5cyVtH6qIcceVmKvo1UIL7MuZpIrYLO8E1m8fGtePVVKUb8vDbBoNFR443aZE
         ErEu7ZKQHuLDznlpeOM9xLX+tiBY7oVhNDI9752V/XhsTybVguccI4iNAbKzg+aZZt
         QgAPq7U4LRFymloRdti4v3O45wRK5TzJwb6stYbQ=
Date:   Tue, 5 May 2020 11:44:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI / utils: Add acpi_evaluate_reg() helper
Message-ID: <20200505164416.GA365505@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-2-hdegoede@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:26PM +0200, Hans de Goede wrote:
> With a recent fix to the pinctrl-cherryview driver we know have
> 2 drivers open-coding the parameter building / passing for calling
> _REG on an ACPI handle.

s/know/now/
