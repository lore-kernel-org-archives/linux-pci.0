Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34069 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcAOUDi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 15:03:38 -0500
Received: by mail-yk0-f177.google.com with SMTP id a85so477294504ykb.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Jan 2016 12:03:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1601152042090.3575@nanos>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost> <alpine.DEB.2.11.1601152042090.3575@nanos>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Jan 2016 12:03:18 -0800
Message-ID: <CAErSpo7yGGr8iRuTJvKqwjJqVELTq35mNyxs9qg-1yhJODvGFQ@mail.gmail.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 11:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 15 Jan 2016, Bjorn Helgaas wrote:
>> +    [bhelgaas: add VMD BAR #defines, factor out vmd_cfg_addr(), whitespace]
>>      Signed-off-by: Keith Busch <keith.busch@intel.com>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Just for the record. You forgot my Acked-bys

Sorry, I added them to the first two patches:

  irqdomain: Export irq_domain_set_info() for module use
  genirq/MSI: Relax msi_domain_alloc() to support parentless MSI irqdomains

Let me know if you intended to ack any of the others, too.

Bjorn
