Return-Path: <bhelgaas@google.com>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW3_hDg7qRpAmmar3b-d8Yj1HvPZnCna_JrnxP=yxf6Tw@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
 <CABhMZUU_YNMXAU0Mr5zQMzxrk_XkFzk1HrwAN0SQxDf8n+F9kA@mail.gmail.com>
 <CAE9FiQVNYWnZzfdNsW38P4vsD1ZpXeA+SwqqDK45SZAAphz_6A@mail.gmail.com>
 <CAErSpo7W_2skcxsgFia+4caf1MgXCt3jqXCrKdX7q3EZ-KLP2Q@mail.gmail.com>
 <CAE9FiQVxno4xGg_SSrbBVs+nifP8+=cqS8SzD5kvVr2cvJD0wA@mail.gmail.com>
 <CAErSpo5dXP0H77Ph91HUTA+Do4q2=sL_tdikOQpTiCLQqw1x-Q@mail.gmail.com> <CAE9FiQW3_hDg7qRpAmmar3b-d8Yj1HvPZnCna_JrnxP=yxf6Tw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 9 Mar 2012 12:10:32 -0700
Message-ID: <CAErSpo7dJ4K=4zbpLzs6d_vEp53F89_FuWFDD+6oYCeBidyTPw@mail.gmail.com>
Subject: Re: [PATCH 00/23] PCI, x86: pci root bus hotplug support
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	x86 <x86@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 9, 2012 at 11:55 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Mar 9, 2012 at 9:34 AM, Bjorn Helgaas <bhelgaas@google.com> wrote=
:
>> On Fri, Mar 9, 2012 at 1:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Thu, Mar 8, 2012 at 4:43 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
>>
>>>> The notes about "-v2, -v3, -v4, etc." are not really useful in the
>>>> commit changelogs. =A0They're helpful in the [00/] message, but not in
>>>> the changelogs.
>>>
>>> But Jesse may still need mark to figure out which one is latest?
>>
>> The way I do that is with "stg mail -v v3", which puts "[PATCH v3
>> 01/10]" in the subject. =A0IMO, that's much more useful because when you
>> post a 23-patch series, I don't want to be bothered with v1, v2, v3 on
>> a per-patch basis.
>
> For that, I could just sed to replace PATCH to PATCH v3
>
>>
>> It's true that when you post v2, many of those 23 patches will be
>> unchanged from v1, and you do have to describe that in the [v2 00/23]
>> mail. =A0But at least it's easy to identify the entire set of v2
>> patches.
>
> Version number of the entire set could be different from individual patch=
.
> That could be more confusing.

You already post the entire series several times, so you have series
v1, series v2, etc.  Trying to talk about series v2 and patch v3
within that series is too complicated.  The version number of the
entire series is enough, in my opinion.

Bjorn
