Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61501C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298EC2084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298EC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLLJje (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:39:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55999 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbeLLJje (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 04:39:34 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ECEFFF80C1759;
        Wed, 12 Dec 2018 17:39:31 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 12 Dec 2018
 17:39:25 +0800
Date:   Wed, 12 Dec 2018 09:39:14 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     <linux-pci@vger.kernel.org>, <x86@kernel.org>,
        <helgaas@kernel.org>, <linuxarm@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <martin@geanix.com>
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20181212093914.00002aed@huawei.com>
In-Reply-To: <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
References: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
        <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Dec 2018 10:19:49 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 12/11/18 1:47 AM, Jonathan Cameron wrote:
> > When the PCI code later comes along and calls acpi_get_node() for any PCI
> > card below the root port, it navigates up the ACPI tree until it finds the
> > _PXM value in the root port. This value is then passed to
> > acpi_map_pxm_to_node().
> > 
> > As numa_off has not been set on x86 it tries to allocate a NUMA node, from
> > the unused set, without setting up all the infrastructure that would
> > normally accompany such a call.   
> 
> FWIW, this _sounds_ like the real problem here.  We're allowing an
> allocation to proceed without some infrastructure that we require.
> Shouldn't we be detecting that this infrastructure is not in place and
> warn about *it* at least?
> 
> I'm a bit worried that this is just papering over an unknown error to
> make a hang go away.  It seems a bit too far away from the root cause.

I'm not totally convinced.  We are warning about it on the two lines just off the
top of this patch.

"No NUMA configuration found"
"Faking a node at [mem....]"

We are falling back to the exact same code paths as if you had deliberately
turned off NUMA at the command line with messages stating that is the case.
That approach seems to be safe and is consistent.

Now there is a potential corner here where I agree with you that it may
make sense to 'also' add protections in the acpi_map_pxm_to_node() path
which is that where we do have a valid NUMA configuration and along comes
a new device with a node outside of those that are defined,
(note there is a change coming in next ACPI precisely to work around a case
that causes this to validly happen when the OS sees some new features and
doesn't know what to do with them - it still relies on the ACPI tables
having the right magic in them though for the fallback to work - more
on that when the spec is out...).

One option would be to (in addition to this patch) add a new version of
acpi_get_node that will only give you a node that actually exists
and an error otherwise allowing code to fallback to to NO_NODE.

Other than the error we might be able to use acpi_map_pxm_to_online_node
for this, or call both acpi_map_pxm_to_node and acpi_map_pxm_to_online_node
and compare the answers to verify we are getting the node we want?

Jonathan

