Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35499C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9E22086C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfBMRUU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:20:20 -0500
Received: from xes-mad.com ([162.248.234.2]:61727 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbfBMRUU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:20:20 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 12:20:19 EST
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 8C3AB20200;
        Wed, 13 Feb 2019 11:11:09 -0600 (CST)
Date:   Wed, 13 Feb 2019 11:11:09 -0600 (CST)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Message-ID: <64301353.124952.1550077869482.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190130224415.GK229773@google.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com> <1540483292-24049-1-git-send-email-asierra@xes-inc.com> <1540483292-24049-2-git-send-email-asierra@xes-inc.com> <20190130224415.GK229773@google.com>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: Move _OSC test for native services to
 top
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - FF65 (Linux)/8.7.5_GA_1764)
Thread-Topic: PCI/ACPI: Move _OSC test for native services to top
Thread-Index: zkRhSgWv1aakSxQVT17/LpqrJS121A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Wednesday, January 30, 2019 4:44:15 PM
> Subject: Re: [PATCH v2 1/2] PCI/ACPI: Move _OSC test for native services to top

> Hi Aaron,
> 
> On Thu, Oct 25, 2018 at 11:01:31AM -0500, Aaron Sierra wrote:
>> Move the simple test for when PCIe native services are disabled
>> closer to the top, prior to where things get more complicated.
>> 
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> ---
>>  drivers/acpi/pci_root.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 707aafc..eb9f14e 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -441,6 +441,12 @@ static void negotiate_os_control(struct acpi_pci_root
>> *root, int *no_aspm,
>>  		return;
>>  	}
>>  
>> +	if (pcie_ports_disabled) {
>> +		dev_info(&device->dev,
>> +			 "PCIe port services disabled; not requesting _OSC control\n");
>> +		return;
>> +	}
> 
> Today we always set "*no_aspm = 1" if _OSC fails, which means we later
> call pcie_no_aspm().
> 
> After this patch, when pcie_ports_disabled is "true", we don't even try to
> evaluate _OSC, and we will never set *no_aspm, so we will never call
> pcie_no_aspm() when pcie_ports_disabled is "true", which happens in these
> cases:
> 
>  1) CONFIG_PCIEPORTBUS is unset, or
>  2) CONFIG_PCIEPORTBUS=y and we booted with "pcie_ports=compat"
> 
> Case 1) isn't a problem because pcie_no_aspm() is only implemented when
> CONFIG_PCIEASPM=y, and CONFIG_PCIEASPM depends on CONFIG_PCIEPORTBUS, so in
> this case today we only call the empty stub pcie_no_aspm() function.
> 
> But case 2) is a behavior change that seems unintended.
> 
> Even though CONFIG_PCIEASPM depends on CONFIG_PCIEPORTBUS, ASPM doesn't
> actually *use* anything provided by PCIEPORTBUS, so I think the ASPM code
> is still active and useful even when we boot with "pcie_ports=compat".
> 
> Whether CONFIG_PCIEASPM should depend on CONFIG_PCIEPORTBUS is another
> question.  I tend to think maybe it should not, but that's an orthogonal
> question.
> 

Bjorn, thanks for the review. I certainly did not mean to change behavior
to the extent that you describe. This patch is also not really needed by
the second patch in the series, so I will drop this from v3. Sorry for
the noise.

-Aaron
