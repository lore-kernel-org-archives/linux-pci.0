Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:53759 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3FZFvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 01:51:23 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so30273810iea.32
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 22:51:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130626025001.GA25384@google.com>
References: <20130626025001.GA25384@google.com>
Date: Tue, 25 Jun 2013 22:51:22 -0700
Message-ID: <CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
Subject: Re: Current open PCI defects
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 7:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Here's a list of the current PCI defects open in https://bugzilla.kernel.org
>
> Hint: maintainers really like it when people take the initiative to
> resolve open issues.
>
> Regressions (8 total):

>   57961 ExpressCard hot-remove and hot-add not recognized by acpiphp

for 3.9 stable:
https://patchwork.kernel.org/patch/2676821/

Greg, can you pick that for 3.9.8?

Thanks

Yinghai
