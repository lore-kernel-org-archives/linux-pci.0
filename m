Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:36519 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbENAZB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 20:25:01 -0400
Received: by yhrr66 with SMTP id r66so18659418yhr.3
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 17:25:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431560124.20218.91.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org> <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org> <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org> <1431560124.20218.91.camel@kernel.crashing.org>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 13 May 2015 19:18:37 -0500
Message-ID: <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 13, 2015 at 6:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-05-05 at 07:14 +1000, Benjamin Herrenschmidt wrote:
>> So the "trivial" way to do it (and the way we have implemented the FW
>> side so far) is to have the FW simply "flatten" the subtree below the
>> slot and pass it to Linux, with the intent of expanding it back below
>> the slot node.
>>
>> This is what Gavin proposed patches do.
>>
>> The overlay mechanism adds all sorts of features that we don't seen to
>> need and would make the above more complex.
>
> Guys, I never got a final answer from you on this. Are we ok with adding
> the way to just expand a subtree or are you insistent we need to use the
> overlap mechanism ?

I haven't decided really.

The main thing with the current patch is I don't really like the added
complexity to unflatten_dt_node. It is already a fairly complex
function. Perhaps removing of "hybrid" as discussed will help?

If there are things we can do to make overlays easier to use in your
use case, I'd like to hear ideas. I don't really buy that being more
complex than needed is an obstacle. That is very often the case to
have common, scale-able solutions. I want to see a simple case be
simple to support.

Rob
