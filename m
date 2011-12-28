Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42222 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab1L1Fdf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2011 00:33:35 -0500
Received: by vcbfk14 with SMTP id fk14so9318455vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 27 Dec 2011 21:33:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EFAA11F.8060007@windriver.com>
References: <CAEH94LjSjBvXYABrh+W7kcp3z3h5JyFqsZpNv0zB0v1XZZ1+cQ@mail.gmail.com>
	<4EFAA11F.8060007@windriver.com>
Date: Wed, 28 Dec 2011 13:33:34 +0800
Message-ID: <CAEH94Lij6N9Uhiz2AnveJF4y2NcwFvuig-oEteMLu=YFaaELcQ@mail.gmail.com>
Subject: Re: PCI: where pci_user_read_config_byte{word, dword}() is defined?
From: Zhi Yong Wu <zwu.kernel@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Cc: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2011 at 12:54 PM, tiejun.chen <tiejun.chen@windriver.com> wrote:
> Zhi Yong Wu wrote:
>> HI,
>>
>> I want to take a look at how pci_user_read_config_byte{word, dword}()
>> is implemented, but can not find their definitions. Can anyone let me
>> know where their definitions locate?
>
> Refer to drivers/pci/access.c.
I have got this, anyway, thanks.

>
> Tiejun



-- 
Regards,

Zhi Yong Wu
