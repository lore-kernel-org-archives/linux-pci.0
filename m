Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:33593 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcDTC6b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 22:58:31 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 20 Apr 2016 12:58:27 +1000
Date: Wed, 20 Apr 2016 12:38:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
Message-ID: <20160420023848.GB3754@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 08:30:42AM -0600, Rob Herring wrote:
>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> The function unflatten_dt_node() is called recursively to unflatten
>> device nodes and properties in the FDT blob. It looks complicated
>> and hard to be understood.
>>
>> This splits the function into 3 functions: populate_properties(),
>> populate_node() and unflatten_dt_node(). populate_properties(),
>> which is called by populate_node(), creates properties for the
>> indicated device node. The later one creates the device nodes
>> from FDT blob. populate_node() gets the offset in FDT blob for
>> next device nodes and then calls populate_node(). No logical
>> changes introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/of/fdt.c | 249 ++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 147 insertions(+), 102 deletions(-)
>
>One nit, otherwise:
>
>Acked-by: Rob Herring <robh@kernel.org>
>
>[...]
>
>> +               /* And we process the "ibm,phandle" property
>> +                * used in pSeries dynamic device tree
>> +                * stuff
>> +                */
>> +               if (!strcmp(pname, "ibm,phandle"))
>> +                       np->phandle = be32_to_cpup(val);
>> +
>> +               pp->name   = (char *)pname;
>> +               pp->length = sz;
>> +               pp->value  = (__be32 *)val;
>
>This cast should not be needed.
>

Rob, very sorry to response so lately. I will fix it up in next revision.

>> +               *pprev     = pp;
>> +               pprev      = &pp->next;
>> +       }
>

