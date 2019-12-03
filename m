Return-Path: <SRS0=tXem=ZZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FEBC432C0
	for <linux-pci@archiver.kernel.org>; Tue,  3 Dec 2019 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63168206EC
	for <linux-pci@archiver.kernel.org>; Tue,  3 Dec 2019 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575382040;
	bh=EGatAtFBvrsjDjApk6awgNmJq6Jgdwl6aS4KaCqWoYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GMXuPjowT9zmwNDDNwvjSRz2efaZEKJso/+3H6P0pRcpGsxC0Cn2O0OPgTJnri6Ol
	 K5qRPECrTcM+wHw/oRCXwMLD0nr3CnjtT8DSn3b5SZUWNURzndQ7wNH2MyGgxluvJq
	 gcr7tEHKRZpm92Gw4cUnT3i/U5wE4QNhxBBrMGEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCOHT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfLCOHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 09:07:19 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB04206EC
        for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2019 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575382038;
        bh=EGatAtFBvrsjDjApk6awgNmJq6Jgdwl6aS4KaCqWoYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u3TfvUXpKObuZK9w49dj6dDQe/oFM76ROu2At20o6n9Nlqbx6zWJprI/08f/pI/CC
         PFhpwYpVAHADsd9nv/4Gn0gZ7Rvwi6iu3OOa8S5fvPjcFovqp7LcgeaSPdP1RXLLqM
         p7Xg8VY6G94o5h63M/6joq/+yo82OKYdGsHpI/E8=
Received: by mail-qt1-f171.google.com with SMTP id z22so3833104qto.7
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 06:07:18 -0800 (PST)
X-Gm-Message-State: APjAAAWfRnHWfTn/+4eEc9wBXnT30vTFH1LQmc+7VtKN9CH33uMf8Ui4
        Qt2dkEMBl3VmYkfTWjvwDo+vyBO0ucP57YrmAIw=
X-Google-Smtp-Source: APXvYqzpiINkhxGJ+qJ8A++X8HXmCEFmVBfYySmTwUdSHuxL74sWpsm4uhlynLHgPakJm0GS2RM4grVFguCEh1WVCh8=
X-Received: by 2002:ac8:7948:: with SMTP id r8mr4872148qtt.91.1575382028983;
 Tue, 03 Dec 2019 06:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20191115135842.119621-1-wei.liu@kernel.org> <20191126230524.GA197236@google.com>
 <CAHd7Wqw49hB3++Td00=xccgJoqPLye_DvYv8+PYjxHWbDm5DVg@mail.gmail.com>
In-Reply-To: <CAHd7Wqw49hB3++Td00=xccgJoqPLye_DvYv8+PYjxHWbDm5DVg@mail.gmail.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Tue, 3 Dec 2019 14:06:57 +0000
X-Gmail-Original-Message-ID: <CAHd7Wqw56pPXFgvk+vNnrMCeVow6Op2mXONiqHs4C9NrMfS=VQ@mail.gmail.com>
Message-ID: <CAHd7Wqw56pPXFgvk+vNnrMCeVow6Op2mXONiqHs4C9NrMfS=VQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 27 Nov 2019 at 10:59, Wei Liu <wei.liu@kernel.org> wrote:
>
> On Tue, 26 Nov 2019 at 23:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> > > CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> > > in.  Removing the ifdef will allow us to build the driver as a module.
> > >
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >
> > Sorry, I missed this thinking it would be under drivers/pci/controller
> > and hence handled by Lorenzo.
> >
> > So I guess this doesn't fix a build problem, but without this patch,
> > we just don't run the quirk if the driver is a module, right?
> >
>
> Yes, this is correct.
>
> Without this patch, the quirk doesn't get to run if the driver is a module.
>

Hi Bjorn

Are you satisfied with the patch? What do I need to do to get it merged?

Thanks,
Wei.
