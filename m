Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2991C433DB
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA67619F2
	for <linux-pci@archiver.kernel.org>; Wed, 24 Mar 2021 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCXLey (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:34:54 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:48434 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCXLe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 07:34:26 -0400
Date:   Wed, 24 Mar 2021 11:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1616585642; bh=KEThvGs8mhCJUE7NWLOhItOB7I4hTptrR+HW935IQCk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=L9mnu1wusvlo5z/k8/W0m0vwLz+p+blybKZ5aTd459zOPr+cU5ol0BWJ86Fb5vceH
         jQ+uOkJgO10PoK82Yql8YQFGFHYIWAi6FqbuavWlRjtg/dTKdClXvX9kO8JZ9uMv/w
         I2jmLOer8UwjQdjZ47KXlh9lCzLg+4FLYHvVsT61fIacfY9GHkcNHP2rM+IP5BMMID
         029uIUgE13CqYFGiJSrOjzm73NG57pEW6agvHoA/xs99stxLEgiwAb2Z4tr0iSWDLV
         SVevpCXD06gWTBJmhnMBvQE2OcWT5cRFgvQAjB1vHq4dzJjpvaPHBmONdNzK6a3qQv
         Hrnr0I5Wr8JjQ==
To:     =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH RESEND] PCI: dwc: put struct dw_pcie::{ep,pp} into a union to reduce its size
Message-ID: <20210324113259.2809-1-alobakin@pm.me>
In-Reply-To: <YFqWftATEbuxsJbn@rocinante>
References: <20210312140116.9453-1-alobakin@pm.me> <YFqWftATEbuxsJbn@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Krzysztof Wilczy=C5=84ski <kw@linux.com>
Date: Wed, 24 Mar 2021 02:31:42 +0100

> Hi Alexander,

Hi!

> Thank you for sending the patch over!
>
> > A single dw_pcie entity can't be a root complex and an endpoint at
> > the same time.
>
> Nice catch!
>
> A small nitpick: this would be Root Complex and Endpoint, as it's
> customary to capitalise these.
>
> Also, if you could capitalise the subject line - it could also perhaps
> be simplified to something like, for example:
>
>   Optimize struct dw_pcie to reduce its size
>
> Feel free to ignore both suggestions, as these are just nitpicks.

They are both correct, so I can send a v2 if this one wont't be
picked to the tree, let's say, this week.

> > We can use this to reduce the size of dw_pcie by 80, from 280 to 200
> > bytes (on x32, guess more on x64), by putting the related embedded
> > structures (struct pcie_port and struct dw_pcie_ep) into a union.
>
> [...]
> > -=09struct pcie_port=09pp;
> > -=09struct dw_pcie_ep=09ep;
> > +=09union {
> > +=09=09struct pcie_port=09pp;
> > +=09=09struct dw_pcie_ep=09ep;
> > +=09};
> [...]
>
> How did you measure the difference?  Often, people include pahole output
> for the "before" and "after", so to speak, to showcase the difference
> and/or improvement.  Do you have something like that handy?

I didn't use pahole to measure the difference, just printed sizeofs
for the structures "before" and "after". But I can get pahole's
output and include it in v2 to make commit message more useful.

> Krzysztof

Thanks!
Al

