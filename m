Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:47904
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751771AbaKKPs5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Nov 2014 10:48:57 -0500
Message-ID: <54622C58.1040701@amd.com>
Date: Tue, 11 Nov 2014 22:33:44 +0700
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20141111112424.GB16265@arm.com>
In-Reply-To: <20141111112424.GB16265@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/14 18:24, Will Deacon wrote:
>> @@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
>> >  		return err;
>> >  	}
>> >
>> >+	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
>> >+						  "msi-parent", 0));
> This bit should be in the generic of_pci.c code and not duplicated for
> each host controller.
>
> Will

I forgot to mention and include in the patch that we are also 
introducing "msi-parent" binding to the generic host controller. I'll do 
that in v2.

Unless this is something that we would like to add to the generic OF 
binding for PCI, I think it should be in the pci-host-generic.c.

Thanks,
Suravee
