Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:39035 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbCIXfb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 19:35:31 -0400
Received: by qgdq107 with SMTP id q107so32686902qgd.6
        for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2015 16:35:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54FD8F94.20305@samsung.com>
References: <54FD8F94.20305@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Mar 2015 18:35:10 -0500
Message-ID: <CAErSpo6jOJUcvStVk=9=xUBb7E2E-MCRcFqBmV1o0X2pULAW6Q@mail.gmail.com>
Subject: Re: [RFC] Build with arm64 configuration
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 9, 2015 at 7:18 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> I have a question for building arm64.
> (Actually, i didn't have many knowledges for PCIe.)
> When i built with arm64 configuration, then i always found the compiler errors.

The kernel does build for arm64, so you'll have to be more specific
about the problem you're seeing.

> Since some header file has dependency on structure of architecture.
> I think it's not solution that it copies from arch/arm/... to arch/arm64/...
>
> So i want to get advise at mailing. how can i solve it?
> If my understanding is right, after enabled PCIe at bootloader, then it bridges at kernel. right?

I don't know how to parse this question.  Can you rephrase it?

Bjorn
