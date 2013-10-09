Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64612 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3JIDAo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 23:00:44 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so363107pab.11
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 20:00:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6nO_t9HOZt8Z7S8Ca7yKjntWJWEg7uON05LmvHWEieZA@mail.gmail.com>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
	<1380363121-1977-2-git-send-email-sachin.kamat@linaro.org>
	<CAErSpo6nO_t9HOZt8Z7S8Ca7yKjntWJWEg7uON05LmvHWEieZA@mail.gmail.com>
Date: Wed, 9 Oct 2013 08:30:43 +0530
Message-ID: <CAK9yfHwpB-ae1ax-D9cMr+Mg3gmbXxhyTv8EaaGVrqHrQZ6Dkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: driver: Staticize pci_dev_pm_ops
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4 October 2013 23:39, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Sep 28, 2013 at 4:12 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> 'pci_dev_pm_ops' is local to this file. Make it static.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Applied to pci/misc, thanks!

Looks like this branch hasn't been pushed out yet.

-- 
With warm regards,
Sachin
