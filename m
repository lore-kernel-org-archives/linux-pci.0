Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B73C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63AD20851
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfAQQe2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:34:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32918 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQQe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 11:34:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so6387625qkj.0;
        Thu, 17 Jan 2019 08:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUO7lExNQVYdMiiSDFiWk5Lp0j1l6DWAJJFEEl3Aahk=;
        b=DUQsi8Me/LivjJFnPZ1+MA5QkBLgnSoN9PjxQcjpU2AYszRTSISnPtwlOXjxB1ripD
         wbqexaXLzQg4m8YNlQXHq0R6hbkQhKw8/oQC3X5868F3sT4dN5rbBS76ruAL51iJodgT
         VtB2PWrZ975UGO9SATUuW9OygvvPqGeEX5LYbLyWbxSnbfvC1PdRPAXN1tDeo2V59uHt
         5WzvBn1O6hcEmROgxM8PV0JFFap3cGtb1CE+dzax7Ck57DAYLIS9IAfkski2RDQ0lN96
         GHTGa9VdX31cEXjWPfc05fWkoCR0qA8GIO0e3DvOgEBjmTqRx9RJjVzM1jGr6/HJz5oU
         q2XQ==
X-Gm-Message-State: AJcUukcd1yJfGEk54PvhIx2LN/zdvXmBQc6ayNd5W96io5DExGD4wxzm
        b1b/rfriJP+Qbrgs2NvDoAbG61bED+0OFqQGJoo=
X-Google-Smtp-Source: ALg8bN7uzTOGwhhASLlM7aRXMlET30fleysyAgvuNFSq8k0HgcIGlnz60xrkuROnjPDwQ7+P26YkjVvwikBmypkQRxE=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr11338192qkf.330.1547742866885;
 Thu, 17 Jan 2019 08:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com> <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
 <20190117162601.tbmi4ounrnktzjga@axis.com>
In-Reply-To: <20190117162601.tbmi4ounrnktzjga@axis.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 17:34:10 +0100
Message-ID: <CAK8P3a3qoxXZqrAuusw++dAU8csHDLHkPNhojjO0AF3FL3jZBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 5:26 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
> On Thu, Jan 17, 2019 at 04:53:25PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 17, 2019 at 4:19 PM Vincent Whitchurch

> > Ok, this seems fine so far. So the vop-host-backend is a regular PCI
> > driver that implements the VOP protocol from the host side, and it
> > can talk to either a MIC, or another guest-backend written for the PCI-EP
> > framework to implement the same protocol, right?
>
> Yes, but just to clarify:  the placement of the device page and the way
> to communicate the location of the device page address and any other
> information needed by the guest-backend are hardware-specific so there
> is no generic vop-host-backend implementation which can talk to both a
> MIC and to something else.

I'm not sure I understand what is hardware specific about it. Shouldn't
it be possible to define at least a vop-host-backend that could work with
any guest-backend running on the PCI-EP framework?

This may have to be different from the interface used on MIC, but
generally speaking that is what I expect from a PCI device.

       Arnd
