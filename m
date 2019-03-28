Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E69C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFBD20700
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 10:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UuqaO2EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfC1Kz7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:55:59 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40898 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1Kz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 06:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553770558; x=1585306558;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rDDlBVtCxpiKMvMhBxNC8z7ui2t4Kib6q0KlPK99CVE=;
  b=UuqaO2EAjg9gF54vY7bHmz2TFl2uV2lyG1Cf2A8oPAfjB5c5TY72GgHf
   n3rweGfeLn5JGv6oYlOGsGhPcUV6RVDesinKmnqPY0n82IGuQhbHeMDaN
   onskoslk+LTlpLS0NSbWw7SaakIQFDQfaFog3f0X4sqk8e+KB4l40Rj+p
   w=;
X-IronPort-AV: E=Sophos;i="5.60,280,1549929600"; 
   d="scan'208";a="393427394"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Mar 2019 10:55:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2SAtot9033886
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Mar 2019 10:55:55 GMT
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Mar 2019 10:55:55 +0000
Received: from [10.55.99.41] (10.43.162.111) by EX13D13UWA001.ant.amazon.com
 (10.43.160.136) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Mar
 2019 10:55:51 +0000
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>, <vaerov@amazon.com>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <zeev@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
 <20190326125508.GG24180@google.com>
From:   Jonathan Chocron <jonnyc@amazon.com>
Message-ID: <7a1c1611-bd88-de5e-c4ae-bc85113191b6@amazon.com>
Date:   Thu, 28 Mar 2019 12:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326125508.GG24180@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.111]
X-ClientProxiedBy: EX13D25UWC004.ant.amazon.com (10.43.162.201) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/26/19 14:55, Bjorn Helgaas wrote:
> Nits, probably Lorenzo will fix them up unless he sees more substantive
> things.
>
> On Tue, Mar 26, 2019 at 12:00:55PM +0200, Jonathan Chocron wrote:
>> Adding support for Amazon's Annapurna Labs PCIe driver.
> Ideally, use "imperative mood", i.e., write it as a command:
>
>    Add support for Amazon's Annapurna Labs PCIe driver.
Done.
>> The HW controller is based on DesignWare's IP.
>>
>> The HW doesn't support accessing the Root Port's config space via
>> ECAM, so we obtain its base address via an AMZN0001 device.
>>
>> Furthermore, the DesignWare PCIe controller doesn't filter out
>> config transactions sent to devices 1 and up on its bus, so they
>> are filtered by the driver.
>> All subordinate buses do support ECAM access.
> I didn't communicate my point very clearly.  The above four lines
> should either be (1) a single paragraph, wrapped to fill the entire
> width, or (2) two paragraphs, with a blank line before "All
> subordinate buses ..."
>
> The fact that "... by the driver" ends in the middle of the line
> suggests that it's the end of the paragraph, but the fact that there's
> no blank line following suggests that it's not.  So it creates an
> unnecessary hiccup for the reader.
Added a blank line.
>> Implementing specific PCI config access functions involves:
>>   - Adding an init function to obtain the Root Port's base address
>>     from an AMZN0001 device.
>>   - Adding a new entry in the mcfg quirk array
> s/mcfg/MCFG/ since "MCFG" is an ACPI table ID, not a word.
Done.
> Bjorn


