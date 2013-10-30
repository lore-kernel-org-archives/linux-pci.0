Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55673 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab3J3QHS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 12:07:18 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so2628234iec.38
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 09:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6n4F1zREyYXuwq9LCRLCD+yZ9o8j==ANamiAZesFz=EA@mail.gmail.com>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
 <1382346403-29576-2-git-send-email-sachin.kamat@linaro.org> <CAErSpo6n4F1zREyYXuwq9LCRLCD+yZ9o8j==ANamiAZesFz=EA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Oct 2013 10:06:58 -0600
Message-ID: <CAErSpo4CFitR_CbG+TBYF-S-nKLdz9+CfV2mex76b=pnh24Vqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Remove redeundant of_match_ptr
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 29, 2013 at 4:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Jason]
>
> On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
>> not required.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> Jason, I assume you'll merge this if you want it.

BTW, Jason, if you think of it, fix the typo in the subject
(s/redeundant/redundant/).  It was correct for the exynos patch, but
wrong for the mvebu and imx6 patches.

>> ---
>>  drivers/pci/host/pci-mvebu.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
>> index 20c470c..7adae6e 100644
>> --- a/drivers/pci/host/pci-mvebu.c
>> +++ b/drivers/pci/host/pci-mvebu.c
>> @@ -1016,8 +1016,7 @@ static struct platform_driver mvebu_pcie_driver = {
>>         .driver = {
>>                 .owner = THIS_MODULE,
>>                 .name = "mvebu-pcie",
>> -               .of_match_table =
>> -                  of_match_ptr(mvebu_pcie_of_match_table),
>> +               .of_match_table = mvebu_pcie_of_match_table,
>>                 /* driver unloading/unbinding currently not supported */
>>                 .suppress_bind_attrs = true,
>>         },
>> --
>> 1.7.9.5
>>
