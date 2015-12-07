Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33804 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbbLGCdd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2015 21:33:33 -0500
MIME-Version: 1.0
In-Reply-To: <5664ED0C.6060706@roeck-us.net>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
 <1449446087.21036.1.camel@kernel.crashing.org> <5664ED0C.6060706@roeck-us.net>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 6 Dec 2015 20:33:13 -0600
Message-ID: <CAL_JsqKWtEkmdDyWKjOFdtgX5wx2f+xfJMFw4jmo05Z5Jo_ZYA@mail.gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling unflatten_dt_node()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Pantelis Antoniou <panto@antoniou-consulting.com>,
	Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 6, 2015 at 8:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/06/2015 03:54 PM, Benjamin Herrenschmidt wrote:
>>
>> On Sun, 2015-12-06 at 14:28 -0600, Rob Herring wrote:
>>>
>>>
>>> Do you plan to respin the OF parts at least soon? There's another
>>> problem Guenter found that of_fdt_unflatten_tree is not re-entrant due
>>> to "depth" being static and this series fixes that. So I'd rather
>>> apply this and avoid adding a mutex if possible.
>>
>>
>> Gavin is on vacation until next year.
>>
>
> That is a bit more than the timeline I am looking for.
>
> Rob, any chance to accept my patch for now ? After all, it can be
> reverted after the rework is complete, and it would be easier
> to apply to earlier kernels.

Yes, will do. It's only 4.1 and later that it should be marked for stable?

Rob
