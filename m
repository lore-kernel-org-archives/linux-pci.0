Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:48432 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab3I0RKc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 13:10:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
References: <1380270519.27811.10.camel@pasglop>
	<CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
Date: Fri, 27 Sep 2013 10:10:32 -0700
Message-ID: <CA+55aFyDfMdAeaniQwkoeW6F-xd3JxrzGYwtFb6N9+NA6aRCMg@mail.gmail.com>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 27, 2013 at 9:01 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> So i would like to use the first way that you suggest : call pci_set_master
> PCIe port driver.

So I have to say, that if we can fix this with just adding a single
new pci_set_master() call, we should do that before we decide to
revert.

If other, bigger issues then come up, we can decide to revert. But if
there's a one-liner fix, let's just do that first, ok?

Mind sending a patch?

             Linus
