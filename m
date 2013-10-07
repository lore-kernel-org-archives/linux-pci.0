Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34923 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab3JGDzH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Oct 2013 23:55:07 -0400
Received: by mail-ob0-f170.google.com with SMTP id gq1so978654obb.1
        for <linux-pci@vger.kernel.org>; Sun, 06 Oct 2013 20:55:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo77zy6K3yMa8_31zbrehA6MByXTBbn5Trr8Sv5TL7ScZQ@mail.gmail.com>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
	<CAErSpo77zy6K3yMa8_31zbrehA6MByXTBbn5Trr8Sv5TL7ScZQ@mail.gmail.com>
Date: Mon, 7 Oct 2013 09:25:05 +0530
Message-ID: <CAK9yfHxxxpZx5Yd=nUdNMe2kz_bZupZFdizG2tL3wUffDOkPCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: sysfs: Staticize local symbols
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4 October 2013 23:39, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Sep 28, 2013 at 4:12 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>
>> -struct attribute *pci_bus_attrs[] = {
>> +static struct attribute *pci_bus_attrs[] = {
>
> Did you compile this?  I see this:
>
> drivers/pci/pci-sysfs.c:306:29: error: static declaration of
> ‘pci_bus_attrs’ follows non-static declaration
> drivers/pci/pci.h:159:29: note: previous declaration of ‘pci_bus_attrs’ was here

Hmm.. strange. I did compile both these patches and did not see this
error on my setup.
Infact it was during compilation that I came across the need for this
change and verified it after. However I used
the linux-next tree and not your tree to generate these.

>
> and there is a use in drivers/pci/pci-driver.c.
>
> I applied this (without the pci_bus_attrs hunk) to my pci/misc branch, thanks!

Thanks for taking care of this and sorry for the trouble. I will check
this once again on my setup.

With warm regards,
Sachin
