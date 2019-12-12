Return-Path: <SRS0=/6ym=2C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8BC43603
	for <linux-pci@archiver.kernel.org>; Thu, 12 Dec 2019 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7712067C
	for <linux-pci@archiver.kernel.org>; Thu, 12 Dec 2019 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576146799;
	bh=LPJsO6nRqqP9PFe1FLl6uMOPGS5DIg2YqlMaCPg5MAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NefyTvJB2odURKu5mx5+LJYFDx68Ri3+MlOGyf+SP/R+5cPJwDdji4WIg/4OCOSeu
	 VU9tLLb/9D+jzbQiTBL8jx4k8FtXYo58uyaEnCLLlIUyEeFrbXspI4CSsuRL43fl/g
	 7I8mNIEDHacJvvqBqjUxzCQ/WZtVd9QD/Q6SCvyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfLLKdT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLLKdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 05:33:19 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F042173E
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2019 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576146798;
        bh=LPJsO6nRqqP9PFe1FLl6uMOPGS5DIg2YqlMaCPg5MAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w0u5g0UzUOl8KmSN0Vk2h+Tl5MOn8iqrYXqfS3FFPR0TUwPpK4Y8jxcwHMjqcpiXH
         983ugN4wR9nZG+gaqSfhdS4XDKekXMtlEdHn8cgdxIWj3OFudei/wVoilvrFpZEtPi
         JKxRHpzmsUR9zoIwOkaCzfZOaCO2zxciUdN36Qmk=
Received: by mail-qt1-f174.google.com with SMTP id z15so1854018qts.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2019 02:33:18 -0800 (PST)
X-Gm-Message-State: APjAAAUPJR1sJSL9mz3aVlLd6S4rWwhM+PM8flJ1a1tKCuHj5BJaCDYr
        RWib38LKRWQYh+6qxjTSkJWfpFH2H8/OxoFh2ig=
X-Google-Smtp-Source: APXvYqy6nOfBOXcJE7VRnXXrvhryEyoTK+jymB2zrBL+R3G47BUA4e6cYKHwbgKltFfCUd5b+0vXkmJxsZEppgvGAM4=
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr6943809qta.112.1576146797564;
 Thu, 12 Dec 2019 02:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20191211223438.GA121846@google.com> <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
 <CABhMZUU82iRD67yQhpUG3MUx3s9WaZ=tAXA=QriEEjUkNbu22w@mail.gmail.com> <8983ae6c-36ac-7acc-5caa-2d11bf593d44@broadcom.com>
In-Reply-To: <8983ae6c-36ac-7acc-5caa-2d11bf593d44@broadcom.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Thu, 12 Dec 2019 10:33:05 +0000
X-Gmail-Original-Message-ID: <CAHd7Wqy=R7LHefrqFgjVirQ4CCfrNY1pwD4LULc5im22RmQ-ZQ@mail.gmail.com>
Message-ID: <CAHd7Wqy=R7LHefrqFgjVirQ4CCfrNY1pwD4LULc5im22RmQ-ZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <helgaas@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com, Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Dec 2019 at 00:05, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 12/11/19 4:02 PM, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2019 at 5:40 PM Ray Jui <ray.jui@broadcom.com> wrote:
> >>
> >>
> >>
> >> On 12/11/19 2:34 PM, Bjorn Helgaas wrote:
> >>> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
> >>>> The quirks were originally enclosed by ifdef. That made the quirks not
> >>>> to be applied when respective drivers were compiled as modules.
> >>>>
> >>>> Move the quirks to driver code to fix the issue.
> >>>>
> >>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >>>
> >>> This straddles the core and native driver boundary, so I applied it to
> >>> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
> >>> always nice when we can encapsulate device-specific things in a
> >>> driver.
> >>>
> >>
> >> Opps! I was going to review and comment and you are quick, :)
> >>
> >> I was going to say, I think it's better to keep this quirk in
> >> "pcie-iproc.c" instead of "pcie-iproc-platform.c".
> >>
> >> The quirk is specific to certain PCIe devices under iProc (activated
> >> based on device ID), but should not be tied to a specific bus
> >> architecture (i.e., platform vs BCMA).
> >
> > I'm happy to move it; that's no problem.
> >
>
> Thanks, Bjorn!

Thank you both.

Wei.
