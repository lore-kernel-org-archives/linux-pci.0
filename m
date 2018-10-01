Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2768DC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 04:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF45F2084C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 04:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="zKrK+SqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF45F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeJALdQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 07:33:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44742 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeJALdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 07:33:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id g184-v6so7304227qkc.11
        for <linux-pci@vger.kernel.org>; Sun, 30 Sep 2018 21:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnrjBvxLkgEYqcoy4gP3bz3vkNJm9uQLA53NunoyuBk=;
        b=zKrK+SqCw0pXqtxApE8AZ6kpFcMmAAF0VugdUfcdSrp8elS80jJnue3yDLnBjgXn8A
         MH3l626cilo7fTZO/DvyDpPh6LrY7KT4kSMdhQWxn9k5R5RvSbR+yHfqlOsMXYHgqw+q
         USpViqU4f8ugY/v6e5cXx6o/gSXGb/IiITZHuoddfVUYCFKwGL1RsX2J9ggD8erjlgRQ
         37ck3pAhAtVFtJjWuSNHAydMuLz/rGrCLSm6p/RS44Jj4U71QO6xAsnzNZt7dF1tCUBo
         w5P81zR1Ikb3JJ3cYj60oU7cLAmGGh2Zt+Fk+6q3U8KZ7HDT84Xkq6WNfkn0p69HjVRo
         aNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnrjBvxLkgEYqcoy4gP3bz3vkNJm9uQLA53NunoyuBk=;
        b=hUV7eXbTquT/DKk1ECuVlOx6Xx3K2pQ+zZ2ZnviNgxRgYn3sSgOMT6v1fewLmJ5QQu
         gCxEPYVJQMOAPsKPUNRh4UoP4Ce0U2XgxaM4VNa+Qj7kBdZr1CtvrhZYal34edeFdU4p
         YuBXr1fSqt4ZYzMEOdV3yecNTXtbKNo9If5acffP829rliNUktlTiQZtUW/2FH+fDgAR
         KTEbn9hn+5kiP3mNAVKYCBXzWtMqWszYHtgOWqSLOj69I92gijAAPgjUztD8J7Ko3Ot+
         6lyz0icAguwTbJrXRKujXzH+Wp0EGrQzB4ZBampeRIng9rWDfjluLmJKrt2ZmKPHdUKq
         eVBw==
X-Gm-Message-State: ABuFfoiZu7QmAOrPZaMd80ca41Z7cx3RjdS1/sex+ePQ9/5BFQPcvZey
        0OA0LuAEKdctQRLjP0olz7M8VM/T6ZjoifBj/0EnwQ==
X-Google-Smtp-Source: ACcGV62AH/lpTJqfs7LctyFks9p2g1nLlHZ/w5vWgh3mI0EGsxzcvvOiwWgzTwkWcJViUyEW+7rFMBKXETX29hwPYL0=
X-Received: by 2002:a37:1f88:: with SMTP id n8-v6mr7012136qkh.64.1538369842479;
 Sun, 30 Sep 2018 21:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180913033745.11178-1-drake@endlessm.com> <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com> <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
In-Reply-To: <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 1 Oct 2018 12:57:11 +0800
Message-ID: <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
To:     Thomas Martitz <kugel@rockbox.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, nic_swsd@realtek.com,
        rchang@marvell.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
> The latest iteration does not work on my HP system. The GPU fails to
> power up just like the unpatched kernel.

That's weird, I would not expect a behaviour change in the latest
patch. pci_restore_config_dword() has some debug messages, could you
please make them visible and show logs again?
Also remind us of the PCI device address of the parent bridge (lspci -vt)

Thanks
Daniel
