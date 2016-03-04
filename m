Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:36486 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcCDGNw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2016 01:13:52 -0500
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr() on ARM
References: <m337sapw89.fsf@t19.piap.pl> <20160303173522.GA9189@localhost>
Date: Fri, 04 Mar 2016 07:13:49 +0100
In-Reply-To: <20160303173522.GA9189@localhost> (Bjorn Helgaas's message of
	"Thu, 3 Mar 2016 11:35:22 -0600")
Message-ID: <m38u1yojmq.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Tue, Mar 01, 2016 at 07:07:18AM +0100, Krzysztof Hałasa wrote:
>> Many ARM platforms use a wrapper:
>> /*
>>  * Compatibility wrapper for older platforms that do not care about
>>  * passing the parent device.
>>  */
>> static inline void pci_common_init(struct hw_pci *hw)
>> {
>>         pci_common_init_dev(NULL, hw);
>> }
>> 
>> which means that pci_bus_assign_domain_nr() can be called without
>> a parent. This patch fixes the NULL pointer dereference.
>
> What exactly is the impact of this?  Does this fix need to be in v4.5?
> It sounds like it should be, but I need a little more detailed
> justification, e.g., "platforms X, Y, Z don't boot at all without
> this change."

At least CNS3xxx doesn't boot. I haven't verified a couple of others,
but they may be broken as well.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
