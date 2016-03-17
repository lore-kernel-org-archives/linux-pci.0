Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35855 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbcCQNbh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2016 09:31:37 -0400
MIME-Version: 1.0
In-Reply-To: <20160308005633.GA30023@gwshan>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
 <20160219031655.GA10818@gwshan> <CAL_JsqJFacEMD6jwi=YsT83BTVp5Asjmw4nYU6Msct-DcR2W9Q@mail.gmail.com>
 <20160308005633.GA30023@gwshan>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 17 Mar 2016 08:31:16 -0500
Message-ID: <CAL_Jsq+2M3iLMCwJhttiL3BTvefUa_5tUiYqvzp3Aix4uK7exw@mail.gmail.com>
Subject: Re: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 7, 2016 at 6:56 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Tue, Mar 01, 2016 at 08:40:12PM -0600, Rob Herring wrote:
>>On Thu, Feb 18, 2016 at 9:16 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> On Wed, Feb 17, 2016 at 08:59:53AM -0600, Rob Herring wrote:
>>>>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>>>> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
>>>>> populates multiple device nodes from FDT blob. No logical changes
>>>>> introduced.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>> ---
>>>>>  drivers/of/fdt.c | 14 +++++++-------
>>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>>Acked-by: Rob Herring <robh@kernel.org>
>>>>
>>>>I'm happy to take patches 40-42 for 4.6 if the rest of the series
>>>>doesn't go in given they fix a separate problem. I just need to know
>>>>soon (or at least they need to go into -next soon).
>>>>
>>>
>>> Thanks for quick response, Rob. It depends how much comments I will
>>> receive for the powerpc/powernv part. Except that, all parts including
>>> this one have been ack'ed. I can discuss it with Michael Ellerman.
>>> By the way, how soon you need the decision to merge 40-42? If that's
>>> one or two weeks later, I don't think the reivew on the whole series
>>> can be done.
>>
>>Well, it's been 2 weeks now. I need to know this week.
>>
>>> Also, I think you probably can merge 40-44 as they're all about
>>> fdt.c. If they can be merged at one time, I needn't bother (cc)
>>> you again if I need send a updated revision. Thanks for your
>>> review.
>>
>>I did not include 43 and 44 as they are only needed for the rest of your series.
>>
>
> Rob, sorry for late reponse. I really expect this series to be merged to 4.6 and
> I was checking reviewers' bandwidth to review it. Unfortunately, I didn't receive
> any comments except yours until now. That means this series has to miss 4.6. Please
> pick/merge 41 and 42 if no body has objection. Thanks again for your time on this.

Too late for 4.6.

Rob
