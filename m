Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
 <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org>
 <CAJZ5v0h1o5C8t+QJuFo93uZt0XuPNwtXFs5XSBkhm-fARWqi2g@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Jon Masters <jcm@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <96388f6b-f8b1-5720-4725-3f0ec0f5d1c3@codeaurora.org>
Date: Wed, 29 Jun 2016 17:19:13 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h1o5C8t+QJuFo93uZt0XuPNwtXFs5XSBkhm-fARWqi2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2016 5:14 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 29, 2016 at 8:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 6/29/2016 9:16 AM, Rafael J. Wysocki wrote:
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Well, this is a rather obvious one, so I'm wondering why it is the
>>> last one in the series?
>>>
>>
>> The first three are more relevant to each other. It makes easy to
>> correlate the changes.
> 
> But this one doesn't seem to depend on them and it could be applied
> without them, right?
> 

Sure. It has no dependency. 


> Thanks,
> Rafael
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
