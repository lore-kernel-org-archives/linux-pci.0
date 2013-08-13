Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:33345 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab3HMLl0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2013 07:41:26 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 13 Aug 2013 17:03:57 +0530
Message-ID: <520A1B5E.8040105@linux.vnet.ibm.com>
Date: Tue, 13 Aug 2013 17:11:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
CC: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
	bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl,
	lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com> <20130812114404.3bd64fa0@samsung.com>
In-Reply-To: <20130812114404.3bd64fa0@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/12/2013 08:14 PM, Mauro Carvalho Chehab wrote:
>> But, this only seems to expose the APEI data as a string
>> and doesn't look to really make all the fields available to user-space
>> in a raw manner. Not sure how well this can be utilised by a user-space
>> tool. Do you have suggestions on how we can do this?
>
> There's already an userspace tool that handes it:
> 	https://git.fedorahosted.org/cgit/rasdaemon.git/
>
> What is missing there on the current version is the bits that would allow
> to translate from APEI way to report an error (memory node, card, module,
> bank, device) into a DIMM label[1].

If I'm reading this right, all APEI data seems to be squashed into a 
string in mc_event. Also, the fru id/text don't seem to be passed to 
user-space.

- Naveen

