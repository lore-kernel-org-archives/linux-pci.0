Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:54128 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbbENLCc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 May 2015 07:02:32 -0400
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <1431589652.4160.49.camel@kernel.crashing.org>
Date: Thu, 14 May 2015 14:02:26 +0300
Cc: Rob Herring <robherring2@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-Id: <A748C569-24CF-41B9-BA91-822A67132DA9@antoniou-consulting.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com> <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com> <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com> <1430493730.7979.58.camel@kernel.crashing.org> <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com> <1430521038.7979.70.camel@kernel.crashing.org> <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com> <1430774063.7979.139.camel@kernel.crashing.org> <1431560124.20218.91.camel@kernel.crashing.org> <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com> <1431564871.4160.8.camel@kernel.crashing.org> <53EAE361-0015-4702-97C6-9F67B87963C2@antoniou-consulting.com> <1431585994.4160.32.camel@kernel.crashing.org> <3988EABE-3DE9-4E1C-9778-22E35138E359@antoniou-consulting.com> <1431587657.4160.37.camel@kernel.crashing.org> <75F026CA-5AC1-4106-B2F0-AB0D006DEF5A@antoniou-consulting.com> <1431588358.4160.42.camel@kernel.crashing.org> <D7FC0542-DD1A-42
 8F-8E75-81620C6D83DC@antoniou-consulting.com> <1431589652.4160.49.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ben,

> On May 14, 2015, at 10:47 , Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 

[snip]

So I spend some time thinking about your use case and I think it boils down
to this:

I have a live tree in the firmware, I have made changes and I need to reflect
those changes to the live tree in the kernel.

Sounds like ‘how do I generate a patch for getting those two in sync'. No?

I can see where this might be useful for others as all.

I think we really need to create a liblivedt like we have libfdt since
we have a number of projects going about using/manipulating DT at runtime.

1. The linux kernel, with it’s own live tree implementation.
2. The device tree compiler (it has a live tree) custom implemented.
3. Your weird and wonderful (or wacky) firmware.
4. u-boot does use DT now, but it does with libfdt. I believe this is suboptimal.
5. barebox does DT as well.

Most of what we want to do with DT can be abstracted in a library I think that
all of those projects can use.

What are your thoughts?

Regards

— Pantelis

