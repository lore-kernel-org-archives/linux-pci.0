Return-Path: <SRS0=Wepl=PV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C3C43387
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D0E20850
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MW/N4POS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfAMXfP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:35:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34738 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfAMXfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Jan 2019 18:35:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so17460045lje.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Jan 2019 15:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjYM19yOEPsU+ud8BmeG3oivsix/FAcL+sYI9urX9rk=;
        b=MW/N4POSy7TdPq1Ne41HvuwWSN/MkcTZus15aM7ZGhQIjNzJWbNBjiUG7diGgq0dUH
         Ni9AnEopQ2Kkfxx5IScmMHrx0N2UDZyowdGJEdJ6q9H1Ku+BEfWC3CLt2Nj46Spmiqst
         FdMbK2XvPsU4uvSRMAw8VJbxJ8lC+q28P4gT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjYM19yOEPsU+ud8BmeG3oivsix/FAcL+sYI9urX9rk=;
        b=en3rX5nO+AdNNnfvU5wS2iv1BoVyqPNV8sdn9cT6div7UTPrgb83sTB0ESN3X6ckny
         U7VEeFoD/q66OKjxqRQ9M1rZUNcxODsh5+X9LOuRCPoRHnAGwj3oXqFH+RHvX6P5LdQg
         MSIw7SbymqgZOQl8JAZufK0i5lk9XEanPhSzyn9uc3n31tPUST+eLlnyRFze3a/N/DEh
         E0bb8DBoY6ARrTDf78bdma0sp9pe+nO5ZlYD60JdliNaSeX+s9SmfcjlKhYdMq+I0kVx
         LcHsqt+vmzHRs1VcstguPMaOTYwjUN2XcTT/h6I9MCHP7FHh/GwBNwXveEPAWYPdaASF
         kLFQ==
X-Gm-Message-State: AJcUukdHzFvCAMoR27V9dRRe+41piXvGAwNmu2WDuNYXoJqL0NSiO29g
        gLydPjluMFT5NNS1Z42bs401lwuRagxD6RaZQJEG/g==
X-Google-Smtp-Source: ALg8bN4XtCjqiIajtM6DrDZUytYdp9E/E7b6Z7d4cXqSMzj710KzdzYgUDLMZo7mhs6ReDo5+TQNKtIe01hiTmFvcSI=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr12818811ljc.66.1547422513407;
 Sun, 13 Jan 2019 15:35:13 -0800 (PST)
MIME-Version: 1.0
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
In-Reply-To: <20190113154028.GB4635@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 00:35:01 +0100
Message-ID: <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Baruch Siach <baruch@tkos.co.il>, linux-pwm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 13, 2019 at 4:40 PM Andrew Lunn <andrew@lunn.ch> wrote:

> > Another look at this comment made me realize that we need comphy
> > initialization support in the kernel for PCIe reset to work correctly.
> >
> > The workaround that this patch proposes will not solve the problem for
> > v5.0, since the GPIO get_direction patch will only appear in v5.1.
>
> You could ask for it to be applied to v5.0 since a real fix depends on
> it.

If it makes a piece of hardware work that was working before and
now is not working as a result of other kernel changes I would
definately apply it because that is a clear cut regression.

I am under the impression that this is the case?

Yours,
Linus Walleij
