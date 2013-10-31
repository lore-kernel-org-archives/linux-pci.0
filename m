Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36710 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3JaDZW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 23:25:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so2443396obb.17
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 20:25:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4CFitR_CbG+TBYF-S-nKLdz9+CfV2mex76b=pnh24Vqw@mail.gmail.com>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
	<1382346403-29576-2-git-send-email-sachin.kamat@linaro.org>
	<CAErSpo6n4F1zREyYXuwq9LCRLCD+yZ9o8j==ANamiAZesFz=EA@mail.gmail.com>
	<CAErSpo4CFitR_CbG+TBYF-S-nKLdz9+CfV2mex76b=pnh24Vqw@mail.gmail.com>
Date: Thu, 31 Oct 2013 08:55:22 +0530
Message-ID: <CAK9yfHyTUdgS8-DUVn+1rUQ7aADRNJ+Y+n+qTkZ47=F2gVh2Ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Remove redeundant of_match_ptr
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30 October 2013 21:36, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Oct 29, 2013 at 4:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Jason]
>>
>> On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
>>> not required.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>
>> Jason, I assume you'll merge this if you want it.
>
> BTW, Jason, if you think of it, fix the typo in the subject
> (s/redeundant/redundant/).  It was correct for the exynos patch, but
> wrong for the mvebu and imx6 patches.

Sorry for the typo. Somehow I happened to overlook it.

-- 
With warm regards,
Sachin
