Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46327 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab2KMS7j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2012 13:59:39 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so3438072wey.19
        for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 10:59:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50A205C902000078000A7ECF@nat28.tlf.novell.com>
References: <1352781547-9433-1-git-send-email-acooks@gmail.com> <50A205C902000078000A7ECF@nat28.tlf.novell.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 13 Nov 2012 11:59:16 -0700
Message-ID: <CAErSpo4WtLcMwyCHJ5rkJNhc6g-U9A=uaBzBP6HhtGUsRUn8pQ@mail.gmail.com>
Subject: Re: [PATCH] Add missing license for ioapic module.
To: Jan Beulich <JBeulich@suse.com>
Cc: Andrew Cooks <acooks@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 13, 2012 at 12:33 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 13.11.12 at 05:39, Andrew Cooks <acooks@gmail.com> wrote:
>> config PCI_IOAPIC turned into a tristate in commit
>> b95a7bd700466c10fda84acbd33f70cf66ec91ce, but no module license is specified.
>> This adds the missing module license.
>>
>> Signed-off-by: Andrew Cooks <acooks@gmail.com>
>
> Acked-by: Jan Beulich <jbeulich@suse.com>

I applied this to my pci/misc branch as v3.8 material.  Thanks!

Bjorn
